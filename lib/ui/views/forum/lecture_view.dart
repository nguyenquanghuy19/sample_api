import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/forum/lecture_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LectureView extends BaseView {
  final String slug;
  final String lectureName;

  const LectureView({Key? key, required this.slug, required this.lectureName})
      : super(key: key);

  @override
  LectureViewState createState() => LectureViewState();
}

class LectureViewState extends BaseViewState<LectureView, LectureViewModel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = LectureViewModel()..onInitViewModel(context, slug: widget.slug);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lectureName,
          style: AppText.text22,
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary.shade400,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Selector<LectureViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Selector<LectureViewModel, ForumPostsModel?>(
                  selector: (_, viewModel) => viewModel.forumResponseModel,
                  builder: (_, postData, __) {
                    return postData != null
                        ? _buildBodyOverview(postData)
                        : _dataCoursesEmpty();
                  },
                );
        },
      ),
    );
  }

  Widget _dataCoursesEmpty() {
    return Center(
      child: Text(Strings.of(context)!.defaultValueProfile),
    );
  }

  Widget _buildBodyOverview(ForumPostsModel postData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLectureSubtitleColumn(postData),
        SizedBox(
          height: 45.h,
          child: TabBar(
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            labelStyle: AppText.text18,
            tabs: [
              Tab(
                text: Strings.of(context)!.overview,
              ),
              Tab(
                text: Strings.of(context)!.discussion,
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              viewModel.onTapBar(index);
            },
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverView(postData),
              _buildDiscussionView(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLectureSubtitleColumn(ForumPostsModel dataForum) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 8.h,
      ),
      child: Column(
        children: [
          _buildDisplayName(dataForum.displayName),
          SizedBox(height: 8.h),
          _buildCreateAt(dataForum.dateFormat),
        ],
      ),
    );
  }

  Widget _buildDisplayName(String? displayName) {
    return displayName != null
        ? Row(children: [
            Icon(FontAwesomeIcons.solidUser, size: 20.h),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                displayName,
                style: AppText.text18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ])
        : const SizedBox.shrink();
  }

  Widget _buildCreateAt(String? date) {
    return date != null
        ? Row(children: [
            Icon(FontAwesomeIcons.clock, size: 20.h),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                date,
                style: AppText.text18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ])
        : const SizedBox.shrink();
  }

  Widget _buildOverView(ForumPostsModel forumData) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.contentPaddingHorizontal,
          vertical: 10.h,
        ),
        width: MediaQuery.of(context).size.width,
        child: MarkdownBody(data: "${forumData.content}"),
      ),
    );
  }

  Widget _buildDiscussionView() {
    return Selector<LectureViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoadMore,
      builder: (_, isLoadMore, __) {
        return SmartRefresher(
          enablePullUp: isLoadMore,
          enablePullDown: false,
          controller: viewModel.refreshController,
          onLoading: () {
            viewModel.getCommentsBySlug(widget.slug);
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
          child: Selector<LectureViewModel, List<CommentItemModel>>(
            selector: (_, viewModel) => viewModel.comments,
            shouldRebuild: (pre, next) => true,
            builder: (_, comments, __) {
              return comments.isEmpty
                  ? Center(
                      child: Text(Strings.of(context)!.defaultValueProfile),
                    )
                  : ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.contentPaddingHorizontal,
                        vertical: 15.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = viewModel.comments[index];

                        return _buildItemComment(item);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                      itemCount: viewModel.comments.length,
                    );
            },
          ),
        );
      },
    );
  }

  Widget _buildItemComment(CommentItemModel item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage(Images.defaultAvatar),
          ),
          SizedBox(
            width: 10.w,
          ),
          _buildContentComment(item),
        ],
      ),
    );
  }

  Widget _buildContentComment(CommentItemModel item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Todo change when have API
          Text(
            'Software Developer',
            style: AppText.text12,
          ),
          SizedBox(
            height: 4.h,
          ),
          //Todo change when have API
          Text(
            'Giảng ko BUG',
            style: AppText.text16.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            item.content ?? "",
            style: AppText.text14,
          ),
          SizedBox(
            height: 4.h,
          ),
          _buildActionComment(item),
        ],
      ),
    );
  }

  Widget _buildActionComment(CommentItemModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(item.dateFormat(context) ?? ''),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: InkWell(
                  onTap: () {
                    viewModel.postLikeForumComment(
                      item,
                      item.type,
                      item.forumPostId,
                    );
                  },
                  child: item.hasLike
                      ? Text(
                          Strings.of(context)!.liked,
                          style: const TextStyle(color: Colors.blue),
                        )
                      : Text(
                          Strings.of(context)!.like,
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: InkWell(
                  child: Text(Strings.of(context)!.report),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(item.totalLike.toString()),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              FontAwesomeIcons.solidThumbsUp,
              size: 14.h,
            ),
          ],
        ),
      ],
    );
  }
}
