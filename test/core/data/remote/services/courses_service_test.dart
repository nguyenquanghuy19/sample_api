import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'base_service.dart';

class CoursesServiceTest extends BaseService {
  BaseService baseService;

  CoursesServiceTest({required this.baseService});

  Future<DataResponseCourseModel?> getAllListCourses({
    required String param,
  }) async {
    return await baseService.get(
      ApiEndPointConstants.getGuestCoursesAll,
      param: param,
      mapper: (json) =>
          DataResponseCourseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
