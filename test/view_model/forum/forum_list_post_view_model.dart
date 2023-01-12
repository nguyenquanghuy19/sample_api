import 'package:elearning/core/data/models/forum_model.dart';
import '../../core/data/repositories/forum_repository_test.dart';
import '../base_view_model.dart';


class ForumListPostViewModelTest extends BaseViewModel {
  ForumRepository listPostRepository;

  ForumListPostViewModelTest({required this.listPostRepository});

  Future<ResponseDataPostModel?> getListPost(String slug, String param) async {
    try {
      return await listPostRepository.getListPost(slug, param);
    } on Exception {
      rethrow;
    }
  }
}
