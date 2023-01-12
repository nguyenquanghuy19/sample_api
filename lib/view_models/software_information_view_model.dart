import 'package:elearning/core/data/models/software_information_model.dart';
import 'package:elearning/core/data/repositories/software_information_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SoftwareInformationViewModel extends BaseViewModel {
  final SoftwareInformationRepository _softwareInformationRepository =
      SoftwareInformationRepository();

  List<SoftwareInformationModel>? _softwareList;

  List<SoftwareInformationModel>? get softwareList => _softwareList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    _initListLicense();
  }

  Future<void> _initListLicense() async {
    _isLoading = true;
    try {
      final res = await _softwareInformationRepository.getAllListLicense();
      _softwareList = res;
    } on Exception {
      // TODO handle api error
    }
    _isLoading = false;
    updateUI();
  }
}
