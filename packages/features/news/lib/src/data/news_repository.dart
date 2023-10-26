import 'package:news_feature/src/data/datasource/news_remote_datasource.dart';

import '../domain/entity/article.dart';
import '../domain/repository/news_repository.dart';

class NewsRepository extends INewsRepository {
  NewsRepository({
    required INewsRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  final INewsRemoteDatasource _remoteDatasource;

  @override
  Future<List<Article>> getArticles({required int page}) async {
    final news = await _remoteDatasource.getNews(page: page);

    return news.articles;
  }
}
