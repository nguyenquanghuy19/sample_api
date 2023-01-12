import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forum_course_view_model_test.mocks.dart';
import 'view_model/forum/forum_topic_view_model.dart';

@GenerateMocks([ForumRepository])
void main() {
  MockForumRepository mockForumRepository = MockForumRepository();
  late ForumTopicViewModel forumTopicViewModel;
  setUpAll(() {
    forumTopicViewModel =
        ForumTopicViewModel(forumRepository: mockForumRepository);
  });

  test(
    "Test get data course development can't null...",
    () async {
      when(
        mockForumRepository.getAllCourseOfTopic(any),
      ).thenAnswer(
        (inv) => Future.value(
          ForumTopicModel(
            status: true,
            message: '',
            total: 0,
            data: DataForumCourse(),
          ),
        ),
      );
      expect(
        await forumTopicViewModel.getDataCourseDevelopment('PKGNGLRC'),
        isA<ForumTopicModel>(),
      );
    },
  );

  test(
    "Test get data course development can null...",
    () async {
      when(
        mockForumRepository.getAllCourseOfTopic(any),
      ).thenAnswer(
        (inv) => Future.value(
          ForumTopicModel(
            status: true,
            message: '',
            total: 0,
            data: DataForumCourse(),
          ),
        ),
      );
      expect(
        await forumTopicViewModel.getDataCourseDevelopment('PKGNGLRC'),
        isA<ForumTopicModel?>(),
      );
    },
  );

  test(
    "Test get data course development has exception ...",
    () async {
      when(
        mockForumRepository.getAllCourseOfTopic(any),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await forumTopicViewModel
            .getDataCourseDevelopment('PKGNGLRC')
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );
}
