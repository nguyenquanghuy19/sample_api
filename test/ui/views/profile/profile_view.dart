import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/profile/profile_view_model.dart';
import 'update_password_view.dart';
import 'update_profile_view.dart';

class ProfileView extends BaseView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends BaseViewState<ProfileView, ProfileViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ProfileViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          Strings.of(context)!.profile,
          style: AppText.text24.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: const IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: null,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                child: _buildImage(),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextDisplayName,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextDateOfBirth,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextGender,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.emailAddress,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextPhoneNumber,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextAddress,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            _displayProfile(
              title: Strings.of(context)!.hintTextCountry,
              value: Strings.of(context)!.defaultValueProfile,
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: _buttonUpdate(),
            ),
            SizedBox(
              height: 5.h,
            ),
            AppButton(
              label: "Change Password",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const UpdatePasswordView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.white),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/default_avt.jpg'),
      ),
    );
  }

  Widget _displayProfile({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppText.text14.copyWith(color: AppColor.neutrals),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(value, style: AppText.text18),
        ],
      ),
    );
  }

  Widget _buttonUpdate() {
    return AppButton(
      label: Strings.of(context)!.labelButtonEdit,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const UpdateProfileView(),
          ),
        );
      },
    );
  }
}
