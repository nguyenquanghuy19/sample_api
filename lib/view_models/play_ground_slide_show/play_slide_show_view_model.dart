import 'package:elearning/core/data/models/comment_model.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/slide_show_model.dart';
import 'package:elearning/core/data/repositories/media_repository.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/mock_datas/mock_play_ground_slide_show_data.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class PlaySlideShowViewModel extends BaseViewModel {
  List<CommentModel> comments = [];

  List<SlideShowModel> slideShows = [];

  List<ItemSlideShowModel> itemSlideShows = [];

  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  final MediaRepository _mediaRepository = MediaRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? id}) async {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][PLAY_SLIDE_SHOW_VIEW_MODEL] => INIT");
    await _getData(id);
    comments = MockPlayGroundSlideShowData.listComment;
    slideShows = MockPlayGroundSlideShowData.listSlideShow;
  }

  Future<void> _getData(int? id) async {
    try {
      _isLoading = true;
      if (id != null) {
        String param = "?Id=$id";
        final res = await _myLearningRepository.getContentSlideShow(
          param: param,
        );
        if (res != null && res.data != null && res.data?.items != null) {
          itemSlideShows = res.data!.items;
          getListImage(itemSlideShows, res.data!.items.length);
        }
      }
      _isLoading = false;
    } on Exception {
      _isLoading = false;
      LogUtils.d("[$runtimeType][GET_DATA_PLAY_SLIDE_SHOW_DETAIL] => ERROR");
    }
    updateUI();
  }

  Future<void> getImage(ItemSlideShowModel itemSlideShow) async {
    try {
      if (itemSlideShow.image != null) {
        itemSlideShow.isLoadingImage = true;
        final res =
            await _mediaRepository.getLmsFeatureImage(itemSlideShow.image!);
        itemSlideShow.convertImage = res.data;
        itemSlideShow.isSvg =
            res.headers["content-type"]?[0].contains("svg") ?? false;
        itemSlideShow.isLoadingImage = false;
      } else {
        itemSlideShow.isLoadingImage = false;
      }
    } on Exception {
      itemSlideShow.isLoadingImage = false;
      LogUtils.i("Error get image");
    }
    updateUI();
  }

  void getListImage(List<ItemSlideShowModel> itemSlideShows, int length) {
    for (int i = itemSlideShows.length - length;
        i < itemSlideShows.length;
        i++) {
      getImage(itemSlideShows[i]);
    }
  }
}
