import 'dart:io';

import 'package:commons_testing/flutter.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';
import 'package:news_feature/news.dart';
import 'package:news_feature/src/presentation/news_page.dart';
import 'package:provider/provider.dart';

void main() {
  group(NewsPage, () {
    late MockHttpClient mockClient;
    late IAppNavigator mockNavigator;

    setUp(() {
      mockClient = MockHttpClient();
      mockNavigator = _MockAppNavigator();
    });

    goldenTest(
      'should show news successful',
      fileName: 'show_news_successful',
      builder: () {
        final responseFile =
            FileX.fromFixtureJson('top_headlines_success_response');
        mockClient.handler.enqueue(respondWithJson(responseFile));

        return GoldenTestApp(
          builder: () => MultiProvider(
            providers: [
              Provider<Client>.value(value: mockClient),
              Provider<IAppNavigator>.value(value: mockNavigator),
            ],
            builder: (_, __) => const NewsModule(),
          ),
        );
      },
    );

    goldenTest(
      'should show error on news failure',
      fileName: 'show_news_failure',
      builder: () {
        mockClient.handler.enqueue(
          (request) async => throw const SocketException('Failed to connect'),
        );

        return GoldenTestApp(
          builder: () => MultiProvider(
            providers: [
              Provider<Client>.value(value: mockClient),
              Provider<IAppNavigator>.value(value: mockNavigator),
            ],
            builder: (_, __) => const NewsModule(),
          ),
        );
      },
    );
  });
}

class _MockAppNavigator extends Mock implements IAppNavigator {}
