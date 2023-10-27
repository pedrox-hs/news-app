library ds;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tokens/color.dart';
import 'tokens/typography.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    this.title = '',
    required this.home,
    this.debugShowCheckedModeBanner = kDebugMode,
  });

  final String title;
  final Widget home;
  final bool debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.brandPrimary01),
        useMaterial3: false,
        textTheme: theme.textTheme.apply(fontFamily: AppFontFamily.highlight),
      ),
      home: home,
      debugShowCheckedModeBanner: false,
    );
  }
}
