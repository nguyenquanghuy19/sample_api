import 'package:elearning/core/data/models/course_model.dart';

class MockCommentTeacher {
  static CommentModel commentModel = CommentModel(
    status: true,
    message: 'Free test Comment tree',
    total: 0,
    data: [
      DataCommentModel(
        displayName: "Trần b. Giảng",
        content: "content childddddddddddddddddddddddddddd",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
      DataCommentModel(
        displayName: "Mai văn Tuấn",
        content: "content child",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
      DataCommentModel(
        displayName: "Nguyễn Quang Huy",
        content: "content child",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
      DataCommentModel(
        displayName: "Nguyễn Thanh Hải",
        content: "content child",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
      DataCommentModel(
        displayName: "Giảng pro 123",
        content: "content child",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
      DataCommentModel(
        displayName: "Giảng pro 123",
        content: "content child",
        createdAt: DateTime.parse('2012-02-27 13:27:00'),
      ),
    ],
  );
}
