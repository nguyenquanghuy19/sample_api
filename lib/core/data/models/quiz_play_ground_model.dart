import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';

class QuizDetailResponse {
  bool? status;
  String? message;
  QuizDetailModel? data;
  int? total;
  ExtendModel? extend;

  QuizDetailResponse({
    this.status,
    this.message,
    this.data,
    this.total,
    this.extend,
  });

  factory QuizDetailResponse.fromJson(Map<String, dynamic> json) {
    return QuizDetailResponse(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] != null ? QuizDetailModel.fromJson(json['data']) : null,
      total: json['total'],
      extend:
          json['extend'] != null ? ExtendModel.fromJson(json['extend']) : null,
    );
  }
}

class QuizDetailModel {
  int? id;
  int classroomId;
  int roadmapId;
  int contestId;
  DateTime? openDate;
  DateTime? closeDate;
  String? status;
  String? note;
  int? total;
  int? duration;
  int? remaining;
  String? passingScore;
  String? quizSeriesName;
  String? quizName;
  String? version;
  String? classroomSeriesName;
  String? classroomName;

  QuizDetailModel({
    this.id,
    this.classroomId = 0,
    this.roadmapId = 0,
    this.contestId = 0,
    this.openDate,
    this.closeDate,
    this.status,
    this.note,
    this.total,
    this.duration,
    this.remaining,
    this.passingScore,
    this.quizSeriesName,
    this.quizName,
    this.version,
    this.classroomSeriesName,
    this.classroomName,
  });

  int get calQuizCode => contestId + classroomId + roadmapId + 1000000;

  factory QuizDetailModel.fromJson(Map<String, dynamic> json) {
    return QuizDetailModel(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int,
      roadmapId: json['roadmapId'] as int,
      contestId: json['contestId'] as int,
      openDate: json['openDate'] == null
          ? null
          : DateTime.tryParse(json['openDate'] as String),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.tryParse(json['closeDate'] as String),
      status: json['status'] as String?,
      note: json['note'] as String?,
      total: json['total'] as int?,
      duration: json['duration'] as int?,
      remaining: json['remaining'] as int?,
      passingScore: json['passingScore'] as String?,
      quizSeriesName: json['quizSeriesName'] as String?,
      quizName: json['quizName'] as String?,
      version: json['version'] as String?,
      classroomSeriesName: json['classroomSeriesName'] as String?,
      classroomName: json['classroomName'] as String?,
    );
  }
}

class ExtendModel {
  List<MemberModel> members;

  ExtendModel({
    this.members = const [],
  });

