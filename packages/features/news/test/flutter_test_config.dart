import 'dart:async';

import 'package:ui_testing/ui_testing.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) =>
    configureFlutterTest(testMain);
