import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankMyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  List<MemberRankModel> memberRanks = [];

  int _totalRecord = 0;

  bool get isLoadMore => memberRanks.length < _totalRecord;

  RefreshController refreshController = RefreshController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _page = 1;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    await getDataMemberRankMyLearning(courseId);
  }

  Future<void> getDataMemberRankMyLearning(
    int? courseId, {
    bool isFirst = true,
  }) async {
    try {
      if (courseId != null) {
        if (isFirst) {
          _isLoading = true;
          _page = 1;
          notifyListeners();
          memberRanks.clear();
        }
        String param = "?Page=$_page&PerPage=10";
        final res = await _myLearningRepository.getMemberRankMyLearningDetail(
          courseId: courseId,
          param: param,
        );
        if (res != null && res.data.isNotEmpty) {
          memberRanks.addAll(res.data);
          _getListImage(memberRanks, res.data.length);
          _totalRecord = res.total!;
          _page++;
        }
        _isLoading = false;
        refreshController.loadComplete();
      }
    } on Exception {
      _isLoading = false;
      refreshController.loadComplete();
      LogUtils.d(
        "[$runtimeType][GET_LIST_MEMBER_RANK_MY_LEARNING_DETAIL] => ERROR",
      );
    }
    notifyListeners();
  }

  void _getListImage(
    List<MemberRankModel> memberRanks,
    int length,
  ) async {
    for (int i = memberRanks.length - length; i < memberRanks.length; i++) {
      _getImage(memberRanks[i]);
    }
  }

  Future<void> _getImage(MemberRankModel memberRankModel) async {
    try {
      if (memberRankModel.avatar != null) {
        if (memberRankModel.avatar != null) {
          final res =
              await _myLearningRepository.getAvatar(memberRankModel.avatar);
          memberRankModel.avatarImage = res.data;
          memberRankModel.isSvg =
              res.headers["content-type"]?[0].contains("svg") ?? false;
          updateUI();
        }
      }
    } on Exception {
      LogUtils.i("Error get avatar");
    }
  }
}
