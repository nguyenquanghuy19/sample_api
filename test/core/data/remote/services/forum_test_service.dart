import 'dart:async';

import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/forum_model.dart';

import 'base_service.dart';

class ForumService extends BaseService {
  BaseService baseService;

  ForumService({required this.baseService});

  Future<ForumModel?> getTopics() async {
    return await baseService.get(
      ApiEndPointConstants.getTopics,
      mapper: (json) => ForumModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumModel?> getAllCourseOfTopic(String slug) async {
    return await baseService.get(
      '${ApiEndPointConstants.courseOfTopic}$slug',
      mapper: (json) => ForumModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ResponseDataPostModel?> getListPost(String slug, String param) async {
    return await baseService.get(
      "${ApiEndPointConstants.courseOfTopic}$slug",
      param: param,
      mapper: (json) =>
          ResponseDataPostModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumResponseModel?> getForumSlug(String? slug) async {
    return await baseService.get(
      '${ApiEndPointConstants.getForumSlug}$slug',
      mapper: (json) =>
          ForumResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CommentModel?> getCommentsBySlug(String? slug, String param) async {
    return await baseService.get(
      "${ApiEndPointConstants.getCommentsBySlug}/$slug/comments",
      param: param,
      mapper: (json) => CommentModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ForumLikesResponseModel?> postLikeForumComment(
    String? type,
    int? idPost,
  ) async {
    final body = '{"type": "$type"}';

    return await baseService.post(
      '${ApiEndPointConstants.postLikeForumComment}$idPost/likes',
      body: body,
      mapper: (json) =>
          ForumLikesResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
