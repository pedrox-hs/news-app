import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:network/network.dart';
import 'package:news_feature/news.dart';
import 'package:provider/provider.dart';

import 'src/app_navigator.dart';

void main() {
  runApp(GoogleNewsApp());
}

class GoogleNewsApp extends App {
  GoogleNewsApp({super.key})
      : super(
          title: 'Google News App',
          home: MultiProvider(
            providers: [
              Provider<Client>(
                create: (_) => NewsHttpClient(),
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
