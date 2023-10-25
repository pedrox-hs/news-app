import 'package:flutter/material.dart';

class ButtonStyleData extends ButtonStyle {
  ButtonStyleData({
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? overlayColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
  }) : super(
          textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
          backgroundColor:
              _ButtonBackgroundColor(backgroundColor, disabledBackgroundColor),
          overlayColor:
              overlayColor != null ? _ButtonOverlayColor(overlayColor) : null,
          padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
        );
}

@immutable
class _ButtonBackgroundColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ButtonBackgroundColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _ButtonOverlayColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ButtonOverlayColor(this.overlay);

  final Color overlay;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return overlay;
    }
    return null;
  }
}
