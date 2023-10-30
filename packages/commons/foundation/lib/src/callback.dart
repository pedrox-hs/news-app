import 'package:flutter/foundation.dart';

class CallbackValue {
  const CallbackValue._();

  static VoidCallback? orNull<T>(void Function(T value)? callback, T value) {
    if (callback != null) {
      return () => callback(value);
    }
    return null;
  }
}
