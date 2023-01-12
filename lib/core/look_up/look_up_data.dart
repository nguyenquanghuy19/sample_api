import 'dart:typed_data';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/profile_model.dart';

class LookUpData {
  static List<CountryModel> countries = [];
  static List<GenderModel> genders = [
    GenderModel(
      genderVi: "Nam",
      codeGender: Constants.male,
      genderEn: "Man",
      genderJp: "Man",
    ),
    GenderModel(
      genderVi: "Nữ",
      codeGender: Constants.female,
      genderEn: "Woman",
      genderJp: "Woman",
    ),
    GenderModel(
      genderVi: "Khác",
      codeGender: Constants.none,
      genderEn: "Other",
      genderJp: "Other",
    ),
  ];

  static Uint8List? avatar;
  static String? displayName;
  static bool? avatarType;
}
