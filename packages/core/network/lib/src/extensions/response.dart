import 'dart:convert';

import 'package:http/http.dart';

extension ResponseX on Response {
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;

  bool get isClientError => statusCode >= 400 && statusCode < 500;

  bool get isServerError => statusCode >= 500 && statusCode < 600;

  bool get isFailed => isClientError || isServerError;

  dynamic get bodyAsJson => body.isNotEmpty ? jsonDecode(body) : null;
}
