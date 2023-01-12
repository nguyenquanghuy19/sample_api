import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/forum/forum_course_view_model.dart';

class ForumCourseView extends BaseView {
  const ForumCourseView({Key? key}) : super(key: key);

  @override
  ForumCourseState createState() => ForumCourseState();
}

class ForumCourseState
    extends BaseViewState<ForumCourseView, ForumCourseViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ForumCourseViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Forum",
          style: AppText.text24
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Selector<ForumCourseViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              children: [
                _buildBanner(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      _buildGeneral(),
                      SizedBox(
                        height: 15.h,
                      ),
                      _buildMajor(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGeneral() {
    return Column(
      children: [
        _buildHeader("General"),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return _buildItemGeneral();
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
              color: Colors.grey,
              height: 0,
            );
          },
        ),
      ],
    );
  }

  Widget _buildItemGeneral() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(
              Icons.layers,
              size: 35.h,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Development",
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  const Text("Development"),
                ],
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            Row(
              children: [
                const Text("20"),
                SizedBox(width: 5.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      color: Colors.yellow.shade100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.h),
      child: Text(
        title,
        style: AppText.text20,
      ),
    );
  }

  Widget _buildMajor() {
    return Column(
      children: [
        _buildHeader("Major"),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return _buildItemMajor();
          },
          itemCount: 3,
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
              color: Colors.grey,
              height: 0,
            );
          },
        ),
      ],
    );
  }

  Widget _buildItemMajor() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(
              Icons.layers,
              size: 35.h,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Development",
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: List<Widget>.generate(
                      5,
                      (index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Icon(
                              Icons.cookie,
                              size: 17.h,
                              color: AppColor.neutrals,
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          const Flexible(
                            child: Text("Development"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50.h,
            ),
            Row(
              children: [
                const Text("5"),
                SizedBox(
                  width: 5.w,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: <Color>[
            AppColor.primary.shade300,
            AppColor.primary.shade400,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome To Our Educational ReSource',
            textAlign: TextAlign.center,
            style: AppText.text26.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'A Place Where You Can Learn Any Course Online And Discuss Your Problem With Each Other, Help OThers And Contribute ReSources',
            style: AppText.text20,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
