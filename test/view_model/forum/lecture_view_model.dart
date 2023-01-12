import 'package:elearning/core/data/models/forum_model.dart';
import '../../core/data/repositories/forum_repository_test.dart';
import '../base_view_model.dart';

class LectureViewModelTest extends BaseViewModel {
  ForumRepository lectureRepository;

  LectureViewModelTest({required this.lectureRepository});

  Future<ForumLikesResponseModel?> postLikeForumComment(
    String? type,
    int? idPostComment,
  ) async {
    try {
      return await lectureRepository.postLikeForumComment(type, idPostComment);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumResponseModel?> getAllListCourses(String? slug) async {
    try {
      return await lectureRepository.getAllListCourses(slug);
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel?> getCommentsBySlug(String? slug, String param) async {
    try {
      return await lectureRepository.getCommentsBySlug(slug, param);
    } on Exception {
      rethrow;
    }
  }
}
