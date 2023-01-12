import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/core/data/share_preference/spref_locale_model.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/views/profile/update_profile_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel {
  DataProfileModel? profileModel;

  ProfileModel? get profile => profileModel?.data;
  final AccountRepository _accountRepository = AccountRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    await getProfile();
  }

  Future<void> getProfile({bool isFirstLoad = true}) async {
    try {
      if (isFirstLoad) {
        _isLoading = true;
      }
      final res = await _accountRepository.getProfile();
      profileModel = res;
      if (profile != null) {
        getAvatar(profile!.avatar);
      }
      _isLoading = false;
      updateUI();
    } on Exception {
      _isLoading = false;
    }
    updateUI();
  }

  Future<void> getAvatar(String? fileName) async {
    try {
      final res = await _accountRepository.getAvatar(fileName);
      profileModel!.data!.avatarFile = res.data;
      profileModel!.data!.isSvg =
          res.headers["content-type"]?[0].contains("svg") ?? false;
      SPrefUserModel().setDisplayName(profileModel!.data!.displayName!);
      SPrefUserModel().setAvatar(res.data);
      SPrefUserModel().setAvatarType(profileModel!.data!.isSvg);
      LookUpData.displayName = profileModel!.data!.displayName;
      LookUpData.avatarType = profileModel!.data!.isSvg;
      LookUpData.avatar = res.data;
      updateUI();
    } on Exception {
      LogUtils.i("Error get avatar");
    }
  }

  void onSubmitButtonUpdate(BuildContext context) {
    if (profile != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => UpdateProfileView(
            data: profile!,
            callBack: () {
              getProfile(isFirstLoad: false);
            },
            countries: LookUpData.countries,
          ),
        ),
      );
    }
  }

  String? getNameCountry() {
    for (int i = 0; i < LookUpData.countries.length; i++) {
      if (SPrefLocaleModel().getLocale() == Constants.ja &&
          profile!.country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].ja;
      } else if (SPrefLocaleModel().getLocale() == Constants.vi &&
          profile!.country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].en;
      } else if ((SPrefLocaleModel().getLocale() == Constants.en &&
              profile!.country == LookUpData.countries[i].alpha2) ||
          (SPrefLocaleModel().getLocale() == Constants.en &&
              profile!.country == LookUpData.countries[i].alpha3)) {
        return LookUpData.countries[i].en;
      } else if (profile!.country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].en;
      }
    }

    return null;
  }

  String? getGenderName() {
    for (int i = 0; i < LookUpData.genders.length; i++) {
      if (SPrefLocaleModel().getLocale() == Constants.ja &&
          profile?.gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderJp;
      } else if (SPrefLocaleModel().getLocale() == Constants.vi &&
          profile?.gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderVi;
      } else if ((SPrefLocaleModel().getLocale() == Constants.en &&
              profile?.gender == LookUpData.genders[i].codeGender) ||
          (SPrefLocaleModel().getLocale() == Constants.en &&
              profile?.gender == LookUpData.genders[i].genderEn)) {
        return LookUpData.genders[i].genderEn;
      } else if (profile?.gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderEn;
      }
    }

    return null;
  }
}
