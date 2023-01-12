import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/result_my_learning_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResultWidget extends BaseView {
  final int? courseId;

  const ResultWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  ResultWidgetState createState() => ResultWidgetState();
}

class ResultWidgetState
    extends BaseViewState<ResultWidget, ResultMyLearningViewModel> {
  DateTime selectDate = DateTime.now();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ResultMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return _buildMyLearningDetailResult();
  }

  Widget _buildMyLearningDetailResult() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: Constants.contentPaddingHorizontal.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRankInformation(),
          SizedBox(height: 14.h),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.of(context)!.titleLearningTime,
                        style: AppText.text16
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      _buildSelectDate(),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _chartTimeResult(),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            Strings.of(context)!.quizCompleted,
            style: AppText.text16.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 14.h),
          _buildListQuizCompleted(),
        ],
      ),
    );
  }

  Widget _buildRankInformation() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      Images.imageRankNumber,
                      height: 90.h,
                      width: 85.w,
                    ),
                    Text(
                      // TODO insert rank
                      "3",
                      style: AppText.text18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  Strings.of(context)!.rankMyLearning,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  // TODO insert point
                  "190 ${Strings.of(context)!.point}",
                  style: AppText.text14
                      .copyWith(color: AppColor.neutrals.shade300),
                ),
              ],
            ),
            _buildItemStatusRank(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemStatusRank() {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 90.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Images.iconProgressRank),
                  SizedBox(width: 14.w),
                  Text(
                    "${Strings.of(context)!.progress}:",
                    style: AppText.text14,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      percent: 50 / 100,
                      restartAnimation: true,
                      lineHeight: 8,
                      animation: true,
                      animationDuration: 1000,
                      backgroundColor: AppColor.neutrals.shade300,
                      progressColor: AppColor.primary.shade400,
                      barRadius: const Radius.circular(100),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    // TODO insert progress
                    "50%",
                    style: AppText.text14,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(Images.iconTimeRank),
                  SizedBox(width: 14.w),
                  SizedBox(
                    width: 100,
                    child: Text(
                      Strings.of(context)!.time,
                      style: AppText.text14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // TODO insert time
                      "12h40m",
                      style: AppText.text14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(Images.iconAttendanceRank),
                  SizedBox(width: 14.w),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "${Strings.of(context)!.attendance}:",
                      style: AppText.text14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // TODO insert attendance
                      "3/15 ${Strings.of(context)!.absent}",
                      style: AppText.text14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListQuizCompleted() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildItemQuizCompleted();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      // [TODO] Handler click view more quiz completed
                    },
                    child: Row(
                      children: [
                        Text(
                          Strings.of(context)!.viewMore,
                          style: AppText.text14.copyWith(
                            color: AppColor.supporting.shade600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SvgPicture.asset(
                          Images.iconArrowRight,
                          width: (6.w + 10.h) / 2,
                          height: (6.w + 10.h) / 2,
                          color: AppColor.supporting.shade600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemQuizCompleted() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Images.iconPointResult,
                width: 75,
                height: 75,
              ),
              Positioned(
                top: 75.h / 3,
                child: Text(
                  "90",
                  style: AppText.text14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // TODO insert quiz name
                  "Quiz Name 0001",
                  style: AppText.text16.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 4),
                Text(
                  // TODO insert date
                  "2022/11/20 09:30 GMT+07",
                  style: AppText.text14
                      .copyWith(color: AppColor.neutrals.shade300),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Images.iconTimer,
                          width: (15.h + 15.w) / 2,
                          height: (15.h + 15.w) / 2,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          // TODO insert time
                          "${Strings.of(context)!.time}: 18:23",
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Images.iconQuestionRank,
                          width: (15.h + 15.w) / 2,
                          height: (15.h + 15.w) / 2,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          // TODO insert question
                          "${Strings.of(context)!.question}: 30",
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Images.iconResultRank,
                          width: (15.h + 15.w) / 2,
                          height: (15.h + 15.w) / 2,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          // TODO insert result
                          "${Strings.of(context)!.result}: 25/30",
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'MON';
        break;
      case 1:
        text = 'TUE';
        break;
      case 2:
        text = 'WED';
        break;
      case 3:
        text = 'THU';
        break;
      case 4:
        text = 'FRI';
        break;
      case 5:
        text = 'SAT';
        break;
      case 6:
        text = 'SUN';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: AppText.text12.copyWith(color: Colors.black.withOpacity(0.4)),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '1h';
        break;
      case 2:
        text = '2h';
        break;
      case 3:
        text = '3h';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: AppText.text14.copyWith(color: Colors.black.withOpacity(0.4)),
      ),
    );
  }

  Widget _chartTimeResult() {
    return AspectRatio(
      aspectRatio: 1.66,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: _bottomTitles,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: leftTitles,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.black.withOpacity(0.05),
              strokeWidth: 1,
            ),
            drawVerticalLine: false,
            drawHorizontalLine: true,
          ),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(color: Colors.black.withOpacity(0.2)),
            ),
          ),
          barGroups: getData(),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 2,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 1
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 3,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 2
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 4,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 3
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 2,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 4
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 1,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 5
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 3,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 6
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            toY: 4,
            width: 18.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
            color: selectDate.weekday == 7
                ? AppColor.neutrals.shade800
                : AppColor.neutrals.shade100,
          ),
        ],
      ),
    ];
  }

  Future<void> _showDatePicker() async {
    final res = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      errorFormatText: Strings.of(context)!.messageErrorDatePicker,
      errorInvalidText: Strings.of(context)!.messageErrorInvalidDatePicker,
      helpText: Strings.of(context)!.hintTextDateOfBirth,
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(3000),
    );
    if (res != null) {
      setState(() {
        selectDate = res;
      });
    }
  }

  Widget _buildSelectDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.neutrals.shade400),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            DateFormat('dd/MM/yyyy').format(selectDate),
            style: AppText.text14,
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            _showDatePicker();
          },
          child: Icon(
            FontAwesomeIcons.calendar,
            size: 20.h,
          ),
        ),
      ],
    );
  }
}
