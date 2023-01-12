import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/ui/widgets/road_map_widget.dart';
import 'package:elearning/ui/widgets/shape_custom.dart';
import 'package:elearning/view_models/course/course_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class CourseDetailView extends BaseView {
  final String? uuid;
  final int? id;
  final Uint8List? image;
  final bool isSvg;

  const CourseDetailView({
    Key? key,
    required this.uuid,
    required this.id,
    this.image,
    required this.isSvg,
  }) : super(key: key);

  @override
  CourseDetailViewState createState() => CourseDetailViewState();
}

class CourseDetailViewState
    extends BaseViewState<CourseDetailView, CourseDetailViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = CourseDetailViewModel()
      ..onInitViewModel(context, uuid: widget.uuid, id: widget.id);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.of(context)!.courseDetail,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Selector<CourseDetailViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Selector<CourseDetailViewModel, GuestCourseModel>(
                    selector: (_, viewModel) => viewModel.guestCourseModel,
                    builder: (_, guestCourseModel, __) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 160.h,
                            child: widget.image != null && widget.isSvg
                                ? SvgPicture.memory(
                                    fit: BoxFit.cover,
                                    widget.image!,
                                  )
                                : widget.image != null
                                    ? Image.memory(
                                        fit: BoxFit.cover,
                                        widget.image!,
                                      )
                                    : SvgPicture.asset(
                                        Images.defaultCourses,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 124.h),
                              _buildCourse(guestCourseModel),
                              SizedBox(
                                height: 23.h,
                              ),
                              _buildDescription(guestCourseModel),
                              SizedBox(
                                height: 24.h,
                              ),
                              _buildRoadMap(guestCourseModel),
                              SizedBox(
                                height: 12.h,
                              ),
                              _buildReview(),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: Selector<CourseDetailViewModel, bool>(
        selector: (_, viewModel) => viewModel.isShowButtonScrollTop,
        builder: (_, showButton, __) {
          return showButton
              ? FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    viewModel.scrollController.animateTo(
                      viewModel.scrollController.position.minScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRoadMap(GuestCourseModel guestCourseModel) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40.h),
          color: AppColor.primary.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h),
              guestCourseModel.extend?.roadmaps?.data?.isNotEmpty ?? false
                  ? RoadMapWidget(
                      lecture:
                          guestCourseModel.extend!.roadmaps!.data![0].items,
                      isAction: false,
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 16.h),
                      alignment: Alignment.center,
                      child: Text(
                        Strings.of(context)!.defaultValueProfile,
                        style: AppText.text20,
                      ),
                    ),
            ],
          ),
        ),
        Card(
          elevation: 3.0,
          margin: const EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.of(context)!.roadMap,
                  style: AppText.text20.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12.h),
                guestCourseModel.extend?.roadmaps?.data?.isNotEmpty ?? false
                    ? Text(
                        Strings.of(context)!.descriptionRoadMap(guestCourseModel
                                .extend?.roadmaps?.data?[0].items.length ??
                            0),
                        style: AppText.text14,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReview() {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 32),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.contentPaddingHorizontal,
                  ),
                  child: AppInput(
                    isBorder: false,
                    fillColor: Colors.white,
                    hintText: Strings.of(context)!.hintTextComment,
                    radius: 5.r,
                    maxLines: 3,
                    maxLength: 500,
                    textInputAction: TextInputAction.done,
                    controller: viewModel.commentController,
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: AppButton(
                    label: Strings.of(context)!.comment,
                    onPressed: () {
                      viewModel.addComment(id: widget.id);
                    },
                    width: 166.w,
                    isDisableButton: false,
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(
                  thickness: 2,
                  height: 2,
                  color: AppColor.neutrals.shade300,
                ),
                _buildListComment(),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Selector<CourseDetailViewModel, bool>(
                    selector: (_, viewModel) => viewModel.isLoadMore,
                    builder: (_, isLoadMore, __) {
                      return isLoadMore
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Selector<CourseDetailViewModel, bool>(
                              selector: (_, viewModel) =>
                                  viewModel.isLoadMoreButton,
                              builder: (_, isLoadMoreButton, __) {
                                return isLoadMoreButton
                                    ? const SizedBox.shrink()
                                    : Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 16.h),
                                          child: AppButton(
                                            backgroundColor: Colors.white,
                                            label: Strings.of(context)!
                                                .loadMoreComment,
                                            styleLabel: AppText.text16.copyWith(
                                              color: AppColor.primary.shade400,
                                            ),
                                            onPressed: () {
                                              viewModel.getCommentList(
                                                loadMore: true,
                                                id: widget.id,
                                              );
                                            },
                                            width: 166.w,
                                          ),
                                        ),
                                      );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Selector<CourseDetailViewModel, int>(
              selector: (_, viewModel) => viewModel.totalComment,
              builder: (_, totalComment, __) {
                return Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: Strings.of(context)!.review,
                      style:
                          AppText.text20.copyWith(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: " ($totalComment)",
                      style: AppText.text14
                          .copyWith(color: AppColor.neutrals.shade300),
                    ),
                  ]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListComment() {
    return Selector<CourseDetailViewModel, List<DataCommentModel>>(
      selector: (_, viewModel) => viewModel.comments,
      shouldRebuild: (prev, next) => true,
      builder: (_, comments, __) {
        return ListView.separated(
          padding: EdgeInsets.only(top: 12.h),
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final comment = comments[index];

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarWidget(
                    avatar: comments[index].image,
                    radius: 25.r,
                    isSvg: comments[index].isSvg,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comments[index].displayName != null
                              ? comments[index].displayName ?? ''
                              : comments[index].userName ?? '',
                          style: AppText.text16,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          comment.content ?? '',
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade300,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          comments[index].dateFormat(context) ?? '',
                          style: AppText.text14
                              .copyWith(color: AppColor.supporting.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: comments.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.h,
              color: AppColor.neutrals.shade200,
              height: 0,
              indent: 20.w,
              endIndent: 20.w,
            );
          },
        );
      },
    );
  }

  Widget _buildDescription(GuestCourseModel guestCourseModel) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.of(context)!.courseSummary,
              style: AppText.text20.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Strings.of(context)!.whatWillYouLearn,
                  style: AppText.text16.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.h,
                ),
                ReadMoreText(
                  guestCourseModel.data?.description ?? '',
                  style: AppText.text14,
                  trimLines: 4,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: Strings.of(context)!.seeMore,
                  trimExpandedText: Strings.of(context)!.showLess,
                  moreStyle: AppText.text14
                      .copyWith(color: AppColor.supporting.shade600),
                  lessStyle: AppText.text14
                      .copyWith(color: AppColor.supporting.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourse(GuestCourseModel guestCourseModel) {
    return Selector<CourseDetailViewModel, bool>(
      selector: (_, viewModel) => viewModel.isRegister,
      builder: (_, isRegister, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildOverviewCourse(isRegister, guestCourseModel, context),
            if (guestCourseModel.data?.settings?.saleOff != null)
              _buildSaleOff(guestCourseModel),
            isRegister
                ? const SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    child: AppButton(
                      width: 166.w,
                      borderRadius: 24,
                      label: Strings.of(context)!.register,
                      isDisableButton: false,
                      onPressed: () {
                        viewModel.onRegister(widget.id!);
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }

  Padding _buildOverviewCourse(
    bool isRegister,
    GuestCourseModel guestCourseModel,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isRegister ? 0 : 25.h),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(
          horizontal: Constants.contentPaddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guestCourseModel.data?.name ?? '',
                    style: AppText.text20.copyWith(
                      color: AppColor.primary.shade400,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    guestCourseModel.data?.metaDescription ?? "",
                    style: AppText.text14,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: _buildTeacher(
                            guestCourseModel.extend?.teachers?.data ?? [],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${Strings.of(context)!.dateStart}: ',
                              style: AppText.text14
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: guestCourseModel.data?.settings?.openDate !=
                                          null &&
                                      guestCourseModel
                                              .data?.settings?.openDate !=
                                          ''
                                  ? DateFormat('yyyy/MM/dd').format(
                                      DateTime.parse(guestCourseModel
                                              .data?.settings?.openDate ??
                                          ''),
                                    )
                                  : '----/--/--',
                              style: AppText.text14,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${Strings.of(context)!.dateEnd}: ',
                              style: AppText.text14
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text:
                                  guestCourseModel.data?.settings?.closeDate !=
                                              null &&
                                          guestCourseModel
                                                  .data?.settings?.closeDate !=
                                              ''
                                      ? DateFormat('yyyy/MM/dd').format(
                                          DateTime.parse(guestCourseModel
                                                  .data?.settings?.closeDate ??
                                              ''),
                                        )
                                      : '----/--/--',
                              style: AppText.text14,
                            ),
                          ],
                        ),
                      ),
                      isRegister
                          ? SizedBox(
                              height: 8.h,
                            )
                          : const SizedBox.shrink(),
                      isRegister
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${Strings.of(context)!.status}: ',
                                    style: AppText.text14
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(
                                    text: 'Waiting confirm',
                                    style: AppText.text14
                                        .copyWith(color: AppColor.redApp),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  isRegister ? const SizedBox.shrink() : SizedBox(height: 37.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaleOff(
    GuestCourseModel guestCourseModel,
  ) {
    return Selector<CourseDetailViewModel, bool>(
      selector: (_, viewModel) => viewModel.isRegister,
      builder: (_, isRegister, __) {
        return isRegister
            ? const SizedBox.shrink()
            : Positioned(
                left: MediaQuery.of(context).size.width / 2 + 166 / 4,
                bottom: 55.h,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width / 2 - 25.w - 166 / 4,
                  ),
                  decoration: ShapeDecoration(
                    color: AppColor.redApp.shade400,
                    shape: const ShapeCustom(usePadding: true),
                    shadows: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Text(
                      guestCourseModel.data!.settings!.saleOff!,
                      style: AppText.text14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  List<TextSpan> _buildTeacher(List<DataTeacherModel> teachers) {
    List<TextSpan> tc = [];
    tc.add(
      TextSpan(
        text: '${Strings.of(context)!.teacher}: ',
        style: AppText.text14.copyWith(fontWeight: FontWeight.w700),
      ),
    );
    if (teachers.isNotEmpty) {
      for (int i = 0; i < teachers.length; i++) {
        if (i != teachers.length - 1) {
          tc.add(
            TextSpan(
              text: '${teachers[i].displayName ?? teachers[i].userName}, ',
              style: AppText.text14,
            ),
          );
        } else {
          tc.add(
            TextSpan(
              text: '${teachers[i].displayName ?? teachers[i].userName}',
              style: AppText.text14,
            ),
          );
        }
      }
    } else {
      tc.add(
        TextSpan(
          text: ' -- ',
          style: AppText.text14,
        ),
      );
    }

    return tc;
  }
}
