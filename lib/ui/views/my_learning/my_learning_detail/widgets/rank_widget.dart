import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/rank_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankWidget extends BaseView {
  final int? courseId;

  const RankWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  RankWidgetState createState() => RankWidgetState();
}

class RankWidgetState
    extends BaseViewState<RankWidget, RankMyLearningViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = RankMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<RankMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  _buildItemMyRank(),
                  Expanded(child: _buildMyLearningDetailRanks()),
                ],
              );
      },
    );
  }

  Widget _buildItemMyRank() {
    return Container(
      padding: EdgeInsets.only(top: 7.h, bottom: 20.h),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Images.iconCourseResult,
                width: 85.w,
                height: 90.h,
              ),
              Text(
                // [TODO] Handler get my rank
                "8",
                style: AppText.text14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            // [TODO] Handler get my rank
            "Rank 8",
            style: AppText.text16.copyWith(
              color: AppColor.neutrals.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            // [TODO] Handler get my score
            "200 Score",
            style: AppText.text16.copyWith(
              color: AppColor.neutrals.shade300,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyLearningDetailRanks() {
    return Selector<RankMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoadMore,
      builder: (_, isLoadMore, __) {
        return SmartRefresher(
          enablePullUp: isLoadMore,
          enablePullDown: false,
          controller: viewModel.refreshController,
          onLoading: () {
            viewModel.getDataMemberRankMyLearning(
              widget.courseId,
              isFirst: false,
            );
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
          child: Selector<RankMyLearningViewModel, List<MemberRankModel>>(
            selector: (_, viewModel) => viewModel.memberRanks,
            shouldRebuild: (pre, next) => true,
            builder: (_, memberRanks, __) {
              return memberRanks.isEmpty
                  ? Center(
                      child: Text(Strings.of(context)!.defaultValueProfile),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHeaderRankWidget(),
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: Constants.contentPaddingHorizontal,
                              vertical: 10.h,
                            ),
                            itemBuilder: (context, index) {
                              final item = memberRanks[index];

                              return _buildItemMemberRanks(item);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 6.h);
                            },
                            itemCount: memberRanks.length,
                          ),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeaderRankWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 5.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              Strings.of(context)!.rankMyLearning,
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade300,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                Strings.of(context)!.account,
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              Strings.of(context)!.progress,
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade300,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              Strings.of(context)!.titleScoreRank,
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade300,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _buildItemMemberRanks(MemberRankModel item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        color: _handlerColorItemRank(item.rank ?? ""),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: _buildItemAccountRankWidget(item),
    );
  }

  Widget _buildItemAccountRankWidget(MemberRankModel item) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _handlerRankUser(item.rank ?? ""),
            style: AppText.text14.copyWith(
              color: AppColor.neutrals.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 2.w),
        _buildItemInfoUser(item),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            item.progress != null
                ? Strings.of(context)!.progressCompleted(item.progress!)
                : "",
            style: AppText.text14.copyWith(
              color: _handlerColorTitleRank(item.rank ?? ""),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 2.w),
        _buildItemScore(item),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildItemInfoUser(MemberRankModel item) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarWidget(
            isSvg: item.isSvg,
            avatar: item.avatarImage,
            radius: 20.r,
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayName ?? "",
                  style: AppText.text14.copyWith(
                    color: _handlerColorTitleRank(item.rank ?? ""),
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  item.userName ?? "",
                  style: AppText.text14.copyWith(
                    color: _handlerColorTitleRank(item.rank ?? ""),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemScore(MemberRankModel item) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.score != null ? item.score! : "",
            style: AppText.text14.copyWith(
              color: _handlerColorTitleRank(item.rank ?? ""),
            ),
          ),
          Text(
            item.scoreAverage != null
                ? Strings.of(context)!.titleScoreAverageRank(item.scoreAverage!)
                : "",
            style: AppText.text14.copyWith(
              color: _handlerColorTitleRank(item.rank ?? ""),
            ),
          ),
        ],
      ),
    );
  }

  String _handlerRankUser(String ranks) {
    switch (ranks) {
      case Constants.isFirstRank:
        return Strings.of(context)!.titleFirstRank(ranks);
      case Constants.isSecondRank:
        return Strings.of(context)!.titleSecondRank(ranks);
      case Constants.isThirdRank:
        return Strings.of(context)!.titleThirdRank(ranks);
      default:
        return Strings.of(context)!.titleDefaultRank(ranks);
    }
  }

  Color _handlerColorItemRank(String ranks) {
    switch (ranks) {
      case Constants.isFirstRank:
        return AppColor.yellow.shade400;
      case Constants.isSecondRank:
        return AppColor.greenAccent.shade300;
      case Constants.isThirdRank:
        return AppColor.supporting.shade300;
      default:
        return Colors.white;
    }
  }

  Color _handlerColorTitleRank(String ranks) {
    switch (ranks) {
      case Constants.isFirstRank:
      case Constants.isSecondRank:
      case Constants.isThirdRank:
        return Colors.white;
      default:
        return AppColor.neutrals.shade800;
    }
  }
}
