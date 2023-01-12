import 'package:elearning/core/data/models/course_model.dart';

class MockDataCoursesTest {
  /// MOCK DATA TITLE TEST
  static String groupTestListCoursesViewModelTitle =
      "E-LEANING_TEST_API_LIST_COURSES_VIEW_MODEL";

  static String groupTestListCoursesServiceTitle =
      "E-LEANING_TEST_API_LIST_COURSES_SERVICE";

  static String groupTestListCoursesRepositoryTitle =
      "E-LEANING_TEST_API_LIST_COURSES_REPOSITORY";

  static String listCourseTitleNotNull =
      "E-LEANING_TEST_API_LIST_COURSES_NOT_NULL";

  static String listCourseTitleCanNull =
      "E-LEANING_TEST_API_LIST_COURSES_CAN_NULL";

  static String listCourseTitleFailed =
      "E-LEANING_TEST_API_LIST_COURSES_FAILED";

  /// PARAM REQUEST API

  static String param = "?Page=1&PerPage=10&Name=hj&Time=7";

  /// MOCK DATA RESPONSE

  static DataResponseCourseModel dataResponseCourseModel =
      DataResponseCourseModel(
    status: true,
    message: "Get ready classrooms successfully",
    data: [
      CourseModel(
        tableName: null,
        id: 3,
        uuid: "b14742a5-c3e3-45ee-9ba8-71a4223b142d",
        seriesName: "XOZNSVAK",
        name: "YCHJYSZH",
        description: "VSYOVYNL",
        items: null,
        total: 0,
        used: 0,
        status: "published",
        type: "unknown",
        licensed: "unknown",
        featuredImage: null,
        metaTitle: null,
        canonicalLink: null,
        slug: "ZBKKGQHD",
        metaKeywords: null,
        metaDescription: null,
        version: "0.0.1",
        setting: null,
        createdBy: "7f0e1ba7-7ed3-4353-b747-688306b304bd",
        createdAt: DateTime.parse("2022-10-31T08:50:23.076564"),
        updatedBy: "7f0e1ba7-7ed3-4353-b747-688306b304bd",
        updatedAt: DateTime.now(),
        deletedAt: null,
      ),
    ],
    total: 1,
  );
}
