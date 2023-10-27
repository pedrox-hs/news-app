import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';
import 'package:news_feature/src/domain/entity/article.dart';
import 'package:news_feature/src/domain/get_news_usecase.dart';
import 'package:news_feature/src/presentation/news_state.dart';
import 'package:news_feature/src/presentation/news_view_model.dart';

import '../../fixtures/articles.dart';

void main() {
  group(NewsViewModel, () {
    late NewsViewModel sut;
    late GetNewsUseCase mockGetNews;
    late IAppNavigator mockNavigator;

    setUp(() {
      mockGetNews = _MockGetNewsUseCase();
      mockNavigator = _MockAppNavigator();
      sut = NewsViewModel.create(
        getNews: mockGetNews,
        navigator: mockNavigator,
      );
    });

    test(
      'should init with loading state',
      () {
        // assert
        expect(sut.state, const NewsState.loading());
      },
    );

    test(
      'readMore should call navigator with article',
      () async {
        // arrange
        when(() => mockNavigator.openUrl(any()))
            .thenAnswer((_) => Future.value());
        const article = Article(
          title:
              'iPhones have been exposing your unique MAC despite Apple\'s promises otherwise - Ars Technica',
          subtitle:
              '“From the get-go, this feature was useless,” researcher says of feature put into iOS 14.',
          url:
              'https://arstechnica.com/security/2023/10/iphone-privacy-feature-hiding-wi-fi-macs-has-failed-to-work-for-3-years/',
          content:
              'Enlarge/ Private Wi-Fi address setting on an iPhone.\r\n36 with \r\nThree years ago, Apple introduced a privacy-enhancing feature that hid the Wi-Fi address of iPhones and iPads when they joined a networ… [+3994 chars]',
        );

        // act
        await sut.readMore(article);

        // assert
        verify(
          () => mockNavigator.openUrl(
            'https://arstechnica.com/security/2023/10/iphone-privacy-feature-hiding-wi-fi-macs-has-failed-to-work-for-3-years/',
          ),
        ).called(1);
      },
    );

    group('load', () {
      test('should call usecase with first page', () async {
        // arrange
        when(() => mockGetNews(page: any(named: 'page')))
            .thenAnswer((_) async => []);

        // act
        await sut.load();

        // assert
        verify(() => mockGetNews(page: 1)).called(1);
      });

      test(
        'should set state to loaded on success',
        () async {
          // arrange
          final articles = articlesFixture;
          when(() => mockGetNews(page: any(named: 'page')))
              .thenAnswer((_) async => articles);

          // act
          await sut.load();

          // assert
          expect(sut.state, NewsState.loaded(1, articles));
        },
      );

      test(
        'should set state to error on failure',
        () async {
          // arrange
          const error = GenericErrorData();
          when(() => mockGetNews(page: any(named: 'page')))
              .thenThrow(Exception());

          // act
          await sut.load();

          // assert
          expect(sut.state, const NewsState.error(error));
        },
      );
    });

    group('refresh', () {
      test(
        'should call usecase with first page',
        () async {
          // arrange
          when(() => mockGetNews(page: any(named: 'page')))
              .thenAnswer((_) async => []);

          // act
          await sut.refresh();

          // assert
          verify(() => mockGetNews(page: 1)).called(1);
        },
      );

      group('retry', () {
        test(
          'should call usecase with first page when come from error state',
          () async {
            // arrange
            sut.currentState = NewsState.error(_FakeErrorData());
            when(() => mockGetNews(page: any(named: 'page')))
                .thenAnswer((_) async => []);

            // act
            await sut.retry();

            // assert
            verify(() => mockGetNews(page: 1)).called(1);
          },
        );

        test(
          'should not call usecase when come from loading state',
          () async {
            // arrange
            sut.currentState = const NewsState.loading();

            // act
            await sut.retry();

            // assert
            verifyZeroInteractions(mockGetNews);
          },
        );

        test(
          'should not call usecase when come from loaded state',
          () async {
            // arrange
            sut.currentState = const NewsState.loaded(1, []);

            // act
            await sut.retry();

            // assert
            verifyZeroInteractions(mockGetNews);
          },
        );
      });

      group('loadMore', () {
        test(
          'should call usecase with next page',
          () async {
            // arrange
            sut.currentState = const NewsState.loaded(1, []);
            when(() => mockGetNews(page: any(named: 'page')))
                .thenAnswer((_) async => []);

            // act
            await sut.loadMore();

            // assert
            verify(() => mockGetNews(page: 2)).called(1);
          },
        );

        test(
          'should not call usecase when can not load more',
          () async {
            // arrange
            sut.currentState = const NewsState.completed(1, []);

            // act
            await sut.loadMore();

            // assert
            verifyZeroInteractions(mockGetNews);
          },
        );

        test(
          'should set state to completed when can not load more',
          () async {
            // arrange
            sut.currentState = const NewsState.loaded(1, []);
            when(() => mockGetNews(page: any(named: 'page')))
                .thenAnswer((_) async => []);

            // act
            await sut.loadMore();

            // assert
            expect(sut.state, const NewsState.completed(2, []));
          },
        );
      });
    });
  });
}

class _MockGetNewsUseCase extends Mock implements GetNewsUseCase {}

class _MockAppNavigator extends Mock implements IAppNavigator {}

class _FakeErrorData extends Fake implements ErrorData {}
