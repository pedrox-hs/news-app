import 'dart:async';

import 'package:commons_testing/flutter.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) =>
    configureFlutterTest(testMain);
