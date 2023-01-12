import 'dart:typed_data';

import 'package:intl/intl.dart';

class DataResponseFlashCardModel {
  bool? status;
  String? message;
  FlashCardModel? data;
  int? total;

  DataResponseFlashCardModel({
    this.status,
    this.message,
    this.data,
    this.total,
  });

  factory DataResponseFlashCardModel.fromJson(Map<String, dynamic> json) {
    return DataResponseFlashCardModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? FlashCardModel.fromJson(json['data']) : null,
      total: json['total'] as int,
    );
  }
}

class FlashCardModel {
  int? id;
  String? uuid;
  String? seriesName;
  String? name;
  String? description;
  List<TermModel> items = [];
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

  FlashCardModel({
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
  });

  factory FlashCardModel.fromJson(Map<String, dynamic> json) {
    return FlashCardModel(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      seriesName: json['seriesName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (dynamic e) => TermModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
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
    );
  }

  String? get dateFormat {
    if (createdAt != null) {
      return DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(createdAt!);
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

class TermModel {
  int? id;
  String? term;
  String? definition;
  String? audio;
  bool isRemember;

  // Uint8List? image;
  String? image;

  TermModel({
    this.id,
    this.term,
    this.definition,
    this.audio,
    this.image,
    this.isRemember = false,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) {
    return TermModel(
      id: json['id'] as int?,
      term: json['term'] as String?,
      definition: json['definition'] as String?,
      audio: json['audio'] as String?,
      image: json['image'] as String?,
      isRemember: false,
    );
  }
}
