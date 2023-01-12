import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/software_information_view.dart';
import 'package:elearning/ui/views/switch_languague_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/view_models/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingView extends BaseView {
  const SettingView({Key? key}) : super(key: key);

  @override
  SettingViewState createState() => SettingViewState();
}

class SettingViewState extends BaseViewState<SettingView, SettingViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SettingViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          Strings.of(context)!.setting,
          style: AppText.text24.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Selector<SettingViewModel, bool>(
          selector: (_, viewModel) => viewModel.checkSignIn,
          shouldRebuild: (prev, next) => true,
          builder: (_, checkSignIn, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 37.w, vertical: 10.h),
                  child: checkSignIn
                      ? Row(
                          children: [
                            AvatarWidget(
                              radius: 40.r,
                              avatar: LookUpData.avatar,
                              isSvg: LookUpData.avatarType ?? false,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              LookUpData.displayName ?? "",
                              style: AppText.text20
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 40.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    const AssetImage(Images.imageDefaultAvatar),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    viewModel.onClickLogin();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      Strings.of(context)!.login,
                                      style: AppText.text18.copyWith(
                                        color: AppColor.supporting.shade600,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    viewModel.onClickRegister();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      Strings.of(context)!.createNewAccount,
                                      style: AppText.text18.copyWith(
                                        color: AppColor.supporting.shade600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
                //TODO: handle next sprint
                // _buildItemMenu(
                //   Strings.of(context)!.themeMode,
                //   icons: IconString.iconDarkMode,
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => const DarkModeView(),
                //       ),
                //     );
                //   },
                // ),
                if (checkSignIn)
                  _buildItemMenu(
                    Strings.of(context)!.profile,
                    icons: Images.iconProfile,
                    onTap: () {
                      viewModel.onClickProfileButton();
                    },
                  ),
                if (checkSignIn)
                  _buildItemMenu(
                    Strings.of(context)!.updatePasswordTitle,
                    icons: Images.iconChangePassword,
                    onTap: () {
                      viewModel.onClickChangePasswordButton();
                    },
                  ),
                _buildItemMenu(
                  Strings.of(context)!.language,
                  icons: Images.iconLanguage,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SwitchLanguageView(),
                      ),
                    );
                  },
                ),
                _buildItemMenu(
                  Strings.of(context)!.about,
                  icons: Images.iconAbout,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SoftwareInformationView(),
                    ),
                  ),
                ),
                if (checkSignIn)
                  _buildItemMenu(
                    Strings.of(context)!.signOut,
                    icons: Images.iconSignOut,
                    onTap: () {
                      viewModel.onClickSignOut();
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemMenu(
    String? title, {
    void Function()? onTap,
    String? icons,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 6.h,
      ),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () => onTap?.call(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              icons != null || icons != ''
                  ? Tab(
                      icon: SvgPicture.asset(icons!),
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  title ?? '',
                  style: AppText.text18.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Images.iconArrowRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
