import 'package:elearning/core/data/models/forum_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_forum_test.dart';
import 'core/data/repositories/forum_repository_test.dart';
import 'forum_list_post_view_model_test.mocks.dart';
import 'view_model/forum/forum_list_post_view_model.dart';

@GenerateMocks([ForumRepository])
void main() {
  MockForumRepository mockForumRepository = MockForumRepository();
  late ForumListPostViewModelTest forumListPostViewModelTest;

  setUp(() {
    forumListPostViewModelTest =
        ForumListPostViewModelTest(listPostRepository: mockForumRepository);
  });

  /// GROUP TEST CASE API FORUM LIST POST VIEW MODEL
  group(
    MockDataForumTest.groupTestForumListPostViewModelTitle,
    () {
      test(
        MockDataForumTest.getListPostNotNull,
        () async {
          when(mockForumRepository.getListPost(any, any)).thenAnswer(
            (_) => Future.value(
              MockDataForumTest.responseDataPostModel,
            ),
          );
          expect(
            await forumListPostViewModelTest.getListPost(
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
            mockForumRepository.getListPost(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumListPostViewModelTest.getListPost(
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
            mockForumRepository.getListPost(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forumListPostViewModelTest
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
