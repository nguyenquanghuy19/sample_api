import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBeforeSignInWidget extends StatelessWidget {
  BottomNavigationBeforeSignInWidget({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  final BottomTabItemBeforeSignIn currentTab;
  final ValueChanged<BottomTabItemBeforeSignIn> onSelectTab;

  final Map<BottomTabItemBeforeSignIn, Widget> tabIcon = {
    BottomTabItemBeforeSignIn.home: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconHome),
    ),
    BottomTabItemBeforeSignIn.course: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconCourse),
    ),
    BottomTabItemBeforeSignIn.setting: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconSetting),
    ),
  };

  final Map<BottomTabItemBeforeSignIn, Widget> tabIconActive = {
    BottomTabItemBeforeSignIn.home: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(Images.iconHomeActive),
    ),
    BottomTabItemBeforeSignIn.course: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(
        Images.iconCourseActive,
      ),
    ),
    BottomTabItemBeforeSignIn.setting: Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SvgPicture.asset(
        Images.iconSettingActive,
      ),
    ),
  };

  Map<BottomTabItemBeforeSignIn, String> nameTabItem(BuildContext context) {
    return {
      BottomTabItemBeforeSignIn.home:
          Strings.of(context)!.homeBottomNavigationBar,
      BottomTabItemBeforeSignIn.course: Strings.of(context)!.course,
      BottomTabItemBeforeSignIn.setting: Strings.of(context)!.setting,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildBottomTabItem(BottomTabItemBeforeSignIn.home, context),
        _buildBottomTabItem(BottomTabItemBeforeSignIn.course, context),
        _buildBottomTabItem(BottomTabItemBeforeSignIn.setting, context),
      ],
      onTap: (index) => onSelectTab(
        BottomTabItemBeforeSignIn.values[index],
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
    BottomTabItemBeforeSignIn item,
    BuildContext context,
  ) {
    return BottomNavigationBarItem(
      icon: currentTab != item ? tabIcon[item]! : tabIconActive[item]!,
      label: nameTabItem(context)[item]!,
      tooltip: "",
    );
  }
}
