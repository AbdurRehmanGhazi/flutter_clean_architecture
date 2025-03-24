import 'package:flutter/material.dart';
import 'dart:math' as math;

class RectSliderThumbShape extends SliderComponentShape {
  final double width;
  const RectSliderThumbShape({required this.width});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, 0);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    assert(sliderTheme.thumbColor != null);

    final rect =
    Rect.fromCenter(center: center, width: width, height: 12);
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(width / 2)),
      Paint()..color = sliderTheme.thumbColor!,
    );
  }
}