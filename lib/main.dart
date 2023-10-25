import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:news_feature/news.dart';

void main() {
  runApp(const GoogleNewsApp());
}

class GoogleNewsApp extends App {
  const GoogleNewsApp({super.key})
      : super(
          title: 'Google News App',
          home: const NewsPage(),
        );
}
