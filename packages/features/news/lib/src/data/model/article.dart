import '../../domain/entity/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.title,
    required super.subtitle,
    required super.content,
    required super.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'] as String?,
        subtitle: json['description'] as String?,
        content: json['content'] as String?,
        url: json['url'] as String,
      );
}
