import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feature/src/data/datasource/news_remote_datasource.dart';
import 'package:news_feature/src/data/repository/news_repository.dart';
import 'package:news_feature/src/domain/repository/news_repository.dart';

import '../../../fixtures/news.dart';

void main() {
  group(NewsRepository, () {
    late INewsRepository sut;
    late INewsRemoteDatasource mockRemoteDatasource;

    setUp(() {
      mockRemoteDatasource = _MockNewsRemoteDatasource();
      sut = NewsRepository(
        remoteDatasource: mockRemoteDatasource,
      );
    });

    test('should call datasource', () async {
      // arrange
      final randomPage = Random().nextInt(100);
      when(() => mockRemoteDatasource.getNews(page: any(named: 'page')))
          .thenAnswer((_) async => newsResponseFixture);

      // act
      await sut.getArticles(page: randomPage);

      // assert
      verify(() => mockRemoteDatasource.getNews(page: randomPage)).called(1);
      verifyNoMoreInteractions(mockRemoteDatasource);
    });

    test('should return list of articles', () async {
      // arrange
      final expectedArticles = newsResponseFixture.articles;
      when(() => mockRemoteDatasource.getNews(page: any(named: 'page')))
          .thenAnswer((_) async => newsResponseFixture);

      // act
      final actual = await sut.getArticles(page: 1);

      // assert
      expect(actual, expectedArticles);
    });

    test('should throw exception when datasource throws exception', () async {
      // arrange
      when(() => mockRemoteDatasource.getNews(page: any(named: 'page')))
          .thenThrow(Exception());

      // act
      final call = sut.getArticles;

      // assert
      expect(() => call(page: 1), throwsException);
    });
  });
}

class _MockNewsRemoteDatasource extends Mock implements INewsRemoteDatasource {}
