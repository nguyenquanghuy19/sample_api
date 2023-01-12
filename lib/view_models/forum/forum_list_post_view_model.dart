import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumListPostViewModel extends BaseViewModel {
  final ForumRepository _forumRepository = ForumRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _slug;

  List<ForumPostsModel> posts = [];

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int _totalRecord = 0;

  int _page = 1;

  bool get isLoadMore => posts.length < _totalRecord;

  void inItData(String slug) {
    _slug = slug;
  }

  Future<void> getListPost({bool isLoadMore = false}) async {
    try {
      if (!isLoadMore) {
        _isLoading = true;
      }
      if (_slug != null) {
        final String param = "?page=$_page&perPage=10";
        final res = await _forumRepository.getListPost(_slug!, param);
        if (res != null && res.data != null) {
          posts.addAll(res.data!.posts);
          _totalRecord = res.data!.total;
          _page++;
        }
      }
      _isLoading = false;
      refreshController.loadComplete();
      notifyListeners();
    } on Exception {
      refreshController.loadComplete();
      _isLoading = false;
    }
  }
}

