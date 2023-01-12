import 'package:elearning/core/data/models/course_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_courses.dart';
import 'core/data/repositories/courses_repository_test.dart';
import 'list_course_view_model_test.mocks.dart';
import 'view_model/course/list_course_view_model.dart';

@GenerateMocks([CoursesRepository])
void main() {
  MockCoursesRepository coursesRepository = MockCoursesRepository();
  late ListCourseViewModel listCourseViewModel;

  setUp(() {
    listCourseViewModel =
        ListCourseViewModel(coursesRepository: coursesRepository);
  });

  /// GROUP TEST CASE API LIST COURSES VIEW MODEL
  group(MockDataCoursesTest.groupTestListCoursesViewModelTitle, () {
    test(
      MockDataCoursesTest.listCourseTitleNotNull,
      () async {
        when(
          coursesRepository.getAllListCourses(param: MockDataCoursesTest.param),
        ).thenAnswer(
          (_) => Future.value(MockDataCoursesTest.dataResponseCourseModel),
        );
        expect(
          await listCourseViewModel.getAllListCourses(
            param: MockDataCoursesTest.param,
          ),
          isA<DataResponseCourseModel>(),
        );
      },
    );
    test(
      MockDataCoursesTest.listCourseTitleCanNull,
      () async {
        when(
          coursesRepository.getAllListCourses(param: MockDataCoursesTest.param),
        ).thenAnswer(
          (_) => Future.value(),
        );
        expect(
          await listCourseViewModel.getAllListCourses(
            param: MockDataCoursesTest.param,
          ),
          isA<DataResponseCourseModel?>(),
        );
      },
    );
    test(
      MockDataCoursesTest.listCourseTitleFailed,
      () async {
        when(
          coursesRepository.getAllListCourses(param: MockDataCoursesTest.param),
        ).thenAnswer(
          (_) => Future.value(),
        );
        expect(
          await listCourseViewModel
              .getAllListCourses(param: MockDataCoursesTest.param)
              .then((value) => Exception()),
          isA<Exception>(),
        );
      },
    );
  });
}
