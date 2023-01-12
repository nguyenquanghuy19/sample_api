import 'package:flutter/widgets.dart';

import 'controller.dart';

// INTERNAL USE
// ignore_for_file: public_member_api_docs

class SlideScrollingBehavior extends StatefulWidget {
  const SlideScrollingBehavior({
    Key? key,
    required this.controller,
    this.closeOnScroll = true,
    required this.child,
  }) : super(key: key);

  final SlideController controller;

  final bool closeOnScroll;
  final Widget child;

  @override
  SlideScrollingBehaviorState createState() => SlideScrollingBehaviorState();
}

class SlideScrollingBehaviorState extends State<SlideScrollingBehavior> {
  ScrollPosition? scrollPosition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    removeScrollingNotifierListener();
    addScrollingNotifierListener();
  }

  @override
  void didUpdateWidget(covariant SlideScrollingBehavior oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.closeOnScroll != widget.closeOnScroll) {
      removeScrollingNotifierListener();
      addScrollingNotifierListener();
    }
  }

  @override
  void dispose() {
    removeScrollingNotifierListener();
    super.dispose();
  }

  void addScrollingNotifierListener() {
    if (widget.closeOnScroll) {
      scrollPosition = Scrollable.of(context)?.position;
      if (scrollPosition != null) {
        scrollPosition!.isScrollingNotifier.addListener(handleScrollingChanged);
      }
    }
  }

  void removeScrollingNotifierListener() {
    scrollPosition?.isScrollingNotifier.removeListener(handleScrollingChanged);
  }

  void handleScrollingChanged() {
    if (widget.closeOnScroll &&
        scrollPosition != null &&
        scrollPosition!.isScrollingNotifier.value) {
      widget.controller.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
