import 'package:elearning/core/data/models/forum_model.dart';
import '../remote/services/forum_test_service.dart';

class ForumRepository {
  final ForumService forumService;

  ForumRepository({required this.forumService});

  Future<ForumLikesResponseModel?> postLikeForumComment(
    String? type,
    int? idPost,
  ) async {
    try {
      return await forumService.postLikeForumComment(type, idPost);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumResponseModel?> getAllListCourses(String? slug) async {
    try {
      return await forumService.getForumSlug(slug);
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel?> getCommentsBySlug(String? slug, String param) async {
    try {
      return await forumService.getCommentsBySlug(slug, param);
    } on Exception {
      rethrow;
    }
  }

  Future<ForumModel?> getTopics() async {
    try {
      return await forumService.getTopics();
    } on Exception {
      rethrow;
    }
  }

  Future<ForumModel?> getAllCourseOfTopic(String slug) async {
    try {
      return await forumService.getAllCourseOfTopic(slug);
    } on Exception {
      rethrow;
    }
  }

  Future<ResponseDataPostModel?> getListPost(String slug, String param) async {
    try {
      return await forumService.getListPost(slug, param);
    } on Exception {
      rethrow;
    }
  }
}
