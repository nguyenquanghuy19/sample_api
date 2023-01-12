import 'package:elearning/ui/widgets/slide_item_custom/dismissible_pane_motions.dart';
import 'package:flutter/widgets.dart';

import 'controller.dart';
import 'slide_custom.dart';

const double _kDismissThreshold = 0.75;
const Duration _kDismissalDuration = Duration(milliseconds: 300);
const Duration _kResizeDuration = Duration(milliseconds: 300);

typedef ConfirmDismissCallback = Future<bool> Function();

class DismissiblePane extends StatefulWidget {
  const DismissiblePane({
    Key? key,
    required this.onDismissed,
    this.dismissThreshold = _kDismissThreshold,
    this.dismissalDuration = _kDismissalDuration,
    this.resizeDuration = _kResizeDuration,
    this.confirmDismiss,
    this.closeOnCancel = false,
    this.motion = const InverseDrawerMotion(),
  })  : assert(dismissThreshold > 0 && dismissThreshold < 1),
        super(key: key);

  final double dismissThreshold;
  final Duration dismissalDuration;
  final Duration resizeDuration;
  final ConfirmDismissCallback? confirmDismiss;
  final VoidCallback onDismissed;
  final bool closeOnCancel;
  final Widget motion;

  @override
  DismissiblePaneState createState() => DismissiblePaneState();
}

class DismissiblePaneState extends State<DismissiblePane> {
  SlideController? controller;

  @override
  void initState() {
    super.initState();
    assert(() {
      final slideCustomView =
          context.findAncestorWidgetOfExactType<SlideCustomView>()!;
      if (slideCustomView.key == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            'DismissiblePane created on a SlideCustomView without a Key.',
          ),
          ErrorDescription(
            'The closest SlideCustomView of DismissiblePane has been created without '
            'a Key.\n'
            'The key argument must not be null because SlideCustomView are '
            'commonly used in lists and removed from the list when '
            'dismissed. Without keys, the default behavior is to sync '
            'widgets based on their index in the list, which means the item '
            'after the dismissed item would be synced with the state of the '
            'dismissed item. Using keys causes the widgets to sync according '
            'to their keys and avoids this pitfall.',
          ),
          ErrorHint(
            'To avoid this problem, set the key of the enclosing Slidable '
            'widget.',
          ),
        ]);
      }

      return true;
    }());
    controller = SlideCustomView.of(context);
    controller!.dismissGesture.addListener(handleDismissGestureChanged);
  }

  @override
  void dispose() {
    controller!.dismissGesture.removeListener(handleDismissGestureChanged);
    super.dispose();
  }

  Future<void> handleDismissGestureChanged() async {
    final endGesture = controller!.dismissGesture.value!.endGesture;
    final position = controller!.animation.value;

    if (endGesture is OpeningGesture ||
        endGesture is StillGesture && position >= widget.dismissThreshold) {
      bool canDismiss = true;
      if (widget.confirmDismiss != null) {
        canDismiss = await widget.confirmDismiss!();
      }
      if (canDismiss) {
        controller!.dismiss(
          ResizeRequest(widget.resizeDuration, widget.onDismissed),
          duration: widget.dismissalDuration,
        );
      } else if (widget.closeOnCancel) {
        controller!.close();
      }

      return;
    }

    controller!.openCurrentActionPane();
  }

  @override
  Widget build(BuildContext context) {
    return widget.motion;
  }
}
