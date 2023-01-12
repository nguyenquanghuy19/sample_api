import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/communication_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/information_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class InformationWidget extends BaseView {
  final int? courseId;
  final Uint8List? image;
  final bool isSvg;
  final double paddingTop;

  const InformationWidget({
    Key? key,
    required this.courseId,
    this.image,
    required this.isSvg,
    required this.paddingTop,
  }) : super(key: key);

  @override
  InformationWidgetState createState() => InformationWidgetState();
}

class InformationWidgetState
    extends BaseViewState<InformationWidget, InformationMyLearningViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = InformationMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<InformationMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<InformationMyLearningViewModel, MyLearningDetailModel?>(
                selector: (_, viewModel) => viewModel.myLearning,
                builder: (_, myLearning, __) {
                  return myLearning == null
                      ? _dataMyLearningDetailEmpty()
                      : SingleChildScrollView(
                          child: Stack(
                            children: [
                              _buildBannerView(),
                              Column(
                                children: [
                                  SizedBox(height: 93.h),
                                  _buildHeaderView(myLearning),
                                  SizedBox(height: 15.h),
                                  _buildCardInformation(myLearning),
                                  SizedBox(height: 15.h),
                                  _buildCardSummary(myLearning),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              );
      },
    );
  }

  Widget _buildBannerView() {
    return SizedBox(
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
    );
  }

  Widget _dataMyLearningDetailEmpty() {
    return Center(
      child: Text(
        Strings.of(context)!.defaultValueProfile,
        style: AppText.text16,
      ),
    );
  }

  Widget _buildCardInformation(MyLearningDetailModel myLearning) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
            vertical: 16.h,
          ),
          child: _buildItemSummaryCourse(myLearning),
        ),
      ),
    );
  }

  Widget _buildHeaderView(MyLearningDetailModel myLearning) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myLearning.name ?? "",
                style: AppText.text18.copyWith(
                  color: AppColor.neutrals.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Images.iconFlash,
                    width: (12.w + 12.h) / 2,
                    height: (12.w + 12.h) / 2,
                  ),
                  SizedBox(width: 5.w),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        if (myLearning.settings?.openDate != null)
                          TextSpan(
                            text: DateFormat('yyyy/MM/dd')
                                .format(myLearning.settings!.openDate!),
                            style: AppText.text14.copyWith(
                              color: AppColor.neutrals.shade300,
                            ),
                          ),
                        if (myLearning.settings?.openDate == null)
                          TextSpan(
                            text: "----/--/--",
                            style: AppText.text14.copyWith(
                              color: AppColor.neutrals.shade300,
                            ),
                          ),
                        TextSpan(
                          text: "  ~  ",
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade300,
                          ),
                        ),
                        if (myLearning.settings?.closeDate != null)
                          TextSpan(
                            text: DateFormat('yyyy/MM/dd')
                                .format(myLearning.settings!.closeDate!),
                            style: AppText.text14.copyWith(
                              color: AppColor.neutrals.shade300,
                            ),
                          ),
                        if (myLearning.settings?.closeDate == null)
                          TextSpan(
                            text: "----/--/--",
                            style: AppText.text14.copyWith(
                              color: AppColor.neutrals.shade300,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildDescriptionSummary(myLearning),
              SizedBox(
                height: 13.h,
              ),
              _buildListItemTeacher(myLearning),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSummary(MyLearningDetailModel myLearning) {
    return Row(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Images.iconPeopleMyLearning,
              width: (18.w + 18.h) / 2,
              height: (18.w + 18.h) / 2,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              (myLearning.members.length == 1)
                  ? Strings.of(context)!.memberMyLearningDetail
                  : Strings.of(context)!.memberCourseMyLearning(
                      "${myLearning.members.length}",
                    ),
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade800,
              ),
            ),
          ],
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                Images.iconRemainingTimeMyLearning,
                width: (18.w + 16.h) / 2,
                height: (18.w + 16.h) / 2,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                (myLearning.settings?.openDate != null &&
                        myLearning.settings?.closeDate != null)
                    ? (myLearning.settings!.getTimeDifference() > 1)
                        ? Strings.of(context)!.remainingTimes(
                            "${myLearning.settings!.getTimeDifference()}",
                          )
                        : Strings.of(context)!.remainingTime
                    : "--",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItemTeacher(MyLearningDetailModel myLearning) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${Strings.of(context)!.teacher} :",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildListNameTeacher(myLearning),
        ),
        InkWell(
          onTap: () async {
            await BottomSheetWidget().showBottomSheetWidget(
              context,
              content: const CommunicationWidget(),
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              maxHeight: MediaQuery.of(context).size.height -
                  widget.paddingTop -
                  AppBar().preferredSize.height,
            );
          },
          child: SvgPicture.asset(
            Images.iconCommentMyLearning,
            width: (16.w + 16.h) / 2,
            height: (16.w + 16.h) / 2,
          ),
        ),
      ],
    );
  }

  Widget _buildListNameTeacher(
    MyLearningDetailModel myLearningDetailModel,
  ) {
    return myLearningDetailModel.teachers.isEmpty
        ? Text(
            "--",
            style: AppText.text14.copyWith(
              color: AppColor.neutrals.shade800,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: myLearningDetailModel.teachers.length,
            itemBuilder: (context, index) {
              return Text(
                myLearningDetailModel.teachers[index]
                        .handlerShowNameTeacher() ??
                    "--",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade800,
                ),
              );
            },
          );
  }

  Widget _buildItemSummaryCourse(MyLearningDetailModel myLearning) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${Strings.of(context)!.summaryMyLearning} :",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        // [TODO] Handler show summary of my learning course
        _buildSummaryContent(),
      ],
    );
  }

  Widget _buildSummaryContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.progress,
                  content: "30%",
                  pathIcon: Images.iconProgressMyLearning,
                ),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.titleQuiz,
                  content: "12/36",
                  pathIcon: Images.iconQuizMyLearning,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.flashCard,
                  content: "08/12",
                  pathIcon: Images.iconFlashCardMyLearning,
                ),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.slideShowMyLearningDetail,
                  content: "3/8",
                  pathIcon: Images.iconSlideShowAboutMyLearning,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.roadMap,
                  content: "01",
                  pathIcon: Images.iconRoadMapLearning,
                ),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: _buildContentSummaryWidget(
                  title: Strings.of(context)!.award,
                  content: "01",
                  pathIcon: Images.iconAWardMyLearning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentSummaryWidget({
    String? title,
    String? content,
    required String pathIcon,
  }) {
    return Row(
      children: [
        SvgPicture.asset(pathIcon),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                content ?? "",
                style: AppText.text16.copyWith(
                  color: AppColor.neutrals.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardSummary(MyLearningDetailModel myLearning) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 5.h,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.of(context)!.courseSummary,
                style: AppText.text18.copyWith(
                  color: AppColor.neutrals.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                Strings.of(context)!.whatWillYouLearn,
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ReadMoreText(
                myLearning.description ?? '',
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
        ),
      ),
    );
  }
}
