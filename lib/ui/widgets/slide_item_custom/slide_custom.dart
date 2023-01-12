import 'package:elearning/ui/widgets/slide_item_custom/action_pane_configuration.dart';
import 'package:elearning/ui/widgets/slide_item_custom/auto_close_behavior.dart';
import 'package:elearning/ui/widgets/slide_item_custom/controller.dart';
import 'package:elearning/ui/widgets/slide_item_custom/dismissal.dart';
import 'package:elearning/ui/widgets/slide_item_custom/gesture_detector.dart';
import 'package:elearning/ui/widgets/slide_item_custom/notifications_old.dart';
import 'package:elearning/ui/widgets/slide_item_custom/scrolling_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

part 'action_pane.dart';

/// A widget which can be dragged to reveal contextual actions.
class SlideCustomView extends StatefulWidget {
  /// Creates a [SlideCustomView].
  ///
  /// The [enabled], [closeOnScroll], [direction], [dragStartBehavior],
  /// [useTextDirection] and [child] arguments must not be null.
  const SlideCustomView({
    Key? key,
    this.groupTag,
    this.enabled = true,
    this.closeOnScroll = true,
    this.startActionPane,
    this.endActionPane,
    this.direction = Axis.horizontal,
    this.dragStartBehavior = DragStartBehavior.down,
    this.useTextDirection = true,
    required this.child,
  }) : super(key: key);

  final bool enabled;
  final bool closeOnScroll;
  final Object? groupTag;
  final ActionPane? startActionPane;
  final ActionPane? endActionPane;
  final Axis direction;
  final bool useTextDirection;
  final DragStartBehavior dragStartBehavior;
  final Widget child;

  @override
  SlideCustomViewState createState() => SlideCustomViewState();

  static SlideController? of(BuildContext context) {
    final scope = context
        .getElementForInheritedWidgetOfExactType<
            _SlideCustomViewControllerScope>()
        ?.widget as _SlideCustomViewControllerScope?;

    return scope?.controller;
  }
}

class SlideCustomViewState extends State<SlideCustomView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final SlideController controller;
  late Animation<Offset> moveAnimation;
  late bool keepPanesOrder;

  @override
  bool get wantKeepAlive => !widget.closeOnScroll;

  @override
  void initState() {
    super.initState();
    controller = SlideController(this)
      ..actionPaneType.addListener(handleActionPanelTypeChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateIsLeftToRight();
    updateController();
    updateMoveAnimation();
  }

  @override
  void didUpdateWidget(covariant SlideCustomView oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateIsLeftToRight();
    updateController();
  }

  @override
  void dispose() {
    controller.actionPaneType.removeListener(handleActionPanelTypeChanged);
    controller.dispose();
    super.dispose();
  }

  void updateController() {
    controller
      ..enableStartActionPane = startActionPane != null
      ..startActionPaneExtentRatio = startActionPane?.extentRatio ?? 0;

    controller
      ..enableEndActionPane = endActionPane != null
      ..endActionPaneExtentRatio = endActionPane?.extentRatio ?? 0;
  }

  void updateIsLeftToRight() {
    final textDirection = Directionality.of(context);
    controller.isLeftToRight = widget.direction == Axis.vertical ||
        !widget.useTextDirection ||
        textDirection == TextDirection.ltr;
  }

  void handleActionPanelTypeChanged() {
    setState(() {
      updateMoveAnimation();
    });
  }

  void updateMoveAnimation() {
    final double end = controller.direction.value.toDouble();
    moveAnimation = controller.animation.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: widget.direction == Axis.horizontal
            ? Offset(end, 0)
            : Offset(0, end),
      ),
    );
  }

  Widget? get actionPane {
    switch (controller.actionPaneType.value) {
      case ActionPaneType.start:
        return startActionPane;
      case ActionPaneType.end:
        return endActionPane;
      default:
        return null;
    }
  }

  ActionPane? get startActionPane => widget.startActionPane;

  ActionPane? get endActionPane => widget.endActionPane;

  Alignment get actionPaneAlignment {
    final sign = controller.direction.value.toDouble();

    return widget.direction == Axis.horizontal
        ? Alignment(-sign, 0)
        : Alignment(0, -sign);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    Widget content = SlideTransition(
      position: moveAnimation,
      child: SlideAutoCloseBehaviorInteractive(
        groupTag: widget.groupTag,
        controller: controller,
        child: widget.child,
      ),
    );

    content = Stack(
      children: <Widget>[
        if (actionPane != null)
          Positioned.fill(
            child: ClipRect(
              clipper: _SlideCustomViewClipper(
                axis: widget.direction,
                controller: controller,
              ),
              child: actionPane,
            ),
          ),
        content,
      ],
    );

    return SlideGestureDetector(
      enabled: widget.enabled,
      controller: controller,
      direction: widget.direction,
      dragStartBehavior: widget.dragStartBehavior,
      child: SlideNotificationSender(
        tag: widget.groupTag,
        controller: controller,
        child: SlideScrollingBehavior(
          controller: controller,
          closeOnScroll: widget.closeOnScroll,
          child: SlideDismissal(
            axis: flipAxis(widget.direction),
            controller: controller,
            child: ActionPaneConfiguration(
              alignment: actionPaneAlignment,
              direction: widget.direction,
              isStartActionPane:
                  controller.actionPaneType.value == ActionPaneType.start,
              child: _SlideCustomViewControllerScope(
                controller: controller,
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SlideCustomViewControllerScope extends InheritedWidget {
  const _SlideCustomViewControllerScope({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final SlideController? controller;

  @override
  bool updateShouldNotify(_SlideCustomViewControllerScope old) {
    return controller != old.controller;
  }
}

class _SlideCustomViewClipper extends CustomClipper<Rect> {
  _SlideCustomViewClipper({
    required this.axis,
    required this.controller,
  }) : super(reclip: controller.animation);

  final Axis axis;
  final SlideController controller;

  @override
  Rect getClip(Size size) {
    switch (axis) {
      case Axis.horizontal:
        final double offset = controller.ratio * size.width;
        if (offset < 0) {
          return Rect.fromLTRB(size.width + offset, 0, size.width, size.height);
        }
        return Rect.fromLTRB(0, 0, offset, size.height);
      case Axis.vertical:
        final double offset = controller.ratio * size.height;
        if (offset < 0) {
          return Rect.fromLTRB(
            0,
            size.height + offset,
            size.width,
            size.height,
          );
        }
        return Rect.fromLTRB(0, 0, size.width, offset);
    }
  }

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  @override
  bool shouldReclip(_SlideCustomViewClipper oldClipper) {
    return oldClipper.axis != axis;
  }
}
