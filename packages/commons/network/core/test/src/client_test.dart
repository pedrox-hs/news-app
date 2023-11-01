import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:network_core/network_core.dart';
import 'package:network_extensions/network_extensions.dart';
import 'package:test/test.dart';

const String _apiUrl = 'https://example.org/v2/';
const Map<String, String> _defaultHeaders = {'X-Api-Key': 'API_KEY'};

void main() {
  group(HttpClient, () {
    late Client sut;

    late Client mockClient;

    setUp(() {
      mockClient = MockClient(
        (request) async => Response(
          jsonEncode(
            {
              'url': request.url.toString(),
              'headers': request.headers,
            },
          ),
          200,
        ),
      );

      sut = HttpClient(
        inner: mockClient,
        baseUrl: _apiUrl,
        defaultHeaders: _defaultHeaders,
      );
    });

    tearDown(() {
      sut.close();
    });

    test('should call provided API url', () async {
      final response = await sut.get(Uri(path: 'foo/bar'));

      expect(response.statusCode, 200);
      expect(response.bodyAsJson!['url'], '${_apiUrl}foo/bar');
    });

    test('should call provided API key', () async {
      final response = await sut.get(Uri(path: 'baz'));

      expect(response.statusCode, 200);
      expect(response.bodyAsJson!['headers'], _defaultHeaders);
    });
  });
}