  factory ExtendModel.fromJson(Map<String, dynamic> json) {
    return ExtendModel(
      members: (json['members'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  MemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class QuizPlayGroundResponse {
  bool? status;
  String? message;
  QuizPlayGroundModel? data;
  int? total;

  QuizPlayGroundResponse({
    this.status,
    this.message,
    this.data,
    this.total,
  });

  factory QuizPlayGroundResponse.fromJson(Map<String, dynamic> json) {
    return QuizPlayGroundResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? QuizPlayGroundModel.fromJson(json['data'])
          : null,
      total: json['total'] as int?,
    );
  }
}

class QuizPlayGroundModel {
  String? seriesName;
  String? name;
  String? slug;
  String? version;
  int? id;
  List<ItemQuizModel> items;
  String? result;
  bool? submitted;
  int? classroomId;
  int? roadmapId;
  int? contestId;
  String? contestName;
  String? note;
  DateTime? openDate;
  DateTime? closeDate;
  int? duration;
  int? total;
  int? remaining;

  QuizPlayGroundModel({
    this.seriesName,
    this.name,
    this.slug,
    this.version,
    this.id,
    this.items = const [],
    this.result,
    this.submitted,
    this.classroomId,
    this.roadmapId,
    this.contestId,
    this.contestName,
    this.note,
    this.openDate,
    this.closeDate,
    this.duration,
    this.total,
    this.remaining,
  });

  factory QuizPlayGroundModel.fromJson(Map<String, dynamic> json) {
    return QuizPlayGroundModel(
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      version: json['version'] as String?,
      id: json['id'] as int?,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    ItemQuizModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      result: json['result'] as String?,
      submitted: json['submitted'] as bool?,
      classroomId: json['classroomId'] as int?,
      roadmapId: json['roadmapId'] as int?,
      contestId: json['contestId'] as int?,
      contestName: json['contestName'] as String?,
      note: json['note'] as String?,
      openDate: json['openDate'] == null
          ? null
          : DateTime.tryParse(json['openDate'] as String),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.tryParse(json['closeDate'] as String),
      duration: json['duration'] as int?,
      total: json['total'] as int?,
      remaining: json['remaining'] as int?,
    );
  }
}

class ItemQuizModel {
  String? scoreRate;
  String? group;
  String? subGroup;
  String? question;
  String? questionHint;
  String? totalAnswers;
  String? questionType;
  String? answerType;
  List<String> answer;
  List<dynamic> correct;
  List<dynamic> result;
  String? groupParent;
  String? subGroupParent;
  String? groupBreak;
  String? questionParent;
  String? questionBreak;
  List<bool> answerMultiple;
  String? answerSingle;
  String? answerInput;

  ItemQuizModel({
    this.scoreRate,
    this.group,
    this.subGroup,
    this.question,
    this.questionHint,
    this.totalAnswers,
    this.questionType,
    this.answerType,
    this.answer = const [],
    this.correct = const [],
    this.result = const [],
    this.groupParent,
    this.subGroupParent,
    this.groupBreak,
    this.questionParent,
    this.questionBreak,
    this.answerMultiple = const [],
    this.answerSingle,
    this.answerInput,
  });

  factory ItemQuizModel.fromJson(Map<String, dynamic> json) {
    // ToDo: waiting update camelCase

    ItemQuizModel itemsQuiz = ItemQuizModel();

    itemsQuiz = ItemQuizModel(
      scoreRate: json['score_rate'] as String?,
      group: json['group'] as String?,
      subGroup: json['sub_group'] as String?,
      question: json['question'] as String?,
      questionHint: json['question_hint'] as String?,
      totalAnswers: json['total_answers'] as String?,
      questionType: json['question_type'] as String?,
      answerType: json['answer_type'] as String?,
      answer: json['answer'].cast<String>() ?? const [],
      correct: json['correct'].cast<dynamic>() ?? const [],
      result:
          json['result'] != null ? json['result'].cast<dynamic>() : const [],
      groupParent: json['group_parent'] as String?,
      subGroupParent: json['sub_group_parent'] as String?,
      groupBreak: json['group_break'] as String?,
      questionParent: json['question_parent'] as String?,
      questionBreak: json['question_break'] as String?,
    );

    itemsQuiz.answerMultiple = [];
    for (var _ in itemsQuiz.answer) {
      itemsQuiz.answerMultiple.add(false);
    }

    return itemsQuiz;
  }

  List<bool> getCorrectSingle() {
    List<bool> correct = [];
    for (var _ in answer) {
      if (_ == answerSingle) {
        correct.add(true);
      } else {
        correct.add(false);
      }
    }

    return correct;
  }

  List<dynamic> getCorrectType() {
    List<dynamic> correct = [];
    if (answerInput != null) {
      correct.add(answerInput);
    } else {
      correct.add("");
    }

    return correct;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'score_rate': scoreRate,
        'group': group,
        'sub_group': subGroup,
        'question': question,
        'question_hint': questionHint,
        'total_answers': totalAnswers,
        'question_type': questionType,
        'answer_type': answerType,
        'answer': answer,
        'correct': answerType == Constants.multipleAnswers
            ? answerMultiple
            : answerType == Constants.singleAnswer
                ? getCorrectSingle()
                : answerType == Constants.dropAnswer
                    ? correct
                    : getCorrectType(),
        'group_parent': groupParent,
        'sub_group_parent': subGroupParent,
        'group_break': groupBreak,
        'question_parent': questionParent,
        'question_break': questionBreak,
      };

  bool get isAnswer {
    if (answerType == Constants.dropAnswer) {
      return true;
    }
    if (answerType == Constants.multipleAnswers) {
      if (answerMultiple.contains(true)) {
        return true;
      }

      return false;
    }

    if (answerType == Constants.singleAnswer) {
      if (answerSingle != null) {
        return true;
      }

      return false;
    }

    if (answerInput != null) {
      return true;
    }

    return false;
  }
}

class SubmitModel {
  bool? status;
  String? message;
  bool? data;
  int? total;

  SubmitModel({
    this.status,
    this.message,
    this.data,
    this.total,
  });

  factory SubmitModel.fromJson(Map<String, dynamic> json) {
    return SubmitModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as bool?,
      total: json['total'] as int?,
    );
  }
}

class ParamQuizModel {
  int id;
  List<ItemQuizModel> result;

  ParamQuizModel({
    required this.id,
    this.result = const [],
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'result': result.map((v) => v.toJson()).toList(),
      };
}

class ScoreResultModel {
  int? score;
  int scorePass;
  int scoreTotal;
  num scorePercent;

  ScoreResultModel({
    this.score,
    this.scorePass = 0,
    this.scoreTotal = 0,
    this.scorePercent = 0,
  });

  factory ScoreResultModel.fromJson(Map<String, dynamic> json) {
    return ScoreResultModel(
      score: json['score'] as int?,
      scorePass: json['score_pass'] as int,
      scoreTotal: json['score_total'] as int,
      scorePercent: json['score_percent'] as num,
    );
  }
}

class DataResultModel {
  int? id;
  String? memberId;
  int classroomId;
  int roadmapId;
  int contestId;
  String? contestName;
  String? status;
  String? type;
  List<ItemQuizModel> result;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? dateExpires;
  bool? submitted;
  List<String> comments;
  ScoreResultModel? scoreResult;
  String? classroomSeriesName;
  String? classroomName;
  String? quizSeriesName;
  String? quizName;
  String? displayName;
  String? userName;
  String? lastName;
  String? firstName;
  String? email;

  DataResultModel({
    this.id,
    this.memberId,
    this.classroomId = 0,
    this.roadmapId = 0,
    this.contestId = 0,
    this.contestName,
    this.status,
    this.type,
    this.result = const [],
    this.startDate,
    this.endDate,
    this.dateExpires,
    this.submitted,
    this.comments = const [],
    this.scoreResult,
    this.classroomSeriesName,
    this.classroomName,
    this.quizSeriesName,
    this.quizName,
    this.displayName,
    this.userName,
    this.lastName,
    this.firstName,
    this.email,
  });

  int get calQuizCode => contestId + classroomId + roadmapId + 1000000;

  factory DataResultModel.fromJson(Map<String, dynamic> json) {
    return DataResultModel(
      id: json['id'] as int?,
      memberId: json['memberId'] as String?,
      classroomId: json['classroomId'] as int,
      roadmapId: json['roadmapId'] as int,
      contestId: json['contestId'] as int,
      contestName: json['contestName'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      result: (json['result'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ItemQuizModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.tryParse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.tryParse(json['endDate'] as String),
      dateExpires: json['dateExpires'] == null
          ? null
          : DateTime.tryParse(json['dateExpires'] as String),
      submitted: json['submitted'] as bool?,
      comments: json['comments'].cast<String>() ?? const [],
      scoreResult: json['scoreResult'] != null
          ? ScoreResultModel.fromJson(json['scoreResult'])
          : null,
      classroomSeriesName: json['classroomSeriesName'] as String?,
      classroomName: json['classroomName'] as String?,
      quizSeriesName: json['quizSeriesName'] as String?,
      quizName: json['quizName'] as String?,
      displayName: json['displayName'] as String,
      userName: json['userName'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
    );
  }
}

class ResultResponseModel {
  bool? status;
  String? message;
  DataResultModel? data;
  int total;

  ResultResponseModel({
    this.status,
    this.message,
    this.data,
    this.total = 0,
  });

  factory ResultResponseModel.fromJson(Map<String, dynamic> json) {
    return ResultResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data:
          json['data'] != null ? DataResultModel.fromJson(json['data']) : null,
      total: json['total'] as int,
    );
  }
}
