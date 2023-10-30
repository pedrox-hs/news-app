import 'dart:io';

import 'package:http/http.dart';
import 'package:http/testing.dart' as http;

class MockHttpClient extends http.MockClient {
  MockHttpClient._(this.handler) : super(handler.call);

  factory MockHttpClient() => MockHttpClient._(RequestHandler());

  final RequestHandler handler;
}

class RequestHandler {
  final List<http.MockClientHandler> _queue = [];

  void enqueue(http.MockClientHandler handler) {
    _queue.add(handler);
  }

  Future<Response> call(Request request) async {
    final handler = _queue.removeAt(0);
    return handler(request);
  }
}

http.MockClientHandler respondWithJson(
  File file, {
  int statusCode = HttpStatus.ok,
}) =>
    (request) async {
      return Response(
        file.readAsStringSync(),
        statusCode,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        },
      );
    };
