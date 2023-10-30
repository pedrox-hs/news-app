import 'package:flutter/widgets.dart';

import '../types/shape.dart';

class Shape extends StatelessWidget {
  const Shape({
    required this.child,
    required this.style,
    super.key,
  });

  final ShapeStyleData style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: style.borderRadius,
        border: Border.all(
          width: style.borderWidth,
          color: style.borderColor,
        ),
        color: style.backgroundColor,
      ),
      padding: style.padding,
      child: child,
    );
  }
}
