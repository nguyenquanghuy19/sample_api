import 'package:flutter/widgets.dart';

/// Used to dispatch a Slidable notification.
class SlideGroupNotification {
  const SlideGroupNotification._();

  /// Creates a dispatcher used to dispatch the [notification] to the closest
  /// [SlideGroupBehavior] with the given type.
  ///
  /// [assertParentExists] is only used internally to not throws an assertion
  /// error if there are no [SlideGroupBehavior]s in the tree.
  ///
  /// It can be useful to call this method instead of [dispatch] in case you
  /// want to send a last notification before disposing a StatefulWidget.
  static SlideGroupNotificationDispatcher<T>? createDispatcher<T>(
    BuildContext context, {
    bool assertParentExists = true,
  }) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedSlideNotification<T>>()
        ?.widget as _InheritedSlideNotification<T>?;

    assert(() {
      if (assertParentExists && widget == null) {
        throw FlutterError(
          'SlideGroupBehavior.of<$T> called with a context that '
          'does not contain a SlideGroupBehavior<$T>.',
        );
      }

      return true;
    }());
    if (widget != null) {
      return SlideGroupNotificationDispatcher<T>._(widget);
    }

    return null;
  }

  /// Dispatches the [notification] to the closest [SlideGroupBehavior] with
  /// the given type.
  ///
  /// [assertParentExists] is only used internally to not throws an assertion
  /// error if there are no [SlideGroupBehavior]s in the tree.
  static void dispatch<T>(
    BuildContext context,
    T notification, {
    bool assertParentExists = true,
  }) {
    final dispatcher = createDispatcher<T>(
      context,
      assertParentExists: assertParentExists,
    );
    dispatcher?.dispatch(notification);
  }
}

/// A dispatcher used to dispatch a SlideCustomView notification.
class SlideGroupNotificationDispatcher<T> {
  SlideGroupNotificationDispatcher._(this._inheritedSlideNotification);

  final _InheritedSlideNotification<T> _inheritedSlideNotification;

  /// Dispatches the [notification] to the closest [SlideGroupBehavior] with
  /// the given type.
  ///
  /// [assertParentExists] is only used internally to not throws an assertion
  /// error if there are no [SlideGroupBehavior]s in the tree.
  void dispatch(T notification) {
    final notifier = _inheritedSlideNotification.notifier;
    final onNotification = _inheritedSlideNotification.onNotification;
    final effectiveNotification =
        onNotification != null ? onNotification(notification) : notification;

    if (effectiveNotification != null) {
      notifier.value = effectiveNotification;
    }
  }
}

/// A widget which can dispatch notifications to a group of [SlideCustomView] below it.
class SlideGroupBehavior<T> extends StatefulWidget {
  /// Creates a SlideGroupBehavior.
  const SlideGroupBehavior({
    Key? key,
    this.onNotification,
    required this.child,
  }) : super(key: key);

  /// Callback that can modified a notification before to be dispatched to
  /// listeners.
  ///
  /// If the result if null, then the notification is not dispatched.
  final T? Function(T notification)? onNotification;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  SlideGroupBehaviorState<T> createState() => SlideGroupBehaviorState<T>();
}

class SlideGroupBehaviorState<T> extends State<SlideGroupBehavior<T>> {
  final valueNotifier = ValueNotifier<T?>(null);

  @override
  Widget build(BuildContext context) {
    return _InheritedSlideNotification(
      onNotification: widget.onNotification,
      notifier: valueNotifier,
      child: widget.child,
    );
  }
}

class _InheritedSlideNotification<T> extends InheritedWidget {
  const _InheritedSlideNotification({
    Key? key,
    required this.onNotification,
    required this.notifier,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final T? Function(T notification)? onNotification;
  final ValueNotifier<T?> notifier;

  static ValueNotifier<T?>? of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedSlideNotification<T>>()
        ?.notifier;
  }

  @override
  bool updateShouldNotify(_InheritedSlideNotification<T> oldWidget) {
    return oldWidget.notifier != notifier;
  }
}

/// A widget which listens to notifications dispatched by a
/// [SlideGroupBehavior] of the same type.
///
/// Typically this widget is a child of a [SlideCustomView] widget.
class SlideGroupBehaviorListener<T> extends StatefulWidget {
  /// Creates a [SlideGroupBehaviorListener].
  const SlideGroupBehaviorListener({
    Key? key,
    required this.onNotification,
    required this.child,
  }) : super(key: key);

  /// The callback to invoke when a notification is dispatched.
  final ValueChanged<T> onNotification;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<SlideGroupBehaviorListener<T>> createState() =>
      _SlideGroupBehaviorListenerState<T>();
}

class _SlideGroupBehaviorListenerState<T>
    extends State<SlideGroupBehaviorListener<T>> {
  ValueNotifier<T?>? notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final oldNotifier = notifier;
    final newNotifier = _InheritedSlideNotification.of<T>(context);
    if (oldNotifier != newNotifier) {
      if (oldNotifier != null) {
        oldNotifier.removeListener(handleNotification);
      }
      if (newNotifier != null) {
        newNotifier.addListener(handleNotification);
      }
      notifier = newNotifier;
    }
  }

  @override
  void dispose() {
    notifier?.removeListener(handleNotification);
    super.dispose();
  }

  void handleNotification() {
    final notification = notifier?.value;
    if (notification != null) {
      widget.onNotification(notification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
