import 'package:flutter/widgets.dart';

import 'flex_exit_transition.dart';
import 'slide_custom.dart';

/// A [DismissiblePane] motion which will make the furthest action grows faster
/// as the [SlideCustomView] dismisses.
class InverseDrawerMotion extends StatelessWidget {
  /// Creates a [InverseDrawerMotion].
  const InverseDrawerMotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context)!;
    final controller = SlideCustomView.of(context)!;
    final animation = controller.animation
        .drive(CurveTween(curve: Interval(paneData.extentRatio, 1)));

    return FlexExitTransition(
      mainAxisExtent: animation,
      initialExtentRatio: paneData.extentRatio,
      direction: paneData.direction,
      startToEnd: paneData.fromStart,
      children: paneData.children,
    );
  }
}
