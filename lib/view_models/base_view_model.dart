import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/core/utils/network_utils.dart';
import 'package:elearning/core/utils/toast_util.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';

/// BaseViewModel
abstract class BaseViewModel extends ChangeNotifier {
  // static privateなChangeNotifierリストのメンバを持つ。
  static final List<ChangeNotifier> _notifierList = [];

  List<ChangeNotifier> get notifierList =>
      _notifierList; // 破棄されるかどうか_listenersオブジェクトをチェック

  bool _isEmptyListeners = false;

  bool _isShowLoading = false;

  bool get isShowLoading => _isShowLoading;

  late BuildContext context;

  BaseViewModel({bool isShowLoading = false}) {
    _isShowLoading = isShowLoading;
  }

  void setLoading({required bool isShow}) {
    _isShowLoading = isShow;
    updateCurrentUI();
  }

  bool hasNetworkConnection() {
    return NetworkUtils.hasConnection();
  }

  void onInitViewModel(BuildContext context) {
    LogUtils.i("$runtimeType");
    this.context = context;
  }

  // Function will check size device change
  bool checkReCalculatorSize({required bool allowReCalculatorSize}) {
    return allowReCalculatorSize;
  }

  // When View build success, allow call setState().
  // When need update UI by other viewModels set isNeedReBuildByOtherViewModel is true
  void onBuildComplete({bool isNeedReBuildByOtherViewModel = true}) {
    if (isNeedReBuildByOtherViewModel && !_notifierList.contains(this)) {
      LogUtils.d("add [$this] notifier list");
      // 自身のインスタンス(this)を_notifierListに追加する。
      _notifierList.add(this);
    }
  }

  void updateCurrentUI() {
    LogUtils.d("[updateCurrentUI:$runtimeType]");
    notifyListeners();
  }

  void updateUI() {
    LogUtils.d("[updateUI:$runtimeType]");
    // 破棄される_listenersオブジェクトの場合、状態の変化を通知しない
    if (!_isEmptyListeners) {
      // 状態の変化を通知
      notifyListeners();
    }
    if (_notifierList.isEmpty) return;
    // _notifierList分のnotifyListeners()を呼び出す。
    for (ChangeNotifier notifier in _notifierList) {
      if (notifier != this) {
        notifier.notifyListeners();
      }
    }
  }

  void showToastSuccess(
    String? message, {
    String? title,
    Color? colorContent,
    Color? colorIcon,
    Color? colorBorder,
  }) {
    MessageUtils.showToastMessage(
      context,
      title ?? Strings.of(context)!.success,
      message ?? "",
      AppColor.greenAccent.shade200,
      colorContent ?? Colors.white,
      colorIcon ?? Colors.white,
      colorBorder ?? AppColor.greenAccent.shade200,
      TypeToast.success,
      null,
    );
  }

  void showToastError(
    String? message, {
    String? title,
    Color? colorContent,
    Color? colorIcon,
    Color? colorBorder,
  }) {
    MessageUtils.showToastMessage(
      context,
      title ?? Strings.of(context)!.error,
      message ?? "",
      AppColor.redApp.shade300,
      colorContent ?? Colors.white,
      colorIcon ?? Colors.white,
      colorBorder ?? AppColor.redApp.shade300,
      TypeToast.error,
      null,
    );
  }

  void showToastWarning(
    String? message, {
    String? title,
    Color? colorContent,
    Color? colorIcon,
    Color? colorBorder,
  }) {
    MessageUtils.showToastMessage(
      context,
      title ?? Strings.of(context)!.warning,
      message ?? "",
      AppColor.yellow.shade400,
      colorContent ?? Colors.white,
      colorIcon ?? Colors.white,
      colorBorder ?? AppColor.yellow.shade400,
      TypeToast.warning,
      null,
    );
  }

  void showToastCustom(
    String? message,
    Color? colorBackGround, {
    String? title,
    Color? colorContent,
    IconData? iconData,
    Color? colorIcon,
    Color? colorBorder,
  }) {
    MessageUtils.showToastMessage(
      context,
      title ?? "",
      message ?? "",
      colorBackGround,
      colorContent ?? Colors.white,
      colorIcon ?? Colors.white,
      colorBorder ?? Colors.transparent,
      TypeToast.custom,
      iconData,
    );
  }

  int _errorCodeNumber = Constants.noErrorCode;

  int get errorCodeNumber => _errorCodeNumber;

  Future<void> setErrorCodeNumber(Object? error, {int? errorCode}) async {
    LogUtils.d("$runtimeType set error code number $error -- $errorCode");
    if (error == null) {
      await NetworkUtils.connect();
      _errorCodeNumber = errorCode ??
          (!hasNetworkConnection()
              ? Constants.noInternet
              : Constants.noErrorCode);
    } else if (error is FetchDataException || error is UnauthorisedException) {
      ApiException ex = error as ApiException;
      _errorCodeNumber = ex.errorCodeScreen!;
    } else if (error is NoInternetException || error is AppTimeOutException) {
      _errorCodeNumber = Constants.noInternet;
    }
  }

  // Call when:
  // + dispose
  // + change screen
  void removeNotifier() {
    if (_notifierList.contains(this)) {
      LogUtils.i("viewModel:remove:notifier[$runtimeType]");
      // 自身のインスタンス(this)を_notifierListから削除する。
      _notifierList.remove(this);
    }
  }

  // Call when:
  // + dispose
  // + change screen
  void clearNotifier() {
    _notifierList.clear();
  }

  /// 破棄の処理
  @override
  void dispose() {
    LogUtils.i("viewModel:dispose[$runtimeType]");
    _isEmptyListeners = true;
    removeNotifier();
    super.dispose();
  }
}
