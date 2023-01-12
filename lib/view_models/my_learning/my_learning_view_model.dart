import 'dart:async';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/core/data/repositories/media_repository.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  final MediaRepository _mediaRepository = MediaRepository();

  final AccountRepository _accountRepository = AccountRepository();

  List<RefreshController> refreshControllers = [];

  final TextEditingController searchController = TextEditingController();

  int _page = 1;

  List<MyLearningModel> myLearnings = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _totalRecord = 0;

  bool get isLoadMore => myLearnings.length < _totalRecord;

  String _displayName = "";

  String get displayName => _displayName;

  Timer? _debounce;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    _initRefreshController();
    await inItData();
  }

  Future<void> inItData() async {
    _isLoading = true;
    await _getDisplayName();
    await getListMyLearning(
      refreshController: refreshControllers[0],
    );
    _isLoading = false;
    updateUI();
  }

  // ToDo: Suggest support API get display name
  Future<void> _getDisplayName() async {
    try {
      final res = await _accountRepository.getProfile();
      _displayName = res?.data?.displayName ?? res?.data?.userName ?? "";
    } on Exception {
      LogUtils.i("Error get display name");
    }
  }

  List<RefreshController> _initRefreshController() {
    return refreshControllers = List.generate(
      Constants.sizeTabBarMyLearning,
      (_) => RefreshController(initialRefresh: false),
    );
  }

  void onTapChange(int index) {
    _initRefreshController();
    switch (index) {
      // Handle call all list my learning
      case 0:
        getListMyLearning(
          refreshController: refreshControllers[index],
        );
        break;
      // Handle call list completed my learning
      case 1:
        // TODO insert param completed
        getListMyLearning(
          refreshController: refreshControllers[index],
        );
        break;
      // Handle call list registered my learning
      case 2:
        // TODO insert param registered
        getListMyLearning(
          refreshController: refreshControllers[index],
        );
        break;
    }
  }

  Future<void> getListMyLearning({
    required RefreshController refreshController,
    bool isSearch = false,
    bool isFirstLoad = true,
  }) async {
    try {
      if (isFirstLoad && !isSearch) {
        _isLoading = true;
        _page = 1;
        updateUI();
        myLearnings.clear();
      }
      if (isSearch) {
        _page = 1;
        myLearnings.clear();
      }
      final String param =
          "?Page=$_page&PerPage=10&Name=${searchController.text.trim()}";
      final res =
          await _myLearningRepository.getAllListMyLearning(param: param);
      if (res != null && res.data.isNotEmpty) {
        myLearnings.addAll(res.data);
        myLearnings.sort(((a, b) => b.updatedAt!.compareTo(a.updatedAt!)));
        getListImage(myLearnings, res.data.length);
        _totalRecord = res.total!;
        _page++;
      }
      refreshController.loadComplete();
      _isLoading = false;
    } on Exception {
      _isLoading = false;
      refreshController.loadComplete();
    }
    updateUI();
  }

  Future<void> getImage(MyLearningModel myLearning) async {
    try {
      if (myLearning.featuredImage != null) {
        myLearning.isLoadingImage = true;
        final res = await _mediaRepository
            .getLmsFeatureImage(myLearning.featuredImage!);
        myLearning.image = res.data;
        myLearning.isSvg =
            res.headers["content-type"]?[0].contains("svg") ?? false;
        myLearning.isLoadingImage = false;
      } else {
        myLearning.isLoadingImage = false;
      }
    } on Exception {
      myLearning.isLoadingImage = false;
      LogUtils.i("Error get image");
    }
    updateUI();
  }

  void getListImage(List<MyLearningModel> myLearning, int length) {
    for (int i = myLearning.length - length; i < myLearning.length; i++) {
      getImage(myLearning[i]);
    }
  }

  void onCloseSearch(int index) {
    if (searchController.text.trim().isNotEmpty) {
      searchController.clear();
      if (index == 0) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }
      if (index == 1) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }
      if (index == 2) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }
    } else {
      searchController.clear();
    }
  }

  void onSearch(int index) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      searchController.text.trim();
      if (index == 0) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }

      if (index == 1) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }

      if (index == 2) {
        getListMyLearning(
          refreshController: refreshControllers[0],
          isSearch: true,
        );

        return;
      }
    });
  }
}
