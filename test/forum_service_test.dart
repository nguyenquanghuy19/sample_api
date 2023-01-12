import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_forum_test.dart';
import 'core/data/remote/services/base_service.dart';
import 'core/data/remote/services/forum_test_service.dart';
import 'forum_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BaseService>()])
void main() {
  MockBaseService mockBaseService = MockBaseService();
  late ForumService forumService;

  setUpAll(
    () {
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
      forumService = ForumService(baseService: mockBaseService);
    },
  );

  /// GROUP TEST CASE API FORUM SERVICE
  group(
    MockDataForumTest.groupTestServiceTitle,
    () {
      test(
        MockDataForumTest.overviewTitleNotNull,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumResponseModel,
            ),
          );
          expect(
            await forumService
                .getForumSlug(MockDataForumTest.slug)
                .then((_) => ForumResponseModel),
            ForumResponseModel,
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleCanNull,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.getForumSlug(MockDataForumTest.slug),
            isA<ForumResponseModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.overviewTitleFailed,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer((_) => Future.value());
          expect(
            await forumService
                .getForumSlug(MockDataForumTest.slug)
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleNotNull,
        () async {
          when(
            mockBaseService.get(
              any,
              param: MockDataForumTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.commentModel,
            ),
          );
          expect(
            await forumService
                .getCommentsBySlug(
                  MockDataForumTest.slug,
                  MockDataForumTest.param,
                )
                .then((_) => CommentModel),
            CommentModel,
          );
        },
      );
      test(
        MockDataForumTest.cmDisscussionTitleCanNull,
        () async {
          when(
            mockBaseService.get(
              any,
              param: MockDataForumTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.getCommentsBySlug(
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
            mockBaseService.get(
              any,
              param: MockDataForumTest.param,
              mapper: (json) => Object(),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService
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
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumLikesResponseModel,
            ),
          );
          expect(
            await forumService
                .postLikeForumComment(
                  MockDataForumTest.slug,
                  MockDataForumTest.postId,
                )
                .then((_) => ForumLikesResponseModel),
            ForumLikesResponseModel,
          );
        },
      );
      test(
        MockDataForumTest.likeCommentTitleCanNull,
        () async {
          when(
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.postLikeForumComment(
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
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService
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
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumModel,
            ),
          );
          expect(
            await forumService.getTopics().then((_) => ForumModel),
            ForumModel,
          );
        },
      );
      test(
        MockDataForumTest.getTopicsCanNull,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.getTopics(),
            isA<ForumModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsFailed,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.getTopics().then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsNotNull,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.forumModel,
            ),
          );
          expect(
            await forumService
                .getAllCourseOfTopic(MockDataForumTest.slugTopics)
                .then((_) => ForumModel),
            ForumModel,
          );
        },
      );
      test(
        MockDataForumTest.getTopicsCanNull,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService
                .getAllCourseOfTopic(MockDataForumTest.slugTopics),
            isA<ForumModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getTopicsFailed,
        () async {
          when(
            mockBaseService.get(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService
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
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.responseDataPostModel,
            ),
          );
          expect(
            await forumService
                .getListPost(
                  MockDataForumTest.slugTopics,
                  MockDataForumTest.param,
                )
                .then((_) => ResponseDataPostModel),
            ResponseDataPostModel,
          );
        },
      );
      test(
        MockDataForumTest.getListPostCanNull,
        () async {
          when(
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService.getListPost(
              MockDataForumTest.slugTopics,
              MockDataForumTest.param,
            ),
            isA<ResponseDataPostModel?>(),
          );
        },
      );
      test(
        MockDataForumTest.getListPostCanNull,
        () async {
          when(
            mockBaseService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumService
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
