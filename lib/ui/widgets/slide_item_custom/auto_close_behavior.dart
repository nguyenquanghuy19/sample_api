import 'package:elearning/ui/widgets/slide_item_custom/controller.dart';
import 'package:elearning/ui/widgets/slide_item_custom/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

/// A widget that forces the [SlideCustomView] widgets below it to close when another
/// [SlideCustomView] widget with the same [groupTag] opens.
class SlideAutoCloseBehavior extends StatefulWidget {
  /// Creates a [SlideAutoCloseBehavior].
  const SlideAutoCloseBehavior({
    Key? key,
    this.closeWhenOpened = true,
    this.closeWhenTapped = true,
    required this.child,
  }) : super(key: key);

  /// Indicates whether all the [SlideCustomView] within the same group should be
  /// closed when one of the group is opened.
  ///
  /// Defaults to true.
  final bool closeWhenOpened;

  /// Indicates whether all the [SlideCustomView] within the same group should be
  /// closed when one of the group is tapped while one is opened.
  ///
  /// Defaults to true.
  final bool closeWhenTapped;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<SlideAutoCloseBehavior> createState() => _SlideAutoCloseBehaviorState();
}

class _SlideAutoCloseBehaviorState extends State<SlideAutoCloseBehavior> {
  final Map<Object?, int> openSlide = {};

