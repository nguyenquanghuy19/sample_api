import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core/data/mock_datas/mock_data_courses.dart';
import 'core/data/remote/services/base_service.dart';
import 'core/data/remote/services/courses_service_test.dart';
import 'courses_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BaseService>()])
void main() {
  MockBaseService mockBaseService = MockBaseService();
  late CoursesServiceTest coursesServiceTest;

  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.develop,
      color: Colors.redAccent,
      // それ以外のAPIの接続先
      baseApiUrl: "http://10.20.22.42:1505/api/v1",
      versionAPI: "",
      othersVersionApi: {},
      supportMailAddress: "",
      saveRidingLogApiUrl: "",
      saveRidingLogVersionApi: "",
      hasMockAPI: false,
    );
    coursesServiceTest = CoursesServiceTest(baseService: mockBaseService);
  });

  group(
    MockDataCoursesTest.groupTestListCoursesServiceTitle,
    () {
      test(
        MockDataCoursesTest.listCourseTitleNotNull,
        () async {
          when(
            mockBaseService.get(
              MockDataCoursesTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer(
            (_) => Future.value(
              MockDataCoursesTest.dataResponseCourseModel,
            ),
          );
          expect(
            await coursesServiceTest
                .getAllListCourses(param: MockDataCoursesTest.param)
                .then((_) => DataResponseCourseModel),
            DataResponseCourseModel,
          );
        },
      );
      test(
        MockDataCoursesTest.listCourseTitleCanNull,
        () async {
          when(
            mockBaseService.get(
              MockDataCoursesTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer((_) => Future.value());
          expect(
            await coursesServiceTest.getAllListCourses(
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
            mockBaseService.get(
              MockDataCoursesTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer((_) => Future.value());
          expect(
            await coursesServiceTest
                .getAllListCourses(param: MockDataCoursesTest.param)
                .then((value) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}
