import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationAfterSignInWidget extends StatelessWidget {
  BottomNavigationAfterSignInWidget({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  final BottomTabItemAfterSignIn currentTab;
  final ValueChanged<BottomTabItemAfterSignIn> onSelectTab;

  final Map<BottomTabItemAfterSignIn, Widget> tabIcon = {
    BottomTabItemAfterSignIn.home: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconHome),
    ),
    BottomTabItemAfterSignIn.course: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconCourse),
    ),
    BottomTabItemAfterSignIn.myLearning: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconMyLearning),
    ),
    BottomTabItemAfterSignIn.setting: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconSetting),
    ),
  };

  final Map<BottomTabItemAfterSignIn, Widget> tabIconActive = {
    BottomTabItemAfterSignIn.home: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconHomeActive),
    ),
    BottomTabItemAfterSignIn.course: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(
        Images.iconCourseActive,
      ),
    ),
    BottomTabItemAfterSignIn.myLearning: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(
        Images.iconMyLearningActive,
      ),
    ),
    BottomTabItemAfterSignIn.setting: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(
        Images.iconSettingActive,
      ),
    ),
  };

  Map<BottomTabItemAfterSignIn, String> nameTabItem(BuildContext context) {
    return {
      BottomTabItemAfterSignIn.home:
          Strings.of(context)!.homeBottomNavigationBar,
      BottomTabItemAfterSignIn.course: Strings.of(context)!.course,
      BottomTabItemAfterSignIn.myLearning: Strings.of(context)!.myLearning,
      BottomTabItemAfterSignIn.setting: Strings.of(context)!.setting,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildBottomTabItem(BottomTabItemAfterSignIn.home, context),
        _buildBottomTabItem(BottomTabItemAfterSignIn.course, context),
        _buildBottomTabItem(BottomTabItemAfterSignIn.myLearning, context),
        _buildBottomTabItem(BottomTabItemAfterSignIn.setting, context),
      ],
      onTap: (index) => onSelectTab(
        BottomTabItemAfterSignIn.values[index],
      ),
      currentIndex: currentTab.index,
      unselectedItemColor: Theme.of(context).brightness == Brightness.dark
          ? AppColor.neutrals.shade300
          : Colors.black54,
      selectedLabelStyle: AppText.text14.copyWith(
        color: AppColor.primary.shade400,
      ),
      selectedItemColor: AppColor.primary.shade400,
    );
  }

  BottomNavigationBarItem _buildBottomTabItem(
    BottomTabItemAfterSignIn item,
    BuildContext context,
  ) {
    return BottomNavigationBarItem(
      icon: currentTab != item ? tabIcon[item]! : tabIconActive[item]!,
      label: nameTabItem(context)[item]!,
      tooltip: "",
    );
  }
}
