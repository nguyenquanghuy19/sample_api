import 'package:elearning/core/data/models/course_model.dart';
import '../../core/data/repositories/courses_repository_test.dart';
import '../../view_models/base_view_model.dart';

class ListCourseViewModel extends BaseViewModel {
  CoursesRepository coursesRepository;

  ListCourseViewModel({required this.coursesRepository});

  Future<DataResponseCourseModel?> getAllListCourses({
    required String param,
  }) async {
    try {
      final res = await coursesRepository.getAllListCourses(param: param);

      return res;
    } on Exception {
      rethrow;
    }
  }
}
