import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/my_learning/list_comment_view.dart';
import 'package:elearning/ui/views/my_learning/slide_show_view.dart';
import 'package:elearning/ui/widgets/shimmer_widget.dart';
import 'package:elearning/view_models/play_ground_slide_show/play_slide_show_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlaySlideShowView extends BaseView {
  final int? id;

  const PlaySlideShowView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  PlaySlideShowViewState createState() => PlaySlideShowViewState();
}

class PlaySlideShowViewState
    extends BaseViewState<PlaySlideShowView, PlaySlideShowViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = PlaySlideShowViewModel()
      ..onInitViewModel(
        context,
        id: widget.id,
      );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Selector<PlaySlideShowViewModel, bool>(
          selector: (_, viewModel) => viewModel.isLoading,
          builder: (_, isLoading, __) {
            return Selector<PlaySlideShowViewModel, List<ItemSlideShowModel>>(
              selector: (_, viewModel) => viewModel.itemSlideShows,
              shouldRebuild: (pre, next) => true,
              builder: (_, itemSlideShows, __) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: itemSlideShows.length,
                  itemBuilder: (context, index) {
                    return _buildItemSlideShow(itemSlideShows[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemSlideShow(ItemSlideShowModel itemSlideShow) {
    return Stack(
      children: [
        // TODO load video slide show  from api
        // const VideoPlayerWidget(
        //   videoUrl:
        //       "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        // ),
        // Load image slide show from api
        _buildImage(itemSlideShow),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CircleAvatar(
                radius: 17.r,
                backgroundColor: AppColor.neutrals.shade800,
                child: SvgPicture.asset(
                  Images.iconClose,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 15.h,
          bottom: MediaQuery.of(context).orientation == Orientation.portrait
              ? 160.h
              : 80.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  BottomSheetWidget().showBottomSheetWidget(
                    context,
                    content: ListCommentView(
                      comments: viewModel.comments,
                    ),
                    isScrollControlled: true,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  );
                },
                child: Opacity(
                  opacity: 0.6,
                  child: SvgPicture.asset(Images.iconListComment),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "${viewModel.comments.length}",
                style: AppText.text20.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  BottomSheetWidget().showBottomSheetWidget(
                    context,
                    content: SlideShowView(
                      slideShows: viewModel.slideShows,
                    ),
                    isScrollControlled: true,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  );
                },
                child: Opacity(
                  opacity: 0.6,
                  child: SvgPicture.asset(Images.iconSlideShow),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "${viewModel.slideShows.length}",
                style: AppText.text20.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(ItemSlideShowModel itemSlideShow) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: itemSlideShow.isLoadingImage
          ? const ShimmerWidget(
              height: double.infinity,
              width: double.infinity,
              shapeBorder: RoundedRectangleBorder(),
            )
          : (itemSlideShow.convertImage != null && itemSlideShow.isSvg
              ? SvgPicture.memory(
                  fit: BoxFit.fill,
                  itemSlideShow.convertImage!,
                )
              : itemSlideShow.convertImage != null
                  ? Image.memory(
                      fit: BoxFit.fill,
                      itemSlideShow.convertImage!,
                    )
                  : SvgPicture.asset(
                      Images.defaultCourses,
                      fit: BoxFit.fill,
                    )),
    );
  }
}
