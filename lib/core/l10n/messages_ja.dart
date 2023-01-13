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
  String get localeName => "ja";

  static String mDescriptionLecture(int total) => "Total lecture: $total";

  static String mNumberMeaning(int numberMeaning) => "Meaning $numberMeaning";

  static String progressCompleted(String process) => "$process%";

  static String remainingTimes(String remaining) => "$remaining Remaining days";

  static String lectureCount(String count) => "$count Lecture";

  static String quizCount(String count) => "$count テスト";

  static String flashCardCount(String count) => "$count フラッシュカード";

  static String slideShow(String count) => "$count スライドショー";

  static String lectureSum(int sum) => "$sum Lecture";

  static String timeRemainingQuiz(int timeRemaining) => "$timeRemaining mins";

  static String titleQuestions(String countTitleQuestion) =>
      "質問 $countTitleQuestion";

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

  static String titleMemberMyLearning(String members) => "$members 学生";

  static String titleUnits(String units) => "$units units";

  static String confirmSubmitQuiz(int numberNotAnswer) =>
      "Bạn còn $numberNotAnswer câu chưa trả lời. Bạn có chắc chắn muốn nộp bài không?";

  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, Function> _notInlinedMessages(dynamic _) {
    return <String, Function>{
      "homeBottomNavigationBar": MessageLookupByLibrary.simpleMessage(
        "ホーム",
      ),
      "expirationToken": MessageLookupByLibrary.simpleMessage(
        "ログイン セッションの有効期限が切れました。ログインして続行してください",
      ),
      "anErrorHasOccurred": MessageLookupByLibrary.simpleMessage(
        "An error has occurred",
      ),
      "languageChange": MessageLookupByLibrary.simpleMessage(
        "言語変更",
      ),
      "reStartApp": MessageLookupByLibrary.simpleMessage(
        "言語を変更するには、アプリを再起動する必要があります。 今すぐ再起動しますか?",
      ),
      "about": MessageLookupByLibrary.simpleMessage(
        "アプリ情報",
      ),
      "comments": MessageLookupByLibrary.simpleMessage(
        "コメント",
      ),
      "aComment": MessageLookupByLibrary.simpleMessage(
        "コメント",
      ),
      "pages": MessageLookupByLibrary.simpleMessage(
        "pages",
      ),
      "page": MessageLookupByLibrary.simpleMessage(
        "page",
      ),
      "progress": MessageLookupByLibrary.simpleMessage(
        "進捗",
      ),
      "lecture": MessageLookupByLibrary.simpleMessage(
        "Lecture",
      ),
      "cancel": MessageLookupByLibrary.simpleMessage(
        "Cancel",
      ),
      "gotIt": MessageLookupByLibrary.simpleMessage(
        "Got It",
      ),
      "all": MessageLookupByLibrary.simpleMessage(
        "すべての活動",
      ),
      "complete": MessageLookupByLibrary.simpleMessage(
        "Complete",
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
  }

  static Map<String, Function> _notInlinedAuth(dynamic _) => <String, Function>{
        "requestANewPassword": MessageLookupByLibrary.simpleMessage(
          "パスワードのリセット",
        ),
        "pleaseEnterYourEmail": MessageLookupByLibrary.simpleMessage(
          "入力していただいたメールアドレス宛に再設定のご案内メールが届きます。",
        ),
        "rememberPassword": MessageLookupByLibrary.simpleMessage(
          "現在のパスワードを覚えている",
        ),
        "haveAnAccount": MessageLookupByLibrary.simpleMessage(
          "すでにアカウントをお持ちですか？ログイン",
        ),
        "introduceMessage": MessageLookupByLibrary.simpleMessage(
          "はじめまして!",
        ),
        "introduceLogIn": MessageLookupByLibrary.simpleMessage(
          "ログインしましょう。",
        ),
        "welcomeBack": MessageLookupByLibrary.simpleMessage(
          "ようこそ",
        ),
        "rememberAccount": MessageLookupByLibrary.simpleMessage(
          "ログイン状態を保持する ?",
        ),
        "forgottenPassword": MessageLookupByLibrary.simpleMessage(
          "パスワードを忘れた場合 ?",
        ),
        "signUpNavigation": MessageLookupByLibrary.simpleMessage(
          "無料でアカウント登録する ? ",
        ),
        "btnResetPassword": MessageLookupByLibrary.simpleMessage(
          "パスワードのリセット",
        ),
        "btnSignIn": MessageLookupByLibrary.simpleMessage(
          "ログイン",
        ),
        "signUp": MessageLookupByLibrary.simpleMessage(
          "登録",
        ),
        "btnSignUp": MessageLookupByLibrary.simpleMessage(
          "登録",
        ),
        "emailRequired": MessageLookupByLibrary.simpleMessage(
          "メールアドレスは必須項目です。",
        ),
        "emailInvalid": MessageLookupByLibrary.simpleMessage(
          "無効なメールアドレスです。・有効なメールアドレスを入力してください。",
        ),
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "パスワードは必須項目です。",
        ),
        "passwordOldRequired": MessageLookupByLibrary.simpleMessage(
          "古いパスワードは必須項目です。",
        ),
        "passwordLeastLength": MessageLookupByLibrary.simpleMessage(
          "8 文字以上で入力してください。",
        ),
        "passwordUppercase": MessageLookupByLibrary.simpleMessage(
          "パスワードは1文字以上のアルファベット大文字('A'-'Z')が必要です。",
        ),
        "passwordLowerCase": MessageLookupByLibrary.simpleMessage(
          "パスワードは1文字以上のアルファベット小文字('A'-'Z')が必要です。",
        ),
        "passwordDigit": MessageLookupByLibrary.simpleMessage(
          "パスワードは少なくとも1つの数字('0'-'9')が必要です。",
        ),
        "passwordSpecial": MessageLookupByLibrary.simpleMessage(
          "パスワードは少なくとも1つの英数字以外の文字が必要です。",
        ),
        "sendMailFailed": MessageLookupByLibrary.simpleMessage(
          "Send mail failed.",
        ),
        "registerAccountTitle": MessageLookupByLibrary.simpleMessage(
          "新規登録",
        ),
        "updatePasswordTitle": MessageLookupByLibrary.simpleMessage(
          "パスワードの更新",
        ),
        "updatePasswordButton": MessageLookupByLibrary.simpleMessage(
          "送信",
        ),
        "updatePasswordContent": MessageLookupByLibrary.simpleMessage(
          "半角の英字と数字、特殊な文字を含む、8文字以上の文字列",
        ),
        "oldPassword": MessageLookupByLibrary.simpleMessage(
          "現在のパスワード",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage(
          "新しいパスワード",
        ),
        "confirmPassword": MessageLookupByLibrary.simpleMessage(
          "新しいパスワード（確認用）",
        ),
        "registerAccountContent": MessageLookupByLibrary.simpleMessage(
          "ただいま処理中です．．．しばらくお待ちください。",
        ),
        "emailAddress": MessageLookupByLibrary.simpleMessage(
          "メールアドレス",
        ),
        "password": MessageLookupByLibrary.simpleMessage(
          "パスワード",
        ),
        "repeatPassword": MessageLookupByLibrary.simpleMessage(
          "パスワードの再入力",
        ),
        "agreeTermsAndConditions": MessageLookupByLibrary.simpleMessage(
          "利用規則に同意する",
        ),
        "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "パスワード確認が必要です",
        ),
        "comparePasswordError": MessageLookupByLibrary.simpleMessage(
          "パスワードと確認パスワードが一致しません。",
        ),
        "checkAgreeTermsAndConditions": MessageLookupByLibrary.simpleMessage(
          "利用規約に同意してください。",
        ),
        "passwordInvalidCharacter": MessageLookupByLibrary.simpleMessage(
          "パスワードに無効な文字が含まれています。",
        ),
        "labelSignUp": MessageLookupByLibrary.simpleMessage(
          "登録",
        ),
      };

  static Map<String, Function> _notInlinedProfile(dynamic _) =>
      <String, Function>{
        "profile": MessageLookupByLibrary.simpleMessage(
          "プロファイル",
        ),
        "titleUpdateProfile": MessageLookupByLibrary.simpleMessage(
          "プロファイル編集",
        ),
        "hintTextDisplayName": MessageLookupByLibrary.simpleMessage(
          "表示名",
        ),
        "hintTextPhoneNumber": MessageLookupByLibrary.simpleMessage(
          "電話",
        ),
        "labelSubmit": MessageLookupByLibrary.simpleMessage(
          "送信",
        ),
        "labelEdit": MessageLookupByLibrary.simpleMessage(
          "編集",
        ),
        "hintTextLastName": MessageLookupByLibrary.simpleMessage(
          "姓",
        ),
        "hintTextFirstName": MessageLookupByLibrary.simpleMessage(
          "名",
        ),
        "hintTextFullName": MessageLookupByLibrary.simpleMessage(
          "姓名",
        ),
        "hintTextDateOfBirth": MessageLookupByLibrary.simpleMessage(
          "生年月日",
        ),
        "hintTextGender": MessageLookupByLibrary.simpleMessage(
          "性別 ",
        ),
        "hintTextAddress": MessageLookupByLibrary.simpleMessage(
          "住所",
        ),
        "hintTextCountry": MessageLookupByLibrary.simpleMessage(
          "居住国",
        ),
        "hintTextCity": MessageLookupByLibrary.simpleMessage(
          "市区町村",
        ),
        "removeAvatar": MessageLookupByLibrary.simpleMessage(
          "アバターを削除",
        ),
        "phoneNumberInValid": MessageLookupByLibrary.simpleMessage(
          "無効な電話番号です。",
        ),
        "defaultValueProfile": MessageLookupByLibrary.simpleMessage(
          "空のデータ",
        ),
        "displayNameRequired": MessageLookupByLibrary.simpleMessage(
          "Display is required",
        ),
        "valueMale": MessageLookupByLibrary.simpleMessage(
          "男",
        ),
        "valueFemale": MessageLookupByLibrary.simpleMessage(
          "女",
        ),
        "valueOther": MessageLookupByLibrary.simpleMessage(
          "なし",
        ),
        "messageErrorDatePicker": MessageLookupByLibrary.simpleMessage(
          "Enter valid date",
        ),
        "messageErrorInvalidDatePicker": MessageLookupByLibrary.simpleMessage(
          "Enter date in valid range",
        ),
        "titleCamera": MessageLookupByLibrary.simpleMessage(
          "カメラ",
        ),
        "titleGallery": MessageLookupByLibrary.simpleMessage(
          "ギャラリー",
        ),
      };

  static Map<String, Function> _notInlinedMyLearning(dynamic _) =>
      <String, Function>{
        "information": MessageLookupByLibrary.simpleMessage(
          "情報",
        ),
        "rankMyLearning": MessageLookupByLibrary.simpleMessage(
          "ランキング",
        ),
        "result": MessageLookupByLibrary.simpleMessage(
          "結果",
        ),
        "memberMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "1 学生",
        ),
        "memberCourseMyLearning": MessageLookupByLibrary.simpleMessage(
          titleMemberMyLearning,
        ),
        "slideShowMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "スライドショー",
        ),
        "progressCompleted": MessageLookupByLibrary.simpleMessage(
          progressCompleted,
        ),
        "lectureSum": MessageLookupByLibrary.simpleMessage(
          lectureSum,
        ),
        "startNowMyLearningDetail": MessageLookupByLibrary.simpleMessage(
          "今すぐ開始",
        ),
        "ok": MessageLookupByLibrary.simpleMessage(
          "ok",
        ),
        "myResult": MessageLookupByLibrary.simpleMessage(
          "私の結果",
        ),
        "historyActivity": MessageLookupByLibrary.simpleMessage(
          "最近の活動",
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
          "通知",
        ),
        "titleQuiz": MessageLookupByLibrary.simpleMessage(
          "テスト",
        ),
        "status": MessageLookupByLibrary.simpleMessage(
          "ステータス",
        ),
        "registered": MessageLookupByLibrary.simpleMessage(
          "登録済み",
        ),
        "confirmRegister": MessageLookupByLibrary.simpleMessage(
          "このコースを登録しますか？",
        ),
        "confirmLoginToRegisterCourse": MessageLookupByLibrary.simpleMessage(
          "コースに登録するには、ログインする必要があります。ログインへ遷移します。",
        ),
        "confirm": MessageLookupByLibrary.simpleMessage(
          "確認",
        ),
        "timeRemainingQuiz": MessageLookupByLibrary.simpleMessage(
          timeRemainingQuiz,
        ),
        "hintTextSearchMyLearning": MessageLookupByLibrary.simpleMessage(
          "学習を見つける",
        ),
        "myLearningEmpty": MessageLookupByLibrary.simpleMessage(
          "どのコースにも参加していません。 新しいコースを見つけて登録します。",
        ),
        "quizCompleted": MessageLookupByLibrary.simpleMessage(
          "クイズが完了しました。",
        ),
        "attendance": MessageLookupByLibrary.simpleMessage(
          "出席",
        ),
        "absent": MessageLookupByLibrary.simpleMessage(
          "不在",
        ),
        "teacherCommunication": MessageLookupByLibrary.simpleMessage(
          "教師のコミュニケーション",
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
          "点",
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
      };

  static Map<String, Function> _notInlinedCourse(dynamic _) =>
      <String, Function>{
        "hintTextSearchCourses": MessageLookupByLibrary.simpleMessage(
          "コースの検索",
        ),
        "titleCourses": MessageLookupByLibrary.simpleMessage(
          "コース",
        ),
        "review": MessageLookupByLibrary.simpleMessage(
          "レビュー",
        ),
        "roadMap": MessageLookupByLibrary.simpleMessage(
          "ロードマップ",
        ),
        "overview": MessageLookupByLibrary.simpleMessage(
          "概要",
        ),
        "discussion": MessageLookupByLibrary.simpleMessage(
          "討論 ",
        ),
        "seeMore": MessageLookupByLibrary.simpleMessage(
          "もっと見る",
        ),
        "showLess": MessageLookupByLibrary.simpleMessage(
          "See less",
        ),
        "course": MessageLookupByLibrary.simpleMessage(
          "コース",
        ),
        "whatWillYouLearn": MessageLookupByLibrary.simpleMessage(
          "あなたは何を学びたいですか?",
        ),
        "register": MessageLookupByLibrary.simpleMessage(
          "登録",
        ),
        "descriptionRoadMap": mDescriptionLecture,
        "forum": MessageLookupByLibrary.simpleMessage(
          "フォーラム",
        ),
        "like": MessageLookupByLibrary.simpleMessage(
          "好き",
        ),
        "liked": MessageLookupByLibrary.simpleMessage(
          "いいね",
        ),
        "report": MessageLookupByLibrary.simpleMessage(
          "レポート",
        ),
        "oneWeekAgo": MessageLookupByLibrary.simpleMessage(
          "1週間前",
        ),
        "lastWeek": MessageLookupByLibrary.simpleMessage(
          "先週",
        ),
        "daysAgo": MessageLookupByLibrary.simpleMessage(
          "数日前",
        ),
        "oneDayAgo": MessageLookupByLibrary.simpleMessage(
          "1日前",
        ),
        "yesterday": MessageLookupByLibrary.simpleMessage(
          "昨日のこと",
        ),
        "hoursAgo": MessageLookupByLibrary.simpleMessage(
          "時間前",
        ),
        "oneHourAgo": MessageLookupByLibrary.simpleMessage(
          "1 hour ago",
        ),
        "anHourAgo": MessageLookupByLibrary.simpleMessage(
          "An hour ago",
        ),
        "minutesAgo": MessageLookupByLibrary.simpleMessage(
          "数分前",
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
          "ちょうど今",
        ),
        "daily": MessageLookupByLibrary.simpleMessage(
          "日次",
        ),
        "weekly": MessageLookupByLibrary.simpleMessage(
          "週次",
        ),
        "monthly": MessageLookupByLibrary.simpleMessage(
          "月次",
        ),
        "latest": MessageLookupByLibrary.simpleMessage(
          "最新",
        ),
        "courseDetail": MessageLookupByLibrary.simpleMessage(
          "コース詳細",
        ),
        "courseSummary": MessageLookupByLibrary.simpleMessage(
          "コース概要",
        ),
        "summaryMyLearning": MessageLookupByLibrary.simpleMessage(
          "Summary",
        ),
        "hintTextComment": MessageLookupByLibrary.simpleMessage(
          "コメントを入力してください",
        ),
        "messageLoginBeforeComment": MessageLookupByLibrary.simpleMessage(
          "You need login before leave your comment",
        ),
        "leaveYourComment": MessageLookupByLibrary.simpleMessage(
          "コメントを残す",
        ),
        "comment": MessageLookupByLibrary.simpleMessage(
          "コメント",
        ),
        "loadMoreComment": MessageLookupByLibrary.simpleMessage(
          "もっと読み込む",
        ),
        "teacher": MessageLookupByLibrary.simpleMessage(
          "講師",
        ),
        "dateEnd": MessageLookupByLibrary.simpleMessage(
          "終了日",
        ),
        "dateStart": MessageLookupByLibrary.simpleMessage(
          "開始日",
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
          "通知",
        ),
        "general": MessageLookupByLibrary.simpleMessage(
          "全般的",
        ),
        "delete": MessageLookupByLibrary.simpleMessage(
          "削除",
        ),
        "readTick": MessageLookupByLibrary.simpleMessage(
          "Seen",
        ),
        "reset": MessageLookupByLibrary.simpleMessage(
          "リセット",
        ),
        "filter": MessageLookupByLibrary.simpleMessage(
          "フイルタ",
        ),
        "flashCard": MessageLookupByLibrary.simpleMessage(
          "フラッシュカード",
        ),
        "myLearningDetail": MessageLookupByLibrary.simpleMessage(
          "私の学習詳細",
        ),
        "searchTitle": MessageLookupByLibrary.simpleMessage(
          "検索",
        ),
        "showAllNotification": MessageLookupByLibrary.simpleMessage(
          "すべての通知を表示する",
        ),
        "titleClassRoom": MessageLookupByLibrary.simpleMessage(
          "教室",
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
          "費用",
        ),
        "titlePassScoreQuiz": MessageLookupByLibrary.simpleMessage(
          "合格最低点",
        ),
        "titleBtnStartQuiz": MessageLookupByLibrary.simpleMessage(
          "始め",
        ),
        "time": MessageLookupByLibrary.simpleMessage(
          "分",
        ),
        "titleNumberTestQuiz": MessageLookupByLibrary.simpleMessage(
          "number of tests",
        ),
        "titleQuestions": MessageLookupByLibrary.simpleMessage(
          titleQuestions,
        ),
        "hintTextInputTypeQuiz": MessageLookupByLibrary.simpleMessage(
          "回答...",
        ),
        "confirmCloseQuizAnswer": MessageLookupByLibrary.simpleMessage(
          "回答は保存されません。 今すぐこの画面を閉じますか?",
        ),
        "confirmSubmitAnswer": MessageLookupByLibrary.simpleMessage(
          "この回答を送信してもよろしいですか?",
        ),
        "titleTimeResultQuiz": MessageLookupByLibrary.simpleMessage(
          "回",
        ),
        "titleNumberResultQuiz": MessageLookupByLibrary.simpleMessage(
          "Number of test",
        ),
        "point": MessageLookupByLibrary.simpleMessage(
          "ポイント",
        ),
        "pointCapitalized": MessageLookupByLibrary.simpleMessage(
          "ポイント",
        ),
        "testTime": MessageLookupByLibrary.simpleMessage(
          "試験時間",
        ),
        "question": MessageLookupByLibrary.simpleMessage(
          "質問",
        ),
        "startTime": MessageLookupByLibrary.simpleMessage(
          "開始時間",
        ),
        "endTime": MessageLookupByLibrary.simpleMessage(
          "終了時間",
        ),
        "takingExam": MessageLookupByLibrary.simpleMessage(
          "受験",
        ),
        "submitted": MessageLookupByLibrary.simpleMessage(
          "送信した。",
        ),
        "quizHistory": MessageLookupByLibrary.simpleMessage(
          "クイズの歴史",
        ),
        "titleTimeOutQuizDetail": MessageLookupByLibrary.simpleMessage(
          "タイムアウト",
        ),
        "contentTimeOutQuizDetail": MessageLookupByLibrary.simpleMessage(
          "クイズに答える時間がなくなりました。.",
        ),
        "retestTime": MessageLookupByLibrary.simpleMessage(
          "再テスト回数",
        ),
        "btnQuizNow": MessageLookupByLibrary.simpleMessage(
          "今すぐクイズ",
        ),
        "btnCancel": MessageLookupByLibrary.simpleMessage(
          "キャンセル",
        ),
        "titlePassedQuiz": MessageLookupByLibrary.simpleMessage(
          "Congratulations on completing the test. Let's continue to improve",
        ),
        "titleFailedQuiz": MessageLookupByLibrary.simpleMessage(
          "Don’t give up. Failure is simply the opportunity to begin again, this time more intelligently",
        ),
        "viewResult": MessageLookupByLibrary.simpleMessage(
          "結果を見る",
        ),
        "reQuiz": MessageLookupByLibrary.simpleMessage(
          "reQuiz",
        ),
        "confirmSubmitQuiz": MessageLookupByLibrary.simpleMessage(
          confirmSubmitQuiz,
        ),
      };

  static Map<String, Function> _notInlinedFlashCard(dynamic _) =>
      <String, Function>{
        "termsList": MessageLookupByLibrary.simpleMessage(
          "条項一覧",
        ),
        "terms": MessageLookupByLibrary.simpleMessage(
          "条項",
        ),
        "contentCongrats": MessageLookupByLibrary.simpleMessage(
          "あなたは素晴らしいです!\n難しい用語に引き続き集中してください。",
        ),
        "reLearnTerm": MessageLookupByLibrary.simpleMessage(
          "用語をもう一度学ぶ",
        ),
        "back": MessageLookupByLibrary.simpleMessage(
          "戻る",
        ),
        "known": MessageLookupByLibrary.simpleMessage(
          "知られている",
        ),
        "studying": MessageLookupByLibrary.simpleMessage(
          "勉強する",
        ),
        "remaining": MessageLookupByLibrary.simpleMessage(
          "実行回数",
        ),
        "apply": MessageLookupByLibrary.simpleMessage(
          "申し込み",
        ),
        "explanation": MessageLookupByLibrary.simpleMessage(
          "説明",
        ),
        "cardSetting": MessageLookupByLibrary.simpleMessage(
          "カード設定",
        ),
        "shuffleOn": MessageLookupByLibrary.simpleMessage(
          "シャッフル : オン",
        ),
        "shuffleOff": MessageLookupByLibrary.simpleMessage(
          "シャッフル : オフ",
        ),
        "soundOn": MessageLookupByLibrary.simpleMessage(
          "音声 : オン",
        ),
        "soundOff": MessageLookupByLibrary.simpleMessage(
          "音声 : オフ",
        ),
        "remember": MessageLookupByLibrary.simpleMessage(
          "思い出す",
        ),
        "titleSortFlashcard": MessageLookupByLibrary.simpleMessage(
          "条項ソート",
        ),
        "sortDefault": MessageLookupByLibrary.simpleMessage(
          "元の順番で",
        ),
        "sortAlphabet": MessageLookupByLibrary.simpleMessage(
          "アルファベット順",
        ),
        "reply": MessageLookupByLibrary.simpleMessage(
          "返事",
        ),
      };

  static Map<String, Function> _notInlinedSetting(dynamic _) =>
      <String, Function>{
        "version": MessageLookupByLibrary.simpleMessage(
          "バージョン: 1.0",
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
          "ログイン",
        ),
        "createNewAccount": MessageLookupByLibrary.simpleMessage(
          "Create new account",
        ),
      };

  static Map<String, Function> _notInlinedMyLearningResult(dynamic _) =>
      <String, Function>{
        "titleMyResultScreen": MessageLookupByLibrary.simpleMessage(
          "私の結果",
        ),
        "titleAchievementsMyResult": MessageLookupByLibrary.simpleMessage(
          "実績",
        ),
        "titleCompletedMyResult": MessageLookupByLibrary.simpleMessage(
          "完了",
        ),
        "titleTopQuizMyResult": MessageLookupByLibrary.simpleMessage(
          "トップクイズ",
        ),
        "titleTopCourseMyResult": MessageLookupByLibrary.simpleMessage(
          "トップコース",
        ),
        "titleViewAllMyResult": MessageLookupByLibrary.simpleMessage(
          "すべて見る",
        ),
        "success": MessageLookupByLibrary.simpleMessage(
          "成功",
        ),
        "error": MessageLookupByLibrary.simpleMessage(
          "エラー",
        ),
        "warning": MessageLookupByLibrary.simpleMessage(
          "警告",
        ),
        "titltestprojectTime": MessageLookupByLibrary.simpleMessage(
          "Day streak",
        ),
        "hello": MessageLookupByLibrary.simpleMessage(
          "こんにちは！",
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
