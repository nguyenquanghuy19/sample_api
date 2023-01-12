import 'package:elearning/core/utils/log_utils.dart';
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
  bool _isChangeMetrics = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuildCompleted());
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
    return WillPopScope(
      onWillPop: () async {
        return !Navigator.canPop(context);
      },
      child: ChangeNotifierProvider<VM>(
        create: (_) => viewModel,
        child: Selector<VM, bool>(
          selector: (_, viewModel) => viewModel.isShowLoading,
          builder: (_, isShowLoading, child) {
            return Stack(
              children: [
                AbsorbPointer(
                  // Disable click when loading ...
                  absorbing: isShowLoading,
                  child: child ?? const SizedBox.shrink(),
                ),
                if (isShowLoading)
                  Positioned.fill(
                    child: buildLoading(),
                  ),
              ],
            );
          },
          child: buildView(context),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }

  /// Override for each view ...
  Widget buildView(BuildContext context) {
    return Container();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    LogUtils.d("[$runtimeType] ChangeMetrics");
    _isChangeMetrics = true;
    viewModel.updateUI();
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    LogUtils.d("[$runtimeType] ChangeTextScale");
    if (!_isChangeMetrics) {
      viewModel.updateUI();
    }
    _isChangeMetrics = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
