import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class DataProfileModel {
  bool? status;
  String? message;
  ProfileModel? data;
  int? total;

  DataProfileModel({this.status, this.message, this.data, this.total});

  factory DataProfileModel.fromJson(Map<String, dynamic> json) {
    return DataProfileModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProfileModel.fromJson(json['data'] as Map<String, dynamic>),
      total: json['total'] as int?,
    );
  }
}

class GenderModel {
  final String genderVi;
  final String genderEn;
  final String genderJp;
  final String codeGender;

  GenderModel({
    required this.genderVi,
    required this.codeGender,
    required this.genderEn,
    required this.genderJp,
  });
}

// ignore: must_be_immutable
class ProfileModel extends Equatable {
  String? refreshToken;
  String? refreshTokenExpiryTime;
  String? avatar;
  String? displayName;
  String? lastName;
  String? firstName;
  DateTime? dateOfBirth;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? passport;
  String? identityCode;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool phoneNumberConfirmed;

  // bool twoFactorEnabled;
  String? lockoutEnd;

  // bool lockoutEnabled;
  // int accessFailedCount;
  Uint8List? avatarFile;
  bool isSvg;
  bool isLoadingImage;

  ProfileModel({
    this.refreshToken,
    this.refreshTokenExpiryTime,
    this.avatar,
    this.displayName,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.city,
    this.country,
    this.passport,
    this.identityCode,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed = true,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed = true,
    // this.twoFactorEnabled = true,
    this.lockoutEnd,
    // this.lockoutEnabled = true,
    // this.accessFailedCount = 0,
    this.avatarFile,
    this.isSvg = false,
    this.isLoadingImage = true,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      refreshToken: json['refreshToken'] as String?,
      refreshTokenExpiryTime: json['refreshTokenExpiryTime'] as String?,
      avatar: json['avatar'] as String?,
      displayName: json['displayName'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      passport: json['passport'] as String?,
      identityCode: json['identityCode'] as String?,
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      normalizedUserName: json['normalizedUserName'] as String?,
      email: json['email'] as String?,
      normalizedEmail: json['normalizedEmail'] as String?,
      emailConfirmed: json['emailConfirmed'] as bool,
      passwordHash: json['passwordHash'] as String?,
      securityStamp: json['securityStamp'] as String?,
      concurrencyStamp: json['concurrencyStamp'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool,
      // twoFactorEnabled: json['twoFactorEnabled'] as bool,
      lockoutEnd: json['lockoutEnd'] as String?,
      // lockoutEnabled: json['lockoutEnabled'] as bool,
      // accessFailedCount: json['accessFailedCount'] as int,
      avatarFile: json['avatarNew'] as Uint8List?,
      isSvg: json['isSvg'] != null ? json['isSvg'] as bool : false,
      isLoadingImage: true,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'refreshToken': refreshToken,
        'refreshTokenExpiryTime': refreshTokenExpiryTime,
        'avatar': avatar,
        'displayName': displayName,
        'lastName': lastName,
        'firstName': firstName,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'gender': gender,
        'address': address,
        'city': city,
        'country': country,
        'passport': passport,
        'identityCode': identityCode,
        'id': id,
        'userName': userName,
        'normalizedUserName': normalizedUserName,
        'email': email,
        'normalizedEmail': normalizedEmail,
        'emailConfirmed': emailConfirmed,
        'passwordHash': passwordHash,
        'securityStamp': securityStamp,
        'phoneNumber': phoneNumber,
        'concurrencyStamp': concurrencyStamp,
        'phoneNumberConfirmed': phoneNumberConfirmed,
        // 'twoFactorEnabled': twoFactorEnabled,
        'lockoutEnd': lockoutEnd,
        // 'lockoutEnabled': lockoutEnabled,
        // 'accessFailedCount': accessFailedCount,
        'avatarNew': avatarFile,
        'isSvg': isSvg,
      };

  ProfileModel? get clone => ProfileModel.fromJson(toJson());

  @override
  List<Object?> get props => [
        avatarFile,
        isSvg,
        displayName,
        lastName,
        firstName,
        dateOfBirth,
        gender,
        phoneNumber,
        address,
        city,
        country,
      ];
}

class DataToUpdate {
  String? refreshToken;
  String? refreshTokenExpiryTime;
  File? avatar;
  String? displayName;
  String? lastName;
  String? firstName;
  DateTime? dateOfBirth;
  String? gender;
  String? address;
  String? city;
  String? country;
  String? passport;
  String? identityCode;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String? lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  DataToUpdate({
    this.refreshToken,
    this.refreshTokenExpiryTime,
    this.avatar,
    this.displayName,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.city,
    this.country,
    this.passport,
    this.identityCode,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed = true,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed = true,
    this.twoFactorEnabled = true,
    this.lockoutEnd,
    this.lockoutEnabled = true,
    this.accessFailedCount = 0,
  });
}

class ImageModel {
  File? avatar;

  ImageModel({this.avatar});

  factory ImageModel.formJson(Map<String, dynamic> json) {
    return ImageModel(avatar: json['avatar']);
  }
}

class CountryModel {
  final int? id;
  final String? alpha2;
  final String? alpha3;
  final String? ar;
  final String? bg;
  final String? cs;
  final String? da;
  final String? de;
  final String? el;
  final String? en;
  final String? eo;
  final String? es;
  final String? et;
  final String? eu;
  final String? fi;
  final String? fr;
  final String? hu;
  final String? hy;
  final String? it;
  final String? ja;
  final String? ko;
  final String? lt;
  final String? nl;
  final String? no;
  final String? pl;
  final String? pt;
  final String? ro;
  final String? ru;
  final String? sk;
  final String? sv;
  final String? th;
  final String? uk;
  final String? zh;
  final String? zhTw;

  CountryModel({
    this.id,
    this.alpha2,
    this.alpha3,
    this.ar,
    this.bg,
    this.cs,
    this.da,
    this.de,
    this.el,
    this.en,
    this.eo,
    this.es,
    this.et,
    this.eu,
    this.fi,
    this.fr,
    this.hu,
    this.hy,
    this.it,
    this.ja,
    this.ko,
    this.lt,
    this.nl,
    this.no,
    this.pl,
    this.pt,
    this.ro,
    this.ru,
    this.sk,
    this.sv,
    this.th,
    this.uk,
    this.zh,
    this.zhTw,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as int?,
      alpha2: json['alpha2'] as String?,
      alpha3: json['alpha3'] as String?,
      ar: json['ar'] as String?,
      bg: json['bg'] as String?,
      cs: json['cs'] as String?,
      da: json['da'] as String?,
      de: json['de'] as String?,
      el: json['el'] as String?,
      en: json['en'] as String?,
      eo: json['eo'] as String?,
      es: json['es'] as String?,
      et: json['et'] as String?,
      eu: json['eu'] as String?,
      fi: json['fi'] as String?,
      fr: json['fr'] as String?,
      hu: json['hu'] as String?,
      hy: json['hy'] as String?,
      it: json['it'] as String?,
      ko: json['ko'] as String?,
      lt: json['lt'] as String?,
      nl: json['nl'] as String?,
      no: json['no'] as String?,
      pl: json['pl'] as String?,
      pt: json['pt'] as String?,
      ro: json['ro'] as String?,
      ru: json['ru'] as String?,
      sk: json['sk'] as String?,
      sv: json['sv'] as String?,
      th: json['th'] as String?,
      uk: json['uk'] as String?,
      zh: json['zh'] as String?,
      ja: json['ja'] as String?,
      zhTw: json['zhTw'] as String?,
    );
  }
}
