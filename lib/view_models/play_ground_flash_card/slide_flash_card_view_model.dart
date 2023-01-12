import 'dart:async';
import 'dart:math';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/ui/widgets/term_widget.dart';
import 'package:elearning/ui/widgets/flip.dart';
import 'package:elearning/ui/widgets/slide_item_custom/term_swiper.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class SlideFlashCardViewModel extends BaseViewModel {
  int _counterCurrentFlipCard = 0;

  int _counterCurrentSlideCard = 0;

  int _positionCurrent = 0;

  int get positionCurrent => _positionCurrent;

  List<String> _rememberIds = [];

  List<String> get rememberIds => _rememberIds;

  List<String> _forgetIds = [];

  List<String> get forgetIds => _forgetIds;

  bool _isAutoSlide = false;

  bool get isAutoSlide => _isAutoSlide;

  bool _isRandom = false;

  bool get isRandom => _isRandom;

  List<TermModel> _randomTerms = [];

  List<TermModel> get randomTerms => _randomTerms;

  FlashCardModel? flashCard;

  Timer? _timer;

  late AppinioSwiperController swiperController;

  FlipController? flipShowedController;

  TermController? swiperShowedController;

  bool isLastSlide = false;

  bool _isShuffleAction = false;

  bool get isShuffleAction => _isShuffleAction;

  bool _isSoundAction = false;

  bool get isSoundAction => _isSoundAction;

  bool _isSwapContent = false;

  bool get isSwapContent => _isSwapContent;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    swiperController = AppinioSwiperController();
  }

  void remember(String id) {
    _positionCurrent++;
    _rememberIds.add(id);
    _clearCounterAutoSlide();
    notifyListeners();
  }

  void forget(String id) {
    _positionCurrent++;
    _forgetIds.add(id);
    _clearCounterAutoSlide();
    notifyListeners();
  }

  void undoSlide(String id) {
    if (_positionCurrent > 0) {
      _positionCurrent--;
      _forgetIds.remove(id);
      _rememberIds.remove(id);
    }
    notifyListeners();
  }

  void startAutoSlideFlashCard() {
    if (_isAutoSlide) {
      _stopAutoSlideFlashCard();

      return;
    }

    _clearCounterAutoSlide();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counterCurrentFlipCard++;
      _counterCurrentSlideCard++;
      if (_positionCurrent == flashCard?.items.length) {
        _stopAutoSlideFlashCard();
      }
      if (_counterCurrentFlipCard == Constants.timeAutoFlipFlashCard) {
        flipShowedController?.isFront = false;
      }
      if (_counterCurrentSlideCard == Constants.timeAutoSlideFlashCard) {
        swiperController.swipeRight();
        _clearCounterAutoSlide();
      }
    });

    _isAutoSlide = true;
    notifyListeners();
  }

  void _stopAutoSlideFlashCard() {
    if (_timer != null && _timer?.isActive == true) {
      _timer?.cancel();
      _isAutoSlide = false;
      _clearCounterAutoSlide();
      notifyListeners();
    }
  }

  void _clearCounterAutoSlide() {
    _counterCurrentFlipCard = 0;
    _counterCurrentSlideCard = 0;
  }

  void startRandomTerms() {
    if (!_isShuffleAction) {
      _clearSectionSlide();

      return notifyListeners();
    }

    _clearSectionSlide();
    _randomTerms.addAll(flashCard?.items ?? []);
    _randomTerms.shuffle(Random());
    _isRandom = true;
    notifyListeners();
  }

  void _clearSectionSlide() {
    _positionCurrent = 0;
    _rememberIds = [];
    _forgetIds = [];
    _isAutoSlide = false;
    _isRandom = false;
    _randomTerms = [];
    _timer?.cancel();
    _clearCounterAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    flipShowedController?.dispose();
    swiperShowedController?.dispose();
    super.dispose();
  }

  void reset() {
    swiperShowedController?.mode = TermOutlineMode.none;
    startRandomTerms();
    isLastSlide = false;
    _rememberIds = [];
    _forgetIds = [];
    _positionCurrent = 0;
    updateUI();
  }

  void onApply(
    bool shuffleAction,
    bool soundAction,
    bool swapContent,
  ) {
    _isShuffleAction = shuffleAction;
    _isSoundAction = soundAction;
    if (swapContent != _isSwapContent) {
      flipShowedController!.flip();
    }
    _isSwapContent = swapContent;
    startRandomTerms();
    updateCurrentUI();
  }
}
