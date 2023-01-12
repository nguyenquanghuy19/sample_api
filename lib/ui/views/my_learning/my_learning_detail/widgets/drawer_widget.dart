import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerMyLearningDetail extends StatefulWidget {
  final int? courseId;
  final Uint8List? image;
  final bool isSvg;
  final String? courseName;
  final String? lessonName;
  final Function(MenuMyLearningDetail) callBack;

  const DrawerMyLearningDetail({
    Key? key,
    this.courseId,
    this.image,
    required this.isSvg,
    this.courseName,
    this.lessonName,
    required this.callBack,
  }) : super(key: key);

  @override
  State<DrawerMyLearningDetail> createState() => _DrawerMyLearningDetailState();
}

class _DrawerMyLearningDetailState extends State<DrawerMyLearningDetail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildHeaderDrawer(),
          _buildBodyDrawer(),
        ],
      ),
    );
  }

  Widget _buildHeaderDrawer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: const SafeArea(
        child: SizedBox(
          height: Constants.appBarHeight,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildBodyDrawer() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildItemBodyDrawer(
            iconPrefix: Images.iconIconInformationMyLearning,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.information,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.information);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          // [TODO] Move to road map screen
          _buildItemBodyDrawer(
            iconPrefix: Images.iconRoadMapMyLearning,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.roadMap,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.roadmap);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconMyResult,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.result,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.result);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconCourseResult,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.rankMyLearning,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.rank);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconQuizType,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.titleQuiz,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.quiz);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconFlashCardType,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.flashCard,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.flashCard);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconSlideShowType,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.slideShowMyLearningDetail,
            onPressed: (){
              widget.callBack(MenuMyLearningDetail.slideShow);
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildItemBodyDrawer({
    String? iconPrefix,
    String? iconSuffix,
    required String? title,
    required Function() onPressed,
  }) {
    return ListTile(
      leading: iconPrefix != null
          ? Tab(
              height: (24.w + 24.h) / 2,
              icon: SvgPicture.asset(
                iconPrefix,
                width: (24.w + 24.h) / 2,
              ),
            )
          : null,
      trailing: iconSuffix != null
          ? Tab(
              icon: SvgPicture.asset(
                iconSuffix,
              ),
            )
          : null,
      title: Text(
        title!,
        style: AppText.text18,
      ),
      onTap: onPressed,
    );
  }
}
