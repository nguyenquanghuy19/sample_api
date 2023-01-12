import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_flash_card/slide_flash_card_view.dart';
import 'package:elearning/ui/widgets/flip.dart';
import 'package:elearning/view_models/play_ground_flash_card/flash_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FlashCardView extends BaseView {
  final int? id;

  const FlashCardView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  FlashCardViewState createState() => FlashCardViewState();
}

class FlashCardViewState
    extends BaseViewState<FlashCardView, FlashCardViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = FlashCardViewModel()..onInitViewModel(context, id: widget.id);
  }

  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Selector<FlashCardViewModel, bool>(
          selector: (_, viewModel) => viewModel.isLoading,
          builder: (_, isLoading, __) {
            return isLoading
                ? const Text('')
                : Selector<FlashCardViewModel, FlashCardModel?>(
                    selector: (_, viewModel) => viewModel.flashCardModel,
                    builder: (_, flashCardModel, __) {
                      return Text(
                        flashCardModel?.name ?? '',
                      );
                    },
                  );
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Tab(icon: SvgPicture.asset(Images.iconArrowLeft)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Selector<FlashCardViewModel, bool>(
            selector: (_, viewModel) => viewModel.isLoading,
            builder: (_, isLoading, __) {
              return isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: viewModel.scrollController,
                      child: Column(
                        children: [
                          _buildPreviewSlideFlashCard(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.contentPaddingHorizontal,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInformationFlashCard(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.of(context)!.termsList,
                                        style: AppText.text14.copyWith(
                                          color: AppColor.neutrals.shade800,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _buildBottomSheetSort(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SvgPicture.asset(
                                          Images.iconFilterDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Selector<FlashCardViewModel, bool>(
                                  selector: (_, viewModel) =>
                                      viewModel.isAlphaBet,
                                  builder: (_, isAlphaBet, __) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) {
                                        return _buildItemTermCard(
                                          index,
                                          isAlphaBet
                                              ? viewModel.itemsAlphaBet[index]
                                              : viewModel.items[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 6);
                                      },
                                      itemCount: viewModel.items.length,
                                    );
                                  },
                                ),
                                Selector<FlashCardViewModel, bool>(
                                  selector: (_, viewModel) =>
                                      viewModel.isShowButtonScrollTop,
                                  builder: (_, isShowButtonScrollTop, __) {
                                    return isShowButtonScrollTop
                                        ? SizedBox(
                                            height: 100.h,
                                          )
                                        : Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 80.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: AppButton(
                                              backgroundColor:
                                                  AppColor.primary.shade400,
                                              width: 200.w,
                                              styleLabel:
                                                  AppText.text24.copyWith(
                                                color: Colors.white,
                                              ),
                                              label: 'Learn now',
                                              onPressed: () {
                                                //TODO: handle ontap
                                              },
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
          _buildButtonLearnNow(),
        ],
      ),
    );
  }

  Future<dynamic> _buildBottomSheetSort(BuildContext context) {
    return BottomSheetWidget().showBottomSheetWidget(
      context,
      elevation: 5,
      maxHeight: MediaQuery.of(context).size.height * 0.25,
      isScrollControlled: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16),
            child: Center(
              child: Text(
                Strings.of(context)!.titleSortFlashcard,
                style: AppText.text18,
              ),
            ),
          ),
          ListTile(
            title: Text(
              Strings.of(context)!.sortDefault,
              style: AppText.text16,
            ),
            trailing: viewModel.isAlphaBet
                ? const SizedBox.shrink()
                : const Icon(Icons.check),
            onTap: () {
              viewModel.isChangeAlphaBet(
                false,
              );
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(
              Strings.of(context)!.sortAlphabet,
              style: AppText.text16,
            ),
            trailing: viewModel.isAlphaBet
                ? const Icon(Icons.check)
                : const SizedBox.shrink(),
            onTap: () {
              viewModel.isChangeAlphaBet(
                true,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButtonLearnNow() {
    return Selector<FlashCardViewModel, bool>(
      selector: (_, viewModel) => viewModel.isShowButtonScrollTop,
      builder: (_, isShowButtonScrollTop, __) {
        return isShowButtonScrollTop
            ? Positioned(
                bottom: 0,
                child: Container(
                  height: 80.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: AppButton(
                      backgroundColor: AppColor.primary.shade400,
                      width: 200.w,
                      styleLabel: AppText.text24.copyWith(color: Colors.white),
                      label: 'Learn now',
                      onPressed: () {
                        //TODO: handle onTap
                      },
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildPreviewSlideFlashCard() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, realIndex) {
        final item = viewModel.items.elementAt(index);

        return Flip(
          key: UniqueKey(),
          flipDirection: Axis.vertical,
          firstChild: _buildContentSlideFlashCard(item.term),
          secondChild: _buildContentSlideFlashCard(item.definition),
          controller: FlipController(),
        );
      },
      itemCount: viewModel.items.length,
    );
  }

  Widget _buildInformationFlashCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.flashCardModel?.name ?? '',
          style: AppText.text18.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SizedBox(
              child: SvgPicture.asset(
                Images.iconBookMark,
                width: 12.w,
                height: 14.h,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              "${viewModel.flashCardModel?.items.length ?? 0} ${Strings.of(context)!.terms}",
              style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
            ),
          ],
        ),
        Selector<FlashCardViewModel, int>(
          selector: (_, viewModel) => viewModel.counterRemember.length,
          builder: (_, counterRemember, __) {
            return AnimatedOpacity(
              opacity: counterRemember != 0 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: counterRemember != 0 ? null : 0,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    _buildSelectedButtonRemember(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContentSlideFlashCard(String? text) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 5.0,
      child: Stack(
        children: [
          Center(
            child: Text(
              textAlign: TextAlign.center,
              text ?? "",
              style: AppText.text18.copyWith(
                color: AppColor.neutrals.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: InkWell(
              onTap: () {
                if (viewModel.flashCardModel == null) {
                  return;
                }
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute<void>(
                    builder: (context) {
                      return SlideFlashCardView(viewModel.flashCardModel);
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  Images.iconArrowExpand,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTermCard(int index, TermModel term) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  term.term ?? "",
                  style: AppText.text18
                      .copyWith(color: AppColor.neutrals.shade800),
                ),
                SizedBox(height: 10.h),
                Text(
                  term.definition ?? "",
                  style: AppText.text18
                      .copyWith(color: AppColor.neutrals.shade800),
                ),
                SizedBox(height: 5.h),
                // if (term.image != null) ...{
                //   Image.memory(
                //     term.image as Uint8List,
                //     fit: BoxFit.cover,
                //     width: MediaQuery.of(context).size.height * 0.2,
                //     height: MediaQuery.of(context).size.height * 0.2,
                //   ),
                // },
              ],
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        audioPlayer.play(
                          UrlSource(
                            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                          ),
                        );
                      },
                      child: const Icon(Icons.volume_up),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Selector<FlashCardViewModel, bool>(
                      selector: (_, viewModel) =>
                          viewModel.items[index].isRemember,
                      builder: (_, isRemember, __) {
                        return InkWell(
                          onTap: () {
                            viewModel.actionRemember(term);
                          },
                          child: term.isRemember
                              ? Icon(
                                  Icons.star,
                                  color: AppColor.primary.shade400,
                                )
                              : const Icon(Icons.star_border),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemSelectedStateButton(
    FlashCardSelectedState currentState,
    bool isSelected,
    int number,
  ) {
    String title = currentState == FlashCardSelectedState.remember
        ? Strings.of(context)!.remember
        : Strings.of(context)!.all;
    bool isVisibleNumber = currentState == FlashCardSelectedState.remember;

    return InkWell(
      onTap: () => viewModel.onSelectedCurrentListState(currentState),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueAccent),
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          width: 130.w,
          child: Stack(
            children: [
              Center(
                child: Text(
                  title,
                  style: AppText.text18.copyWith(
                    color:
                        isSelected ? Colors.white : AppColor.neutrals.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (isVisibleNumber) ...{
                Positioned(
                  right: 5.w,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColor.primary.shade400
                          : AppColor.neutrals.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "$number",
                      style: AppText.text14.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColor.neutrals.shade800,
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedButtonRemember() {
    return Selector<FlashCardViewModel, FlashCardSelectedState>(
      selector: (_, viewModel) => viewModel.currentSelectedState,
      builder: (_, currentState, __) {
        return Selector<FlashCardViewModel, int>(
          selector: (_, viewModel) => viewModel.counterRemember.length,
          builder: (_, counterRemember, __) {
            return SizedBox(
              height: 35.h,
              child: Row(
                children: [
                  _buildItemSelectedStateButton(
                    FlashCardSelectedState.values[0],
                    FlashCardSelectedState.values[0] ==
                        viewModel.currentSelectedState,
                    counterRemember,
                  ),
                  _buildItemSelectedStateButton(
                    FlashCardSelectedState.values[1],
                    FlashCardSelectedState.values[1] ==
                        viewModel.currentSelectedState,
                    counterRemember,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
