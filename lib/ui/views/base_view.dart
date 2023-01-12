import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/widgets/error/error_widget.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState<V extends BaseView, VM extends BaseViewModel>
    extends State<V> with WidgetsBindingObserver {
  late final VM viewModel;

  @override
  void initState() {
    super.initState();
    createViewModel();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuildCompleted());
  }

  void createViewModel() {
    // TODO(Override for create ViewModel each View): need to implement.
  }

  bool isNeedReBuildByOtherViewModel() {
    return true;
  }

  /// Register notify when viewModel other call notifyListener()
  void onBuildCompleted() {
    viewModel.onBuildComplete(
      isNeedReBuildByOtherViewModel: isNeedReBuildByOtherViewModel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>(
      create: (_) => viewModel,
      child: buildView(context),
    );
  }

  /// Override for each view ...
  Widget buildView(BuildContext context) {
    return Container();
  }

  Widget buildErrorViewWidget(Function? onButtonPressed, int errorCodeNumber) {
    switch (errorCodeNumber) {
      case Constants.noInternet:
        return ErrorViewWidget(
          image: Images.imageErrorNoInternet,
          errorCode: Strings.of(context)!.noConnection,
          title: Strings.of(context)!.noConnectionTitle,
          message: Strings.of(context)!.noConnectionMessage,
          onButtonPressed: onButtonPressed,
        );
      case Constants.errorCode400:
        return ErrorViewWidget(
          image: Images.imageError400,
          errorCode: Strings.of(context)!.errorCode400,
          title: Strings.of(context)!.errorCode400Title,
          message: Strings.of(context)!.errorCode400Message,
          onButtonPressed: onButtonPressed,
        );
      case Constants.errorCode404:
        return ErrorViewWidget(
          image: Images.imageError404,
          errorCode: Strings.of(context)!.errorCode404,
          title: Strings.of(context)!.errorCode404Title,
          message: Strings.of(context)!.errorCode404Message,
          onButtonPressed: onButtonPressed,
        );
      case Constants.errorCode500:
        return ErrorViewWidget(
          image: Images.imageError500,
          errorCode: Strings.of(context)!.errorCode500,
          title: Strings.of(context)!.errorCode500Title,
          message: Strings.of(context)!.errorCode500Message,
          onButtonPressed: onButtonPressed,
        );
      case Constants.errorCode503:
        return ErrorViewWidget(
          image: Images.imageError503,
          errorCode: Strings.of(context)!.errorCode503,
          title: Strings.of(context)!.errorCode503Title,
          message: Strings.of(context)!.errorCode503Message,
          onButtonPressed: onButtonPressed,
        );
      case Constants.errorCode504:
        return ErrorViewWidget(
          image: Images.imageError504,
          errorCode: Strings.of(context)!.errorCode504,
          title: Strings.of(context)!.errorCode504Title,
          message: Strings.of(context)!.errorCode504Message,
          onButtonPressed: onButtonPressed,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
