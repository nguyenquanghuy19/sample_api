import 'package:elearning/core/data/models/forum_model.dart';

class MockDataForumTest {
  /// MOCK DATA TITLE TEST

  static String groupTestLectureViewModelTitle =
      "E-LEANING_TEST_API_LECTURE_VIEW_MODEL";

  static String groupTestForumListPostViewModelTitle =
      "E-LEANING_TEST_API_LECTURE_VIEW_MODEL";

  static String groupTestServiceTitle = "E-LEANING_TEST_API_FORUM_SERVICE";

  static String groupTestRepositoryTitle =
      "E-LEANING_TEST_API_FORUM_REPOSITORY";

  static String overviewTitleNotNull =
      "OVERVIEW_API_TEST_SUCCESSFUL_DATA_NOT_NULL";

  static String overviewTitleCanNull =
      "OVERVIEW_API_TEST_SUCCESSFUL_DATA_CAN_NULL";

  static String overviewTitleFailed = "OVERVIEW_API_TEST_FAILED";

  static String cmDisscussionTitleNotNull =
      "COMMENT_DISCUSSION_API_TEST_SUCCESSFUL_NOT_NULL";

  static String cmDisscussionTitleCanNull =
      "COMMENT_DISCUSSION_API_TEST_SUCCESSFUL_CAN_NULL";

  static String cmDisscussionTitleFailed = "COMMENT_DISCUSSION_API_TEST_FAILED";

  static String likeCommentTitleNotNull = "LIKE_API_TEST_SUCCESSFUL_NOT_NULL";

  static String likeCommentTitleCanNull = "LIKE_API_TEST_SUCCESSFUL_CAN_NULL";

  static String likeCommentTitleFailed = "LIKE_API_TEST_FAILED";

  static String getTopicsNotNull = "GET_TOPICS_SUCCESSFUL_NOT_NULL";

  static String getTopicsCanNull = "GET_TOPICS_SUCCESSFUL_CAN_NULL";

  static String getTopicsFailed = "GET_TOPICS_FAILED";

  static String getAllCourseOfTopicNotNull =
      "GET_ALL_COURSE_OF_TOPIC_SUCCESSFUL_NOT_NULL";

  static String getAllCourseOfTopicCanNull =
      "GET_ALL_COURSE_OF_TOPIC_SUCCESSFUL_CAN_NULL";

  static String getAllCourseOfTopicFailed = "GET_ALL_COURSE_OF_TOPIC_FAILED";

  static String getListPostNotNull = "GET_LIST_POST_NOT_NULL";

  static String getListPostCanNull = "GET_LIST_POST_CAN_NULL";

  static String getListPostFailed = "GET_LIST_POST_FAILED";

  /// MOCK DATA PARAM AND BODY PUSH API OF LECTURE VIEW

  static String slugTopics = "BMQMWXEK";

  static String slug = "PKGNGLRC";

  static int postId = 40;

  static String param = "?page=$page&perPage=10";

  static int page = 1;

  /// MOCK DATA REPOSITORY FROM API OF LECTURE VIEW

  static ForumResponseModel forumResponseModel = ForumResponseModel(
    status: true,
    message: "Get post successfully",
    dataForum: ForumPostsModel(
      id: 40,
      title: "HODXDYHU",
      content: "SHUHYOIW",
      summary: "PZEPXONU",
      slug: "PKGNGLRC",
      status: "default",
      type: "default",
      topicId: 4,
      createdBy: "5aa2e968-4561-46fe-ab82-a9afdf4016d7",
      createdAt: DateTime.tryParse("2022-10-18T16:50:19.31938"),
      avatar:
          "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",
      displayName: "Tuan2",
    ),
    total: 1,
  );

  static CommentModel commentModel = CommentModel(
    status: true,
    message: "Get comments successfully",
    data: listCommentHardCode,
    total: 2,
  );

  static List<CommentItemModel> listCommentHardCode = [
    CommentItemModel(
      id: 800,
      content: "FJHSZKDF",
      forumPostId: 40,
      totalLike: 0,
      status: "default",
      type: "default",
      hasLike: false,
      createdBy: "8ac6ceeb-0086-4a10-8ecf-05aa3309261a",
      createdAt: DateTime.tryParse("2022-10-18T16:50:19.335878"),
    ),
    CommentItemModel(
      id: 799,
      content: "XJLJEFIG",
      forumPostId: 40,
      totalLike: 0,
      status: "default",
      type: "default",
      hasLike: false,
      createdBy: "b785435f-46e9-4aba-9b47-e39aa93e5daf",
      createdAt: DateTime.tryParse("2022-10-18T16:50:19.335072"),
    ),
  ];

  static ForumLikesResponseModel forumLikesResponseModel =
      ForumLikesResponseModel(
    status: true,
    message: "Like or Unlike successfully",
    total: 0,
  );

  static ForumModel forumModel = ForumModel(
    status: true,
    message: "Get topics successfully",
    data: listDataForumCourse,
    total: 1,
  );

  static List<DataForumCourse> listDataForumCourse = [
    DataForumCourse(
      id: 1,
      name: "SETTRQVL",
      description: "XZOXCPHW",
      slug: "BMQMWXEK",
      total: 0,
      status: "default",
      type: "general",
      parentId: null,
      post: null,
      listTopic: listTopic,
    ),
  ];

  static List<TopicModel> listTopic = [
    TopicModel(
      id: 3,
      name: "ZKEZLGJU",
      description: "ZBGECYOW",
      slug: "SOEYPSGJ",
      total: 20,
      status: "default",
      type: "general",
      parentId: 1,
      children: [],
      latestPost: LatestPostModel(),
      post: null,
    ),
  ];

  static ForumPostsModel postModel = ForumPostsModel(
    id: 20,
    title: "ZRCAOMIP",
    content: "OYGOFUJS",
    summary: "DQITMBUB",
    slug: "JXJLABQA",
    status: "default",
    type: "default",
    topicId: 3,
    createdBy: "a0d5e9ee-881a-4029-8a74-795eeefb1dff",
    createdAt: DateTime.tryParse("2022-10-18T16:50:19.026587"),
    avatar: null,
    displayName: null,
  );

  static List<ForumPostsModel> listPostModel = [
    postModel,
  ];

  static ResponseDataPostModel responseDataPostModel = ResponseDataPostModel(
    status: true,
    message: "Get posts successfully",
    data: DataPostModel(
      id: 1,
      name: "SETTRQVL",
      description: "XZOXCPHW",
      slug: "SOEYPSGJ",
      total: 10,
      type: "default",
      status: "default",
      parentId: null,
      posts: listPostModel,
    ),
    total: 1,
  );
}
