import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/widgets/custom_expandable.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoadMapWidget extends StatefulWidget {
  final List<LectureModel> lecture;
  final bool isAction;

  const RoadMapWidget({Key? key, required this.lecture, required this.isAction})
      : super(key: key);

  @override
  State<RoadMapWidget> createState() => _RoadMapWidgetState();
}

class _RoadMapWidgetState extends State<RoadMapWidget> {
  int? tapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, indexLecture) {
        return _buildLecture(indexLecture, widget.lecture);
      },
      itemCount: widget.lecture.length,
    );
  }

  Widget _buildLecture(int indexLecture, List<LectureModel> lecture) {
    return Container(
      color: indexLecture % 2 == 0 ? AppColor.primary.shade50 : Colors.white,
      child: CustomExpandable(
        hasIcon: lecture[indexLecture].items.isNotEmpty,
        paddingHeader: 18.w,
        onTap: () {
          if (tapped != indexLecture) {
            setState(() {
              tapped = indexLecture;
            });
          }
        },
        expanded: tapped == indexLecture ? true : false,
        header: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            lecture[indexLecture].unit ?? '',
            style: AppText.text16.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        child: Container(
          child: _buildSubContent(lecture[indexLecture].items, indexLecture),
        ),
      ),
    );
  }

  Widget _buildSubContent(List<LectureModel> subContent, int indexLecture) {
    return Container(
      color: AppColor.backgroundRoadMap,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        shrinkWrap: true,
        primary: false,
        itemCount: subContent.length,
        itemBuilder: (context, indexSubContent) {
          return subContent[indexSubContent].type == Constants.defaultType
              ? _buildLesionHasSub(subContent, indexSubContent)
              : _buildLesionOnly(indexSubContent, subContent);
        },
        separatorBuilder: (context, indexSubContent) {
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildLesionHasSub(
    List<LectureModel> subContent,
    int indexSubContent,
  ) {
    return InkWell(
      onTap: widget.isAction
          ? () {
              // TODO insert event on tap in lesion
              LogUtils.d("Push to new view in lesion");
            }
          : () {
              LogUtils.d("Road_map_widget_view_only");
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.contentPaddingHorizontal,
              ),
              child: Text(
                "${indexSubContent + 1}. ${subContent[indexSubContent].unit}",
                style: AppText.text14.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 6),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: subContent[indexSubContent].items.length,
              itemBuilder: (context, indexContent) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: Constants.contentPaddingHorizontal + 26,
                    right: Constants.contentPaddingHorizontal,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: AppColor.colorShadowItemRoadMap,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildAvatarImage(subContent[indexSubContent].type),
                          SizedBox(width: 7.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subContent[indexSubContent]
                                          .items[indexContent]
                                          .name ??
                                      '',
                                  style: AppText.text14.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.neutrals.shade800,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(Images.iconFlash),
                                    SizedBox(width: 5.w),
                                    Text(
                                      subContent[indexSubContent]
                                              .items[indexContent]
                                              .type ??
                                          "",
                                      style: AppText.text12.copyWith(
                                        color: _getTypeColor(
                                          subContent[indexSubContent]
                                              .items[indexContent]
                                              .type,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // TODO insert api sequent in status
                          SvgPicture.asset(Images.iconArrowRightMyLearning),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLesionOnly(int indexSubContent, List<LectureModel> subContent) {
    return InkWell(
      onTap: widget.isAction
          ? () {
              // TODO insert event on tap in lesion
              LogUtils.d("Push to new view in lesion");
            }
          : () {
              LogUtils.d("Road_map_widget_view_only");
            },
      child: Padding(
        padding: const EdgeInsets.only(
          left: Constants.contentPaddingHorizontal,
          right: Constants.contentPaddingHorizontal * 2,
          top: 4,
          bottom: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                color: AppColor.colorShadowItemRoadMap,
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          margin: EdgeInsets.zero,
          child: Container(
            margin: const EdgeInsets.only(right: 26),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _buildAvatarImage(subContent[indexSubContent].type),
                SizedBox(width: 7.w),
                Expanded(
                  child: Text(
                    "${subContent[indexSubContent].name}",
                    style: AppText.text14.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarImage(String? type) {
    switch (type) {
      case Constants.flashcard:
        return Image.asset(
          Images.iconFlashCardRoadMap,
          width: 36.w,
          fit: BoxFit.cover,
        );
      case Constants.typeQuiz:
        return Image.asset(
          Images.iconQuizRoadMap,
          width: 36.w,
          fit: BoxFit.cover,
        );
      case Constants.typeSlideShow:
        return SvgPicture.asset(
          Images.iconSlideShowMyLearning,
          width: (37.w + 37.h) / 2,
          height: (37.w + 37.h) / 2,
          fit: BoxFit.cover,
        );
      default:
        return Image.asset(
          Images.iconFlashCardRoadMap,
          width: 36.w,
          fit: BoxFit.cover,
        );
    }
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case Constants.slideShow:
        return AppColor.primary.shade50;
      case Constants.quiz:
        return AppColor.redApp.shade400;
      case Constants.flashCard:
        return AppColor.supporting.shade600;
      default:
        return Colors.transparent;
    }
  }
}
