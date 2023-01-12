import 'package:carousel_slider/carousel_slider.dart';
import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/course/course_detail_view.dart';
import 'package:elearning/ui/views/home/notification_home_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/ui/widgets/item_course_widget.dart';
import 'package:elearning/ui/widgets/popup_menu_custom.dart';
import 'package:elearning/view_models/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeView extends BaseView {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends BaseViewState<HomeView, HomeViewModel> {
  final GlobalKey<PopupMenuButtonState<String>> _popupImageKey = GlobalKey();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = HomeViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<HomeViewModel, bool>(
      selector: (_, viewModel) => viewModel.checkSignIn,
      builder: (_, checkSignIn, __) {
        return Scaffold(
          appBar: _buildAppbar(context, checkSignIn),
          body: Selector<HomeViewModel, bool>(
            selector: (_, viewModel) => viewModel.isLoading,
            builder: (_, isLoading, __) {
              return isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Stack(
                        children: [
                          _buildHeaderLandingView(),
                          Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.imageWaveGroup),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          _buildContentLandingPage(),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  Widget _buildContentLandingPage() {
    return Padding(
      padding: EdgeInsets.only(
        top: 210.h,
        bottom: 16.h,
        left: Constants.contentPaddingHorizontal,
        right: Constants.contentPaddingHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<HomeViewModel, int>(
            selector: (_, viewModel) => viewModel.activePage,
            builder: (_, activePage, __) {
              return _buildCarousel(activePage);
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          Selector<HomeViewModel, bool>(
            selector: (_, viewModel) => viewModel.checkSignIn,
            builder: (_, checkSignIn, __) {
              return checkSignIn
                  ? _buildContentLearningPlan()
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            Strings.of(context)!.mostPopularCourse,
            style: AppText.text18.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 16.h,
          ),
          Selector<HomeViewModel, bool>(
            selector: (_, viewModel) => viewModel.checkSignIn,
            shouldRebuild: (pre, next) => true,
            builder: (_, checkSignIn, __) {
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemCourseWidget(
                    isSignIn: checkSignIn,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return CourseDetailView(
                              uuid: viewModel.courses[index].uuid,
                              id: viewModel.courses[index].id,
                              image: viewModel.courses[index].image,
                              isSvg: viewModel.courses[index].isSvg,
                            );
                          },
                        ),
                      );
                    },
                    course: viewModel.courses[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 14.h,
                  );
                },
                itemCount: viewModel.courses.length,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(int activePage) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.55,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                viewModel.onChangeCarousel(index);
              },
              enableInfiniteScroll: true,
            ),
            items: viewModel.images.map<Widget>((i) {
              return Builder(
                builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(
            viewModel.images.length,
            activePage,
          ),
        ),
      ],
    );
  }

  Widget _buildContentLearningPlan() {
    return Selector<HomeViewModel, List<MyLearningModel>>(
      selector: (_, viewModel) => viewModel.myLearning,
      builder: (_, myLearning, __) {
        if (myLearning != [] && myLearning.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.of(context)!.learningPlan,
                style: AppText.text18.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () {
                  viewModel.navigateMyLearning();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 2500,
                          barRadius: const Radius.circular(10),
                          padding: EdgeInsets.zero,
                          lineHeight: 14.0,
                          //TODO: handle when have amount course complete
                          percent: viewModel.dataMyLearning.total != null
                              ? 0 / viewModel.dataMyLearning.total!
                              : 0 / 1,
                          backgroundColor: AppColor.neutrals.shade300,
                          progressColor: AppColor.primary.shade400,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //TODO: handle when have amount course complete
                            const Text("3 course's"),
                            Text(
                              "${viewModel.dataMyLearning.total.toString()} course's",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 12.0,
                                  lineWidth: 4.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: const Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    viewModel.myLearning[index].name ?? '',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('12/18'),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemCount: viewModel.myLearning.length,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              Strings.of(context)!.viewMore,
                              style: AppText.text14.copyWith(
                                color: AppColor.blueAccent,
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              Images.iconArrowRight,
                              color: AppColor.blueAccent,
                              width: 10,
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  PreferredSizeWidget? _buildAppbar(
    BuildContext contextScreen,
    bool isCheckSignIn,
  ) {
    return AppBar(
      titleSpacing: 0,
      title: Padding(
        padding:
            const EdgeInsets.only(left: Constants.contentPaddingHorizontal),
        child: isCheckSignIn
            ? Selector<HomeViewModel, ProfileModel>(
                selector: (_, viewModel) => viewModel.profile ?? ProfileModel(),
                shouldRebuild: (pre, next) => true,
                builder: (_, profile, __) {
                  return Row(
                    children: [
                      _buildButtonPopupMenuAvatar(profile),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.of(context)!.hello,
                            style: AppText.text12,
                          ),
                          Text(
                            LookUpData.displayName ?? "",
                            style: AppText.text18.copyWith(
                              color: AppColor.neutrals.shade800,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            : Image.asset(Images.appLogo, height: 28, width: 28),
      ),
      actions: <Widget>[
        isCheckSignIn
            ? Selector<HomeViewModel, bool>(
                selector: (_, viewModel) => viewModel.checkSignIn,
                builder: (_, checkSignIn, __) {
                  return checkSignIn
                      ? IconButton(
                          onPressed: () async {
                            await BottomSheetWidget().showBottomSheetWidget(
                              contextScreen,
                              content: const NotificationHomeView(),
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.transparent,
                              isScrollControlled: true,
                              maxHeight: MediaQuery.of(context).size.height -
                                  MediaQuery.of(contextScreen).padding.top -
                                  AppBar().preferredSize.height,
                            );
                          },
                          icon: Selector<HomeViewModel, bool>(
                            selector: (_, viewModel) =>
                                viewModel.isNewNotification,
                            builder: (_, isNewNotification, __) {
                              return isNewNotification
                                  ? Stack(
                                      children: [
                                        Icon(
                                          Icons.notifications,
                                          color: AppColor.neutrals.shade800,
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Icon(
                                      Icons.notifications,
                                      color: AppColor.neutrals.shade800,
                                    );
                            },
                          ),
                        )
                      : const SizedBox.shrink();
                },
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Constants.contentPaddingHorizontal,
                  ),
                  child: InkWell(
                    onTap: () {
                      viewModel.onClickLogin();
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Strings.of(context)!.login,
                        style: AppText.text14.copyWith(
                          color: AppColor.neutrals.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildButtonPopupMenuAvatar(ProfileModel profile) {
    return PopupMenuButtonCustom<String>(
      key: _popupImageKey,
      position: PopupMenuPositionCustom.under,
      icon: AvatarWidget(
        radius: 20.r,
        avatar: profile.avatarFile,
        isSvg: profile.isSvg,
        isLoading: profile.isLoadingImage,
      ),
      onSelected: (value) {
        if (value == Constants.profile) {
          viewModel.onClickProfile();

          return;
        }
        if (value == Constants.signOut) {
          viewModel.onClickSignOut();

          return;
        }
      },
      itemBuilder: (context) => <PopupMenuEntryCustom<String>>[
        PopupMenuItemCustom<String>(
          value: Constants.profile,
          child: Text(Strings.of(context)!.profile),
        ),
        const PopupMenuDividerCustom(height: 0),
        PopupMenuItemCustom<String>(
          value: Constants.signOut,
          child: Text(Strings.of(context)!.signOut),
        ),
      ],
    );
  }

  Widget _buildHeaderLandingView() {
    return Container(
      height: 300.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.imageBackgroundLandingPage),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Strings.of(context)!.landingTitleHeader,
              style: AppText.text24
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 8.h,
            ),
            Text(
              Strings.of(context)!.landingSubTitleHeader,
              style: AppText.text16.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              Strings.of(context)!.landingContentHeader,
              style: AppText.text14.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
