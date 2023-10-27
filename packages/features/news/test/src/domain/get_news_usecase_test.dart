import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feature/src/domain/get_news_usecase.dart';
import 'package:news_feature/src/domain/repository/news_repository.dart';

import '../../fixtures/articles.dart';

void main() {
  group(GetNewsUseCase, () {
    late GetNewsUseCase sut;
    late INewsRepository mockRepository;

    setUp(() {
      mockRepository = _MockNewsRepository();
      sut = GetNewsUseCase(
        repository: mockRepository,
      );
    });

    test('should call repository', () async {
      // arrange
      final randomPage = Random().nextInt(100);
      when(() => mockRepository.getArticles(page: any(named: 'page')))
          .thenAnswer((_) async => []);

      // act
      await sut(page: randomPage);

      // assert
      verify(() => mockRepository.getArticles(page: randomPage)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return list of articles', () async {
      // arrange
      final expectedArticles = articlesFixture;
      when(() => mockRepository.getArticles(page: any(named: 'page')))
          .thenAnswer((_) async => expectedArticles);

      // act
      final actual = await sut(page: 2);

      // assert
      expect(actual, expectedArticles);
    });

    test('should throw exception when repository throws exception', () async {
      // arrange
      when(() => mockRepository.getArticles(page: any(named: 'page')))
          .thenThrow(Exception());

      // act
      final call = sut;

      // assert
      expect(() => call(page: 1), throwsException);
    });
  });
}

class _MockNewsRepository extends Mock implements INewsRepository {}
