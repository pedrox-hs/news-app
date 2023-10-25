import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button._({
    required this.text,
    required this.style,
    required this.onPressed,
    super.key,
  });

  factory Button.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
  }) =>
      Button._(
        key: key,
        text: text,
        style: AppButtonStyle.primary,
        onPressed: onPressed,
      );

  final String text;
  final ButtonStyle style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: style,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: style,
      ),
    );
  }
}
