import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forum_course_view_model_test.mocks.dart';
import 'view_model/forum/forum_course_view_model.dart';

@GenerateMocks([ForumRepository])
void main() {
  MockForumRepository mockForumRepository = MockForumRepository();

  late ForumCourseViewModel forumCourseViewModel;

  setUpAll(() {
    forumCourseViewModel =
        ForumCourseViewModel(forumRepository: mockForumRepository);
  });

  test('test get all topic not null ...', () async {
    when(mockForumRepository.getTopics()).thenAnswer(
      (inv) => Future.value(
        ForumModel(
          status: true,
          message: "Get topics successfully",
          data: [],
          total: 2,
        ),
      ),
    );
    expect(await forumCourseViewModel.getTopics(), isA<ForumModel>());
  });

  test('test get all topic ...', () async {
    when(mockForumRepository.getTopics()).thenAnswer((inv) => Future.value());
    expect(
      await forumCourseViewModel.getTopics(),
      isA<ForumModel?>(),
    );
  });

  test('test get all topic exception ...', () async {
    when(
      mockForumRepository.getTopics(),
    ).thenAnswer(
      (inv) => Future.value(),
    );
    expect(
      await forumCourseViewModel.getTopics().then((value) => Exception()),
      isA<Exception>(),
    );
  });
}
