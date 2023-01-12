import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_flash_card/flash_card_view.dart';
import 'package:elearning/ui/views/play_ground_slide_show/play_slide_show_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/my_learning_detail_view_model.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/road_map_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:provider/provider.dart';

class RoadMapMyLearningWidget extends BaseView {
  final int courseId;

  const RoadMapMyLearningWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  RoadMapMyLearningWidgetState createState() => RoadMapMyLearningWidgetState();
}

class RoadMapMyLearningWidgetState
    extends BaseViewState<RoadMapMyLearningWidget, RoadMapMyLearningViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = RoadMapMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<MyLearningDetailViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      shouldRebuild: (pre, next) => true,
      builder: (_, isLoadingRoadMap, __) {
        return isLoadingRoadMap
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<MyLearningDetailViewModel, DataRoadmap?>(
                selector: (_, viewModel) => viewModel.dataRoadmap,
                shouldRebuild: (pre, next) => true,
                builder: (_, dataRoadmap, __) {
                  return dataRoadmap != null && dataRoadmap.items.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              SvgPicture.asset("assets/images/start_quiz.svg"),
                              CustomPaint(
                                painter: DashedLinePainterTop(
                                  widthScreen:
                                      MediaQuery.of(context).size.width,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildListLecture(dataRoadmap.items, dataRoadmap),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(Strings.of(context)!.defaultValueProfile),
                        );
                },
              );
      },
    );
  }

  Widget _buildListLecture(
    List<LectureModel> lecture,
    DataRoadmap dataRoadmap,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: lecture.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.contentPaddingHorizontal,
              ),
              width: MediaQuery.of(context).size.width,
              color: _fillColorItem(index),
              height: 47,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${lecture[index].unit}",
                    style: AppText.text16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Text(
                      "${lecture[index].items.length}",
                      style: AppText.text14.copyWith(
                        color: AppColor.neutrals.shade300,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildListLesion(
              index,
              lecture[index].items,
              dataRoadmap,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return dataRoadmap.startLeft(index)
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 76),
                child: CustomPaint(
                  painter: DashedLinePainterTwoItemLeft(
                    widthScreen: MediaQuery.of(context).size.width,
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 76),
                child: CustomPaint(
                  painter: DashedLinePainterTwoItemRight(
                    widthScreen: MediaQuery.of(context).size.width,
                  ),
                ),
              );
      },
    );
  }

  Color _fillColorItem(int index) {
    List colorList = [
      AppColor.redApp.shade200,
      AppColor.greenAccent.shade200,
      AppColor.supporting.shade200,
      AppColor.yellow.shade200,
      AppColor.primary.shade200,
    ];

    return colorList[index % colorList.length];
  }

  Widget _buildListLesion(
    int indexLecture,
    List<LectureModel> subContent,
    DataRoadmap dataRoadmap,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: Constants.contentPaddingHorizontal,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: subContent.length,
      itemBuilder: (BuildContext context, int indexLesion) {
        return Align(
          alignment: dataRoadmap.startLeftPosition(indexLecture, indexLesion)
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: SizedBox(
            width: 120,
            child: InkWell(
              onTap: () async {
                await _handlerRouteType(subContent[indexLesion]);
              },
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 3,
                            // [TODO] fill color border image for sequent lecture or lesion
                            color: subContent[indexLesion].status!.isNotEmpty &&
                                    subContent[indexLesion].status ==
                                        Constants.statusReady
                                ? AppColor.greenAccent.shade300
                                : AppColor.redApp.shade200,
                          ),
                          color: AppColor.yellow.shade100,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/images/bg_roadmap_${indexLesion % 10 + 1}.svg",
                        ),
                      ),
                      (subContent[indexLesion].status!.isNotEmpty &&
                              subContent[indexLesion].status ==
                                  Constants.statusReady)
                          ? const SizedBox.shrink()
                          : Positioned(
                              bottom: 8,
                              child: SvgPicture.asset(
                                Images.iconLockRoadMap,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subContent[indexLesion].type == Constants.defaultType
                        ? "${subContent[indexLesion].unit}"
                        : "${subContent[indexLesion].name}",
                    style: AppText.text16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: subContent[indexLesion].status!.isNotEmpty &&
                              subContent[indexLesion].status ==
                                  Constants.statusReady
                          ? AppColor.neutrals.shade500
                          : AppColor.redApp.shade200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  _buildItemUnit(subContent, indexLesion),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int indexLession) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: dataRoadmap.startLeftPosition(indexLecture, indexLession)
                ? DashLinePainterLeft()
                : DashLinePainterRight(),
          ),
        );
      },
    );
  }

  Future<void> _handlerRouteType(LectureModel subContent) async {
    if (subContent.type == Constants.flashCard &&
        subContent.status == Constants.statusReady) {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (context) {
            return FlashCardView(
              id: subContent.fkey,
            );
          },
        ),
      );
    }

    if (subContent.type == Constants.slideShow &&
        subContent.status == Constants.statusReady) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) {
            return PlaySlideShowView(
              id: subContent.fkey,
            );
          },
        ),
      );
    }

    if (subContent.type == Constants.quiz &&
        subContent.status == Constants.statusReady) {
      await viewModel.handlerMoveQuizItem(idQuiz: subContent.fkey);
    }
  }

  Widget _buildItemUnit(List<LectureModel> subContent, int indexLesion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        subContent[indexLesion].status!.isNotEmpty &&
                subContent[indexLesion].status == Constants.statusReady
            ? const SizedBox.shrink()
            : Row(
                children: [
                  SvgPicture.asset(Images.iconLockLesion),
                  SizedBox(width: 6.w),
                ],
              ),
        Text(
          subContent.length == 1
              ? Strings.of(context)!.titleUnit
              : Strings.of(context)!.titleUnits("${subContent.length}"),
          style: AppText.text14.copyWith(
            fontWeight: FontWeight.w700,
            color: subContent[indexLesion].status!.isNotEmpty &&
                    subContent[indexLesion].status == Constants.statusReady
                ? AppColor.neutrals.shade500
                : AppColor.redApp.shade200,
          ),
        ),
      ],
    );
  }
}

class DashLinePainterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.neutrals.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path = Path();
    path.cubicTo(
      size.width / 4 * 0.5,
      3.5 * size.height / 4,
      3.5 * size.width / 4,
      size.height / 4 * 0.5,
      size.width,
      size.height,
    );
    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10, 8]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashLinePainterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.neutrals.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(
      size.width / 4 * 0.5,
      size.height / 4 * 0.5,
      3.5 * size.width / 4,
      3.5 * size.height / 4,
      size.width,
      0,
    );
    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10, 8]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainterTop extends CustomPainter {
  final double widthScreen;

  DashedLinePainterTop({required this.widthScreen});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.neutrals.shade200
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    Path path = Path();

    path.quadraticBezierTo(
      size.width,
      size.height + 5,
      size.width - 5,
      size.height + 7,
    );
    path.moveTo(size.width - (widthScreen / 2 - 95), size.height + 10);
    path.quadraticBezierTo(
      size.width - (widthScreen / 2 - 80),
      size.height + 60,
      size.width - (widthScreen / 2 - 75),
      size.height + 87,
    );
    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10, 8]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainterTwoItemLeft extends CustomPainter {
  final double widthScreen;

  DashedLinePainterTwoItemLeft({required this.widthScreen});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.neutrals.shade200
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path.moveTo(0, -30);

    path.cubicTo(
      size.width / 4 * 0.25,
      (size.height + 30),
      3.6 * size.width / 4,
      size.height / 4 * 0.5,
      size.width,
      size.height + 47 + 30,
    );
    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10, 8]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainterTwoItemRight extends CustomPainter {
  final double widthScreen;

  DashedLinePainterTwoItemRight({required this.widthScreen});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.neutrals.shade200
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    Path path = Path();

    path.moveTo(0, size.height + 47 + 30);
    path.cubicTo(
      size.width / 4 * 0.3,
      (size.height + 47 / 2) / 4 * 0.5,
      3.85 * size.width / 4,
      (size.height + 47 / 2) / 4 * 3.5,
      size.width,
      size.height - 30,
    );
    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10, 8]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
