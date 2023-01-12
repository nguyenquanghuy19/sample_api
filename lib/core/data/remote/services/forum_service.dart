import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class ForumService extends BaseService {
  Future<ForumModel?> getTopics() async {
    return await get(
      ApiEndPointConstants.getTopics,
      mapper: (json) => ForumModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumTopicModel?> getAllCourseOfTopic(String slug) async {
    return await get(
      '${ApiEndPointConstants.courseOfTopic}$slug',
      mapper: (json) => ForumTopicModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ResponseDataPostModel?> getListPost(String slug, String param) async {
    return await get(
      "${ApiEndPointConstants.courseOfTopic}$slug",
      param: param,
      mapper: (json) =>
          ResponseDataPostModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumResponseModel?> getForumSlug(String slug) async {
    return await get(
      '${ApiEndPointConstants.getForumSlug}$slug',
      mapper: (json) =>
          ForumResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CommentModel?> getCommentsBySlug(String slug, String param) async {
    return await get(
      "${ApiEndPointConstants.getCommentsBySlug}/$slug/comments",
      param: param,
      mapper: (json) => CommentModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumLikesResponseModel?> postLikeForumComment(
    String type,
    int idPost,
  ) async {
    final body = '{"type": "$type"}';

    return await post(
      '${ApiEndPointConstants.postLikeForumComment}$idPost/likes',
      body: body,
      mapper: (json) =>
          ForumLikesResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
