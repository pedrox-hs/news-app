import 'package:flutter/painting.dart';

class ShapeData {
  const ShapeData({
    required this.padding,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
    required this.backgroundColor,
  });

  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
}
