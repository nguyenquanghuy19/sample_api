import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';

class ForumCourseViewModel extends BaseViewModel {
  final ForumRepository forumRepository;

  ForumCourseViewModel({required this.forumRepository});

  Future<ForumModel?> getTopics({bool isFirstLoad = true}) async {
    try {
      return await forumRepository.getTopics();
    } on Exception {
      rethrow;
    }
  }
}
