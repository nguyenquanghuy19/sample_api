import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_forum_test.dart';
import 'core/data/remote/services/forum_test_service.dart';
import 'core/data/repositories/forum_repository_test.dart';
import 'forum_repository_test.mocks.dart';

@GenerateMocks([ForumService])
void main() {
  MockForumService mockForumService = MockForumService();
  late ForumRepository lectureRepository;

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
    lectureRepository = ForumRepository(forumService: mockForumService);
  });

  /// GROUP TEST CASE API FORUM REPOSITORY
  group(
    MockDataForumTest.groupTestRepositoryTitle,
    () {
      test(
        MockDataForumTest.overviewTitleNotNull,
        () async {
          when(
            mockForumService.getForumSlug(any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumResponseModel,
            ),
          );
          expect(
            await lectureRepository.getAllListCourses(MockDataForumTest.slug),
            isA<ForumResponseModel>(),
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleCanNull,
        () async {
          when(
            mockForumService.getForumSlug(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.getAllListCourses(MockDataForumTest.slug),
            isA<ForumResponseModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleFailed,
        () async {
          when(
            mockForumService.getForumSlug(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
                .getAllListCourses(MockDataForumTest.slug)
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleNotNull,
        () async {
          when(
            mockForumService.getCommentsBySlug(any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.commentModel,
            ),
          );
          expect(
            await lectureRepository.getCommentsBySlug(
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
          when(
            mockForumService.getCommentsBySlug(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.getCommentsBySlug(
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
          when(
            mockForumService.getCommentsBySlug(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
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
          when(
            mockForumService.postLikeForumComment(any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumLikesResponseModel,
            ),
          );
          expect(
            await lectureRepository.postLikeForumComment(
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
          when(
            mockForumService.postLikeForumComment(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.postLikeForumComment(
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
          when(
            mockForumService.postLikeForumComment(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
                .postLikeForumComment(
                  MockDataForumTest.slug,
                  MockDataForumTest.postId,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsNotNull,
        () async {
          when(
            mockForumService.getTopics(),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumModel,
            ),
          );
          expect(
            await lectureRepository.getTopics(),
            isA<ForumModel>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsCanNull,
        () async {
          when(
            mockForumService.getTopics(),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.getTopics(),
            isA<ForumModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsFailed,
        () async {
          when(
            mockForumService.getTopics(),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.getTopics().then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.getAllCourseOfTopicNotNull,
        () async {
          when(
            mockForumService.getAllCourseOfTopic(any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumModel,
            ),
          );
          expect(
            await lectureRepository
                .getAllCourseOfTopic(MockDataForumTest.slugTopics),
            isA<ForumModel>(),
          );
        },
      );
      test(
        MockDataForumTest.getAllCourseOfTopicCanNull,
        () async {
          when(
            mockForumService.getAllCourseOfTopic(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
                .getAllCourseOfTopic(MockDataForumTest.slugTopics),
            isA<ForumModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getAllCourseOfTopicFailed,
        () async {
          when(
            mockForumService.getAllCourseOfTopic(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
                .getAllCourseOfTopic(MockDataForumTest.slugTopics)
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.getListPostNotNull,
        () async {
          when(
            mockForumService.getListPost(any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.responseDataPostModel,
            ),
          );
          expect(
            await lectureRepository.getListPost(
              MockDataForumTest.slugTopics,
              MockDataForumTest.param,
            ),
            isA<ResponseDataPostModel>(),
          );
        },
      );
      test(
        MockDataForumTest.getListPostCanNull,
        () async {
          when(
            mockForumService.getListPost(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository.getListPost(
              MockDataForumTest.slugTopics,
              MockDataForumTest.param,
            ),
            isA<ResponseDataPostModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getListPostFailed,
        () async {
          when(
            mockForumService.getListPost(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await lectureRepository
                .getListPost(
                  MockDataForumTest.slugTopics,
                  MockDataForumTest.param,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}
