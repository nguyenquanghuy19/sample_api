import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/forum/lecture_view.dart';
import 'package:elearning/view_models/forum/forum_list_post_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    viewModel.inItData(widget.slug);
    viewModel.getListPost();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nameGroup,
          style: AppText.text22,
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary.shade400,
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
      body: Selector<ForumListPostViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.contentPaddingHorizontal,
                        vertical: 12.h,
                      ),
                      child: Text(
                        "Forum • Teaching & Academics •  ${widget.nameGroup}",
                        style: AppText.text21,
                      ),
                    ),
                    Expanded(
                      child: Selector<ForumListPostViewModel, bool>(
                        selector: (_, viewModel) => viewModel.isLoadMore,
                        builder: (_, isLoadMore, __) {
                          return SmartRefresher(
                            enablePullDown: false,
                            enablePullUp: isLoadMore,
                            controller: viewModel.refreshController,
                            onLoading: () {
                              viewModel.getListPost(isLoadMore: true);
                            },
                            footer: CustomFooter(
                              builder: (context, mode) {
                                return mode == LoadStatus.loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox();
                              },
                            ),
                            child: Selector<ForumListPostViewModel,
                                List<ForumPostsModel>>(
                              selector: (_, viewModel) => viewModel.posts,
                              builder: (_, dataForums, __) {
                                return dataForums.isEmpty
                                    ? const Center(child: Text("Empty data"))
                                    : ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          bottom: 16.h,
                                        ),
                                        itemCount: dataForums.length,
                                        itemBuilder: (context, index) {
                                          final item = dataForums[index];

                                          return _buildItem(item);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                            height: 0,
                                            indent: Constants.contentPaddingHorizontal,
                                            endIndent: Constants.contentPaddingHorizontal,
                                          );
                                        },
                                      );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildItem(ForumPostsModel item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) {
              return LectureView(
                slug: item.slug!,
                lectureName: item.title!,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h * 2, horizontal: Constants.contentPaddingHorizontal),
        child: Row(
          children: [
            item.convertAvatar() != null
                ? CircleAvatar(
                    radius: 26.h,
                    backgroundImage: MemoryImage(item.convertAvatar()!), //here
                  )
                : CircleAvatar(
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
                    "${item.title}",
                    style: AppText.text16.copyWith(
                      color: AppColor.supporting,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: item.displayName),
                        if (item.displayName != null)
                          const TextSpan(text: " - "),
                        TextSpan(
                          text: item.dateFormat,
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
