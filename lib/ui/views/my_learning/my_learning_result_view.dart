import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_result_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyLearningResultView extends BaseView {
  const MyLearningResultView({Key? key}) : super(key: key);

  @override
  MyLearningResultViewState createState() => MyLearningResultViewState();
}

class MyLearningResultViewState
    extends BaseViewState<MyLearningResultView, MyLearningResultViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MyLearningResultViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft),
          ),
        ),
        title: Text(
          Strings.of(context)!.titleMyResultScreen,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _buildHeaderMyResult(),
            const SizedBox(height: 7),
            _buildAchievements(),
            const SizedBox(height: 15),
            _buildTimes(),
            const SizedBox(height: 15),
            _buildTopQuiz(),
            const SizedBox(height: 15),
            _buildTopCourse(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderMyResult() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: const AssetImage(Images.defaultAvatar),
          ),
          const SizedBox(height: 6),
          Text(
            // [TODO] Handler show account name
            "AccountName",
            style: AppText.text14.copyWith(
              color: AppColor.supporting.shade600,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context)!.titleAchievementsMyResult,
          style: AppText.text16.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildContentAchievements(),
        ),
      ],
    );
  }

  Widget _buildContentAchievements() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.iconCourseResult,
                      width: 75.w,
                      height: 75.h,
                    ),
                    Text(
                      "13",
                      style: AppText.text14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.of(context)!.course,
                  style: AppText.text14.copyWith(
                    color: AppColor.neutrals.shade800,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.iconCompletedResult,
                      width: 75.w,
                      height: 75.h,
                    ),
                    Text(
                      "12",
                      style: AppText.text14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.of(context)!.titleCompletedMyResult,
                  style: AppText.text14.copyWith(
                    color: AppColor.neutrals.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.iconTimeResult,
                      width: 75.w,
                      height: 75.h,
                    ),
                    Text(
                      "56:12",
                      style: AppText.text14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.of(context)!.titleTimeResultQuiz,
                  style: AppText.text14.copyWith(
                    color: AppColor.neutrals.shade800,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.iconPointResult,
                      width: 75.w,
                      height: 75.h,
                    ),
                    Positioned(
                      top: 75.h / 3,
                      child: Text(
                        "95",
                        style: AppText.text14.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.of(context)!.point,
                  style: AppText.text14.copyWith(
                    color: AppColor.neutrals.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context)!.titleTimeResultQuiz,
          style: AppText.text16.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildListTime(),
              AppButton(
                width: 120,
                height: 31,
                backgroundColor: AppColor.primary.shade400,
                label: Strings.of(context)!.titleViewAllMyResult,
                styleLabel: AppText.text15.copyWith(color: Colors.white),
                // [TODO] Handler event button
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTime() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      itemBuilder: (context, index) {
        return _buildItemTimeResult();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
      itemCount: 3,
    );
  }

  Widget _buildItemTimeResult() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(
          Images.iconTargetResult,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Course Name 0001",
                  style: AppText.text14
                      .copyWith(color: AppColor.neutrals.shade800),
                ),
                const SizedBox(height: 5),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  percent: 60 / 100,
                  restartAnimation: true,
                  lineHeight: 10.h,
                  animation: true,
                  animationDuration: 1000,
                  backgroundColor: AppColor.neutrals.shade50,
                  progressColor: AppColor.neutrals.shade300,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          "150 h",
          style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
        ),
      ],
    );
  }

  Widget _buildTopQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context)!.titleTopQuizMyResult,
          style: AppText.text16.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                itemBuilder: (context, index) {
                  return _buildItemTopQuizResult();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15);
                },
                itemCount: 3,
              ),
              AppButton(
                width: 120,
                height: 31,
                backgroundColor: AppColor.primary.shade400,
                label: Strings.of(context)!.titleViewAllMyResult,
                styleLabel: AppText.text15.copyWith(color: Colors.white),
                // [TODO] Handler event button
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemTopQuizResult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              Images.iconPointResult,
              width: 75.w,
              height: 75.h,
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
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quiz Name 0001",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade800,
                ),
              ),
              Text(
                "2022/11/20 09:30 GMT+07",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                ),
              ),
              Text(
                "Course Name 00001",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopCourse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context)!.titleTopCourseMyResult,
          style: AppText.text16.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return _buildItemTopCourse();
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width >=
                          Constants.sizeScreenCheck
                      ? 3
                      : 2,
                  crossAxisSpacing: 30,
                  childAspectRatio: MediaQuery.of(context).size.width >=
                          Constants.sizeScreenCheck
                      ? (MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 0.9
                          : 0.73)
                      : (MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 1.1
                          : 0.6),
                ),
              ),
              const SizedBox(height: 5),
              AppButton(
                width: 120,
                height: 31,
                backgroundColor: AppColor.primary.shade400,
                label: Strings.of(context)!.titleViewAllMyResult,
                styleLabel: AppText.text15.copyWith(color: Colors.white),
                // [TODO] Handler event button
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemTopCourse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPieChart(),
        const SizedBox(height: 10),
        Text(
          // [TODO] Handler show course name
          "Course Name 001",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          // [TODO] Handler show user name
          "NguyenNT",
          style: AppText.text14.copyWith(
            color: AppColor.blueAccent.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          // [TODO] Handler show teacher name
          "N2 teacher",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio:
          MediaQuery.of(context).orientation == Orientation.landscape ? 1.5 : 1,
      child: PieChart(
        PieChartData(
          sectionsSpace: 1,
          centerSpaceRadius: 3.r,
          sections: _showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    // [TODO] value PIE chart flutter
    return List.generate(2, (index) {
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: AppColor.supporting.shade300,
            value: 30,
            title: "30%",
            radius: 80.r,
            titleStyle: AppText.text16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.neutrals.shade800,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColor.supporting.shade50,
            value: 70,
            title: "70%",
            radius: 80.r,
            titleStyle: AppText.text16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.neutrals.shade800,
            ),
          );
        default:
          throw Exception();
      }
    });
  }
}
