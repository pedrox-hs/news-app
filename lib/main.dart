import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:network/network.dart';
import 'package:news_feature/news.dart';
import 'package:provider/provider.dart';

import 'src/app_navigator.dart';

/// https://newsapi.org/s/google-news-br-api
const String _newsApiUrl = String.fromEnvironment('NEWS_API_URL');
const String _newsApiKey = String.fromEnvironment('NEWS_API_KEY');

void main() {
  runApp(GoogleNewsApp());
}

class GoogleNewsApp extends App {
  GoogleNewsApp({super.key})
      : super(
          title: 'News App',
          home: MultiProvider(
            providers: [
              Provider<Client>(
                create: (_) => HttpClient(
                  baseUrl: _newsApiUrl,
                  defaultHeaders: {
                    'X-Api-Key': _newsApiKey,
                  },
                ),
                dispose: (_, client) => client.close(),
              ),
              Provider<IAppNavigator>(
                create: (_) => AppNavigator(),
              ),
            ],
            child: const NewsModule(),
          ),
        );
}
