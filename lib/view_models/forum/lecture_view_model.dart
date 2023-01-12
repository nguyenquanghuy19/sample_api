import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LectureViewModel extends BaseViewModel {
  final ForumRepository _forumRepository = ForumRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ForumResponseModel? _forumResponseModel;

  ForumPostsModel? get forumResponseModel => _forumResponseModel?.dataForum;

  List<CommentItemModel> comments = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int _totalRecord = 0;

  int _page = 1;

  bool get isLoadMore => comments.length < _totalRecord;

  @override
  Future<void> onInitViewModel(BuildContext context, {String? slug}) async {
    super.onInitViewModel(context);
    await _getData(slug);
    LogUtils.d("[$runtimeType][LECTURE_VIEW_MODEL] => INIT");
  }

  void onTapBar(int index) {
    if (index == 1) {
      refreshController = RefreshController(initialRefresh: false);
    }
  }

  /// GET DATA OVERVIEW OF LECTURE SCREEN
  Future<void> _getDataOverView(String? slug) async {
    try {
      if (slug != null) {
        final res = await _forumRepository.getAllListCourses(slug);
        _forumResponseModel = res;
      }
      notifyListeners();
    } on Exception {
      LogUtils.d("[$runtimeType][GET_DATA_OVER_VIEW] => ERROR");
    }
  }

  Future<void> getCommentsBySlug(String? slug) async {
    try {
      if (slug != null) {
        final String param = "?page=$_page&perPage=10";
        final res = await _forumRepository.getCommentsBySlug(slug, param);
        if (res != null && res.data.isNotEmpty) {
          comments.addAll(res.data);
          _totalRecord = res.total!;
          _page++;
        }
        refreshController.loadComplete();
      }
      notifyListeners();
    } on Exception {
      refreshController.loadComplete();
    }
  }

  Future<void> _getData(String? slug) async {
    _isLoading = true;
    await _getDataOverView(slug);
    await getCommentsBySlug(slug);
    _isLoading = false;
  }

  Future<void> postLikeForumComment(
    CommentItemModel itemModel,
    String? type,
    int? idPostComment,
  ) async {
    try {
      if (idPostComment != null && type != null) {
        final res =
            await _forumRepository.postLikeForumComment(type, idPostComment);
        if (res != null && res.status == true) {
          itemModel.hasLike = !itemModel.hasLike;
        }
        notifyListeners();
      }
    } on Exception {
      showToastErrorAPI();
    }
  }

  void showToastErrorAPI() {
    showToastError(
      Strings.of(context)!.anErrorHasOccurred,
    );
  }
}
