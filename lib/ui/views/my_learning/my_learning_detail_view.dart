import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/drawer_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/flash_card_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/information_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/notification_my_learning_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/quiz_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/rank_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/result_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/road_map_my_learing_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/slide_show_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/my_learning_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyLearningDetailView extends BaseView {
  final int courseId;
  final Uint8List? image;
  final bool isSvg;
  final String nameCourse;

  const MyLearningDetailView({
    Key? key,
    required this.courseId,
    this.image,
    required this.isSvg,
    required this.nameCourse,
  }) : super(key: key);

  @override
  MyLearningDetailViewState createState() => MyLearningDetailViewState();
}

class MyLearningDetailViewState
    extends BaseViewState<MyLearningDetailView, MyLearningDetailViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MyLearningDetailViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      endDrawer: Drawer(
        child: DrawerMyLearningDetail(
          courseId: widget.courseId,
          isSvg: widget.isSvg,
          image: widget.image,
          callBack: (value) {
            viewModel.onChangeMenu(value);
          },
        ),
      ),
      body: Selector<MyLearningDetailViewModel, MenuMyLearningDetail>(
        selector: (_, viewModel) => viewModel.menu,
        builder: (_, menu, __) {
          if (menu == MenuMyLearningDetail.roadmap) {
            return RoadMapMyLearningWidget(
              courseId: widget.courseId,
            );
          }
          if (menu == MenuMyLearningDetail.quiz) {
            return QuizWidget(
              courseId: widget.courseId,
              paddingTop: MediaQuery.of(context).padding.top,
            );
          }
          if (menu == MenuMyLearningDetail.result) {
            return ResultWidget(
              courseId: widget.courseId,
            );
          }
          if (menu == MenuMyLearningDetail.rank) {
            return RankWidget(
              courseId: widget.courseId,
            );
          }
          if (menu == MenuMyLearningDetail.flashCard) {
            return FlashCardWidget(
              courseId: widget.courseId,
            );
          }

          if (menu == MenuMyLearningDetail.slideShow) {
            return SlideShowWidget(
              courseId: widget.courseId,
            );
          }

          return InformationWidget(
            courseId: widget.courseId,
            isSvg: widget.isSvg,
            image: widget.image,
            paddingTop: MediaQuery.of(context).padding.top,
          );
        },
      ),
      // const RoadMapNewWidget(),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Tab(
          icon: SvgPicture.asset(Images.iconArrowLeft),
        ),
      ),
      title: Text(widget.nameCourse),
      actions: [
        IconButton(
          constraints: const BoxConstraints(),
          icon: SvgPicture.asset(
            Images.iconNotification,
            color: AppColor.neutrals.shade800,
          ),
          padding: EdgeInsets.zero,
          onPressed: () async {
            await BottomSheetWidget().showBottomSheetWidget(
              context,
              content: NotificationMyLearningWidget(
                courseId: widget.courseId,
              ),
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  AppBar().preferredSize.height,
            );
          },
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: AppColor.neutrals.shade800,
            ),
            padding: EdgeInsets.zero,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
      centerTitle: true,
    );
  }
}
