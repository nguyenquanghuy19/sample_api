// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => "en";

  static String mDescriptionLecture(int total) => "Total lecture: $total";

  static String mNumberMeaning(int numberMeaning) => "Meaning $numberMeaning";

  static String progressCompleted(String process) => "$process%";

  static String lectureCount(String count) => "$count Lecture";

  static String quizCount(String count) => "$count Quiz";

  static String flashCardCount(String count) => "$count Flash card";

  static String slideShow(String count) => "$count Slide show";

  static String remainingTimes(String remaining) => "$remaining Remaining days";

  static String lectureSum(int sum) => "$sum Lecture";

  static String timeRemainingQuiz(int timeRemaining) => "$timeRemaining mins";

  static String titleQuestions(String countTitleQuestion) =>
      "Question $countTitleQuestion";

  static String titleSecondsNotification(String seconds) =>
      "$seconds seconds ago";

  static String titleMinutesNotification(String minutes) =>
      "$minutes minutes ago";

  static String titleHoursNotification(String hours) => "$hours hours ago";

  static String titleOneDayNotification(String hourYesterday) =>
      "Yesterday at $hourYesterday";

  static String titleDaysNotification(String days) => "$days days ago";

  static String titleWeeksNotification(String weeks) => "$weeks weeks ago";

  static String titleFirstRank(String ranks) => "${ranks}st";

  static String titleSecondRank(String ranks) => "${ranks}nd";

  static String titleThirdRank(String ranks) => "${ranks}rd";

  static String titleDefaultRank(String ranks) => "${ranks}th";

  static String titleScoreAverageRank(String score) => "$score perday";

  static String titleMemberMyLearning(String members) => "$members Members";

  static String confirmSubmitQuiz(int numberNotAnswer) =>
      "Bạn còn $numberNotAnswer câu chưa trả lời. Bạn có chắc chắn muốn nộp bài không?";

  final messages = _notInlinedMessages(_notInlinedMessages);

  static String titleUnits(String units) => "$units units";

  static Map<String, Function> _notInlinedMessages(dynamic _) =>
      <String, Function>{
        "homeBottomNavigationBar": MessageLookupByLibrary.simpleMessage(
          "Home",
        ),
        "anErrorHasOccurred": MessageLookupByLibrary.simpleMessage(
          "An error has occurred",
        ),
        "expirationToken": MessageLookupByLibrary.simpleMessage(
          "Your login session has expired, please login to continue",
        ),
        "cancel": MessageLookupByLibrary.simpleMessage(
          "Cancel",
        ),
        "accept": MessageLookupByLibrary.simpleMessage(
          "OK",
        ),
        "setting": MessageLookupByLibrary.simpleMessage(
          "Setting",
        ),
        "signOut": MessageLookupByLibrary.simpleMessage(
          "Sign out",
        ),
        "about": MessageLookupByLibrary.simpleMessage(
          "About",
        ),
        "language": MessageLookupByLibrary.simpleMessage(
          "Language",
        ),
        "reStartApp": MessageLookupByLibrary.simpleMessage(
          "To change the language, the app must be restarted. Do you want to restart now?",
        ),
        "vietnam": MessageLookupByLibrary.simpleMessage(
          "Vietnamese",
        ),
        "japan": MessageLookupByLibrary.simpleMessage(
          "Japanese",
        ),
        "english": MessageLookupByLibrary.simpleMessage(
          "English",
        ),

        ///
        "at": MessageLookupByLibrary.simpleMessage(
          "at",
        ),
        "comments": MessageLookupByLibrary.simpleMessage(
          "comments",
        ),
        "aComment": MessageLookupByLibrary.simpleMessage(
          "comment",
        ),
        "pages": MessageLookupByLibrary.simpleMessage(
          "pages",
        ),
        "page": MessageLookupByLibrary.simpleMessage(
          "page",
        ),
        "viewMore": MessageLookupByLibrary.simpleMessage(
          "View more",
        ),
        "joinNow": MessageLookupByLibrary.simpleMessage(
          "Join now",
        ),
        "account": MessageLookupByLibrary.simpleMessage(
          "Account",
        ),

        /// Landing page

        "landingTitleHeader": MessageLookupByLibrary.simpleMessage(
          "Hello, We are eLMS!",
        ),
        "landingSubTitleHeader": MessageLookupByLibrary.simpleMessage(
          "Spend less time doing homeworks to enjoy life more...",
        ),
        "landingContentHeader": MessageLookupByLibrary.simpleMessage(
          "Let's work hard together",
        ),
        "landingTitleSubContent": MessageLookupByLibrary.simpleMessage(
          "Learn with us",
        ),
        "landingSubContent": MessageLookupByLibrary.simpleMessage(
          "We do everything to your life-long companion. Let's start a new story together",
        ),
        "eLMS": MessageLookupByLibrary.simpleMessage(
          "eLMS",
        ),
        "learningPlan": MessageLookupByLibrary.simpleMessage(
          "Learning plan",
        ),
        "mostPopularCourse": MessageLookupByLibrary.simpleMessage(
          "Most popular course",
        ),

        ///
        "progress": MessageLookupByLibrary.simpleMessage(
          "Progress",
        ),
        "lecture": MessageLookupByLibrary.simpleMessage(
          "Lecture",
        ),
        "all": MessageLookupByLibrary.simpleMessage(
          "All",
        ),
        "complete": MessageLookupByLibrary.simpleMessage(
          "Complete",
        ),
        "myLearning": MessageLookupByLibrary.simpleMessage(
          "My Learning",
        ),
        "languageChange": MessageLookupByLibrary.simpleMessage(
          "Language change",
        ),
        "gotIt": MessageLookupByLibrary.simpleMessage(
          "Got It",
        ),
      }
        ..addAll(
          _notInlinedAuth(
            {},
          ),
        )
        ..addAll(
          _notInlinedProfile(
            {},
          ),
        )
        ..addAll(
          _notInlinedMyLearning(
            {},
          ),
        )
        ..addAll(
          _notInlinedCourse(
            {},
          ),
        )
        ..addAll(
          _notInlinedDictionary(
            {},
          ),
        )
        ..addAll(
          _notInlinedQuiz(
            {},
          ),
        )
        ..addAll(
          _notInlinedNotification(
            {},
          ),
        )
        ..addAll(
          _notInlinedFlashCard(
            {},
          ),
        )
        ..addAll(
          _notInlinedSetting(
            {},
          ),
        )
        ..addAll(
          _notInlinedMyLearningResult(
            {},
          ),
        )
        ..addAll(
          _notInlinedErrorView(
            {},
          ),
        );

  static Map<String, Function> _notInlinedAuth(dynamic _) => <String, Function>{
        "requestANewPassword": MessageLookupByLibrary.simpleMessage(
          "Password Reset",
        ),
        "pleaseEnterYourEmail": MessageLookupByLibrary.simpleMessage(
          "Please enter your email address to receive password change information.",
        ),
        "rememberPassword": MessageLookupByLibrary.simpleMessage(
          "Oh, I already know my current password",
        ),
        "haveAnAccount": MessageLookupByLibrary.simpleMessage(
          "Already have an account? Sign In",
        ),
        "introduceMessage": MessageLookupByLibrary.simpleMessage(
          "We're super happy to see you again!",
        ),
        "introduceLogIn": MessageLookupByLibrary.simpleMessage(
          "Let's log you in.",
        ),
        "welcomeBack": MessageLookupByLibrary.simpleMessage(
          "Welcome back",
        ),
        "rememberAccount": MessageLookupByLibrary.simpleMessage(
          "Remember me?",
        ),
        "forgottenPassword": MessageLookupByLibrary.simpleMessage(
          "Forgotten password?",
        ),
        "signUpNavigation": MessageLookupByLibrary.simpleMessage(
          "Don't have an account? ",
        ),
        "btnSignIn": MessageLookupByLibrary.simpleMessage(
          "Sign In",
        ),
        "btnResetPassword": MessageLookupByLibrary.simpleMessage(
          "Reset Your Password",
        ),
        "signUp": MessageLookupByLibrary.simpleMessage(
          "Sign Up",
        ),
        "btnSignUp": MessageLookupByLibrary.simpleMessage(
          "SIGN UP",
        ),
        "emailRequired": MessageLookupByLibrary.simpleMessage(
          "Email is required",
        ),
        "emailInvalid": MessageLookupByLibrary.simpleMessage(
          "Invalid email",
        ),
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Password is required",
        ),
        "passwordOldRequired": MessageLookupByLibrary.simpleMessage(
          "Password old is required",
        ),
        "passwordLeastLength": MessageLookupByLibrary.simpleMessage(
          "Must be 8 or more characters long",
        ),
        "passwordUppercase": MessageLookupByLibrary.simpleMessage(
          "Passwords must have at least one uppercase ('A'-'Z').",
        ),
        "passwordLowerCase": MessageLookupByLibrary.simpleMessage(
          "Passwords must have at least one lowercase ('a'-'z').",
        ),
        "passwordDigit": MessageLookupByLibrary.simpleMessage(
          "Passwords must have at least one digit ('0'-'9').",
        ),
        "passwordSpecial": MessageLookupByLibrary.simpleMessage(
          "Passwords must have at least one non alphanumeric character.",
        ),
        "sendMailFailed": MessageLookupByLibrary.simpleMessage(
          "Send mail failed.",
        ),
        "registerAccountTitle": MessageLookupByLibrary.simpleMessage(
          "Create an account",
        ),
        "updatePasswordTitle": MessageLookupByLibrary.simpleMessage(
          "Change Password",
        ),
        "updatePasswordButton": MessageLookupByLibrary.simpleMessage(
          "SUBMIT",
        ),
        "updatePasswordContent": MessageLookupByLibrary.simpleMessage(
          "Password needs at least 8 characters including letters, numbers and special characters to make your account more secure.",
        ),
        "oldPassword": MessageLookupByLibrary.simpleMessage(
          "Old password",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage(
          "New password",
        ),
        "confirmPassword": MessageLookupByLibrary.simpleMessage(
          "Confirm new password",
        ),
        "registerAccountContent": MessageLookupByLibrary.simpleMessage(
          "Don't worry, it's super fast.",
        ),
        "emailAddress": MessageLookupByLibrary.simpleMessage(
          "Email address",
        ),
        "password": MessageLookupByLibrary.simpleMessage(
          "Password",
        ),
        "repeatPassword": MessageLookupByLibrary.simpleMessage(
          "Repeat password",
        ),
        "agreeTermsAndConditions": MessageLookupByLibrary.simpleMessage(
          "You agree to our Terms & Conditions",
        ),
        "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Confirm password is required",
        ),
        "comparePasswordError": MessageLookupByLibrary.simpleMessage(
          "Password and repeat password are not the same",
        ),
        "checkAgreeTermsAndConditions": MessageLookupByLibrary.simpleMessage(
          "Please agree to our Terms & Conditions",
        ),
        "passwordInvalidCharacter": MessageLookupByLibrary.simpleMessage(
          "Password has invalid character",
        ),
        "labelSignUp": MessageLookupByLibrary.simpleMessage(
          "Sign Up",
        ),
      };

  static Map<String, Function> _notInlinedProfile(dynamic _) =>
      <String, Function>{
        "profile": MessageLookupByLibrary.simpleMessage(
          "Profile",
        ),
        "removeAvatar": MessageLookupByLibrary.simpleMessage(
          "Remove avatar",
        ),
        "titleUpdateProfile": MessageLookupByLibrary.simpleMessage(
          "Update Profile",
        ),
        "hintTextDisplayName": MessageLookupByLibrary.simpleMessage(
          "Display name",
        ),
        "hintTextPhoneNumber": MessageLookupByLibrary.simpleMessage(
          "Phone number",
        ),
        "phoneNumberInValid": MessageLookupByLibrary.simpleMessage(
          "Invalid Phone Number",
        ),
        "labelSubmit": MessageLookupByLibrary.simpleMessage(
          "Submit",
        ),
        "labelEdit": MessageLookupByLibrary.simpleMessage(
          "Edit",
        ),
        "hintTextLastName": MessageLookupByLibrary.simpleMessage(
          "Last name",
        ),
        "hintTextFirstName": MessageLookupByLibrary.simpleMessage(
          "First name",
        ),
        "hintTextFullName": MessageLookupByLibrary.simpleMessage(
          "Full Name",
        ),
        "hintTextDateOfBirth": MessageLookupByLibrary.simpleMessage(
          "Date of birth",
        ),
        "hintTextGender": MessageLookupByLibrary.simpleMessage(
          "Gender",
        ),
        "hintTextAddress": MessageLookupByLibrary.simpleMessage(
          "Address",
        ),
        "hintTextCountry": MessageLookupByLibrary.simpleMessage(
          "Country",
        ),
        "defaultValueProfile": MessageLookupByLibrary.simpleMessage(
          "Empty Data",
        ),
        "displayNameRequired": MessageLookupByLibrary.simpleMessage(
          "Display is required",
        ),
        "hintTextCity": MessageLookupByLibrary.simpleMessage(
          "City",
        ),
        "valueMale": MessageLookupByLibrary.simpleMessage(
          "Male",
        ),
        "valueFemale": MessageLookupByLibrary.simpleMessage(
          "Female",
        ),
        "valueOther": MessageLookupByLibrary.simpleMessage(
          "None",
        ),
        "messageErrorDatePicker": MessageLookupByLibrary.simpleMessage(
          "Enter valid date",
        ),
        "messageErrorInvalidDatePicker": MessageLookupByLibrary.simpleMessage(
          "Enter date in valid range",
        ),
        "titleCamera": MessageLookupByLibrary.simpleMessage(
          "Camera",
        ),
        "titleGallery": MessageLookupByLibrary.simpleMessage(
          "Gallery",
        ),
      };

  static Map<String, Function> _notInlinedMyLearning(dynamic _) =>
      <String, Function>{
        "information": MessageLookupByLibrary.simpleMessage(
          "Information",
        ),
        "rankMyLearning": MessageLookupByLibrary.simpleMessage(
          "Rank",
        ),
        "result": MessageLookupByLibrary.simpleMessage(
          "Result",
        ),
        "memberMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "1 Member",
        ),
        "memberCourseMyLearning": MessageLookupByLibrary.simpleMessage(
          titleMemberMyLearning,
        ),
        "slideShowMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "Slide show",
        ),
        "progressCompleted": MessageLookupByLibrary.simpleMessage(
          progressCompleted,
        ),
        "lectureSum": MessageLookupByLibrary.simpleMessage(
          lectureSum,
        ),
        "startNowMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "Start now",
        ),
        "ok": MessageLookupByLibrary.simpleMessage(
          "ok",
        ),
        "myResult": MessageLookupByLibrary.simpleMessage(
          "My Result",
        ),
        "historyActivity": MessageLookupByLibrary.simpleMessage(
          "Activity",
        ),
        "remainingTime": MessageLookupByLibrary.simpleMessage(
          "1 Remaining day",
        ),
        "lectureCount": MessageLookupByLibrary.simpleMessage(
          lectureCount,
        ),
        "quizCount": MessageLookupByLibrary.simpleMessage(
          quizCount,
        ),
        "flashCardCount": MessageLookupByLibrary.simpleMessage(
          flashCardCount,
        ),
        "slideShow": MessageLookupByLibrary.simpleMessage(
          slideShow,
        ),
        "notification": MessageLookupByLibrary.simpleMessage(
          "Notification",
        ),
        "titleQuiz": MessageLookupByLibrary.simpleMessage(
          "Quiz",
        ),
        "status": MessageLookupByLibrary.simpleMessage(
          "Status",
        ),
        "registered": MessageLookupByLibrary.simpleMessage(
          "Registered",
        ),
        "confirmRegister": MessageLookupByLibrary.simpleMessage(
          "Do you want to register this course?",
        ),
        "confirmLoginToRegisterCourse": MessageLookupByLibrary.simpleMessage(
          "You need to login before you can register for the course. Go to the login page",
        ),
        "confirm": MessageLookupByLibrary.simpleMessage(
          "Confirm",
        ),
        "timeRemainingQuiz": MessageLookupByLibrary.simpleMessage(
          timeRemainingQuiz,
        ),
        "hintTextSearchMyLearning": MessageLookupByLibrary.simpleMessage(
          "Find a learning",
        ),
        "myLearningEmpty": MessageLookupByLibrary.simpleMessage(
          "You have not join any course. Find and register new course",
        ),
        "quizCompleted": MessageLookupByLibrary.simpleMessage(
          "Quiz Completed",
        ),
        "attendance": MessageLookupByLibrary.simpleMessage(
          "Attendance",
        ),
        "absent": MessageLookupByLibrary.simpleMessage(
          "Absent",
        ),
        "teacherCommunication": MessageLookupByLibrary.simpleMessage(
          "Teacher communication",
        ),
        "titleFirstRank": MessageLookupByLibrary.simpleMessage(
          titleFirstRank,
        ),
        "titleSecondRank": MessageLookupByLibrary.simpleMessage(
          titleSecondRank,
        ),
        "titleThirdRank": MessageLookupByLibrary.simpleMessage(
          titleThirdRank,
        ),
        "titleDefaultRank": MessageLookupByLibrary.simpleMessage(
          titleDefaultRank,
        ),
        "titleScoreRank": MessageLookupByLibrary.simpleMessage(
          "Score",
        ),
        "titleScoreAverageRank": MessageLookupByLibrary.simpleMessage(
          titleScoreAverageRank,
        ),
        "locked": MessageLookupByLibrary.simpleMessage(
          "Locked",
        ),
        "award": MessageLookupByLibrary.simpleMessage(
          "Award",
        ),
        "titleUnit": MessageLookupByLibrary.simpleMessage(
          "1 unit",
        ),
        "titleUnits": MessageLookupByLibrary.simpleMessage(
          titleUnits,
        ),
        "hello": MessageLookupByLibrary.simpleMessage(
          "Hello!",
        ),
      };

  static Map<String, Function> _notInlinedCourse(dynamic _) =>
      <String, Function>{
        "hintTextSearchCourses": MessageLookupByLibrary.simpleMessage(
          "Find a course",
        ),
        "titleCourses": MessageLookupByLibrary.simpleMessage(
          "Courses",
        ),
        "review": MessageLookupByLibrary.simpleMessage(
          "Reviews",
        ),
        "roadMap": MessageLookupByLibrary.simpleMessage(
          "Roadmap",
        ),
        "overview": MessageLookupByLibrary.simpleMessage(
          "Overview",
        ),
        "discussion": MessageLookupByLibrary.simpleMessage(
          "Discussion",
        ),
        "seeMore": MessageLookupByLibrary.simpleMessage(
          "See more",
        ),
        "showLess": MessageLookupByLibrary.simpleMessage(
          "See less",
        ),
        "course": MessageLookupByLibrary.simpleMessage(
          "Course",
        ),
        "whatWillYouLearn": MessageLookupByLibrary.simpleMessage(
          "What will you learn?",
        ),
        "register": MessageLookupByLibrary.simpleMessage(
          "Register",
        ),
        "descriptionRoadMap": mDescriptionLecture,
        "forum": MessageLookupByLibrary.simpleMessage(
          "Forum",
        ),
        "like": MessageLookupByLibrary.simpleMessage(
          "Like",
        ),
        "liked": MessageLookupByLibrary.simpleMessage(
          "Liked",
        ),
        "report": MessageLookupByLibrary.simpleMessage(
          "Report",
        ),
        "oneWeekAgo": MessageLookupByLibrary.simpleMessage(
          "1 week ago",
        ),
        "lastWeek": MessageLookupByLibrary.simpleMessage(
          "Last week",
        ),
        "daysAgo": MessageLookupByLibrary.simpleMessage(
          "days ago",
        ),
        "oneDayAgo": MessageLookupByLibrary.simpleMessage(
          "1 day ago",
        ),
        "yesterday": MessageLookupByLibrary.simpleMessage(
          "Yesterday",
        ),
        "hoursAgo": MessageLookupByLibrary.simpleMessage(
          "hours ago",
        ),
        "oneHourAgo": MessageLookupByLibrary.simpleMessage(
          "1 hour ago",
        ),
        "anHourAgo": MessageLookupByLibrary.simpleMessage(
          "An hour ago",
        ),
        "minutesAgo": MessageLookupByLibrary.simpleMessage(
          "minutes ago",
        ),
        "oneMinuteAgo": MessageLookupByLibrary.simpleMessage(
          "1 minute ago",
        ),
        "aMinuteAgo": MessageLookupByLibrary.simpleMessage(
          "A minute ago",
        ),
        "secondsAgo": MessageLookupByLibrary.simpleMessage(
          "seconds ago",
        ),
        "justNow": MessageLookupByLibrary.simpleMessage(
          "Just now",
        ),
        "daily": MessageLookupByLibrary.simpleMessage(
          "Daily",
        ),
        "weekly": MessageLookupByLibrary.simpleMessage(
          "Weekly",
        ),
        "monthly": MessageLookupByLibrary.simpleMessage(
          "Monthly",
        ),
        "latest": MessageLookupByLibrary.simpleMessage(
          "Latest",
        ),
        "courseDetail": MessageLookupByLibrary.simpleMessage(
          "Course Detail",
        ),
        "courseSummary": MessageLookupByLibrary.simpleMessage(
          "Course summary",
        ),
        "summaryMyLearning": MessageLookupByLibrary.simpleMessage(
          "Summary",
        ),
        "hintTextComment": MessageLookupByLibrary.simpleMessage(
          "Leave your comment",
        ),
        "messageLoginBeforeComment": MessageLookupByLibrary.simpleMessage(
          "You need login before leave your comment",
        ),
        "leaveYourComment": MessageLookupByLibrary.simpleMessage(
          "Please leave your comment",
        ),
        "comment": MessageLookupByLibrary.simpleMessage(
          "Comment",
        ),
        "loadMoreComment": MessageLookupByLibrary.simpleMessage(
          "Load more comment",
        ),
        "teacher": MessageLookupByLibrary.simpleMessage(
          "Teacher",
        ),
        "dateEnd": MessageLookupByLibrary.simpleMessage(
          "Date end",
        ),
        "dateStart": MessageLookupByLibrary.simpleMessage(
          "Date start",
        ),
      };

  static Map<String, Function> _notInlinedDictionary(dynamic _) =>
      <String, Function>{
        "meaning": MessageLookupByLibrary.simpleMessage(
          "Meaning",
        ),
        "grammar": MessageLookupByLibrary.simpleMessage(
          "Grammar",
        ),
        "synonyms": MessageLookupByLibrary.simpleMessage(
          "Synonyms",
        ),
        "antonyms": MessageLookupByLibrary.simpleMessage(
          "Antonyms",
        ),
        "noun": MessageLookupByLibrary.simpleMessage(
          "noun",
        ),
        "contributeTranslation": MessageLookupByLibrary.simpleMessage(
          "Contribute translation",
        ),
        "wordType": MessageLookupByLibrary.simpleMessage(
          "Word type",
        ),
        "verbs": MessageLookupByLibrary.simpleMessage(
          "Verbs",
        ),
        "nouns": MessageLookupByLibrary.simpleMessage(
          "Nouns",
        ),
        "adjectives": MessageLookupByLibrary.simpleMessage(
          "Adjectives",
        ),
        "adverbs": MessageLookupByLibrary.simpleMessage(
          "Adverbs",
        ),
        "addMoreMeaning": MessageLookupByLibrary.simpleMessage(
          "Add more meaning",
        ),
        "removeMeaning": MessageLookupByLibrary.simpleMessage(
          "Remove meaning",
        ),
        "numberMeaning": mNumberMeaning,
        "wordMeaning": MessageLookupByLibrary.simpleMessage(
          "Word meaning",
        ),
        "enterWordMeaningVie": MessageLookupByLibrary.simpleMessage(
          "Enter word meaning (by Viet)",
        ),
        "example": MessageLookupByLibrary.simpleMessage(
          "Example",
        ),
        "exampleWordMeaningEng": MessageLookupByLibrary.simpleMessage(
          "Enter word example (by Anh)",
        ),
        "Dictionary": MessageLookupByLibrary.simpleMessage(
          "dictionary",
        ),
      };

  static Map<String, Function> _notInlinedNotification(dynamic _) =>
      <String, Function>{
        "notifications": MessageLookupByLibrary.simpleMessage(
          "Notifications",
        ),
        "general": MessageLookupByLibrary.simpleMessage(
          "General",
        ),
        "delete": MessageLookupByLibrary.simpleMessage(
          "Delete",
        ),
        "readTick": MessageLookupByLibrary.simpleMessage(
          "Seen",
        ),
        "reset": MessageLookupByLibrary.simpleMessage(
          "Reset",
        ),
        "filter": MessageLookupByLibrary.simpleMessage(
          "Filter",
        ),
        "flashCard": MessageLookupByLibrary.simpleMessage(
          "Flash card",
        ),
        "myLearningDetail": MessageLookupByLibrary.simpleMessage(
          "My Learning Detail",
        ),
        "searchTitle": MessageLookupByLibrary.simpleMessage(
          "Search",
        ),
        "showAllNotification": MessageLookupByLibrary.simpleMessage(
          "View all notificaitons",
        ),
        "titleClassRoom": MessageLookupByLibrary.simpleMessage(
          "Classroom",
        ),
        "titleSecondsNotification": MessageLookupByLibrary.simpleMessage(
          titleSecondsNotification,
        ),
        "titleMinuteNotification": MessageLookupByLibrary.simpleMessage(
          "1 minute ago",
        ),
        "titleMinutesNotification": MessageLookupByLibrary.simpleMessage(
          titleMinutesNotification,
        ),
        "titleHourNotification": MessageLookupByLibrary.simpleMessage(
          "1 hour ago",
        ),
        "titleHoursNotification": MessageLookupByLibrary.simpleMessage(
          titleHoursNotification,
        ),
        "titleOneDayNotification": MessageLookupByLibrary.simpleMessage(
          titleOneDayNotification,
        ),
        "titleDaysNotification": MessageLookupByLibrary.simpleMessage(
          titleDaysNotification,
        ),
        "titleWeekNotification": MessageLookupByLibrary.simpleMessage(
          "1 week ago",
        ),
        "titleWeeksNotification": MessageLookupByLibrary.simpleMessage(
          titleWeeksNotification,
        ),
        "titleConfirmDeleteNotification": MessageLookupByLibrary.simpleMessage(
          "Confirm delete",
        ),
        "contentConfirmDeleteNotification":
            MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to delete this notification",
        ),
      };

  static Map<String, Function> _notInlinedQuiz(dynamic _) => <String, Function>{
        "titleId": MessageLookupByLibrary.simpleMessage(
          "ID",
        ),
        "titleCost": MessageLookupByLibrary.simpleMessage(
          "Cost",
        ),
        "titlePassScoreQuiz": MessageLookupByLibrary.simpleMessage(
          "Pass score",
        ),
        "titleBtnStartQuiz": MessageLookupByLibrary.simpleMessage(
          "Start",
        ),
        "time": MessageLookupByLibrary.simpleMessage(
          "minute",
        ),
        "retestTime": MessageLookupByLibrary.simpleMessage(
          "retest time",
        ),
        "titleQuestions": MessageLookupByLibrary.simpleMessage(
          titleQuestions,
        ),
        "hintTextInputTypeQuiz": MessageLookupByLibrary.simpleMessage(
          "Câu trả lời...",
        ),
        "confirmCloseQuizAnswer": MessageLookupByLibrary.simpleMessage(
          "Your answers will not be saved. Do you want to close this screen now?",
        ),
        "confirmSubmitAnswer": MessageLookupByLibrary.simpleMessage(
          "Are you sure submit this answer?",
        ),
        "titleTimeResultQuiz": MessageLookupByLibrary.simpleMessage(
          "Times",
        ),
        "titleNumberResultQuiz": MessageLookupByLibrary.simpleMessage(
          "Number of test",
        ),
        "point": MessageLookupByLibrary.simpleMessage(
          "point",
        ),
        "pointCapitalized": MessageLookupByLibrary.simpleMessage(
          "Point",
        ),
        "testTime": MessageLookupByLibrary.simpleMessage(
          "test time",
        ),
        "question": MessageLookupByLibrary.simpleMessage(
          "Question",
        ),
        "startTime": MessageLookupByLibrary.simpleMessage(
          "Start time",
        ),
        "endTime": MessageLookupByLibrary.simpleMessage(
          "End time",
        ),
        "takingExam": MessageLookupByLibrary.simpleMessage(
          "Taking exam",
        ),
        "submitted": MessageLookupByLibrary.simpleMessage(
          "Submitted",
        ),
        "quizHistory": MessageLookupByLibrary.simpleMessage(
          "Quiz history",
        ),
        "titleTimeOutQuizDetail": MessageLookupByLibrary.simpleMessage(
          "Time out",
        ),
        "contentTimeOutQuizDetail": MessageLookupByLibrary.simpleMessage(
          "You've run out of time to take the quiz.",
        ),
        "btnQuizNow": MessageLookupByLibrary.simpleMessage(
          "Quiz now",
        ),
        "btnCancel": MessageLookupByLibrary.simpleMessage(
          "Cancel",
        ),
        "titlePassedQuiz": MessageLookupByLibrary.simpleMessage(
          "Congratulations on completing the test. Let's continue to improve",
        ),
        "titleFailedQuiz": MessageLookupByLibrary.simpleMessage(
          "Don’t give up. Failure is simply the opportunity to begin again, this time more intelligently",
        ),
        "viewResult": MessageLookupByLibrary.simpleMessage(
          "View result",
        ),
        "reQuiz": MessageLookupByLibrary.simpleMessage(
          "re Quiz",
        ),
        "confirmSubmitQuiz": MessageLookupByLibrary.simpleMessage(
          confirmSubmitQuiz,
        ),
      };

  static Map<String, Function> _notInlinedFlashCard(dynamic _) =>
      <String, Function>{
        "termsList": MessageLookupByLibrary.simpleMessage(
          "Terms List",
        ),
        "terms": MessageLookupByLibrary.simpleMessage(
          "Terms",
        ),
        "contentCongrats": MessageLookupByLibrary.simpleMessage(
          "You are doing great!\nLet's continue like this.",
        ),
        "reLearnTerm": MessageLookupByLibrary.simpleMessage(
          "Learn terms again",
        ),
        "back": MessageLookupByLibrary.simpleMessage(
          "Back",
        ),
        "known": MessageLookupByLibrary.simpleMessage(
          "Known",
        ),
        "studying": MessageLookupByLibrary.simpleMessage(
          "Studying",
        ),
        "remaining": MessageLookupByLibrary.simpleMessage(
          "Remaining",
        ),
        "apply": MessageLookupByLibrary.simpleMessage(
          "Apply",
        ),
        "explanation": MessageLookupByLibrary.simpleMessage(
          "Explanation",
        ),
        "cardSetting": MessageLookupByLibrary.simpleMessage(
          "Card setting",
        ),
        "shuffleOn": MessageLookupByLibrary.simpleMessage(
          "Shuffle : ON",
        ),
        "shuffleOff": MessageLookupByLibrary.simpleMessage(
          "Shuffle : OFF",
        ),
        "soundOn": MessageLookupByLibrary.simpleMessage(
          "Sound : ON",
        ),
        "soundOff": MessageLookupByLibrary.simpleMessage(
          "Sound : OFF",
        ),
        "remember": MessageLookupByLibrary.simpleMessage(
          "Remember",
        ),
        "titleSortFlashcard": MessageLookupByLibrary.simpleMessage(
          "Sort terms",
        ),
        "sortDefault": MessageLookupByLibrary.simpleMessage(
          "In the original order",
        ),
        "sortAlphabet": MessageLookupByLibrary.simpleMessage(
          "Alphabetical order",
        ),
        "reply": MessageLookupByLibrary.simpleMessage(
          "Reply",
        ),
      };

  static Map<String, Function> _notInlinedSetting(dynamic _) =>
      <String, Function>{
        "version": MessageLookupByLibrary.simpleMessage(
          "version: 1.0",
        ),
        "themeMode": MessageLookupByLibrary.simpleMessage(
          "Theme mode",
        ),
        "darkMode": MessageLookupByLibrary.simpleMessage(
          "Dark mode",
        ),
        "lightMode": MessageLookupByLibrary.simpleMessage(
          "Light mode",
        ),
        "login": MessageLookupByLibrary.simpleMessage(
          "Login",
        ),
        "createNewAccount": MessageLookupByLibrary.simpleMessage(
          "Create new account",
        ),
      };

  static Map<String, Function> _notInlinedMyLearningResult(dynamic _) =>
      <String, Function>{
        "titleMyResultScreen": MessageLookupByLibrary.simpleMessage(
          "My result",
        ),
        "titleAchievementsMyResult": MessageLookupByLibrary.simpleMessage(
          "Achievements",
        ),
        "titleCompletedMyResult": MessageLookupByLibrary.simpleMessage(
          "Completed",
        ),
        "titleTopQuizMyResult": MessageLookupByLibrary.simpleMessage(
          "TopQuiz",
        ),
        "titleTopCourseMyResult": MessageLookupByLibrary.simpleMessage(
          "TopCourse",
        ),
        "titleViewAllMyResult": MessageLookupByLibrary.simpleMessage(
          "View all",
        ),
        "success": MessageLookupByLibrary.simpleMessage(
          "Success",
        ),
        "error": MessageLookupByLibrary.simpleMessage(
          "Error",
        ),
        "warning": MessageLookupByLibrary.simpleMessage(
          "Warning",
        ),
        "titltestprojectTime": MessageLookupByLibrary.simpleMessage(
          "Day streak",
        ),
      };

  static Map<String, Function> _notInlinedErrorView(dynamic _) =>
      <String, Function>{
        "tryAgain": MessageLookupByLibrary.simpleMessage(
          "Try again",
        ),
        "noConnection": MessageLookupByLibrary.simpleMessage(
          "No Connection",
        ),
        "noConnectionTitle": MessageLookupByLibrary.simpleMessage(
          "No internet connection found",
        ),
        "noConnectionMessage": MessageLookupByLibrary.simpleMessage(
          "Please check your internet connection",
        ),
        "errorCode404": MessageLookupByLibrary.simpleMessage(
          "404",
        ),
        "errorCode404Title": MessageLookupByLibrary.simpleMessage(
          "Sorry",
        ),
        "errorCode404Message": MessageLookupByLibrary.simpleMessage(
          "The page you are on is not available",
        ),
        "errorCode500": MessageLookupByLibrary.simpleMessage(
          "500",
        ),
        "errorCode500Title": MessageLookupByLibrary.simpleMessage(
          "Internal Server Error",
        ),
        "errorCode500Message": MessageLookupByLibrary.simpleMessage(
          "Server error processing your request",
        ),
        "errorCode400": MessageLookupByLibrary.simpleMessage(
          "400",
        ),
        "errorCode400Title": MessageLookupByLibrary.simpleMessage(
          "Bad request",
        ),
        "errorCode400Message": MessageLookupByLibrary.simpleMessage(
          "We're sorry the page you are not found",
        ),
        "errorCode503": MessageLookupByLibrary.simpleMessage(
          "503",
        ),
        "errorCode503Title": MessageLookupByLibrary.simpleMessage(
          "Server down",
        ),
        "errorCode503Message": MessageLookupByLibrary.simpleMessage(
          "Server down error processing your request",
        ),
        "errorCode504": MessageLookupByLibrary.simpleMessage(
          "504",
        ),
        "errorCode504Title": MessageLookupByLibrary.simpleMessage(
          "Time out",
        ),
        "errorCode504Message": MessageLookupByLibrary.simpleMessage(
          "Time out error processing your request",
        ),
        "replyTo": MessageLookupByLibrary.simpleMessage(
          "Reply to",
        ),
      };
}
