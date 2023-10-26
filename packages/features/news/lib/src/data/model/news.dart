import 'package:news_feature/src/data/model/article.dart';

import '../../domain/entity/article.dart';

class NewsResultModel {
  final List<Article> articles;

  NewsResultModel({
    required this.articles,
  });

  factory NewsResultModel.fromJson(Map<String, dynamic> json) {
    final list = json['articles'] as List;
    return NewsResultModel(
      articles: list.map((e) => ArticleModel.fromJson(e)).toList(),
    );
  }
}
