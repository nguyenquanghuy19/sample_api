import 'package:elearning/core/data/models/course_mock_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/custom_expandable.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../view_models/course/course_detail_view_model.dart';

class CourseDetailView extends BaseView {
  const CourseDetailView({Key? key}) : super(key: key);

  @override
  CourseDetailViewState createState() => CourseDetailViewState();
}

class CourseDetailViewState
    extends BaseViewState<CourseDetailView, CourseDetailViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = CourseDetailViewModel()..onInitViewModel(context);
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
      appBar: AppBar(
        title: Text(Strings.of(context)!.courseDetail),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: viewModel.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            _buildCourse(),
            SizedBox(
              height: 28.h,
            ),
            _buildDescription(),
            SizedBox(
              height: 28.h,
            ),
            _buildRoadMap(),
            SizedBox(
              height: 28.h,
            ),
            _buildReview(context),
          ],
        ),
      ),
      floatingActionButton: Selector<CourseDetailViewModel, bool>(
        selector: (
          _,
          viewModel,
        ) =>
            viewModel.isShowButtonScrollTop,
        builder: (
          _,
          showButton,
          __,
        ) {
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

  Widget _buildRoadMap() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(Strings.of(context)!.roadMap),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        _buildDescriptionRoadMap(),
        _buildRoadMapList(),
      ],
    );
  }

  Widget _buildRoadMapList() {
    return Selector<CourseDetailViewModel, List<LectureModel>>(
      selector: (_, viewModel) => viewModel.lectures,
      shouldRebuild: (prev, next) => true,
      builder: (_, lectures, __) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, indexLecture) {
            var subContentItem = lectures[indexLecture].content;

            return CustomExpandable(
              onTap: () {
                // TODO(developername): handle ontap custom
              },
              header: Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  lectures[indexLecture].title,
                  style: AppText.text18.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              child: _buildSubContent(subContentItem, lectures, indexLecture),
            );
          },
          separatorBuilder: (context, indexLecture) {
            return SizedBox(height: 8.h);
          },
          itemCount: lectures.length,
        );
      },
    );
  }

  Widget _buildSubContent(
    List<LectureModel> subContentItem,
    List<LectureModel> lectures,
    int indexLecture,
  ) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shrinkWrap: true,
      primary: false,
      itemCount: subContentItem.length,
      itemBuilder: (context, indexSubContent) {
        var contentItem =
            lectures[indexLecture].content[indexSubContent].content;

        return CustomExpandable(
          onTap: () {
            // TODO(developername): handle ontap custom
          },
          hasIcon: contentItem.isEmpty ? false : true,
          canTap: contentItem.isNotEmpty,
          header: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 32.w),
            child: Text(
              subContentItem[indexSubContent].title,
              style: AppText.text16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
            shrinkWrap: true,
            primary: false,
            itemCount: contentItem.length,
            itemBuilder: (context, indexContent) {
              return Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 32.w),
                child: Text(
                  contentItem[indexContent].title,
                  style: AppText.text14.copyWith(),
                ),
              );
            },
            separatorBuilder: (context, indexContent) {
              return const SizedBox();
            },
          ),
        );
      },
      separatorBuilder: (context, indexSubContent) {
        return const SizedBox();
      },
    );
  }

  Widget _buildReview(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderReview(),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        SizedBox(height: 14.h),
        _buildListComment(),
        Selector<CourseDetailViewModel, bool>(
          selector: (_, viewModel) => viewModel.hasData,
          builder: (_, hasData, __) {
            return hasData
                ? Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Selector<CourseDetailViewModel, bool>(
                      selector: (_, viewModel) => viewModel.isLoadMore,
                      builder: (_, isLoadMore, __) {
                        return isLoadMore
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppButton(
                                label: Strings.of(context)!.loadMoreComment,
                                onPressed: () {
                                  viewModel.getListComment(loadMore: true);
                                },
                                width: 263.w,
                                height: 36.h,
                                styleLabel: AppText.text12,
                              );
                      },
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildListComment() {
    return Selector<CourseDetailViewModel, List<CommentModel>>(
      selector: (_, viewModel) => viewModel.comments,
      shouldRebuild: (prev, next) => true,
      builder: (_, comments, __) {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
          itemBuilder: (context, index) {
            final comment = comments[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36.w,
                  backgroundImage:
                      const AssetImage('assets/images/avartar.jpg'),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.author, style: AppText.text18),
                      SizedBox(height: 8.h),
                      ReadMoreText(
                        comment.content,
                        trimLines: 2,
                        style: AppText.text14.copyWith(color: AppColor.neutrals),
                        colorClickableText: AppColor.supporting.shade400,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: Strings.of(context)!.seeMore,
                        trimExpandedText: Strings.of(context)!.showLess,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(thickness: 1, color: AppColor.neutrals);
          },
          itemCount: comments.length,
        );
      },
    );
  }

  Widget _buildDescriptionRoadMap() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h * 1.5),
      child: Text(
        Strings.of(context)!.descriptionRoadMap(viewModel.lectures.length),
        style: AppText.text18,
      ),
    );
  }

  Widget _buildHeaderReview() {
    return Container(
      color: Colors.yellow.shade100,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h * 1.5),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(text: Strings.of(context)!.review, style: AppText.text24),
          WidgetSpan(
            child: SizedBox(width: 8.h / 2),
          ),
          TextSpan(text: "(3)", style: AppText.text14),
        ]),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      color: Colors.yellow.shade100,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h * 1.5),
      child: Text(
        title,
        style: AppText.text24,
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(Strings.of(context)!.whatWillYouLearn),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        SizedBox(height: 8.h * 2),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Course summary',
                style: AppText.text22.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "What you'll learn ",
                style: AppText.text20.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              ReadMoreText(
                "• Use 20+ Advanced English Grammar points with ex. st ,and activities \n • Use 20+ Advanced English Grammar points with examples.structures,and activities \n • Use 20+ Advanced English Grammar points with examples.structures,and activities\n • Use 20+ Advanced English Grammar points with examples.structures,and activities ",
                style: AppText.text14,
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: Strings.of(context)!.seeMore,
                trimExpandedText: Strings.of(context)!.showLess,
                moreStyle: AppText.text14.copyWith(color: AppColor.supporting.shade400),
                lessStyle: AppText.text14.copyWith(color: AppColor.supporting.shade400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(Strings.of(context)!.course),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        SizedBox(height: 8.h * 2),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harry Potter and the plumber',
                style: AppText.text22
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Help Mario to collect points for all four houses of hogwarts',
                style: AppText.text14,
              ),
              SizedBox(
                height: 8.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teacher: John Smith @johnsmith',
                    style: AppText.text14,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Date start course: 2022/09/30',
                    style: AppText.text14,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Date end course: 2022/12/31',
                    style: AppText.text14,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h * 2,
              ),
              Text(
                'Sale off 35% before 20/10',
                style: AppText.text16.copyWith(
                  color: AppColor.primary.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.h * 2,
              ),
              AppButton(
                height: 40.h,
                label: Strings.of(context)!.register,
                styleLabel: AppText.text16
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
