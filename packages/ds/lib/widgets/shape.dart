import 'package:ds/types/shape.dart';
import 'package:flutter/widgets.dart';

class Shape extends StatelessWidget {
  const Shape({
    required this.shape,
    required this.child,
    super.key,
  });

  final ShapeData shape;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: shape.borderRadius,
        border: Border.all(
          width: shape.borderWidth,
          color: shape.borderColor,
        ),
        color: shape.backgroundColor,
      ),
      padding: shape.padding,
      child: child,
    );
  }
}
