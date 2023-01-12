import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_flash_card/flash_card_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/flash_card_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FlashCardWidget extends BaseView {
  final int? courseId;

  const FlashCardWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  FlashCardWidgetState createState() => FlashCardWidgetState();
}

class FlashCardWidgetState
    extends BaseViewState<FlashCardWidget, FlashCardMyLearningViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = FlashCardMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<FlashCardMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      shouldRebuild: (pre, next) => true,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<FlashCardMyLearningViewModel, List<TypeDataModel>>(
                selector: (_, viewModel) => viewModel.dataTypes,
                shouldRebuild: (pre, next) => true,
                builder: (_, dataTypes, __) {
                  return dataTypes.isEmpty
                      ? Center(
                          child: Text(
                            Strings.of(context)!.defaultValueProfile,
                          ),
                        )
                      : GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 15.h),
                          itemCount: dataTypes.length,
                          itemBuilder: (context, index) {
                            final item = dataTypes[index];

                            return _buildItemFlashCard(item);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 2.4
                                    : 1.45,
                          ),
                        );
                },
              );
      },
    );
  }

  Widget _buildItemFlashCard(TypeDataModel item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 10.h,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              builder: (context) {
                return FlashCardView(
                  id: item.fkey,
                );
              },
            ),
          );
        },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Images.iconFlashCardItemMyLearning,
                    width: (30.w + 30.h) / 2,
                    height: (30.w + 30.h) / 2,
                    fit: BoxFit.cover,
                  ),
                  _buildItemStatusFlashCard(item.status),
                ],
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: 90.w,
                child: Text(
                  item.name ?? "",
                  style: AppText.text14.copyWith(
                    color: AppColor.neutrals.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 7.h),
              _buildItemLockStatus(item.status),
            ],
          ),
        ),
      ),
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

  Widget _buildItemLockStatus(String? status) {
    return status == Constants.statusReady
        ? const SizedBox.shrink()
        : Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                  border:
                      Border.all(color: AppColor.neutrals.shade500, width: 1.w),
                  color: AppColor.neutrals.shade500,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Images.iconLockLecture,
                      color: AppColor.redApp.shade400,
                      width: (15.w + 15.h) / 2,
                      height: (15.w + 15.h) / 2,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      Strings.of(context)!.locked,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.redApp.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
