import 'package:dio/dio.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/remote/services/courses_service.dart';

class CoursesRepository {
  final CoursesService _coursesService = CoursesService();

  Future<DataResponseCourseModel?> getAllListCourses(
      {required String param,}) async {
    try {
      return await _coursesService.getAllListCourses(param: param);
    } on Exception {
      rethrow;
    }
  }


  Future<GuestCourseModel?> getGuestCourse(String uuid) async {
    try {
      return await _coursesService.getGuestCourse(uuid);
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel?> getComment(int? id, int page) async {
    try {
      return await _coursesService.getComment(id, page);
    } on Exception {
      rethrow;
    }
  }

  Future<PostCommentModel?> createComment(CommentParam commentParam) async {
    try {
      return await _coursesService.createComment(commentParam);
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await _coursesService.getAvatar(fileName);
    } on Exception {
      rethrow;
    }
  }

  Future<RegisterModel?> registerCourse(int? id) async {
    try {
      return await _coursesService.registerCourse(id);
    } on Exception {
      rethrow;
    }
  }

  Future<RegisterModel?> getMember(int? id) async {
    try {
      return await _coursesService.getMember(id);
    } on Exception {
      rethrow;
    }
  }
}
