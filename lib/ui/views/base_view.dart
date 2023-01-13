import 'package:testproject/view_models/base_view_model.dart';
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
