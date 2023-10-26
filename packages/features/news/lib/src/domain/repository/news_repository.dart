import '../entity/article.dart';

abstract class INewsRepository {
  Future<List<Article>> getArticles({required int page});
}