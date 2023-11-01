import 'package:flutter/material.dart';

import '../style_dictionary.dart';

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
        style: JDesignTokens.buttonStylePrimary,
        onPressed: onPressed,
      );

  final String text;
  final ButtonStyle style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(text),
    );
  }
}
