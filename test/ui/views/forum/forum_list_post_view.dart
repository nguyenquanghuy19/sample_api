import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/forum/forum_list_post_view_model.dart';

class ForumListPostView extends BaseView {
  final String slug;
  final String nameGroup;

  const ForumListPostView({
    Key? key,
    required this.slug,
    required this.nameGroup,
  }) : super(key: key);

  @override
  ForumListCourseViewState createState() => ForumListCourseViewState();
}

class ForumListCourseViewState
    extends BaseViewState<ForumListPostView, ForumListPostViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ForumListPostViewModel()..onInitViewModel(context);
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
        title: Text(widget.nameGroup),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildItem();
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Colors.grey,
            height: 0,
            indent: 16.w,
            endIndent: 16.w,
          );
        },
      ),
    );
  }

  Widget _buildItem() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h * 2, horizontal: 16.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.h,
              backgroundImage:
                  const AssetImage('assets/images/default_avt.jpg'),
            ),
            SizedBox(width: 4.w * 3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ZSDZSDZSDZSD",
                    style: AppText.text18.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(
                    TextSpan(
                      children: const [
                        TextSpan(text: "GFFGFGFGFG"),
                        TextSpan(
                          text: "10/28/2022",
                        ),
                      ],
                      style: AppText.text16,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  const Text("Views: 0"),
                  SizedBox(height: 4.h),
                  const Text("Replies: 0"),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 38.h * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
