import 'package:dio/dio.dart';
import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class CoursesService extends BaseService {
  Future<DataResponseCourseModel?> getAllListCourses({
    required String param,
  }) async {
    return await get(
      ApiEndPointConstants.getGuestCoursesAll,
      param: param,
      mapper: (json) =>
          DataResponseCourseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<GuestCourseModel?> getGuestCourse(String uuid) async {
    try {
      return await get(
        "${ApiEndPointConstants.getGuestCourse}?uuid=$uuid",
        mapper: (json) =>
            GuestCourseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel?> getComment(int? id, int page) async {
    try {
      return await get(
        "${ApiEndPointConstants.getGuestCourse}/$id/comments?page=$page&perPage=10",
        mapper: (json) => CommentModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<PostCommentModel?> createComment(CommentParam commentParam) async {
    try {
      return await post(
        ApiEndPointConstants.createComment,
        body: commentParam.toJson(),
        mapper: (json) =>
            PostCommentModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await getImage(
        ApiEndPointConstants.getAvatar,
        param: "?fileName=$fileName",
      );
    } on Exception {
      rethrow;
    }
  }

  Future<RegisterModel?> registerCourse(int? id) async {
    return await post(
      "${ApiEndPointConstants.register}/$id/register",
      mapper: (json) => RegisterModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<RegisterModel?> getMember(int? id) async {
    return await get(
      "${ApiEndPointConstants.register}/$id/member",
      mapper: (json) => RegisterModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
