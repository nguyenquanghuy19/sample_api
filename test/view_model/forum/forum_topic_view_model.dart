import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';

class ForumTopicViewModel extends BaseViewModel {
  final ForumRepository forumRepository;

  ForumTopicViewModel({required this.forumRepository});

  Future<ForumTopicModel?> getDataCourseDevelopment(String slug) async {
    try {
      final res = await forumRepository.getAllCourseOfTopic(slug);

      return res;
    } on Exception {
      rethrow;
    }
  }
}
