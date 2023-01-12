import 'package:elearning/core/data/models/course_mock_model.dart';
import 'package:elearning/ui/shared/images.dart';

class MockDataCourses {
  static List<CoursesModel> courses = [
    CoursesModel(
      "FLUTTER BEGINNER 1",
      "Flutter is defined as the Google’s UI toolkit for building beautiful, natively compiled applications for mobile (Android, iOS )",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 2",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 3",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 4",
      "Flutter is defined as the Google’s UI toolkit for building beautiful, natively compiled applications for mobile (Android, iOS )",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 5",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 6",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 7",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 8",
      "Flutter is defined as the Google’s UI toolkit for building beautiful, natively compiled applications for mobile (Android, iOS )",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 9",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 10",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 11",
      "Flutter is defined as the Google’s UI toolkit for building beautiful, natively compiled applications for mobile (Android, iOS )",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 12",
      "Course for beginner with flutter",
      Images.defaultCourses,
    ),
    CoursesModel(
      "FLUTTER BEGINNER 13",
      "Flutter is defined as the Google’s UI toolkit for building beautiful, natively compiled applications for mobile (Android, iOS )",
      Images.defaultCourses,
    ),
  ];

  static List<CommentModel> comments = [
    CommentModel(
      author: "John",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Peter",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Jack",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Jesse",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Jesus",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Shaka",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Xhaka",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
    CommentModel(
      author: "Valencia",
      avatarAuthor: "",
      content:
          "The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.",
    ),
  ];

  static List<LectureModel> lectures = [
    LectureModel(
      title: "Lecture 1",
      content: [
        LectureModel(
          title: "Sub-content 1",
          content: [
            LectureModel(title: "Content 1.1"),
            LectureModel(title: "Content 1.2"),
            LectureModel(title: "Content 1.3"),
            LectureModel(title: "Content 1.4"),
          ],
        ),
        LectureModel(
          title: "Sub-content 1.2",
          content: [
            LectureModel(title: "Content 1.2.1"),
            LectureModel(title: "Content 1.2.2"),
            LectureModel(title: "Content 1.2.3"),
            LectureModel(title: "Content 1.2.4"),
          ],
        ),
      ],
    ),
    LectureModel(
      title: "Lecture 2",
      content: [
        LectureModel(
          title: "Sub-content 2.1",
          content: [
            LectureModel(title: "Content 2.1"),
          ],
        ),
      ],
    ),
    LectureModel(
      title: "Lecture 3",
      content: [
        LectureModel(
          title: "Sub-content 3.1",
          content: [
            LectureModel(title: "Content 3.1"),
            LectureModel(title: "Content 3.1"),
          ],
        ),
        LectureModel(
          title: "Sub-content 3.2",
          content: [
            LectureModel(title: "Content 3.2.1"),
            LectureModel(title: "Content 3.2.2"),
            LectureModel(title: "Content 3.2.3"),
            LectureModel(title: "Content 3.2.4"),
          ],
        ),
      ],
    ),
    LectureModel(
      title: "Lecture 4",
      content: [
        LectureModel(
          title: "Sub-content 4.1",
        ),
      ],
    ),
    LectureModel(
      title: "Lecture 5",
      content: [
        LectureModel(
          title: "Sub-content 5.1",
          content: [], // Case response empty list data
        ),
      ],
    ),
  ];
}
