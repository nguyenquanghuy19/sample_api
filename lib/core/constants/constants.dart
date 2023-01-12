import 'package:flutter/material.dart';

class Constants {
  const Constants._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  //TODO Constants
  static const String stringEmpty = "";

  /// 15000msec
  static const int timeConnectTimeout = 15000;

  /// 15000msec
  static const int timeSendTimeout = 15000;

  /// 15000msec
  static const int timeReceiveTimeout = 15000;

  static const String slash = "/";

  /// Size TabBar List Lecture
  static const int sizeTabBarLecture = 4;

  /// Size TabBar list MyLearning
  static const int sizeTabBarMyLearning = 3;

  /// Size TabBar MyLearning Detail
  static const int sizeTabBarMyLearningDetail = 4;

  /// Size TabBar Notification
  static const int sizeTabBarNotification = 7;

  /// Type General Notification
  static const String typeGeneral = "";

  /// Type Course Notification
  static const String typeCourse = "course";

  /// Type Account Notification
  static const String typeAccount = "account";

  /// Type quiz notification
  static const String typeQuiz = "quiz";

  /// Type practice Notification
  static const String flashcard = "flashcard";

  /// Type My ClassRoom Notification
  static const String typeClassRoom = "my_classroom";

  /// Option readAllNotifications
  static const String readAllNotifications = "ReadAll";

  /// Option removeAllNotifications
  static const String removeAllNotifications = "RemoveAll";

  /// Type slideShow Notification
  static const String typeSlideShow = "slideshow";

  /// Daily
  static const double daily = 1;

  /// Weekly
  static const double weekly = 7;

  /// Monthly
  static const double monthly = 30;

  /// Latest
  static const double latest = 0;

  /// Male
  static const String male = 'male';

  /// Female
  static const String female = 'female';

  /// none
  static const String none = 'none';

  /// vn
  static const String vn = 'vn';

  /// jp
  static const String jp = 'jp';

  /// cn
  static const String cn = 'cn';

  /// kr
  static const String kr = 'kr';

  /// ru
  static const String ru = 'ru';

  /// us
  static const String us = 'us';

  /// vi
  static const String vi = 'vi';

  /// en
  static const String en = 'en';

  /// ja
  static const String ja = 'ja';

  /// camera
  static const String camera = 'camera';

  /// gallery
  static const String gallery = 'gallery';

  /// remove image
  static const String removeImage = 'removeImage';

  /// Status new
  static const String newStatus = "new";

  /// Status un read
  static const String unReadStatus = "un_read";

  /// Status read
  static const String readStatus = "read";

  /// Status removed
  static const String removedStatus = "removed";

  /// Road map type
  static const String roadMapType = "Road map";

  /// Quiz type
  static const String quizType = "Quiz";

  /// Flash card type
  static const String flashCardType = "Flash card";

  static const String paramFlashCard = "flashcard";

  /// Slide show type
  static const String slideShowType = "Slide show";

  static const String paramSlideShow = "slideshow";

  /// Roadmap, Quiz
  static const String slideShow = "slideshow";
  static const String quiz = "quiz";
  static const String flashCard = "flashcard";
  static const String defaultType = "default";
  static const String statusReady = "ready";
  static const String statusPending = "Pending";

  /// Popup Avatar
  static const String profile = "Profile";
  static const String signOut = "Sign out";

  /// start flip 3sec
  static const int timeAutoFlipFlashCard = 3;

  /// start slide 6sec
  static const int timeAutoSlideFlashCard = 6;

  /// Content padding horizontal

  static const double contentPaddingHorizontal = 16;

  /// Type quiz
  static const String multipleAnswers = "mtext";
  static const String singleAnswer = "text";
  static const String dropAnswer = "drop";
  static const String inputAnswer = "input";
  static const double zeroValue = 0;
  static const int valueTime = 60;
  static const int zeroValueDefault = 0;
  static const int pageQuizDefault = 15;
  static const int pageFirstValue = 1;
  static const bool statusSubmit = true;
  static const String statusSubmitQuiz = "submit";
  static const String statusTakingExamQuiz = "play";
  static const String lockQuiz = "lock";

  /// Value check ratio screen my result
  static const double sizeScreenCheck = 700.0;

  /// Rank user my learning
  static const String isFirstRank = "1";
  static const String isSecondRank = "2";
  static const String isThirdRank = "3";

  /// Error code number
  static const int noErrorCode = -1;
  static const int noInternet = 0;
  static const int errorCode400 = 400;
  static const int errorCode404 = 404;
  static const int errorCode500 = 500;
  static const int errorCode503 = 503;
  static const int errorCode504 = 504;

  static const double appBarHeight = 50;
}
