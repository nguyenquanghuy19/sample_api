import 'package:elearning/core/data/models/meaning_model.dart';
import 'package:elearning/core/data/models/translation_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';
import 'package:elearning/core/mock_datas/mock_translation_data.dart';

class TranslationService extends BaseService {
  Future<TranslationModel?> getTranslationData() async {
    await Future<Duration>.delayed(const Duration(milliseconds: 150));

    return MockTranslationData.translationModel;
  }

  Future<MeaningModel?> postContributeMeaning() async {
    // TODO handle post api
    return null;
  }
}
