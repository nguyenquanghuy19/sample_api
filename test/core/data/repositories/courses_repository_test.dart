import 'package:elearning/core/data/models/course_model.dart';
import '../remote/services/courses_service_test.dart';

class CoursesRepository {
  final CoursesServiceTest coursesServiceTest;

  CoursesRepository({required this.coursesServiceTest});

  Future<DataResponseCourseModel?> getAllListCourses({
    required String param,
  }) async {
    try {
      final res = await coursesServiceTest.getAllListCourses(param: param);

      return res;
    } on Exception {
      rethrow;
    }
  }
}
