import 'package:flutter/material.dart';

class GradientBoxBorder extends BoxBorder {
  final Gradient gradient;
  final double width;

  const GradientBoxBorder({required this.gradient, required this.width});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  BoxBorder scale(double t) {
    return GradientBoxBorder(
      gradient: gradient,
      width: width * t,
    );
  }

  @override
  BorderSide get top => throw UnimplementedError();
  @override
  BorderSide get bottom => throw UnimplementedError();

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    if (shape == BoxShape.rectangle) {
      if (borderRadius != null) {
        final RRect rRect = RRect.fromRectAndCorners(
          rect,
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        );
        canvas.drawRRect(rRect, paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    } else if (shape == BoxShape.circle) {
      final Offset center = rect.center;
      final double radius = rect.shortestSide / 2;
      canvas.drawCircle(center, radius, paint);
    }
  }
}