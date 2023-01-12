import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/form_meaning_widget.dart';
import 'package:elearning/view_models/dictionary/contribute_translation_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ContributeTranslationView extends BaseView {
  const ContributeTranslationView({Key? key}) : super(key: key);

  @override
  ContributeTranslationViewState createState() =>
      ContributeTranslationViewState();
}

class ContributeTranslationViewState extends BaseViewState<
    ContributeTranslationView, ContributeTranslationViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<PopupMenuButtonState<String>> _popupButtonKey = GlobalKey();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ContributeTranslationViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          Strings.of(context)!.contributeTranslation,
          style: AppText.text22,
        ),
        backgroundColor: AppColor.primary.shade400,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Selector<ContributeTranslationViewModel, int>(
        selector: (_, viewModel) => viewModel.numberOfMeaningTextField,
        builder: (_, numberOfMeaningTextField, __) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 16.h),
              child: Column(
                children: <Widget>[
                  _buildWordTypeDropDown(),
                  SizedBox(height: 15.h),
                  _buildListMeaning(numberOfMeaningTextField),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: Strings.of(context)!.addMoreMeaning,
                          width: 150.w,
                          styleLabel: AppText.text14.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            // Add text editing controller
                            viewModel.addMoreMeaning();
                          },
                        ),
                      ),
                      const SizedBox(width: Constants.contentPaddingHorizontal),
                      Expanded(
                        child: AppButton(
                          label: Strings.of(context)!.removeMeaning,
                          width: 150.w,
                          styleLabel: AppText.text14.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            // Remove text editing controller at index
                            if (numberOfMeaningTextField > 1) {
                              viewModel.removeMeaning();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    label: Strings.of(context)!.labelButtonSubmit,
                    styleLabel: AppText.text20.copyWith(color: Colors.white),
                    backgroundColor: const Color(0xFF48C78E),
                    borderRadius: 10,
                    onPressed: () async {
                      // TODO on tap button submit, post to api
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWordTypeDropDown() {
    return AppInput(
      label: Strings.of(context)!.wordType,
      textLabelStyle: AppText.text18.copyWith(color: Colors.black),
      readOnly: true,
      onTap: () {
        _popupButtonKey.currentState?.showButtonMenu();
      },
      suffixIcon: _buildButtonPopupMenu(),
      hintText: Strings.of(context)!.wordType,
      controller: viewModel.wordTypeController,
    );
  }

  Widget _buildButtonPopupMenu() {
    return PopupMenuButton<String>(
      key: _popupButtonKey,
      icon: Icon(
        Icons.arrow_drop_down,
        size: 20.h,
      ),
      onSelected: (value) {
        viewModel.wordTypeController.text = value;
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: Strings.of(context)!.verbs,
          child: Text(Strings.of(context)!.verbs),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.nouns,
          child: Text(Strings.of(context)!.nouns),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.adjectives,
          child: Text(Strings.of(context)!.adjectives),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.adverbs,
          child: Text(Strings.of(context)!.adverbs),
        ),
      ],
    );
  }

  Widget _buildListMeaning(int number) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      shrinkWrap: true,
      primary: false,
      itemCount: number,
      itemBuilder: (context, index) {
        return FormMeaningWidget(
          numberMeaningTextField: index + 1,
          callBack: (meaningModel) {
            // TODO Add item to list
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.h,
        );
      },
    );
  }
}
