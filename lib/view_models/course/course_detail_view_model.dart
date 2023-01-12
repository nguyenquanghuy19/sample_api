import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/repositories/courses_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/ui/views/auth/sign_in_view.dart';
import 'package:elearning/ui/views/mains/main_view_after_sign_in.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class CourseDetailViewModel extends BaseViewModel {
  final CoursesRepository _courseRepository = CoursesRepository();

  bool get isRegister => member.data != null;

  CommentModel commentModel = CommentModel();

  GuestCourseModel guestCourseModel = GuestCourseModel();

  List<DataCommentModel> comments = [];

  RegisterModel registerModel = RegisterModel();

  RegisterModel member = RegisterModel();

  bool _isLoading = false;

  bool _isLoadMore = false;

  bool get isLoading => _isLoading;

  bool get isLoadMore => _isLoadMore;

  int _totalComment = 0;

  int get totalComment => _totalComment;

  bool get isLoadMoreButton => totalComment == comments.length;

  TextEditingController commentController = TextEditingController();

  ScrollController scrollController = ScrollController();

  bool isShowButtonScrollTop = false;

  int _page = 1;

  @override
  Future<void> onInitViewModel(
    BuildContext context, {
    String? uuid,
    int? id,
  }) async {
    super.onInitViewModel(context);
    scrollController.addListener(() {
      if (scrollController.position.extentBefore > 350) {
        _handleShowButtonScrollTop(true);
      } else {
        _handleShowButtonScrollTop(false);
      }
    });
    await _getDataOptionCourses(uuid, id);
  }

  Future<void> checkRegister(int id) async {
    try {
      final res = await _courseRepository.getMember(id);
      if (res != null) {
        member = res;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> getCommentList({bool loadMore = false, required int? id}) async {
    try {
      if (loadMore) {
        _isLoadMore = true;
      }
      updateUI();
      if (id != null) {
        final res = await _courseRepository.getComment(id, _page);
        if (res != null) {
          commentModel = res;
          comments.addAll(res.data);
          getListImage(comments, res.data.length);
          _totalComment = commentModel.total;
          _page++;
          _isLoadMore = false;
          updateUI();
        }
      }
    } on Exception {
      _isLoadMore = false;
      LogUtils.d("[$runtimeType][GET_LIST_COMMENT] => ERROR");
    }
  }

  void _handleShowButtonScrollTop(bool value) {
    isShowButtonScrollTop = value;
    updateUI();
  }

  Future<void> _getGuestCourse(String? uuid) async {
    try {
      if (uuid != null) {
        final res = await _courseRepository.getGuestCourse(uuid);
        if (res != null) {
          guestCourseModel = res;
          if (res.data != null) {
            getCommentList(id: res.data?.id ?? 0);
          }
          updateUI();
        }
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> _getDataOptionCourses(String? uuid, int? id) async {
    try {
      _isLoading = true;
      if (_checkSignIn()) {
        await checkRegister(id!);
      }
      await _getGuestCourse(uuid);
      _isLoading = false;
    } on Exception {
      _isLoading = false;
    }
  }

  void onRegister(int id) {
    if (_checkSignIn()) {
      DialogWidget().showBasicDialog(
        context: context,
        title: Strings.of(context)!.confirm,
        content: Strings.of(context)!.confirmRegister,
        positiveOnClickListener: () => _onRegister(id),
      );
    } else {
      DialogWidget().showBasicDialog(
        context: context,
        title: Strings.of(context)!.confirm,
        content: Strings.of(context)!.confirmLoginToRegisterCourse,
        positiveOnClickListener: () => _onNavigateLogin(),
      );
    }
  }

  void _onRegister(int id) async {
    try {
      final res = await _courseRepository.registerCourse(id);
      if (res != null) {
        registerModel = res;
        showToastSuccess(res.message);
      }
      await checkRegister(id);
      updateUI();
    } on Exception {
      rethrow;
    }
  }

  void _onNavigateLogin() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) => SignInView(
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
        ),
      ),
    );
  }

  bool _checkSignIn() {
    return SPrefUserModel().getIsSignIn();
  }

  Future<void> addComment({required int? id}) async {
    if (!_checkSignIn()) {
      hideCurrentSnackBar();
      showToastError(Strings.of(context)!.messageLoginBeforeComment);
    } else {
      if (commentController.text.isNotEmpty &&
          commentController.text.trim() != '') {
        if (id != null) {
          hideCurrentSnackBar();
          final dataAddComment =
              CommentParam(content: commentController.text, lmsId: id);
          try {
            final res = await _courseRepository.createComment(dataAddComment);
            if (res != null) {
              _page = 1;
              commentController.clear();
              comments.clear();
              getCommentList(id: id);
            }
          } on Exception {
            hideCurrentSnackBar();
            LogUtils.d("[ADD_COMMENT] => ERROR");
          }
        } else {
          hideCurrentSnackBar();
          showToastError(Strings.of(context)!.leaveYourComment);
        }
      } else {
        hideCurrentSnackBar();
        showToastError(Strings.of(context)!.leaveYourComment);
      }
    }
  }

  Future<void> getImage(DataCommentModel dataCommentModel) async {
    try {
      if (dataCommentModel.avatar != null) {
        final res = await _courseRepository.getAvatar(dataCommentModel.avatar);
        dataCommentModel.image = res.data;
        dataCommentModel.isSvg =
            res.headers["content-type"]?[0].contains("svg") ?? false;
        updateUI();
      }
    } on Exception {
      LogUtils.i("Error get avatar");
    }
  }

  void getListImage(List<DataCommentModel> dataCommentModel, int length) {
    for (int i = dataCommentModel.length - length;
        i < dataCommentModel.length;
        i++) {
      getImage(dataCommentModel[i]);
    }
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
