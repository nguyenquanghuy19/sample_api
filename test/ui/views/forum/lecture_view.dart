import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/forum/lecture_view_model.dart';

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
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.lectureName"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _buildBodyOverview(),
    );
  }

  Widget _buildBodyOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLectureSubtitleColumn(),
        Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
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
              _buildOverView(),
              _buildDiscussionView(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLectureSubtitleColumn() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Column(
        children: [
          _buildDisplayName("dataForum.displayName"),
          SizedBox(height: 8.h),
          _buildCreateAt("dataForum.dateFormat"),
        ],
      ),
    );
  }

  Widget _buildDisplayName(String? displayName) {
    return displayName != null
        ? Row(
            children: [
              Icon(Icons.person, size: 27.h),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  displayName,
                  style: AppText.text18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildCreateAt(String? date) {
    return date != null
        ? Row(
            children: [
              Icon(Icons.access_time_filled_rounded, size: 27.h),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  date,
                  style: AppText.text18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildOverView() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        width: MediaQuery.of(context).size.width,
        child: const MarkdownBody(data: "forumData.content"),
      ),
    );
  }

  Widget _buildDiscussionView() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      itemBuilder: (context, index) {
        return _buildItemComment();
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8.h,
        );
      },
      itemCount: 5,
    );
  }

  Widget _buildItemComment() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage(Images.defaultAvatar),
          ),
          SizedBox(
            width: 10.w,
          ),
          _buildContentComment(),
        ],
      ),
    );
  }

  Widget _buildContentComment() {
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
            "item.content",
            style: AppText.text14,
          ),
          SizedBox(
            height: 4.h,
          ),
          _buildActionComment(),
        ],
      ),
    );
  }

  Widget _buildActionComment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              const Expanded(
                child: Text("item.dateFormat(context)"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  child: Text(Strings.of(context)!.like),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  child: Text(Strings.of(context)!.report),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Text("10"),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              Icons.thumb_up,
              size: 14.h,
            ),
          ],
        ),
      ],
    );
  }
}
