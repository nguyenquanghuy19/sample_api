import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LectureViewModel extends BaseViewModel {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ForumResponseModel? _forumResponseModel;

  ForumPostsModel? get forumResponseModel => _forumResponseModel?.dataForum;

  List<CommentItemModel> comments = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Future<void> onInitViewModel(BuildContext context, {String? slug}) async {
    super.onInitViewModel(context);
    await getData(slug);
  }

  void onTapBar(int index) {
    if (index == 1) {
      refreshController = RefreshController(initialRefresh: false);
    }
  }

  /// GET DATA OVERVIEW OF LECTURE SCREEN
  Future<void> getDataOverView(String? slug) async {
    try {
      notifyListeners();
    } on Exception {
      LogUtils.d("[$runtimeType][GET_DATA_OVER_VIEW] => ERROR");
    }
  }

  Future<void> getCommentsBySlug(String? slug) async {
    try {
      refreshController.loadComplete();
      notifyListeners();
    } on Exception {
      refreshController.loadComplete();
    }
  }

  Future<void> getData(String? slug) async {
    _isLoading = true;
    await getDataOverView(slug);
    await getCommentsBySlug(slug);
    _isLoading = false;
  }

  Future<void> postLikeForumComment(String? type, int? idPostComment) async {
    try {
      notifyListeners();
    } on Exception {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showToastError(
      "An error has occurred",
    );
  }
}
