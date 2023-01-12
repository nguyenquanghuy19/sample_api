import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/translation_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/translation/contribute_translation_view.dart';
import 'package:elearning/view_models/dictionary/dictionary_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DictionaryView extends BaseView {
  const DictionaryView({super.key});

  @override
  DictionaryViewState createState() => DictionaryViewState();
}

class DictionaryViewState
    extends BaseViewState<DictionaryView, DictionaryViewModel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _activeSearch = false;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = DictionaryViewModel()..onInitViewModel(context);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: Selector<DictionaryViewModel, bool>(
          selector: (_, viewModel) => viewModel.isLoading,
          builder: (_, isLoading, __) {
            return Column(
              children: <Widget>[
                _buildChangeLanguage(),
                SizedBox(
                  height: 45.h,
                  child: _buildTabBar(),
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Selector<DictionaryViewModel, TranslationModel?>(
                          selector: (_, viewModel) =>
                              viewModel.getTranslationData,
                          builder: (_, translationData, __) {
                            return translationData != null
                                ? _buildContentTabBarView(translationData)
                                : _dataTranslationEmpty();
                          },
                        ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.primary.shade400,
          label: Text(
            Strings.of(context)!.contributeTranslation,
            style: AppText.text14,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return const ContributeTranslationView();
                },
              ),
            );
          },
          isExtended: true,
        ),
      ),
    );
  }

  Widget _buildChangeLanguage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                _showModalBottomSheetFrom<void>();
              },
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Selector<DictionaryViewModel, String?>(
                  selector: (_, viewModel) => viewModel.languageFrom,
                  builder: (_, languageFrom, __) {
                    return Text(languageFrom ?? '');
                  },
                ),
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              viewModel.reverseLanguage();
            },
            icon: const Icon(Icons.compare_arrows),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                _showModalBottomSheetTo<void>();
              },
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Selector<DictionaryViewModel, String?>(
                  selector: (_, viewModel) => viewModel.languageTo,
                  builder: (_, languageTo, __) {
                    return Text(languageTo ?? '');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.orange,
      labelColor: Colors.orange,
      tabs: [
        Tab(
          text: Strings.of(context)!.meaning,
        ),
        Tab(
          text: Strings.of(context)!.grammar,
        ),
        Tab(
          text: Strings.of(context)!.synonyms,
        ),
        Tab(
          text: Strings.of(context)!.antonyms,
        ),
      ],
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primary.shade400,
      title: _activeSearch
          ? TextField(
              controller: viewModel.searchController,
              style: AppText.text16,
              autofocus: true,
              decoration: InputDecoration(
                hintText: Strings.of(context)!.hintTextSearchCourses,
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().screenWidth * 0.01,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30.0).w,
                ),
              ),
            )
          : Text(
              Strings.of(context)!.dictionary,
              style: AppText.text22,
            ),
      actions: _activeSearch
          ? <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(left: 0, right: Constants.contentPaddingHorizontal),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  viewModel.searchController.clear();
                  setState(() => _activeSearch = false);
                },
              ),
            ]
          : <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.only(left: 0, right: 20.w),
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () => setState(() => _activeSearch = true),
              ),
            ],
    );
  }

  Widget _buildContentTabBarView(TranslationModel translationData) {
    return TabBarView(
      children: [
        _buildContentMeaning(translationData),
        Center(
          child: Text(Strings.of(context)!.grammar),
        ),
        _buildContentType(translationData, translationData.synonyms),
        _buildContentType(translationData, translationData.antonyms),
      ],
    );
  }

  Widget _dataTranslationEmpty() {
    return Center(
      child: Text(Strings.of(context)!.defaultValueProfile),
    );
  }

  Widget _buildContentMeaning(TranslationModel translationData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal),
          child: Wrap(
            spacing: 5.w,
            children: _buildListTitleType(translationData),
          ),
        ),
        const Divider(thickness: 0.5, color: AppColor.neutrals, height: 0),
        Expanded(
          child: _buildContentType(
            translationData,
            translationData.meanings,
            hasItemKey: true,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildListTitleType(TranslationModel translationData) {
    return List.generate(
      translationData.meanings.length,
      (index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: (translationData.meanings[index].wordType ==
                      Strings.of(context)!.noun)
                  ? Colors.orange
                  : Colors.green,
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 15.w),
            child: InkWell(
              onTap: () {
                Scrollable.ensureVisible(
                  viewModel.keyScroll[index].currentContext!,
                );
              },
              child: Text(
                "${translationData.meanings[index].wordType}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: (translationData.meanings[index].wordType ==
                          Strings.of(context)!.noun)
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentType(
    TranslationModel translationModel,
    List<SubTranslation> listDataSubTranslation, {
    bool hasItemKey = false,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVocabularyView(
            "${translationModel.originalWordText}",
            "${translationModel.wordSpelling}",
          ),
          _buildTranslationView(listDataSubTranslation, hasItemKey: hasItemKey),
        ],
      ),
    );
  }

  Widget _buildVocabularyView(String vocabulary, String pronounce) {
    return Row(
      children: [
        Text(
          vocabulary,
          style: AppText.text26.copyWith(
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(width: 20.w),
        Text(
          pronounce,
          style: AppText.text18.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTitleMeaningView(String title, bool isNoun) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppText.text18.copyWith(
              color: isNoun ? Colors.orange : Colors.green,
            ),
          ),
          InkWell(
            onTap: () {
              // [TODO] handler push report screen
            },
            child: Text(
              Strings.of(context)!.report,
              style: AppText.text14.copyWith(
                color: Colors.red,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationView(
    List<SubTranslation> listDataSubTranslation, {
    bool hasItemKey = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: listDataSubTranslation.length,
        itemBuilder: (context, index) {
          var listWords = listDataSubTranslation[index].words;

          return Column(
            key: hasItemKey ? viewModel.keyScroll[index] : null,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleMeaningView(
                "${listDataSubTranslation[index].wordType}",
                listDataSubTranslation[index].wordType ==
                    Strings.of(context)!.noun,
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: listWords.length,
                itemBuilder: (context, indexWords) {
                  return Text(
                    "${listWords[indexWords].wordText}",
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 5.h,
                  );
                },
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(thickness: 1, color: AppColor.neutrals, height: 20.h);
        },
      ),
    );
  }

  Future<T?> _showModalBottomSheetFrom<T>() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSelectLanguageFrom(
          languageFrom: viewModel.languageFrom,
          callBack: (languageFrom) {
            viewModel.chooseLanguageFrom(languageFrom);
          },
        );
      },
    );
  }

  Future<T?> _showModalBottomSheetTo<T>() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSelectLanguageTo(
          languageTo: viewModel.languageTo,
          callBack: (languageTo) {
            viewModel.chooseLanguageTo(languageTo);
          },
        );
      },
    );
  }
}

class BottomSelectLanguageFrom extends StatefulWidget {
  final String? languageFrom;
  final Function(String?) callBack;

  const BottomSelectLanguageFrom({
    Key? key,
    this.languageFrom,
    required this.callBack,
  }) : super(key: key);

  @override
  State<BottomSelectLanguageFrom> createState() =>
      _BottomSelectLanguageFromState();
}

class _BottomSelectLanguageFromState extends State<BottomSelectLanguageFrom> {
  List<String> listLanguage = ['Tiếng Anh', 'Tiếng Việt', 'Tiếng Nhật'];
  String? languageFrom;

  @override
  void initState() {
    languageFrom = widget.languageFrom;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 10.h),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 10.h),
            decoration: BoxDecoration(
              color: languageFrom == listLanguage[index]
                  ? Colors.blue[200]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              onTap: () {
                languageFrom = listLanguage[index];
                widget.callBack(languageFrom);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listLanguage[index],
                    style: AppText.text20,
                  ),
                  languageFrom == listLanguage[index]
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
        itemCount: listLanguage.length,
      ),
    );
  }
}

class BottomSelectLanguageTo extends StatefulWidget {
  final String? languageTo;
  final Function(String?) callBack;

  const BottomSelectLanguageTo({
    Key? key,
    this.languageTo,
    required this.callBack,
  }) : super(key: key);

  @override
  State<BottomSelectLanguageTo> createState() => _BottomSelectLanguageToState();
}

class _BottomSelectLanguageToState extends State<BottomSelectLanguageTo> {
  List<String> listLanguage = ['Tiếng Anh', 'Tiếng Việt', 'Tiếng Nhật'];
  String? languageTo;

  @override
  void initState() {
    languageTo = widget.languageTo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 10.h),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.contentPaddingHorizontal, vertical: 10.h),
            decoration: BoxDecoration(
              color: languageTo == listLanguage[index]
                  ? Colors.blue[200]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              onTap: () {
                languageTo = listLanguage[index];
                widget.callBack(languageTo);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listLanguage[index],
                    style: AppText.text20,
                  ),
                  languageTo == listLanguage[index]
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
        itemCount: listLanguage.length,
      ),
    );
  }
}
