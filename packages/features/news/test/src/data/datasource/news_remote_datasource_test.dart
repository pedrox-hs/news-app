import 'dart:io';
import 'dart:math';

import 'package:commons_foundation/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:news_feature/src/data/datasource/news_remote_datasource.dart';
import 'package:testing_commons/testing_commons.dart';

import '../../../fixtures/news.dart';

void main() {
  group(NewsRemoteDatasource, () {
    late INewsRemoteDatasource sut;
    late MockHttpClient mockClient;

    setUp(() {
      mockClient = MockHttpClient();
      sut = NewsRemoteDatasource(client: mockClient);
    });

    test('should make request correctly', () async {
      // arrange
      final randomPage = Random().nextInt(100);
      final expectedUri = Uri(path: 'everything');
      final content = FileX.fromFixtureJson('news_success_response');

      Request? actualRequest;
      mockClient.handler.enqueue(
        (request) async {
          actualRequest = request;
          return Response(content.readAsStringSync(), HttpStatus.ok);
        },
      );

      // act
      await sut.getNews(page: randomPage);

      // assert
      final url = actualRequest?.url;
      expect(actualRequest, isNotNull);
      expect(url?.withoutQuery(), expectedUri.withoutQuery());
      expect(url?.queryParameters, allOf(
        containsPair('sources', 'google-news-br,info-money,globo,blasting-news-br'),
        containsPair('page', '$randomPage'),
        containsPair('pageSize', '5'),
      ));
    });

    test('should return news response', () async {
      // arrange
      const expected = newsResponseFixture;
      final content = FileX.fromFixtureJson('news_success_response');
      mockClient.handler.enqueue(
        (_) async => Response(content.readAsStringSync(), HttpStatus.ok),
      );

      // act
      final actual = await sut.getNews(page: 1);

      // assert
      expect(actual, expected);
    });
  });
}
