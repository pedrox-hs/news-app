library ds;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    this.title = '',
    required this.home,
    this.debugShowCheckedModeBanner = kDebugMode,
  });

  final String title;
  final Widget home;
  final bool debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      home: home,
      debugShowCheckedModeBanner: false,
    );
  }
}