  @override
  Widget build(BuildContext context) {
    return _SlideAutoCloseData(
      closeWhenOpened: widget.closeWhenOpened,
      closeWhenTapped: widget.closeWhenTapped,
      child: SlideGroupBehavior<SlideAutoCloseNotification>(
        child: SlideGroupBehavior<SlideAutoCloseBarrierNotification>(
          onNotification: (notification) {
            final key = notification.groupTag;
            final previousOpenForThatTag = openSlide.putIfAbsent(key, () => 0);
            final openForThatTag =
                previousOpenForThatTag + (notification.enabled ? 1 : -1);
            openSlide[key] = openForThatTag;
            if (openForThatTag == 0 || previousOpenForThatTag == 0) {
              return notification;
            }

            return null;
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _SlideAutoCloseData extends InheritedWidget {
  const _SlideAutoCloseData({
    Key? key,
    required this.closeWhenOpened,
    required this.closeWhenTapped,
    required Widget child,
  }) : super(key: key, child: child);

  final bool closeWhenOpened;
  final bool closeWhenTapped;

  @override
  bool updateShouldNotify(_SlideAutoCloseData oldWidget) {
    return oldWidget.closeWhenOpened != closeWhenOpened ||
        oldWidget.closeWhenTapped != closeWhenTapped;
  }

  static _SlideAutoCloseData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_SlideAutoCloseData>();
  }
}

/// INTERNAL USE
class SlideAutoCloseBehaviorInteractive extends StatelessWidget {
  /// INTERNAL USE
  const SlideAutoCloseBehaviorInteractive({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideAutoCloseInteractive(
      groupTag: groupTag,
      controller: controller,
      child: SlideAutoCloseBarrierInteractive(
        groupTag: groupTag,
        controller: controller,
        child: child,
      ),
    );
  }
}

/// A notification used to close other [SlideCustomView] widgets with the same
/// [groupTag].
@immutable
class SlideAutoCloseNotification {
  /// Creates a notification that can be used to close other [SlideCustomView] widgets
  /// with the same [groupTag].
  const SlideAutoCloseNotification({
    required this.groupTag,
    required this.controller,
    this.closeSelf = false,
  });

  final Object? groupTag;
  final SlideController controller;
  final bool closeSelf;
}

/// INTERNAL USE
class SlideAutoCloseInteractive extends StatelessWidget {
  /// INTERNAL USE
  const SlideAutoCloseInteractive({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideAutoCloseNotificationSender(
      groupTag: groupTag,
      controller: controller,
      child: SlideAutoCloseBehaviorListener(
        groupTag: groupTag,
        controller: controller,
        child: child,
      ),
    );
  }
}

/// INTERNAL USE
class SlideAutoCloseBehaviorListener extends StatelessWidget {
  /// INTERNAL USE
  const SlideAutoCloseBehaviorListener({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideGroupBehaviorListener<SlideAutoCloseNotification>(
      onNotification: (SlideAutoCloseNotification notification) {
        if (groupTag == notification.groupTag &&
            (notification.closeSelf || notification.controller != controller) &&
            !controller.closing) {
          controller.close();
        }
      },
      child: child,
    );
  }
}

/// INTERNAL USE
class SlideAutoCloseNotificationSender extends StatelessWidget {
  /// INTERNAL USE
  const SlideAutoCloseNotificationSender({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  void _handleStatusChanged(BuildContext context, AnimationStatus status) {
    final moving =
        status == AnimationStatus.forward || status == AnimationStatus.reverse;
    if (moving && !controller.closing) {
      SlideGroupNotification.dispatch(
        context,
        SlideAutoCloseNotification(
          groupTag: groupTag,
          controller: controller,
        ),
        assertParentExists: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SlideNotificationSender(
      controller: controller,
      onStatusChanged: (status) => _handleStatusChanged(context, status),
      enabled: _SlideAutoCloseData.of(context)?.closeWhenOpened ?? false,
      child: child,
    );
  }
}

/// A notification used to indicate if a barrier should be pub on [SlideCustomView]
@immutable
class SlideAutoCloseBarrierNotification {
  /// Creates a notification to activate/deactivate the barrier on [SlideCustomView]
  /// widgets.
  const SlideAutoCloseBarrierNotification({
    required this.groupTag,
    required this.controller,
    this.enabled = false,
  });

  final Object? groupTag;
  final SlideController controller;
  final bool enabled;
}

/// INTERNAL USE
class SlideAutoCloseBarrierInteractive extends StatelessWidget {
  /// INTERNAL USE
  const SlideAutoCloseBarrierInteractive({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideAutoCloseBarrierNotificationSender(
      groupTag: groupTag,
      controller: controller,
      child: SlideAutoCloseBarrierBehaviorListener(
        groupTag: groupTag,
        controller: controller,
        child: child,
      ),
    );
  }
}

/// INTERNAL USE
class SlideAutoCloseBarrierNotificationSender extends StatefulWidget {
  /// INTERNAL USE
  const SlideAutoCloseBarrierNotificationSender({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  State<SlideAutoCloseBarrierNotificationSender> createState() =>
      _SlideAutoCloseBarrierNotificationSenderState();
}

class _SlideAutoCloseBarrierNotificationSenderState
    extends State<SlideAutoCloseBarrierNotificationSender> {
  SlideGroupNotificationDispatcher? dispatcher;

  void _handleStatusChanged(AnimationStatus status) {
    //TODO(romain): There is a bug if more than one try to open at the same time.
    final willBarrierBeEnabled = status != AnimationStatus.dismissed;
    final barrierEnabled = dispatcher != null;
    if (willBarrierBeEnabled != barrierEnabled) {
      dispatcher = SlideGroupNotification.createDispatcher<
          SlideAutoCloseBarrierNotification>(
        context,
        assertParentExists: false,
      );
      dispatchSlideAutoCloseBarrierNotification(
        enabled: willBarrierBeEnabled,
      );
      if (!willBarrierBeEnabled) {
        // We can set the dispatcher to null because we won't need it anymore.
        dispatcher = null;
      }
    }
  }

  void dispatchSlideAutoCloseBarrierNotification({required bool enabled}) {
    final notification = SlideAutoCloseBarrierNotification(
      groupTag: widget.groupTag,
      controller: widget.controller,
      enabled: enabled,
    );
    dispatcher?.dispatch(notification);
  }

  @override
  void dispose() {
    if (dispatcher != null) {
      // If we still have a dispatcher, it means that this widget was disposed
      // while the barrier was still enabled for this group.
      // We need to release the barrier.

      // In Flutter 3, [SchedulerBinding.instance] is not nullable, but since
      // we want to support Flutter 2, this is a simple way to do it without
      // having a build warning.
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final SchedulerBinding? schedulerBinding = SchedulerBinding.instance;
      schedulerBinding?.addPostFrameCallback((Duration _) {
        // We call it in the next frame to avoid to rebuild a widget that is
        // already rebuilding.
        dispatchSlideAutoCloseBarrierNotification(enabled: false);
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SlideNotificationSender(
      controller: widget.controller,
      onStatusChanged: _handleStatusChanged,
      enabled: _SlideAutoCloseData.of(context)?.closeWhenTapped ?? false,
      child: widget.child,
    );
  }
}

/// INTERNAL USE
class SlideAutoCloseBarrierBehaviorListener extends StatefulWidget {
  /// INTERNAL USE
  const SlideAutoCloseBarrierBehaviorListener({
    Key? key,
    required this.groupTag,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Object? groupTag;
  final SlideController controller;
  final Widget child;

  @override
  SlideAutoCloseBarrierBehaviorListenerState createState() =>
      SlideAutoCloseBarrierBehaviorListenerState();
}

class SlideAutoCloseBarrierBehaviorListenerState
    extends State<SlideAutoCloseBarrierBehaviorListener> {
  bool absorbing = false;

  void handleOnTap() {
    if (!widget.controller.closing) {
      SlideGroupNotification.dispatch(
        context,
        SlideAutoCloseNotification(
          groupTag: widget.groupTag,
          controller: widget.controller,
          closeSelf: true,
        ),
        assertParentExists: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideGroupBehaviorListener<SlideAutoCloseBarrierNotification>(
      onNotification: (SlideAutoCloseBarrierNotification notification) {
        if (widget.groupTag == notification.groupTag) {
          if (mounted) {
            setState(() {
              absorbing = notification.enabled;
            });
          }
        }
      },
      child: GestureDetector(
        onTap: absorbing ? handleOnTap : null,
        child: AbsorbPointer(
          absorbing: absorbing,
          child: widget.child,
        ),
      ),
    );
  }
}

/// INTERNAL USE
class _SlideNotificationSender extends StatefulWidget {
  /// INTERNAL USE
  const _SlideNotificationSender({
    Key? key,
    required this.controller,
    required this.onStatusChanged,
    required this.enabled,
    required this.child,
  }) : super(key: key);

  final SlideController controller;

  final AnimationStatusListener onStatusChanged;

  final Widget child;

  final bool enabled;

  @override
  _SlideNotificationSenderState createState() =>
      _SlideNotificationSenderState();
}

class _SlideNotificationSenderState extends State<_SlideNotificationSender> {
  @override
  void initState() {
    super.initState();
    addListeners(widget);
  }

  @override
  void didUpdateWidget(_SlideNotificationSender oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller ||
        oldWidget.onStatusChanged != widget.onStatusChanged) {
      removeListeners(oldWidget);
      addListeners(widget);
    }
  }

  @override
  void dispose() {
    removeListeners(widget);
    super.dispose();
  }

  void handleStatusChanged(AnimationStatus status) {
    if (widget.enabled) {
      widget.onStatusChanged(status);
    }
  }

  void addListeners(_SlideNotificationSender widget) {
    widget.controller.animation.addStatusListener(handleStatusChanged);
  }

  void removeListeners(_SlideNotificationSender widget) {
    widget.controller.animation.addStatusListener(handleStatusChanged);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
