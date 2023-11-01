import 'package:flutter/material.dart';

import 'style_dictionary.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: JDesignTokens.brandColorPrimary1,
      ),
      useMaterial3: false,
      textTheme:
          theme.textTheme.apply(fontFamily: JDesignTokens.fontFamilyHighlight),
    );
  }

  static ThemeData dark(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: JDesignTokens.brandColorPrimary1,
      ),
      useMaterial3: false,
      textTheme:
          theme.textTheme.apply(fontFamily: JDesignTokens.fontFamilyHighlight),
    );
  }
}
