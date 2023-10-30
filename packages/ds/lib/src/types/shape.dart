import 'package:flutter/material.dart';

class ShapeStyleData {
  const ShapeStyleData({
    required this.borderRadius,
    this.padding,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.backgroundColor,
  });

  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;
  final Color borderColor;
  final Color? backgroundColor;
}
