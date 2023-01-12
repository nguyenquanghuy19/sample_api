import 'dart:io';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/core/data/share_preference/spref_locale_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class UpdateProfileViewModel extends BaseViewModel {
  ProfileModel? _currentProfile;
  ProfileModel? editingProfile;
  String? valueGender;

  bool get isEdit =>
      _currentProfile != null && editingProfile != _currentProfile;

  Uint8List? get avatar => editingProfile?.avatarFile;
  final AccountRepository _accountRepository = AccountRepository();

  bool editedAvatar = false;

  XFile? image;

  File? _imageRaw;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  CountryModel? country;

  final _picker = ImagePicker();

  Future<bool> onPressUpdate() async {
    try {
      final dataNew = DataToUpdate(
        avatar: _imageRaw,
        displayName: editingProfile?.displayName,
        lastName: editingProfile?.lastName,
        firstName: editingProfile?.firstName,
        email: editingProfile?.email,
        phoneNumber: editingProfile?.phoneNumber,
        gender: editingProfile?.gender,
        address: editingProfile?.address,
        country: editingProfile?.country,
        dateOfBirth: editingProfile?.dateOfBirth,
        city: editingProfile?.city,
      );
      if (isEdit) {
        final res = await _accountRepository.updateProfile(dataNew);
        if (res != null) {
          hideCurrentSnackBar();
          showToastSuccess(res.message);

          return true;
        } else if (res != null && res.status != null && !res.status!) {
          hideCurrentSnackBar();
          showToastError(res.message);

          return false;
        }
      }

      return false;
    } on ApiException catch (e) {
      hideCurrentSnackBar();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );

      return false;
    } on Exception {
      hideCurrentSnackBar();
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );

      return false;
    }
  }

  void initData(ProfileModel dataDefault) {
    _currentProfile = dataDefault.clone;
    editingProfile = dataDefault.clone;
    nameController.text = editingProfile?.displayName ?? '';
    lastNameController.text = editingProfile?.lastName ?? '';
    firstNameController.text = editingProfile?.firstName ?? '';
    emailController.text = editingProfile?.email ?? '';
    phoneController.text = editingProfile?.phoneNumber ?? '';
    valueGender = editingProfile?.gender ?? '';
    addressController.text = editingProfile?.address ?? '';
    cityController.text = editingProfile?.city ?? '';
    if (editingProfile?.country != null) {
      countryController.text = getNameCountry(editingProfile!.country!) ?? '';
    }
    if (editingProfile != null && editingProfile?.dateOfBirth != null) {
      dateOfBirthController.text =
          DateFormat('dd/MM/yyyy').format(editingProfile!.dateOfBirth!);
    }
    if (avatar != null && !editingProfile!.isSvg) {
      _convertFileFromBase64();
    }
    valueGender = editingProfile?.gender;
  }

  Future<void> getImage(ImageSource imageSource) async {
    image = await _picker.pickImage(
      source: imageSource,
      imageQuality: 25,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null) {
      editedAvatar = true;
      _imageRaw = File(image!.path);
      List<int> imageBytes = _imageRaw!.readAsBytesSync();
      editingProfile?.avatarFile = imageBytes as Uint8List;
      editingProfile?.isSvg = false;
      notifyListeners();
    }
  }

  void deleteAvatar() async {
    editingProfile!.avatarFile = null;
    editingProfile!.isSvg = false;
    _imageRaw = null;
    updateUI();
  }

  void onChangeValueGender(String? value) {
    valueGender = value;
    editingProfile?.gender = value;
    updateUI();
  }

  void onChangePhoneNumber(String? phone) {
    editingProfile?.phoneNumber = phone;
    notifyListeners();
  }

  Future<void> _convertFileFromBase64() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    _imageRaw = await file.writeAsBytes(avatar!);
  }

  void onChangeCountry(CountryModel countryModel) {
    country = countryModel;
    editingProfile?.country = countryModel.alpha2;
    updateUI();
  }

  void onChangeDisPlayName() {
    editingProfile?.displayName =
        nameController.text.isNotEmpty ? nameController.text : null;
    updateUI();
  }

  void onChangeLastName() {
    editingProfile?.lastName =
        lastNameController.text.isNotEmpty ? lastNameController.text : null;
    updateUI();
  }

  void onChangeFirstName() {
    editingProfile?.firstName =
        firstNameController.text.isNotEmpty ? firstNameController.text : null;
    updateUI();
  }

  void onChangeAddress() {
    editingProfile?.address =
        addressController.text.isNotEmpty ? addressController.text : null;
    updateUI();
  }

  void onChangeCity() {
    editingProfile?.city =
        cityController.text.isNotEmpty ? cityController.text : null;
    updateUI();
  }

  void onChangeDateOfBirth(DateTime? dateTime) {
    editingProfile?.dateOfBirth = dateTime;
    updateUI();
  }

  String? getNameCountry(String country) {
    for (int i = 0; i < LookUpData.countries.length; i++) {
      if (SPrefLocaleModel().getLocale() == Constants.ja &&
          country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].ja;
      } else if (SPrefLocaleModel().getLocale() == Constants.vi &&
          country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].en;
      } else if ((SPrefLocaleModel().getLocale() == Constants.en &&
              country == LookUpData.countries[i].alpha2) ||
          (SPrefLocaleModel().getLocale() == Constants.en &&
              country == LookUpData.countries[i].alpha3)) {
        return LookUpData.countries[i].en;
      } else if (country == LookUpData.countries[i].alpha2) {
        return LookUpData.countries[i].en;
      }
    }

    return null;
  }

  String getGenderName(String gender) {
    for (int i = 0; i < LookUpData.genders.length; i++) {
      if (SPrefLocaleModel().getLocale() == Constants.ja &&
          gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderJp;
      } else if (SPrefLocaleModel().getLocale() == Constants.vi &&
          gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderVi;
      } else if ((SPrefLocaleModel().getLocale() == Constants.en &&
              gender == LookUpData.genders[i].codeGender) ||
          (SPrefLocaleModel().getLocale() == Constants.en &&
              gender == LookUpData.genders[i].codeGender)) {
        return LookUpData.genders[i].genderEn;
      } else if (gender == LookUpData.genders[i].codeGender) {
        return LookUpData.genders[i].genderEn;
      }
    }

    return "";
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
