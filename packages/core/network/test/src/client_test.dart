import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';

const String newsApiUrl = 'https://newsapi.org/v2/';
const String newsApiKey = '1234567890';

void main() {
  group(NewsHttpClient, () {
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

      sut = NewsHttpClient(
        inner: mockClient,
        baseUrl: newsApiUrl,
        apiKey: newsApiKey,
      );
    });

    tearDown(() {
      sut.close();
    });

    test('should call provided API url', () async {
      final result = await sut.get(Uri(path: 'top-headlines'));

      expect(result.statusCode, 200);
      expect(jsonDecode(result.body)['url'], '${newsApiUrl}top-headlines');
    });

    test('should call provided API key', () async {
      final result = await sut.get(Uri(path: 'top-headlines'));

      expect(result.statusCode, 200);
      expect(jsonDecode(result.body)['headers']['X-Api-Key'], newsApiKey);
    });
  });
}
