import 'package:elearning/core/data/models/translation_model.dart';
import 'package:elearning/core/data/repositories/translation_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class DictionaryViewModel extends BaseViewModel {
  final TranslationRepository _translationRepository = TranslationRepository();

  TextEditingController searchController = TextEditingController();

  TranslationModel _translationData = TranslationModel();

  TranslationModel get getTranslationData => _translationData;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<GlobalKey> keyScroll = [];

  // Todo: translate
  final List<String> _listLanguage = ['Tiếng Anh', 'Tiếng Việt', 'Tiếng Nhật'];

  String? languageFrom;

  String? languageTo;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    languageFrom = _listLanguage[0];
    languageTo = _listLanguage[1];
    await initTranslationData();
  }

  Future<void> initTranslationData() async {
    _isLoading = true;
    await _getTranslationData();
    createSizeItemsKey();
    _isLoading = false;
    notifyListeners();
  }

  void createSizeItemsKey() {
    keyScroll.clear();
    for (int i = 0; i < getTranslationData.meanings.length; i++) {
      keyScroll.add(GlobalKey(debugLabel: 'key_item_$i'));
    }
  }

  Future<void> _getTranslationData() async {
    try {
      final res = await _translationRepository.getTranslationData();
      if (res != null) {
        _translationData = res;
      }
    } on Exception {
      // [TODO] Handler call APi Error
    }
  }

  void chooseLanguageFrom(String? languageFromNew) {
    if (languageFromNew == languageTo) {
      reverseLanguage();
    } else {
      languageFrom = languageFromNew;
    }
    notifyListeners();
  }

  void chooseLanguageTo(String? languageToNew) {
    if (languageToNew == languageFrom) {
      reverseLanguage();
    } else {
      languageTo = languageToNew;
    }
    notifyListeners();
  }

  void reverseLanguage() {
    final temp = languageFrom;
    languageFrom = languageTo;
    languageTo = temp;
    notifyListeners();
  }
}
