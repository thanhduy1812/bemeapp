import 'package:flutter/material.dart';

class GtdTooltipShape extends ShapeBorder {
  final bool usePadding;

  const GtdTooltipShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)))
      ..moveTo(rect.bottomRight.dx - 40, rect.bottomRight.dy)
      ..relativeLineTo(4, 8)
      ..relativeLineTo(4, -8)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
