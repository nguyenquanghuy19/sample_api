import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpandable extends StatefulWidget {
  final Widget? child;
  final Widget header;
  final bool hasIcon;
  final bool canTap;
  final bool isTopLecture;
  final bool isShowIconDown;
  final double paddingHeader;
  final bool expanded;
  final Function() onTap;

  const CustomExpandable({
    Key? key,
    this.child,
    required this.header,
    this.hasIcon = true,
    this.canTap = true,
    this.isTopLecture = true,
    this.isShowIconDown = true,
    this.paddingHeader = 0,
    this.expanded = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomExpandable> createState() => _CustomExpandableState();
}

class _CustomExpandableState extends State<CustomExpandable>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expanded;
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (_isExpanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(CustomExpandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isExpanded = widget.expanded;
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.canTap
              ? () {
                  widget.onTap();
                  setState(() {
                    _isExpanded = !_isExpanded;
                    _runExpandCheck();
                  });
                }
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.paddingHeader),
            child: Row(
              children: [
                Expanded(child: widget.header),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(expandController),
                  child: widget.isShowIconDown
                      ? Tab(
                          child: SvgPicture.asset(
                            Images.iconArrowDown,
                            width: 16,
                            color: widget.isTopLecture
                                ? AppColor.primary.shade400
                                : AppColor.neutrals.shade800,
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: widget.child,
        ),
      ],
    );
  }
}
