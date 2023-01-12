import 'dart:convert';
import 'dart:typed_data';
import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:elearning/core/utils/time_ago_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataResponseCourseModel {
  bool? status;
  String? message;
  List<CourseModel> data;
  int? total;

  DataResponseCourseModel({
    this.status,
    this.message,
    required this.data,
    this.total,
  });

  factory DataResponseCourseModel.fromJson(Map<String, dynamic> json) {
    return DataResponseCourseModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  CourseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as int,
    );
  }
}

class CourseModel {
  int? id;
  String? uuid;
  String? seriesName;
  String? name;
  String? description;
  String? items;
  int? total;
  int? used;
  String? status;
  String? type;
  String? licensed;
  String? featuredImage;
  String? metaTitle;
  String? canonicalLink;
  String? slug;
  String? metaKeywords;
  String? metaDescription;
  String? version;
  SettingModel? setting;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? tableName;

  Uint8List? image;
  bool isSvg;
  bool isLoadingImage;

  CourseModel({
    this.id,
    this.uuid,
    this.seriesName,
    this.name,
    this.description,
    this.items,
    this.total,
    this.used,
    this.status,
    this.type,
    this.licensed,
    this.featuredImage,
    this.metaTitle,
    this.canonicalLink,
    this.slug,
    this.metaKeywords,
    this.metaDescription,
    this.version,
    this.setting,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.tableName,
    this.image,
    this.isSvg = false,
    this.isLoadingImage = true,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      items: json['items'] as String?,
      total: json['total'] as int?,
      used: json['used'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      licensed: json['licensed'] as String?,
      featuredImage: json['featuredImage'] as String?,
      metaTitle: json['metaTitle'] as String?,
      canonicalLink: json['canonicalLink'] as String?,
      slug: json['slug'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      metaDescription: json['metaDescription'] as String?,
      version: json['version'] as String?,
      setting: json['settings'] != null
          ? SettingModel.fromJson(json['settings'])
          : null,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      tableName: json['tableName'] as String?,
      isLoadingImage: true,
    );
  }

  String? get dateFormat {
    if (createdAt != null) {
      return DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(createdAt!);
    }

    return null;
  }
}

class GuestCourseModel {
  bool? status;
  String? message;
  DataCourseModel? data;
  int? total;
  ExtendModel? extend;

  GuestCourseModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.extend,
  });

  factory GuestCourseModel.fromJson(Map<String, dynamic> json) {
    return GuestCourseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data:
          json['data'] != null ? DataCourseModel.fromJson(json['data']) : null,
      total: json['total'] as int?,
      extend:
          json['extend'] != null ? ExtendModel.fromJson(json['extend']) : null,
    );
  }
}

