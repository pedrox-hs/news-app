import 'dart:ui';

class ShadowLevelData extends Shadow {
  ShadowLevelData({
    required double b,
    required double x,
    required double y,
  }) : super(
          blurRadius: b,
          offset: Offset(x, y),
        );
}
