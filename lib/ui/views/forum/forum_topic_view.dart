import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/forum/forum_list_post_view.dart';
import 'package:elearning/view_models/forum/forum_topic_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    return Selector<ForumTopicViewModel, List<TopicModel>>(
      selector: (_, viewModel) => viewModel.listAllCourseOfTopic,
      builder: (_, listAllCourseOfTopic, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.nameTopic,
              style: AppText.text22,
            ),
            backgroundColor: AppColor.primary.shade400,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),
              Padding(
                padding: const EdgeInsets.only(left: Constants.contentPaddingHorizontal),
                child: Text(
                  "Forum • ${widget.nameTopic}",
                  style: AppText.text21,
                ),
              ),
              Expanded(
                child: _buildListDevelopmentCourse(listAllCourseOfTopic),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListDevelopmentCourse(List<TopicModel> listAllCourseOfTopic) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      shrinkWrap: true,
      primary: false,
      itemCount: listAllCourseOfTopic.length,
      itemBuilder: (context, index) {
        return _buildItemDevelopmentCourse(listAllCourseOfTopic[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          height: 0,
          endIndent: Constants.contentPaddingHorizontal,
          indent: Constants.contentPaddingHorizontal,
        );
      },
    );
  }

  Widget _buildItemDevelopmentCourse(TopicModel topicModel) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) {
              return ForumListPostView(
                slug: topicModel.slug!,
                nameGroup: topicModel.name!,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: Constants.contentPaddingHorizontal),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.layerGroup,
              size: 25.h,
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      topicModel.name!,
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
                            "${topicModel.total}",
                            textAlign: TextAlign.end,
                            style: AppText.text16.copyWith(),
                          ),
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.h,
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
