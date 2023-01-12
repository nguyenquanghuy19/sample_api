import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/forum/forum_topic_view_model.dart';

class ForumTopicView extends BaseView {
  final String slug;
  final String nameTopic;

  const ForumTopicView({Key? key, required this.slug, required this.nameTopic})
      : super(key: key);

  @override
  ForumTopicViewState createState() => ForumTopicViewState();
}

class ForumTopicViewState
    extends BaseViewState<ForumTopicView, ForumTopicViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ForumTopicViewModel(slug: widget.slug)
      ..onInitViewModel(context);
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
      appBar: AppBar(
        title: const Text("ZSDZLSD"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Text(
                "Forum • ZSDZLSD",
                style: AppText.text21,
              ),
            ),
            SizedBox(height: 5.h),
            _buildListDevelopmentCourse(),
          ],
        ),
      ),
    );
  }

  Widget _buildListDevelopmentCourse() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 16.w),
      shrinkWrap: true,
      primary: false,
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildItemDevelopmentCourse();
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          height: 0,
        );
      },
    );
  }

  Widget _buildItemDevelopmentCourse() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          children: [
            Icon(Icons.layers, size: 45.h),
            SizedBox(width: 24.w),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "ZSDSDSD",
                      style: AppText.text18.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.supporting,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "20",
                            textAlign: TextAlign.end,
                            style: AppText.text16.copyWith(),
                          ),
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 22.h,
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
}
