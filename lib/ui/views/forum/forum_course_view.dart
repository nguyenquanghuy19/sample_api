import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/forum/forum_list_post_view.dart';
import 'package:elearning/ui/views/forum/forum_topic_view.dart';
import 'package:elearning/view_models/forum/forum_course_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary.shade400,
        title: Text(
          Strings.of(context)!.forum,
          style: AppText.text22,
        ),
        centerTitle: true,
      ),
      body: Selector<ForumCourseViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Column(
                    children: [
                      _buildBanner(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            if (viewModel.general != null) _buildGeneral(),
                            SizedBox(
                              height: 15.h,
                            ),
                            if (viewModel.major != null) _buildMajor(),
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
        _buildHeader(viewModel.general!.name ?? ''),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        ListView.separated(
          itemCount: viewModel.general!.listTopic.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final item = viewModel.general!.listTopic[index];

            return _buildItemGeneral(item);
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

  Widget _buildItemGeneral(TopicModel item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) {
              return ForumListPostView(
                slug: item.slug!,
                nameGroup: item.name!,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.layerGroup,
              size: 25.h,
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
                          item.name ?? '',
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.supporting,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(item.description ?? ''),
                ],
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            Row(
              children: [
                Text(item.total.toString()),
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

  Widget _buildHeader(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: AppText.text20,
      ),
    );
  }

  Widget _buildMajor() {
    return Column(
      children: [
        _buildHeader(viewModel.major!.name ?? ''),
        const Divider(thickness: 2, color: AppColor.neutrals, height: 0),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final item = viewModel.major!.listTopic[index];

            return _buildItemMajor(item);
          },
          itemCount: viewModel.major!.listTopic.length,
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

  Widget _buildItemMajor(TopicModel item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) =>
                ForumTopicView(slug: item.slug!, nameTopic: item.name!),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.layerGroup,
              size: 25.h,
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
                          item.name ?? '',
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.supporting,
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
                      item.children.length,
                      (index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Icon(
                              FontAwesomeIcons.cookieBite,
                              size: 15.h,
                              color: AppColor.neutrals,
                            ),
                          ),
                          SizedBox(width: 5.h),
                          Flexible(
                            child: Text(
                              item.children[index].name ?? '',
                              style: AppText.text12.copyWith(
                                color: AppColor.supporting,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 50.h),
            Row(
              children: [
                Text(item.total.toString()),
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
