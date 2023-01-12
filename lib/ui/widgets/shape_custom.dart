import 'package:flutter/material.dart';

class ShapeCustom extends ShapeBorder {
  final bool usePadding;

  const ShapeCustom({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(
        bottom: usePadding ? 12 : 0,
      );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 13));
    Path p1 = Path()
      ..moveTo(rect.bottomLeft.dx + 0, rect.bottomCenter.dy)
      ..relativeLineTo(0, 10)
      ..relativeLineTo(10, -10)
      ..close();

    Path p2 = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: const Radius.circular(5),
          bottomRight: const Radius.circular(5),
          topRight: const Radius.circular(5),
        ),
      )
      ..close();

    return Path.combine(PathOperation.union, p1, p2);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
