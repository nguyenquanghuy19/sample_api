import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/remote/services/forum_service.dart';

class ForumRepository {
  final ForumService _forumService = ForumService();

  Future<ForumModel?> getTopics() async {
    try {
      return await _forumService.getTopics();
    } on Exception {
      rethrow;
    }
  }

  Future<ResponseDataPostModel?> getListPost(String slug, String param) async {
    try {
      return await _forumService.getListPost(slug, param);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumTopicModel?> getAllCourseOfTopic(String slug) async {
    try {
      return await _forumService.getAllCourseOfTopic(slug);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumResponseModel?> getAllListCourses(String slug) async {
    try {
      return await _forumService.getForumSlug(slug);
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel?> getCommentsBySlug(String slug, String param) async {
    try {
      return await _forumService.getCommentsBySlug(slug, param);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumLikesResponseModel?> postLikeForumComment(
    String type,
    int idPost,
  ) async {
    try {
      return await _forumService.postLikeForumComment(type, idPost);
    } on Exception {
      rethrow;
    }
  }
}
