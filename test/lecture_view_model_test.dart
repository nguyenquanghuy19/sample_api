import 'package:elearning/core/data/models/forum_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_forum_test.dart';
import 'core/data/repositories/forum_repository_test.dart';
import 'lecture_view_model_test.mocks.dart';
import 'view_model/forum/lecture_view_model.dart';

@GenerateMocks([ForumRepository])
void main() {
  MockForumRepository mockLectureRepository = MockForumRepository();
  late LectureViewModelTest lectureViewModelTest;

  setUp(() {
    lectureViewModelTest =
        LectureViewModelTest(lectureRepository: mockLectureRepository);
  });

  /// GROUP TEST CASE API LECTURE VIEW MODEL
  group(
    MockDataForumTest.groupTestLectureViewModelTitle,
    () {
      test(
        MockDataForumTest.overviewTitleNotNull,
        () async {
          when(mockLectureRepository.getAllListCourses(any)).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumResponseModel,
            ),
          );
          expect(
            await lectureViewModelTest
                .getAllListCourses(MockDataForumTest.slug),
            isA<ForumResponseModel>(),
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleCanNull,
        () async {
          when(mockLectureRepository.getAllListCourses(any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest
                .getAllListCourses(MockDataForumTest.slug),
            isA<ForumResponseModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleFailed,
        () async {
          when(mockLectureRepository.getAllListCourses(any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest
                .getAllListCourses(MockDataForumTest.slug)
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleNotNull,
        () async {
          when(mockLectureRepository.getCommentsBySlug(any, any)).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.commentModel,
            ),
          );
          expect(
            await lectureViewModelTest.getCommentsBySlug(
              MockDataForumTest.slug,
              MockDataForumTest.param,
            ),
            isA<CommentModel>(),
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleCanNull,
        () async {
          when(mockLectureRepository.getCommentsBySlug(any, any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest.getCommentsBySlug(
              MockDataForumTest.slug,
              MockDataForumTest.param,
            ),
            isA<CommentModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleFailed,
        () async {
          when(mockLectureRepository.getCommentsBySlug(any, any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest
                .getCommentsBySlug(
                  MockDataForumTest.slug,
                  MockDataForumTest.param,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.likeCommentTitleNotNull,
        () async {
          when(mockLectureRepository.postLikeForumComment(any, any)).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumLikesResponseModel,
            ),
          );
          expect(
            await lectureViewModelTest.postLikeForumComment(
              MockDataForumTest.slug,
              MockDataForumTest.postId,
            ),
            isA<ForumLikesResponseModel>(),
          );
        },
      );
      test(
        MockDataForumTest.likeCommentTitleCanNull,
        () async {
          when(mockLectureRepository.postLikeForumComment(any, any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest.postLikeForumComment(
              MockDataForumTest.slug,
              MockDataForumTest.postId,
            ),
            isA<ForumLikesResponseModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.likeCommentTitleFailed,
        () async {
          when(mockLectureRepository.postLikeForumComment(any, any)).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureViewModelTest
                .postLikeForumComment(
                  MockDataForumTest.slug,
                  MockDataForumTest.postId,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}
