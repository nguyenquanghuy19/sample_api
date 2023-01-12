import 'dart:convert';
import 'dart:io';

import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileViewModel extends BaseViewModel {
  ProfileModel? currentDataModel;
  ProfileModel? editDataModel;

  bool get isEdit =>
      currentDataModel != null && editDataModel != currentDataModel;

  Uint8List? avatar;

  XFile? image;
  File? imageRaw;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _picker = ImagePicker();

  void initData(ProfileModel dataDefault) {
    currentDataModel = dataDefault.clone;
    editDataModel = dataDefault.clone;
    nameController.text = editDataModel?.displayName ?? '';
    lastNameController.text = editDataModel?.lastName ?? '';
    firstNameController.text = editDataModel?.firstName ?? '';
    emailController.text = editDataModel?.email ?? '';
    phoneController.text = editDataModel?.phoneNumber ?? '';
    genderController.text = editDataModel?.gender ?? '';
    addressController.text = editDataModel?.address ?? '';
    cityController.text = editDataModel?.city ?? '';
    countryController.text = editDataModel?.country ?? '';
  }

  String? validateFullName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.displayNameRequired;
    }

    return null;
  }

  Future<void> getImage(ImageSource imageSource) async {
    image = await _picker.pickImage(
      source: imageSource,
      imageQuality: 25,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null) {
      imageRaw = File(image!.path);
      List<int> imageBytes = imageRaw!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      editDataModel!.avatar = base64Image;
      updateUI();
    }
  }

  void setEditDataModel() {
    editDataModel?.displayName = nameController.text;
    editDataModel?.lastName = lastNameController.text;
    editDataModel?.firstName = firstNameController.text;
    editDataModel?.gender = genderController.text;
    editDataModel?.address = addressController.text;
    editDataModel?.city = cityController.text;
    editDataModel?.country = countryController.text;
    notifyListeners();
  }

  void setPhone(String? phone) {
    editDataModel?.phoneNumber = phone;
    notifyListeners();
  }
}
