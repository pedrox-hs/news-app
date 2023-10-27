import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

extension ResponseX on Response {
  bool get isSuccessful =>
      statusCode >= HttpStatus.ok && statusCode < HttpStatus.multipleChoices;

  bool get isClientError =>
      statusCode >= HttpStatus.badRequest &&
      statusCode < HttpStatus.internalServerError;

  bool get isServerError =>
      statusCode >= HttpStatus.internalServerError &&
      statusCode <= HttpStatus.networkConnectTimeoutError;

  bool get isFailed => isClientError || isServerError;

  dynamic get bodyAsJson => body.isNotEmpty ? jsonDecode(body) : null;
}
