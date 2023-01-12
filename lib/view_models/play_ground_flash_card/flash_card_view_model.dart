import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/core/data/repositories/flash_card_repository.dart';
import 'package:elearning/core/data/share_preference/spref_setting_flash_card.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashCardViewModel extends BaseViewModel {
  final FlashCardRepository _flashCardRepository = FlashCardRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  FlashCardSelectedState _selectedState = FlashCardSelectedState.all;

  FlashCardSelectedState get currentSelectedState => _selectedState;

  late FlashCardModel? _flashCardModel;

  FlashCardModel? get flashCardModel => _flashCardModel;

  List<TermModel> get items => _flashCardModel?.items ?? [];

  Iterable<TermModel> get counterRemember =>
      items.where((arr) => arr.isRemember);

  bool _isAlphaBet = false;

  bool get isAlphaBet => _isAlphaBet;

  List<TermModel> get itemsAlphaBet => _flashCardModel?.items ?? [];

  ScrollController scrollController = ScrollController();

  bool isShowButtonScrollTop = false;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? id}) async {
    super.onInitViewModel(context);
    _isAlphaBet = SPrefSettingFlashCard().getAlphabet();
    scrollController.addListener(() {
      if (scrollController.position.extentBefore > 50) {
        _handleShowButtonScrollTop(true);
      } else {
        _handleShowButtonScrollTop(false);
      }
    });
    await initFlashCardsData(id);
  }

  void _handleShowButtonScrollTop(bool value) {
    isShowButtonScrollTop = value;
    updateUI();
  }

  Future<void> initFlashCardsData(int? id) async {
    _isLoading = true;

    await _getFlashCardData(id);
    itemsAlphaBet.sort((a, b) {
      var value1 = a.term ?? '';
      var value2 = b.term ?? '';

      return value1.compareTo(value2);
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _getFlashCardData(int? id) async {
    try {
      final res = await _flashCardRepository.getFlashCard(id: id);
      if (res != null) {
        _flashCardModel = res.data;
      }
    } on Exception {
      LogUtils.d("Load flash card failed");
    }
  }

  void onSelectedCurrentListState(FlashCardSelectedState selectedState) {
    _selectedState = selectedState;
    notifyListeners();
  }

  void actionRemember(TermModel term) {
    term.isRemember = !term.isRemember;
    notifyListeners();
  }

  void isChangeAlphaBet(bool value) {
    _isAlphaBet = value;
    notifyListeners();
  }
}
