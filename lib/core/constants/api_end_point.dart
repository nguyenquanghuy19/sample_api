class ApiEndPointConstants {
  const ApiEndPointConstants._();

  static const String signup = "/authenticate/register";
  static const String signIn = "/authenticate/login";
  static const String resetPassword = "/authenticate/forgot-password";
  static const String updatePassword = "/account/update-password";
  static const String getProfile = "/account/get-me";
  static const String updateProfile = "/account/update-profile";
  static const String refreshToken = "/authenticate/refresh-token";
  static const String getTopics = "/forum/topics/all";
  static const String getCommentsBySlug = "/forum/posts/get";
  static const String getListPost = "/forum/topics/get";
  static const String courseOfTopic = "/forum/topics/get/";
  static const String getForumSlug = "/forum/posts/get/";
  static const String postLikeForumComment = "/forum/comments/update/";
  static const String getGuestCoursesAll = "/lms/guest/courses/all";
  static const String getGuestCourse = "/lms/guest/courses/get";
  static const String createComment =
      "/lms/guest/courses/comments/create-or-update";
  static const String getNotifications = "/notifications/my";
  static const String getAvatar = "/media/avatar";
  static const String getLmsFeatureImage = "/media/lms-featured-image";
  static const String getFeaturedImage = "/media/lms-featured-image?fileName";
  static const String updateStatusNotification = "/notifications/update-status";
  static const String register = "/lms/guest/courses";
  static const String getListMyLearning = "/mylearning/courses";
  static const String getRankMemberMyClassRoom = "/myclassroom";
  static const String getQuizMyClassRoom = "/myclassroom/contests/all";
  static const String getNotificationDetail =
      "/notifications/my-classroom/notify";
  static const String getRoadMapMyLearningDetail = "/mylearning/courses";
  static const String getMyNotification = "/notifications/my-learning/notify";
  static const String getNotificationActivities =
      "/notifications/my-learning/activities";
  static const String getMyQuizDetail = "/playground/quizzes/get";
  static const String getContentOnRoadMap =
      "/mylearning/courses/content-on-roadmaps";
  static const String getStatusNotification = "/notifications/status";
  static const String getQuizPlayGround = "/playground/quizzes/play";
  static const String getDetailFlashCard = "/playground/flashcards/get";
  static const String postQuizPlayGround = "/playground/quizzes/submit";
  static const String getResultQuizPlayGround = "/playground/quizzes/result";
  static const String getLatestNotification = "/notifications/my";
  static const String getContentSlideShow = "/playground/slideshows/get";
}
