import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
    required TabController tabController,
    required this.onTap,
    this.tabs = const [],
    required this.hasLabelPadding,
    required this.isScrollable,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final Function(int) onTap;
  final List<Tab> tabs;
  final bool hasLabelPadding;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(bottom: 10),
      height: 60,
      decoration: Theme.of(context).brightness == Brightness.dark
          ? const BoxDecoration(
              color: Colors.black45,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.5,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  color: Colors.grey,
                ),
              ],
            )
          : const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.5,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  color: Colors.grey,
                ),
              ],
            ),
      child: TabBar(
        isScrollable: isScrollable
            ? MediaQuery.of(context).size.width > 450
                ? false
                : true
            : false,
        unselectedLabelColor: AppColor.neutrals.shade800,
        indicatorColor: AppColor.primary.shade400,
        indicatorWeight: 4,
        labelColor: AppColor.primary.shade400,
        tabs: tabs,
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppText.text18.copyWith(fontWeight: FontWeight.w700),
        unselectedLabelStyle: AppText.text18,
        labelPadding:
            hasLabelPadding ? const EdgeInsets.symmetric(horizontal: 16) : null,
        onTap: (index) {
          onTap(index);
        },
      ),
    );
  }
}
