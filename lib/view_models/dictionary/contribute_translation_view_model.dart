import 'package:elearning/core/data/repositories/translation_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ContributeTranslationViewModel extends BaseViewModel {
  final TranslationRepository _translationRepository = TranslationRepository();

  TextEditingController wordTypeController = TextEditingController();

  int _numberOfMeaningTextField = 1;

  int get numberOfMeaningTextField => _numberOfMeaningTextField;

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  void addMoreMeaning() {
    _numberOfMeaningTextField++;
    updateCurrentUI();
  }

  void removeMeaning() {
    _numberOfMeaningTextField--;
    updateCurrentUI();
  }

  Future<void> onTapButtonSubmit() async {
    _isSubmitting = true;
    try {
      final res = await _translationRepository.postContributeMeaning();
      if (res != null) {
        showToastSuccess("Contribute word success");
        _backToTranslationView();
      }
    } on Exception {
      // TODO handle error call api error
    } finally {
      _isSubmitting = false;
    }
  }

  void _backToTranslationView() {
    Navigator.of(context).pop();
  }
}
