import 'dart:async';

import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/core/data/repositories/courses_repository.dart';
import 'package:elearning/core/data/repositories/media_repository.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/data/repositories/notification_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/auth/sign_in_view.dart';
import 'package:elearning/ui/views/mains/main_view_after_sign_in.dart';
import 'package:elearning/ui/views/mains/main_view_before_sign_in.dart';
import 'package:elearning/ui/views/profile/profile_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:elearning/view_models/mains/main_view_after_sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  final AccountRepository _accountRepository = AccountRepository();

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  bool get checkSignIn => SPrefUserModel().getIsSignIn();

  bool isLoading = false;

  final CoursesRepository _coursesRepository = CoursesRepository();

  final MediaRepository _mediaRepository = MediaRepository();

  List<CourseModel> courses = [];

  DataResponseMyLearningModel dataMyLearning = DataResponseMyLearningModel();

  List<MyLearningModel> get myLearning => dataMyLearning.data;

  List<String> images = [
    Images.imageSaleOff1,
    Images.imageSaleOff2,
    Images.imageSaleOff3,
    Images.imageSaleOff4,
  ];

  int activePage = 0;

  Uint8List? avatarFile;

  DataProfileModel? profileModel = DataProfileModel(
    data: ProfileModel(),
  );

  ProfileModel? get profile => profileModel?.data;

  bool isNewNotification = false;

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    initData();
    LogUtils.d("[$runtimeType][LANDING_VIEW_MODEL] => RUNNING");
  }

  void initData() async {
    try {
      isLoading = true;
      if (checkSignIn) {
        _getAvatar();
        await getDataMyLearning();
        await _getStatusNotification();
      }
      await getDataCourses();
      isLoading = false;
      updateUI();
    } on Exception {
      isLoading = false;
    }
    updateUI();
  }

  Future<void> _getStatusNotification() async {
    try {
      final res = await _notificationRepository.getStatusNotification();
      if (res != null) {
        isNewNotification = res.data;
      }
    } on Exception {
      LogUtils.i("Error get status Notification");
    }
  }

  Future<void> _getAvatar() async {
    try {
      if (SPrefUserModel().getAvatar() == null) {
        profileModel = await _accountRepository.getProfile();
        profileModel!.data!.isLoadingImage = true;
        final resAvatar = await _accountRepository.getAvatar(profile!.avatar);
        profileModel!.data!.avatarFile = resAvatar.data;
        profileModel!.data!.isSvg =
            resAvatar.headers["content-type"]?[0].contains("svg") ?? false;
        LookUpData.avatar = resAvatar.data;
        LookUpData.avatarType = profileModel!.data!.isSvg;
        SPrefUserModel().setAvatar(resAvatar.data);
        SPrefUserModel().setAvatarType(profileModel!.data!.isSvg);
      } else {
        profileModel!.data!.avatarFile = LookUpData.avatar;
        profileModel!.data!.isSvg = LookUpData.avatarType ?? false;
      }
      if (SPrefUserModel().getDisplayName() == null) {
        profileModel = await _accountRepository.getProfile();
        LookUpData.displayName = profileModel!.data!.displayName;
        SPrefUserModel().setDisplayName(profileModel!.data!.displayName!);
      } else {
        profileModel!.data!.displayName = LookUpData.displayName;
      }
      profileModel!.data!.isLoadingImage = false;
    } on Exception {
      profileModel!.data!.isLoadingImage = false;
      LogUtils.i("Error get avatar");
    }
  }

  void onChangeCarousel(int value) {
    activePage = value;
    updateUI();
  }

  void onClickLogin() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (
          context,
        ) {
          return SignInView(
            canBack: true,
            callBack: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const MainViewAfterSignIn();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getDataMyLearning() async {
    try {
      final res = await _myLearningRepository.getAllListMyLearning(
        param: '?Page=1&PerPage=5',
      );
      if (res != null) {
        dataMyLearning = res;
      }
    } on Exception {
      LogUtils.i("Error get data course");
    }
    updateUI();
  }

  Future<void> getDataCourses() async {
    try {
      courses.clear();
      const String param = "?Page=1&PerPage=5";
      final res = await _coursesRepository.getAllListCourses(param: param);
      if (res != null && res.data.isNotEmpty) {
        courses.addAll(res.data);
        getListImage(courses, res.data.length);
      }
    } on Exception {
      LogUtils.i("Error get data course");
    }
    updateUI();
  }

  Future<void> getImage(CourseModel course) async {
    try {
      if (course.featuredImage != null) {
        course.isLoadingImage = true;
        final res =
            await _mediaRepository.getLmsFeatureImage(course.featuredImage!);
        course.image = res.data;
        course.isSvg = res.headers["content-type"]?[0].contains("svg") ?? false;
        course.isLoadingImage = false;
      } else {
        course.isLoadingImage = false;
      }
    } on Exception {
      course.isLoadingImage = false;
      LogUtils.i("Error get image");
    }
    updateUI();
  }

  void getListImage(List<CourseModel> course, int length) {
    for (int i = course.length - length; i < course.length; i++) {
      getImage(course[i]);
    }
  }

  void navigateMyLearning() {
    final mainViewNotifier =
        notifierList.whereType<MainViewAfterSignInViewModel>().first;
    mainViewNotifier.changeTab(
      BottomTabItemAfterSignIn.myLearning,
    );
  }

  void onClickProfile() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const ProfileView(),
      ),
    );
  }

  void onClickSignOut() {
    SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.isSignInKey);
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainViewBeforeSignIn(),
      ),
    );
  }
}
