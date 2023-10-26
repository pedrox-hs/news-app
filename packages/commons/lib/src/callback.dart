import 'package:flutter/foundation.dart';

class CallbackValue {
  const CallbackValue._(this.callback);

  final VoidCallback callback;

  static VoidCallback? orNull<T>(void Function(T value)? callback, T value) {
    if (callback != null) {
      return CallbackValue._(() => callback(value));
    }
    return null;
  }

  void call() => callback();
}
