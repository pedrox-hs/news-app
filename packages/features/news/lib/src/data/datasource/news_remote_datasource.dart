import 'package:http/http.dart';
import 'package:network_extensions/network_extensions.dart';

import '../model/news.dart';

abstract class INewsRemoteDatasource {
  Future<NewsResultModel> getNews({required int page});
}

class NewsRemoteDatasource implements INewsRemoteDatasource {
  NewsRemoteDatasource({
    required Client client,
  }) : _client = client;

  final Client _client;

  @override
  Future<NewsResultModel> getNews({required int page}) async {
    final response = await _client.get(
      Uri(
        path: 'everything',
        queryParameters: {
          'sources': 'google-news-br,info-money,globo,blasting-news-br',
          'page': '$page',
          'pageSize': '5',
        },
      ),
    );

    if (response.isFailed) throw Exception(response.body);

    final jsonResponse = response.bodyAsJson as Map<String, dynamic>;
    return NewsResultModel.fromJson(jsonResponse);
  }
}
