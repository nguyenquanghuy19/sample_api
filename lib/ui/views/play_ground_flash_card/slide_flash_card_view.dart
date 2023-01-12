import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_flash_card/bottom_sheet_setting_flash_card_widget.dart';
import 'package:elearning/ui/widgets/flip.dart';
import 'package:elearning/ui/widgets/slide_item_custom/term_swiper.dart';
import 'package:elearning/ui/widgets/term_widget.dart';
import 'package:elearning/view_models/play_ground_flash_card/slide_flash_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class SlideFlashCardView extends BaseView {
  final FlashCardModel? flashCardModel;

  const SlideFlashCardView(
    this.flashCardModel, {
    Key? key,
  }) : super(key: key);

  @override
  SlideFlashCardViewState createState() => SlideFlashCardViewState();
}

class SlideFlashCardViewState
    extends BaseViewState<SlideFlashCardView, SlideFlashCardViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SlideFlashCardViewModel()..onInitViewModel(context);
    viewModel.flashCard = widget.flashCardModel;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Selector<SlideFlashCardViewModel, int>(
          selector: (_, viewModel) => viewModel.positionCurrent,
          builder: (_, position, __) {
            return Text(
              position == viewModel.flashCard?.items.length
                  ? "$position/${viewModel.flashCard?.items.length}"
                  : "${position + 1}/${viewModel.flashCard?.items.length}",
            );
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Tab(icon: SvgPicture.asset(Images.iconClose)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Tab(icon: SvgPicture.asset(Images.iconSetting, width: 24)),
            onPressed: () {
              BottomSheetWidget().showBottomSheetWidget(
                context,
                elevation: 5,
                maxHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height,
                isScrollControlled: false,
                content: BottomSheetSettingFlashCardWidget(
                  isShuffleAction: viewModel.isShuffleAction,
                  isSoundAction: viewModel.isSoundAction,
                  isSwapContent: viewModel.isSwapContent,
                  onApply: (isShuffleAction, isSoundAction, isSwapContent) {
                    viewModel.onApply(
                      isShuffleAction,
                      isSoundAction,
                      isSwapContent,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProgressFlashCard(),
            const SizedBox(height: 20),
            Selector<SlideFlashCardViewModel, bool>(
              selector: (_, viewModel) => viewModel.isLastSlide,
              builder: (_, isLastSlide, __) {
                return isLastSlide
                    ? const SizedBox.shrink()
                    : _buildCounterRememberFlashCard();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.contentPaddingHorizontal,
              ),
              child: Selector<SlideFlashCardViewModel, bool>(
                selector: (_, viewModel) => viewModel.isLastSlide,
                builder: (_, isLastSlide, __) {
                  return Column(
                    children: [
                      isLastSlide
                          ? _buildWhenLastSlide()
                          : _buildSlideFlashCard(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Selector<SlideFlashCardViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLastSlide,
        builder: (_, isLastSlide, __) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 30.h),
              child: isLastSlide
                  ? _buildFooterWhenLastSlide()
                  : _buildOptionSlideFlashCard(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFooterWhenLastSlide() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          label: Strings.of(context)!.reLearnTerm,
          styleLabel: AppText.text24.copyWith(color: Colors.white),
          onPressed: () {
            viewModel.reset();
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        AppButton(
          label: Strings.of(context)!.back,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildWhenLastSlide() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                Strings.of(context)!.contentCongrats,
                style: AppText.text18.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Image.asset(
              Images.imageCongrats,
              height: 120.h,
              width: 120.w,
            ),
          ],
        ),
        SizedBox(
          height: 45.h,
        ),
        Row(
          children: [
            CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              radius: 50.0.r,
              lineWidth: 12,
              backgroundColor: AppColor.primary.shade400,
              progressColor: Colors.greenAccent.shade400,
              percent: viewModel.rememberIds.length /
                  (viewModel.flashCard?.items.length ?? 1),
              center: Text(
                "${((viewModel.rememberIds.length / (viewModel.flashCard?.items.length ?? 1)) * 100).toString().split('.')[0]}%",
                style: AppText.text16,
              ),
            ),
            SizedBox(
              width: 25.w,
            ),
            Expanded(
              child: SizedBox(
                height: 110.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.of(context)!.known,
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${viewModel.rememberIds.length}',
                              style: AppText.text14.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.of(context)!.studying,
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: AppColor.primary[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${viewModel.forgetIds.length}',
                              style: AppText.text14.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.of(context)!.remaining,
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '0',
                              style: AppText.text14.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 170.h,
        ),
      ],
    );
  }

  Widget _buildCounterRememberFlashCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColor.primary.shade50,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Selector<SlideFlashCardViewModel, int>(
            selector: (_, viewModel) => viewModel.forgetIds.length,
            builder: (_, counter, __) => Text(
              "$counter",
              style: AppText.text20.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Selector<SlideFlashCardViewModel, int>(
            selector: (_, viewModel) => viewModel.rememberIds.length,
            builder: (_, counter, __) => Text(
              "$counter",
              style: AppText.text20.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressFlashCard() {
    return Selector<SlideFlashCardViewModel, int>(
      selector: (_, viewModel) => viewModel.positionCurrent,
      builder: (_, position, __) {
        final size = viewModel.flashCard?.items.length ?? 1;
        final percentCurrent = position / size;

        return LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 2.0,
          percent: percentCurrent,
          backgroundColor: AppColor.neutrals.shade300,
          progressColor: AppColor.primary.shade400,
        );
      },
    );
  }

  Widget _buildSlideFlashCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Selector<SlideFlashCardViewModel, bool>(
        selector: (_, viewModel) => viewModel.isSwapContent,
        builder: (_, isSwapContent, __) {
          return Selector<SlideFlashCardViewModel, bool>(
            selector: (_, viewModel) => viewModel.isRandom,
            builder: (_, isRandom, __) {
              return TermSwiper(
                unlimitedUnswipe: true,
                items: isRandom
                    ? viewModel.randomTerms.toList()
                    : viewModel.flashCard?.items.reversed.toList() ?? [],
                controller: viewModel.swiperController,
                verticalSwipeEnabled: false,
                placeHolder: _buildPlaceHolderFlashCard(),
                onEnd: () {
                  viewModel.isLastSlide = true;
                },
                onSwipe: (int index, TermSwiperDirection direction) {
                  String id = (isRandom
                          ? viewModel.randomTerms.toList()
                          : viewModel.flashCard?.items.reversed.toList() ??
                              [])[index]
                      .id
                      .toString();
                  if (direction == TermSwiperDirection.left) {
                    viewModel.forget(id);
                  } else if (direction == TermSwiperDirection.right) {
                    viewModel.remember(id);
                  }
                },
                onSwipeMode: (TermOutlineMode mode) {
                  viewModel.swiperShowedController?.mode = mode;
                },
                onUndoSwipe: (termUndo) {
                  viewModel.undoSlide(termUndo.id.toString());
                },
                itemBuilder: (context, data) {
                  TermWidget widget = TermWidget(
                    swapContent: isSwapContent,
                    key: ValueKey(data.id),
                    termModel: data,
                    flipController: FlipController(),
                    swiperController: TermController(),
                  );
                  viewModel.flipShowedController = widget.flipController;
                  viewModel.swiperShowedController = widget.swiperController;

                  return widget;
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildOptionSlideFlashCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => viewModel.startAutoSlideFlashCard(),
            child: Selector<SlideFlashCardViewModel, bool>(
              selector: (_, viewModel) => viewModel.isAutoSlide,
              builder: (_, isAutoSlide, __) {
                return Icon(
                  isAutoSlide ? Icons.pause : Icons.play_arrow,
                  size: 30,
                );
              },
            ),
          ),
          Selector<SlideFlashCardViewModel, int>(
            selector: (_, viewModel) => viewModel.positionCurrent,
            builder: (_, position, __) {
              return InkWell(
                onTap: () => viewModel.swiperController.unswipe(),
                child: Icon(
                  Icons.undo,
                  size: 30,
                  color: position == 0 ? Colors.grey : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<TermModel> getTermsWithMode(bool isRandom) {
    return isRandom
        ? viewModel.randomTerms.toList()
        : viewModel.flashCard?.items.reversed.toList() ?? [];
  }

  Widget _buildPlaceHolderFlashCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 1.0,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.6,
    );
  }
}
