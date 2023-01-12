import 'dart:typed_data';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:intl/intl.dart';

class DataResponseMyLearningModel {
  bool? status;
  String? message;
  List<MyLearningModel> data;
  int? total;

  // String? extend;

  DataResponseMyLearningModel({
    this.status,
    this.message,
    this.data = const [],
    this.total,
    // this.extend,
  });

  factory DataResponseMyLearningModel.fromJson(Map<String, dynamic> json) {
    return DataResponseMyLearningModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  MyLearningModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as int,
      // extend: json['extend'] as String,
    );
  }
}

class MyLearningModel {
  int? id;
  String? uuid;
  String? seriesName;
  String? name;
  String? description;
  int? total;
  int? used;
  String? status;
  String? type;
  String? licensed;
  String? featuredImage;
  String? slug;
  String? version;
  SettingModel? setting;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TeacherModel> teachers;
  List<MemberModel> members;
  List<RoadmapModel> roadmaps;
  Uint8List? image;
  bool isSvg;
  bool isLoadingImage;

  MyLearningModel({
    this.id,
    this.uuid,
    this.seriesName,
    this.name,
    this.description,
    this.total,
    this.used,
    this.status,
    this.type,
    this.licensed,
    this.featuredImage,
    this.slug,
    this.version,
    this.setting,
    this.createdAt,
    this.updatedAt,
    this.teachers = const [],
    this.members = const [],
    this.roadmaps = const [],
    this.image,
    this.isSvg = false,
    this.isLoadingImage = true,
  });

