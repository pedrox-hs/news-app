import 'package:equatable/equatable.dart';

import '../../domain/entity/article.dart';
import 'article.dart';

class NewsResultModel extends Equatable {
  final List<Article> articles;

  const NewsResultModel({
    required this.articles,
  });

  factory NewsResultModel.fromJson(Map<String, dynamic> json) {
    final list = json['articles'] as List;
    return NewsResultModel(
      articles: list.map((e) => ArticleModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [articles];
}
