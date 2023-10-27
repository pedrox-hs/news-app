import 'package:news_feature/src/domain/entity/article.dart';

final articlesFixture = List.generate(
  7,
  (index) => Article(
    title: 'Title #$index',
    subtitle: 'Subtitle #$index',
    content: 'Content #$index',
    url: 'https://news.com/$index',
  ),
);
