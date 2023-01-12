import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class QuizResultViewModel extends BaseViewModel {
  late DataResultModel dataResult;

  int _numberPage = 0;

  int get numberPage => _numberPage;

  int indexPage = Constants.zeroValueDefault;

  int get indexReducePage => indexPage >= 1 ? --indexPage : indexPage;

  int get indexIncreasePage =>
      indexPage < (numberPage - 1) ? ++indexPage : indexPage;

  List<ItemQuizModel> listPerPage = [];

  ScrollController scrollController = ScrollController();

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[INIT_QUIZ_RESULT_VIEW_MODEL]");
  }

  void inItData(DataResultModel data) {
    dataResult = data;
    _handlerPerPage(firstLoad: true);
    _handleIndexPage();
  }

  void _handleIndexPage() {
    _numberPage = dataResult.result.length % Constants.pageQuizDefault ==
        Constants.zeroValueDefault
        ? dataResult.result.length ~/ Constants.pageQuizDefault
        : dataResult.result.length ~/ Constants.pageQuizDefault +
        Constants.pageFirstValue;
  }

  void _handlerPerPage({bool firstLoad = false}) {
    listPerPage.clear();
    final value = (dataResult.result.length >
        (indexPage + Constants.pageFirstValue) * Constants.pageQuizDefault)
        ? (indexPage + Constants.pageFirstValue) * Constants.pageQuizDefault
        : dataResult.result.length;
    for (int i = indexPage * Constants.pageQuizDefault; i < value; i++) {
      listPerPage.add(dataResult.result[i]);
    }
    if(!firstLoad){
      updateUI();
    }
  }

  void handleOnChangePage(int index, {bool firstLoad = false}) {
    indexPage = index;
    _handlerPerPage();
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1),
    );
    if(!firstLoad){
      updateUI();
    }
  }
}
