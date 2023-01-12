import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/view_models/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Tab(
            icon: SvgPicture.asset(
              Images.iconArrowLeft,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              viewModel.onSubmitButtonUpdate(context);
            },
            icon: Tab(
              icon: SvgPicture.asset(Images.iconEdit),
            ),
          ),
        ],
        title: Text(
          Strings.of(context)!.profile,
          style: AppText.text24
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Selector<ProfileViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Selector<ProfileViewModel, ProfileModel?>(
                  selector: (_, viewModel) => viewModel.profile,
                  builder: (_, profile, __) {
                    return profile == null
                        ? Center(
                            child:
                                Text(Strings.of(context)!.defaultValueProfile),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 78.h,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade800
                                        : AppColor.primary,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Constants.contentPaddingHorizontal,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 90.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextDisplayName,
                                            value: profile.displayName ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextDateOfBirth,
                                            value: profile.dateOfBirth != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(
                                                    profile.dateOfBirth!,
                                                  )
                                                : Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextGender,
                                            value: viewModel.getGenderName() ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .emailAddress,
                                            value: profile.email ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextPhoneNumber,
                                            value: profile.phoneNumber ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextAddress,
                                            value: profile.address ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                          _displayProfile(
                                            title: Strings.of(context)!
                                                .hintTextCountry,
                                            value: viewModel.getNameCountry() ??
                                                Strings.of(context)!
                                                    .defaultValueProfile,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Profile image
                              Positioned(
                                top: 8.h,
                                child: _buildImage(),
                              ),
                            ],
                          );
                  },
                );
        },
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: AppColor.primary.shade400),
        shape: BoxShape.circle,
      ),
      child: Selector<ProfileViewModel, ProfileModel>(
        selector: (_, viewModel) => viewModel.profile!,
        shouldRebuild: (pre, next) => true,
        builder: (_, profile, __) {
          return AvatarWidget(
            avatar: profile.avatarFile,
            isSvg: profile.isSvg,
          );
        },
      ),
    );
  }

  Widget _displayProfile({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppText.text16.copyWith(
              color: AppColor.primary.shade400,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            value != "" ? value : Strings.of(context)!.defaultValueProfile,
            style: AppText.text18.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