class DataCourseModel {
  String? tableName;
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
  String? metaTitle;
  String? canonicalLink;
  String? slug;
  String? metaKeywords;
  String? metaDescription;
  String? version;
  SettingModel? settings;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  DataCourseModel({
    this.tableName,
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
    this.metaTitle,
    this.canonicalLink,
    this.slug,
    this.metaKeywords,
    this.metaDescription,
    this.version,
    this.settings,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataCourseModel.fromJson(Map<String, dynamic> json) {
    return DataCourseModel(
      tableName: json['tableName'] as String?,
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'],
      description: json['description'] as String?,
      total: json['total'] as int?,
      used: json['used'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      licensed: json['licensed'] as String?,
      featuredImage: json['featuredImage'] as String?,
      metaTitle: json['metaTitle'] as String?,
      canonicalLink: json['canonicalLink'] as String?,
      slug: json['slug'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      metaDescription: json['metaDescription'] as String?,
      version: json['version'] as String?,
      settings: json['settings'] != null
          ? SettingModel.fromJson(json['settings'])
          : null,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }
}

class SettingModel {
  String? saleOff;
  String? openDate;
  String? closeDate;

  SettingModel({this.saleOff, this.openDate, this.closeDate});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      openDate: json['openDate'] as String?,
      closeDate: json['closeDate'] as String?,
      saleOff: json['saleOff'] as String?,
    );
  }
}

class ExtendModel {
  RoadmapModel? roadmaps;
  TeacherModel? teachers;

  ExtendModel({this.roadmaps, this.teachers});

  factory ExtendModel.fromJson(Map<String, dynamic> json) {
    return ExtendModel(
      teachers: json['teachers'] != null
          ? TeacherModel.fromJson(json['teachers'])
          : null,
      roadmaps: json['roadmaps'] != null
          ? RoadmapModel.fromJson(json['roadmaps'])
          : null,
    );
  }
}

class RoadmapModel {
  List<DataRoadmap>? data;

  RoadmapModel({this.data});

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  DataRoadmap.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class CommentModel {
  bool? status;
  String? message;
  List<DataCommentModel> data;
  int total;
  ExtendModel? extend;

  CommentModel({
    this.status,
    this.message,
    this.data = const [],
    this.total = 0,
    this.extend,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  DataCommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as int,
      extend: json['extend'] != null
          ? ExtendModel.fromJson(
              json['extend'],
            )
          : null,
    );
  }
}

class DataCommentModel {
  int? id;
  String? content;
  String? lmsId;
  String? type;
  String? status;
  DateTime? createdAt;
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
  Uint8List? image;
  bool isSvg;

  DataCommentModel({
    this.id,
    this.content,
    this.lmsId,
    this.type,
    this.status,
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
    this.image,
    this.isSvg = false,
  });

  String? dateFormat(BuildContext context) {
    if (createdAt != null) {
      return TimeAgoUtils.dateFormat(createdAt!, context);
    }

    return null;
  }

  String? timeAgo(BuildContext context) {
    if (createdAt != null) {
      return TimeAgoUtils.timeAgo(context: context, time: createdAt!);
    }

    return null;
  }

  Uint8List? convertAvatar() {
    try {
      return base64Decode(avatar!);
    } catch (e) {
      return null;
    }
  }

  factory DataCommentModel.fromJson(Map<String, dynamic> json) {
    return DataCommentModel(
      id: json['id'] as int?,
      content: json['content'] as String?,
      lmsId: json['lmsId'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
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
}

class TeacherModel {
  List<DataTeacherModel>? data;

  TeacherModel({this.data});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    DataTeacherModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}

class DataTeacherModel {
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

  DataTeacherModel({
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

  factory DataTeacherModel.fromJson(Map<String, dynamic> json) {
    return DataTeacherModel(
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
}

class PostCommentModel {
  bool? status;
  String? message;
  DataPostCommentModel? data;
  int total;
  ExtendModel? extend;

  PostCommentModel({
    this.status,
    this.message,
    this.data,
    this.total = 0,
    this.extend,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? DataPostCommentModel.fromJson(json['data'])
          : null,
      total: json['total'],
      extend:
          json['extend'] != null ? ExtendModel.fromJson(json['extend']) : null,
    );
  }
}

class DataPostCommentModel {
  int? id;
  String? content;
  int? lmsId;
  String? type;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  DataPostCommentModel({
    this.id,
    this.content,
    this.lmsId,
    this.type,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory DataPostCommentModel.fromJson(Map<String, dynamic> json) {
    return DataPostCommentModel(
      id: json['id'] as int?,
      content: json['content'] as String?,
      lmsId: json['lmsId'] as int?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class CommentParam {
  int? id;
  String? content;
  int? lmsId;
  String? status;

  CommentParam({this.id, this.status, this.content, this.lmsId});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'content': content,
        'lmsId': lmsId,
        'status': status,
      };
}

class RegisterModel {
  bool? status;
  String? message;
  DataRegisterModel? data;
  int? total;

  RegisterModel({this.status, this.message, this.data, this.total});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? DataRegisterModel.fromJson(json['data'])
          : null,
      total: json['total'],
    );
  }
}

class DataRegisterModel {
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

  DataRegisterModel({
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

  factory DataRegisterModel.fromJson(Map<String, dynamic> json) {
    return DataRegisterModel(
      id: json['id'],
      classroomId: json['classroomId'],
      memberId: json['memberId'],
      type: json['type'],
      status: json['status'],
      note: json['note'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userName: json['userName'],
      email: json['email'],
      displayName: json['displayName'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      avatar: json['avatar'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }
}
