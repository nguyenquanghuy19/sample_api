import 'package:flutter/material.dart';

import 'slide_custom.dart';

/// Signature for [SlideCustomViewAction.onPressed].
typedef SlideCustomViewActionCallback = void Function(BuildContext context);

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

/// Represents an action of an [ActionPane].
class SlideCustomViewAction extends StatelessWidget {
  /// Creates a [SlideCustomViewAction].
  ///
  /// The [flex], [backgroundColor], [autoClose] and [child] arguments must not
  /// be null.
  ///
  /// The [flex] argument must also be greater than 0.
  const SlideCustomViewAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    required this.onPressed,
    required this.child,
  })  : assert(flex > 0),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlideCustomViewActionCallback? onPressed;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveForegroundColor = foregroundColor ??
        (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                Brightness.light
            ? Colors.black
            : Colors.white);

    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: OutlinedButton(
          onPressed: () => _handleTap(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: effectiveForegroundColor,
            padding: padding,
            backgroundColor: backgroundColor,
            disabledForegroundColor: effectiveForegroundColor.withOpacity(0.38),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide.none,
          ),
          child: child,
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      SlideCustomView.of(context)?.close();
    }
  }
}

/// An action for [SlideAction] which can show an icon, a label, or both.
class SlideAction extends StatelessWidget {
  /// Creates a [SlideAction].
  ///
  /// The [flex], [backgroundColor], [autoClose] and [spacing] arguments
  /// must not be null.
  ///
  /// You must set either an [icon] or a [label].
  ///
  /// The [flex] argument must also be greater than 0.
  const SlideAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    required this.onPressed,
    this.icon,
    this.spacing = 4,
    this.label,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.textStyle,
  })  : assert(flex > 0),
        assert(icon != null || label != null),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlideCustomViewActionCallback? onPressed;
  final Widget? icon;
  final double spacing;
  final String? label;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        icon!,
      );
    }

    if (label != null) {
      if (children.isNotEmpty) {
        children.add(
          SizedBox(height: spacing),
        );
      }

      children.add(
        Text(
          label!,
          overflow: TextOverflow.ellipsis,
          style: textStyle,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children.map(
                (child) => Flexible(
                  child: child,
                ),
              ),
            ],
          );

    return SlideCustomViewAction(
      borderRadius: borderRadius,
      padding: padding,
      onPressed: onPressed,
      autoClose: autoClose,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}
