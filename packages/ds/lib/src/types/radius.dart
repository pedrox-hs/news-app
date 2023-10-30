import 'package:flutter/painting.dart';

class PercentageBorderRadius extends BorderRadius {
  const PercentageBorderRadius.all(super.radius) : super.all();

  @override
  RRect toRRect(Rect rect) {
    final topLeft = Radius.elliptical(
      rect.width * this.topLeft.x,
      rect.height * this.topLeft.y,
    );

    final topRight = Radius.elliptical(
      rect.width * this.topRight.x,
      rect.height * this.topRight.y,
    );

    final bottomLeft = Radius.elliptical(
      rect.width * this.bottomLeft.x,
      rect.height * this.bottomLeft.y,
    );

    final bottomRight = Radius.elliptical(
      rect.width * this.bottomRight.x,
      rect.height * this.bottomRight.y,
    );

    return RRect.fromRectAndCorners(
      rect,
      topLeft: topLeft.clamp(minimum: Radius.zero),
      topRight: topRight.clamp(minimum: Radius.zero),
      bottomLeft: bottomLeft.clamp(minimum: Radius.zero),
      bottomRight: bottomRight.clamp(minimum: Radius.zero),
    );
  }
}