  factory MyLearningModel.fromJson(Map<String, dynamic> json) {
    return MyLearningModel(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      total: json['total'] as int?,
      used: json['used'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      licensed: json['licensed'] as String?,
      featuredImage: json['featuredImage'] as String?,
      slug: json['slug'] as String?,
      version: json['version'] as String?,
      setting: json['settings'] != null
          ? SettingModel.fromJson(json['settings'])
          : null,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      teachers: (json['teachers'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  TeacherModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      members: (json['members'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  MemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      roadmaps: (json['roadmaps'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  RoadmapModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoadingImage: true,
    );
  }

  String? get dateFormat {
    if (updatedAt != null) {
      return DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(updatedAt!);
    }

    return null;
  }
}

class SettingModel {
  String? saleOff;
  String? openDate;
  String? closeDate;

  SettingModel({this.saleOff, this.openDate, this.closeDate});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      saleOff: json['saleOff'] as String?,
      openDate: json['openDate'] as String?,
      closeDate: json['closeDate'] as String?,
    );
  }
}

class MyLearningDetailResponse {
  bool? status;
  String? message;
  MyLearningDetailModel? data;
  int? total;

  MyLearningDetailResponse({
    this.status,
    this.message,
    this.data,
    this.total,
  });

  factory MyLearningDetailResponse.fromJson(Map<String, dynamic> json) {
    return MyLearningDetailResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? MyLearningDetailModel.fromJson(json['data'])
          : null,
      total: json['total'] as int?,
    );
  }
}

class MyLearningDetailModel {
  int? id;
  String? uuid;
  String? seriesName;
  String? name;
  String? description;
  int? total;
  int? used;
  String? status;
  String? type;
  String? licensed;
  String? featuredImage;
  String? slug;
  String? version;
  SettingMyLearningDetailModel? settings;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TeacherModel> teachers;
  List<MemberModel> members;
  List<RoadmapModel> roadmaps;
  Uint8List? image;
  bool isSvg;

  MyLearningDetailModel({
    this.id,
    this.uuid,
    this.seriesName,
    this.name,
    this.description,
    this.total,
    this.used,
    this.status,
    this.type,
    this.licensed,
    this.featuredImage,
    this.slug,
    this.version,
    this.settings,
    this.createdAt,
    this.updatedAt,
    this.teachers = const [],
    this.members = const [],
    this.roadmaps = const [],
    this.image,
    this.isSvg = false,
  });

  factory MyLearningDetailModel.fromJson(Map<String, dynamic> json) {
    return MyLearningDetailModel(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      total: json['total'] as int?,
      used: json['used'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      licensed: json['licensed'] as String?,
      featuredImage: json['featuredImage'] as String?,
      slug: json['slug'] as String?,
      version: json['version'] as String?,
      settings: json['settings'] != null
          ? SettingMyLearningDetailModel.fromJson(json['settings'])
          : null,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
      teachers: (json['teachers'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  TeacherModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      members: (json['members'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  MemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      roadmaps: (json['roadmaps'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  RoadmapModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class TeacherModel {
  int? id;
  int? classroomId;
  String? memberId;
  String? type;
  String? status;
  String? note;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? email;
  String? displayName;
  String? lastName;
  String? firstName;
  String? dateOfBirth;
  String? gender;
  String? avatar;
  String? phoneNumber;
  String? address;
  String? city;
  String? country;

  TeacherModel({
    this.id,
    this.classroomId,
    this.memberId,
    this.type,
    this.status,
    this.note,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.email,
    this.displayName,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.avatar,
    this.phoneNumber,
    this.address,
    this.city,
    this.country,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int?,
      memberId: json['memberId'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
    );
  }

  String? handlerShowNameTeacher() {
    return displayName ?? userName;
  }
}

class MemberModel {
  int? id;
  int? classroomId;
  String? memberId;
  String? type;
  String? status;
  String? note;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  String? email;
  String? displayName;
  String? lastName;
  String? firstName;
  String? dateOfBirth;
  String? gender;
  String? avatar;
  String? phoneNumber;
  String? address;
  String? city;
  String? country;

  MemberModel({
    this.id,
    this.classroomId,
    this.memberId,
    this.type,
    this.status,
    this.note,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.email,
    this.displayName,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.avatar,
    this.phoneNumber,
    this.address,
    this.city,
    this.country,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int?,
      memberId: json['memberId'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
    );
  }

  String? handlerShowNameTeacher() {
    return displayName ?? userName;
  }
}

class RoadmapModel {
  int? id;
  int? classroomId;
  int? roadmapId;
  String? type;
  String? status;
  String? note;
  String? items;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  int? total;

  RoadmapModel({
    this.id,
    this.classroomId,
    this.roadmapId,
    this.type,
    this.status,
    this.note,
    this.items,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.total,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int?,
      roadmapId: json['roadmapId'] as int?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
      items: json['items'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.tryParse(json['deletedAt'] as String),
      total: json['total'] as int?,
    );
  }
}

class SettingMyLearningDetailModel {
  String? saleOff;
  DateTime? openDate;
  DateTime? closeDate;

  SettingMyLearningDetailModel({this.saleOff, this.openDate, this.closeDate});

  factory SettingMyLearningDetailModel.fromJson(Map<String, dynamic> json) {
    return SettingMyLearningDetailModel(
      saleOff: json['saleOff'] as String?,
      openDate: json['openDate'] == null
          ? null
          : DateTime.tryParse(json['openDate'] as String),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.tryParse(json['closeDate'] as String),
    );
  }

  int getTimeDifference() {
    if (closeDate != null) {
      DateTime startDate = DateTime.now();
      int time = timeRemaining(startDate, closeDate!);

      return time;
    }

    return 0;
  }

  int timeRemaining(DateTime startDate, DateTime endDate) {
    startDate = DateTime(startDate.year, startDate.month, startDate.day);
    endDate = DateTime(endDate.year, endDate.month, endDate.day);

    return (endDate.difference(startDate).inHours / 24).round();
  }
}

class MemberRankResponse {
  bool? status;
  String? message;
  List<MemberRankModel> data;
  int? total;

  MemberRankResponse({
    this.status,
    this.message,
    this.data = const [],
    this.total,
  });

  factory MemberRankResponse.fromJson(Map<String, dynamic> json) {
    return MemberRankResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  MemberRankModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'],
    );
  }
}

class MemberRankModel {
  int? id;
  String? memberId;
  int? classroomId;
  String? avatar;
  String? displayName;
  String? userName;
  String? lastName;
  String? firstName;
  String? email;
  String? type;
  String? status;
  String? progress;
  String? rank;
  String? score;
  String? scoreAverage;
  Uint8List? avatarImage;
  bool isSvg;

  MemberRankModel({
    this.id,
    this.memberId,
    this.classroomId,
    this.avatar,
    this.displayName,
    this.userName,
    this.lastName,
    this.firstName,
    this.email,
    this.type,
    this.status,
    this.progress,
    this.rank,
    this.score,
    this.scoreAverage,
    this.avatarImage,
    this.isSvg = false,
  });

  factory MemberRankModel.fromJson(Map<String, dynamic> json) {
    return MemberRankModel(
      id: json['id'] as int?,
      memberId: json['memberId'] as String?,
      classroomId: json['classroomId'] as int?,
      avatar: json['avatar'] as String?,
      displayName: json['displayName'] as String?,
      userName: json['userName'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String?,
      status: json['status'],
      progress: json['progress'] as String?,
      rank: json['rank'] as String?,
      score: json['score'] as String?,
      scoreAverage: json['scoreAverage'] as String?,
    );
  }
}

class QuizMyLearningResponse {
  bool? status;
  String? message;
  List<QuizModel> data;
  int? total;

  QuizMyLearningResponse({
    this.status,
    this.message,
    this.data = const [],
    this.total,
  });

  factory QuizMyLearningResponse.fromJson(Map<String, dynamic> json) {
    return QuizMyLearningResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (dynamic e) => QuizModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      total: json['total'],
    );
  }
}

class QuizModel {
  int? id;
  int classroomId;
  int roadmapId;
  int contestId;
  String? contestName;
  String? status;
  String? type;
  String? note;
  DateTime? openDate;
  DateTime? closeDate;
  int? duration;
  int? total;
  int? remaining;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<DetailQuizModel> detail;

  QuizModel({
    this.id,
    this.classroomId = 0,
    this.roadmapId = 0,
    this.contestId = 0,
    this.contestName,
    this.status,
    this.type,
    this.note,
    this.openDate,
    this.closeDate,
    this.duration,
    this.total,
    this.remaining,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.detail = const [],
  });

  int get calQuizCode => contestId + classroomId + roadmapId + 1000000;

  bool checkQuiz() {
    if (status != null && status == Constants.lockQuiz) {
      return false;
    }

    if (openDate == null && closeDate == null) {
      return false;
    }

    if (openDate != null &&
        openDate!.isBefore(DateTime.now()) &&
        closeDate == null) {
      return true;
    }

    if (closeDate != null &&
        closeDate!.isAfter(DateTime.now()) &&
        openDate == null) {
      return true;
    }

    if (openDate != null &&
        openDate!.isBefore(DateTime.now()) &&
        closeDate != null &&
        closeDate!.isAfter(DateTime.now())) {
      return true;
    }

    return false;
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int,
      roadmapId: json['roadmapId'] as int,
      contestId: json['contestId'] as int,
      contestName: json['contestName'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
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
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.tryParse(json['deletedAt'] as String),
      detail: (json['detail'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  DetailQuizModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class DetailQuizModel {
  int? id;
  String? memberId;
  String? contestName;
  int? contestId;
  int? classroomId;
  int? roadmapId;
  DateTime? startDate;
  DateTime? endDate;
  bool? submitted;
  String? dateExpires;
  String? status;
  String? type;
  String? createdAt;
  ScoreResultModel? scoreResult;

  DetailQuizModel({
    this.id,
    this.memberId,
    this.contestName,
    this.contestId,
    this.classroomId,
    this.roadmapId,
    this.startDate,
    this.endDate,
    this.submitted,
    this.dateExpires,
    this.status,
    this.type,
    this.createdAt,
    this.scoreResult,
  });

  factory DetailQuizModel.fromJson(Map<String, dynamic> json) {
    return DetailQuizModel(
      id: json['id'] as int?,
      memberId: json['memberId'] as String?,
      contestName: json['contestName'] as String?,
      contestId: json['contestId'] as int?,
      classroomId: json['classroomId'] as int?,
      roadmapId: json['roadmapId'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.tryParse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.tryParse(json['endDate'] as String),
      submitted: json['submitted'] as bool?,
      dateExpires: json['dateExpires'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      scoreResult: json['scoreResult'] != null
          ? ScoreResultModel.fromJson(json['scoreResult'])
          : null,
    );
  }
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
      scorePass: json['scorePass'] != null ? json['scorePass'] as int : 0,
      scoreTotal: json['scoreTotal'] != null ? json['scoreTotal'] as int : 0,
      scorePercent:
          json['scorePercent'] != null ? json['scorePercent'] as num : 0,
    );
  }
}

class RoadmapResponse {
  bool? status;
  String? message;
  List<DataRoadmap> data;
  int? total;
  String? extend;

  RoadmapResponse({
    this.status,
    this.message,
    this.data = const [],
    this.total,
    this.extend,
  });

  factory RoadmapResponse.fromJson(Map<String, dynamic> json) {
    return RoadmapResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  DataRoadmap.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as int?,
      extend: json['extend'] as String?,
    );
  }
}

class TypeDataResponse {
  bool? status;
  String? message;
  List<TypeDataModel> data;
  int? total;

  TypeDataResponse({
    this.status,
    this.message,
    this.data = const [],
    this.total,
  });

  factory TypeDataResponse.fromJson(Map<String, dynamic> json) {
    return TypeDataResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    TypeDataModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      total: json['total'] as int?,
    );
  }
}

class TypeDataModel {
  int? id;
  int? fkey;
  String? name;
  String? slug;
  String? type;
  String? status;
  String? sequent;

  TypeDataModel({
    this.id,
    this.fkey,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.sequent,
  });

  factory TypeDataModel.fromJson(Map<String, dynamic> json) {
    return TypeDataModel(
      id: json['id'] as int?,
      fkey: json['fkey'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      sequent: json['sequent'] as String?,
    );
  }
}

class PlaySlideShowDataResponse {
  bool? status;
  String? message;
  PlaySlideShowModel? data;
  int? total;

  PlaySlideShowDataResponse({
    this.status,
    this.message,
    this.data,
    this.total,
  });

  factory PlaySlideShowDataResponse.fromJson(Map<String, dynamic> json) {
    return PlaySlideShowDataResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? PlaySlideShowModel.fromJson(json['data'])
          : null,
      total: json['total'] as int?,
    );
  }
}

class PlaySlideShowModel {
  int? id;
  String? uuid;
  String? seriesName;
  String? name;
  String? description;
  List<ItemSlideShowModel> items;
  int? total;
  int? used;
  String? status;
  String? type;
  String? licensed;
  String? featuredImage;
  String? slug;
  String? version;
  SettingModel? setting;
  DateTime? createdBy;
  DateTime? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  PlaySlideShowModel({
    this.id,
    this.uuid,
    this.seriesName,
    this.name,
    this.description,
    this.items = const [],
    this.total,
    this.used,
    this.status,
    this.type,
    this.licensed,
    this.featuredImage,
    this.slug,
    this.version,
    this.setting,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PlaySlideShowModel.fromJson(Map<String, dynamic> json) {
    return PlaySlideShowModel(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    ItemSlideShowModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      total: json['total'] as int?,
      used: json['used'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      licensed: json['licensed'] as String?,
      featuredImage: json['featuredImage'] as String?,
      slug: json['slug'] as String?,
      version: json['version'] as String?,
      setting: json['settings'] != null
          ? SettingModel.fromJson(json['settings'])
          : null,
      createdBy: json['createdBy'] == null
          ? null
          : DateTime.parse(json['createdBy'] as String),
      updatedBy: json['updatedBy'] == null
          ? null
          : DateTime.parse(json['updatedBy'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );
  }
}

class ItemSlideShowModel {
  String? id;
  String? image;
  String? title;
  String? description;
  Uint8List? convertImage;
  bool isSvg;
  bool isLoadingImage;

  ItemSlideShowModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.convertImage,
    this.isSvg = false,
    this.isLoadingImage = true,
  });

  factory ItemSlideShowModel.fromJson(Map<String, dynamic> json) {
    return ItemSlideShowModel(
      id: json['id'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isLoadingImage: true,
    );
  }
}

class QuizArgumentModel {
  final int idQuiz;
  final int classroomId;
  final int roadmapId;
  final int contestId;
  final int? resultId;
  final int? timeQuiz;

  QuizArgumentModel({
    required this.idQuiz,
    required this.classroomId,
    required this.contestId,
    required this.roadmapId,
    this.resultId,
    this.timeQuiz,
  });
}
