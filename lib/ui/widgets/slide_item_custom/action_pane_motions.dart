import 'package:flutter/widgets.dart';

import 'flex_entrance_transition.dart';
import 'slide_custom.dart';

class BehindMotion extends StatelessWidget {
  const BehindMotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context)!;

    return Flex(
      direction: paneData.direction,
      children: paneData.children,
    );
  }
}

class StretchMotion extends StatelessWidget {
  const StretchMotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context);
    final controller = SlideCustomView.of(context)!;

    return AnimatedBuilder(
      animation: controller.animation,
      builder: (BuildContext context, Widget? child) {
        final value = controller.animation.value / paneData!.extentRatio;

        return FractionallySizedBox(
          alignment: paneData.alignment,
          widthFactor: paneData.direction == Axis.horizontal ? value : 1,
          heightFactor: paneData.direction == Axis.horizontal ? 1 : value,
          child: child,
        );
      },
      child: const BehindMotion(),
    );
  }
}

/// An [ActionPane] motion which reveals actions as if they were scrolling
/// from the outside.
class ScrollMotion extends StatelessWidget {
  const ScrollMotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context)!;
    final controller = SlideCustomView.of(context)!;

    // Each child starts just outside of the SlideCustomView.
    final startOffset = Offset(paneData.alignment.x, paneData.alignment.y);

    final animation = controller.animation
        .drive(CurveTween(curve: Interval(0, paneData.extentRatio)))
        .drive(Tween(begin: startOffset, end: Offset.zero));

    return SlideTransition(
      position: animation,
      child: const BehindMotion(),
    );
  }
}

/// An [ActionPane] motion which reveals actions as if they were drawers.
class DrawerMotion extends StatelessWidget {
  const DrawerMotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context)!;
    final controller = SlideCustomView.of(context)!;
    final animation = controller.animation
        .drive(CurveTween(curve: Interval(0, paneData.extentRatio)));

    return FlexEntranceTransition(
      mainAxisPosition: animation,
      direction: paneData.direction,
      startToEnd: paneData.fromStart,
      children: paneData.children,
    );
  }
}
