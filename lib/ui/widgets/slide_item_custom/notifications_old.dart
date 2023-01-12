import 'package:elearning/ui/widgets/slide_item_custom/controller.dart';
import 'package:flutter/cupertino.dart';

typedef SlideNotificationCallback = void Function(
  SlideNotification notification,
);

@immutable
class SlideNotification {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SlideNotification({
    required this.tag,
  });

  final Object? tag;

  void dispatch(BuildContext context, SlideController controller) {
    final scope = context
        .getElementForInheritedWidgetOfExactType<
            _SlideNotificationListenerScope>()
        ?.widget as _SlideNotificationListenerScope?;

    scope?.state.acceptNotification(controller, this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SlideNotification && other.tag == tag;
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() => 'SlideNotification(tag: $tag)';
}

class SlideRatioNotification extends SlideNotification {
  /// Creates a [SlideRatioNotification].
  const SlideRatioNotification({
    required Object? tag,
    required this.ratio,
  }) : super(tag: tag);

  /// The ratio value of the [SlideController].
  final double ratio;

  @override
  bool operator ==(Object other) {
    return super == other &&
        other is SlideRatioNotification &&
        other.ratio == ratio;
  }

  @override
  int get hashCode => Object.hash(tag, ratio);

  @override
  String toString() => 'SlideRatioNotification(tag: $tag, ratio: $ratio)';
}

/// A widget that listens for [SlideNotification]s bubbling up the tree.
///
/// To dispatch notifications, use the [SlideNotification.dispatch] method.
class SlideNotificationListener extends StatefulWidget {
  /// Creates a [SlideNotificationListener].
  const SlideNotificationListener({
    Key? key,
    this.onNotification,
    this.autoClose = true,
    required this.child,
  })  : assert(
          autoClose || onNotification != null,
          'Either autoClose or onNotification must be set.',
        ),
        super(key: key);

  /// The widget directly below this widget in the tree.
  ///
  /// This is not necessarily the widget that dispatched the notification.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Called when a notification of the appropriate arrives at this location in
  /// the tree.
  final SlideNotificationCallback? onNotification;

  /// Whether to automatically close any [SlideCustomView] with a given tag when
  /// another [SlideCustomView] with the same tag opens.
  final bool autoClose;

  @override
  SlideNotificationListenerState createState() =>
      SlideNotificationListenerState();
}

class SlideNotificationListenerState extends State<SlideNotificationListener> {
  final Map<Object?, SlideController> openControllers =
      <Object?, SlideController>{};

  void acceptNotification(
    SlideController controller,
    SlideNotification notification,
  ) {
    handleNotification(controller, notification);
    widget.onNotification?.call(notification);
  }

  void handleNotification(
    SlideController controller,
    SlideNotification notification,
  ) {
    if (widget.autoClose && !controller.closing) {
      // Automatically close the last controller saved with the same tag.
      final lastOpenController = openControllers[notification.tag];
      if (lastOpenController != null && lastOpenController != controller) {
        lastOpenController.close();
      }
      openControllers[notification.tag] = controller;
    }
  }

  void clearController(SlideController controller, Object? tag) {
    final lastOpenController = openControllers[tag];
    if (lastOpenController == controller) {
      openControllers.remove(tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SlideNotificationListenerScope(
      state: this,
      child: widget.child,
    );
  }
}

class _SlideNotificationListenerScope extends InheritedWidget {
  const _SlideNotificationListenerScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final SlideNotificationListenerState state;

  @override
  bool updateShouldNotify(covariant _SlideNotificationListenerScope oldWidget) {
    return oldWidget.state != state;
  }
}

class SlideNotificationSender extends StatefulWidget {
  const SlideNotificationSender({
    Key? key,
    required this.tag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? tag;
  final SlideController controller;
  final Widget child;

  @override
  SlideNotificationSenderState createState() => SlideNotificationSenderState();
}

class SlideNotificationSenderState extends State<SlideNotificationSender> {
  SlideNotificationListenerState? listenerState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context
        .dependOnInheritedWidgetOfExactType<_SlideNotificationListenerScope>()
        ?.state;
    if (state != listenerState) {
      if (state == null) {
        removeListeners();
      } else if (listenerState == null) {
        addListeners();
      }
      listenerState = state;
    }
  }

  @override
  void dispose() {
    if (listenerState != null) {
      removeListeners();
      listenerState!.clearController(widget.controller, widget.tag);
    }
    super.dispose();
  }

  void addListeners() {
    widget.controller.animation.addListener(handleRatioChanged);
  }

  void removeListeners() {
    widget.controller.animation.removeListener(handleRatioChanged);
  }

  void handleRatioChanged() {
    final controller = widget.controller;
    final notification = SlideRatioNotification(
      tag: widget.tag,
      ratio: controller.ratio,
    );
    listenerState!.acceptNotification(controller, notification);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
