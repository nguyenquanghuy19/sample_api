import 'package:elearning/core/data/models/meaning_model.dart';
import 'package:elearning/core/data/models/translation_model.dart';
import 'package:elearning/core/data/remote/services/translation_service.dart';

class TranslationRepository {
  final TranslationService _translationService = TranslationService();

  Future<TranslationModel?> getTranslationData() async {
    try {
      return await _translationService.getTranslationData();
    } on Exception {
      rethrow;
    }
  }

  Future<MeaningModel?> postContributeMeaning() async {
    try {
      return await _translationService.postContributeMeaning();
    } on Exception {
      rethrow;
    }
  }
}
