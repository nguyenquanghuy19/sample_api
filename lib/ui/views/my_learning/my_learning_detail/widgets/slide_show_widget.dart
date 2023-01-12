import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_slide_show/play_slide_show_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/slide_show_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowWidget extends BaseView {
  final int? courseId;

  const SlideShowWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  SlideShowWidgetState createState() => SlideShowWidgetState();
}

class SlideShowWidgetState extends BaseViewState<
    SlideShowWidget, SlideShowMyLearningViewModel> {

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SlideShowMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<SlideShowMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      shouldRebuild: (pre, next) => true,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<SlideShowMyLearningViewModel, List<TypeDataModel>>(
                selector: (_, viewModel) => viewModel.dataTypes,
                shouldRebuild: (pre, next) => true,
                builder: (_, dataTypes, __) {
                  return dataTypes.isEmpty
                      ? Center(
                          child: Text(Strings.of(context)!.defaultValueProfile),
                        )
                      : GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          itemCount: dataTypes.length,
                          itemBuilder: (context, index) {
                            final item = dataTypes[index];

                            return _buildItemSlideShow(item);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 3.4
                                    : 1.75,
                          ),
                        );
                },
              );
      },
    );
  }

  Widget _buildItemSlideShow(TypeDataModel item) {
    return GestureDetector(
      onTap: () {
        _showDialogSlideShow(item);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: Constants.contentPaddingHorizontal,
          right: Constants.contentPaddingHorizontal,
          top: 4,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            image: const DecorationImage(
              image: AssetImage(Images.backgroundFlashCard),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: AppColor.neutrals.shade200, width: 1.w),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Images.iconSlideShowItemMyLearning,
                    width: (30.w + 30.h) / 2,
                    height: (30.w + 30.h) / 2,
                    fit: BoxFit.cover,
                  ),
                  _buildLockFlashCard(item.status),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      item.name ?? "",
                      style: AppText.text16.copyWith(
                        color: AppColor.neutrals.shade800,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  _buildItemStatusFlashCard(item.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockFlashCard(String? status) {
    return status == Constants.statusReady
        ? const SizedBox.shrink()
        : SvgPicture.asset(
            Images.iconLockLecture,
            color: AppColor.redApp.shade400,
            width: (15.w + 15.h) / 2,
            height: (15.w + 15.h) / 2,
          );
  }

  Widget _buildItemStatusFlashCard(String? status) {
    return status == Constants.statusReady
        ? Row(
            children: [
              SvgPicture.asset(
                Images.iconFlash,
                color: AppColor.greenAccent.shade300,
              ),
              SvgPicture.asset(
                Images.iconFlash,
                color: AppColor.greenAccent.shade300,
              ),
              SvgPicture.asset(
                Images.iconFlash,
                color: AppColor.greenAccent.shade300,
              ),
            ],
          )
        : Row(
            children: [
              SvgPicture.asset(Images.iconFlashNoColor),
              SvgPicture.asset(Images.iconFlashNoColor),
              SvgPicture.asset(Images.iconFlashNoColor),
            ],
          );
  }

  void _showDialogSlideShow(
    TypeDataModel item,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black,
                    blurRadius: 1,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? "",
                    style: AppText.text20.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary.shade400,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // TODO: CALCULATOR OR API RESPONSE
                  _buildItemSlideShowDetail(
                    title: "${Strings.of(context)!.titleId}:",
                    content: "_____",
                  ),
                  const SizedBox(height: 12),
                  _buildItemSlideShowDetail(
                    title: "${Strings.of(context)!.course}:",
                    content: "Course name",
                  ),
                  const SizedBox(height: 12),
                  _buildListItemTeacher(
                    context,
                  ),
                  const SizedBox(height: 12),
                  _buildItemSlideShowDetail(
                    title: "${Strings.of(context)!.titleCost}:",
                    content: "123 Pages",
                  ),
                  const SizedBox(height: 16),
                  _buildButtonStart(
                    context,
                    item,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemSlideShowDetail({
    required String title,
    required String content,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          content,
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildListItemTeacher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${Strings.of(context)!.teacher}:",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              // TODO insert list teacher
              text: "Teacher 1, Teacher 2",
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonStart(
    BuildContext context,
    TypeDataModel typeDataModel,
  ) {
    return Center(
      child: AppButton(
        width: 130.w,
        height: 31.h,
        label: Strings.of(context)!.titleBtnStartQuiz,
        isDisableButton: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return PlaySlideShowView(id: typeDataModel.fkey);
              },
            ),
          );
        },
      ),
    );
  }
}
