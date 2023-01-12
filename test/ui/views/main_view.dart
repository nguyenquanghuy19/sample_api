import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/home/home_view.dart';
import 'package:elearning/view_models/mains/main_view_before_sign_in_view_model.dart';
import 'package:flutter/material.dart';

class MainView extends BaseView {
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends BaseViewState<MainView, MainViewBeforeSignInViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewBeforeSignInViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return const HomeView();
  }
}
