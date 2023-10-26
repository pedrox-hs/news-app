import 'dart:convert';

import 'package:http/http.dart';

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
        path: 'top-headlines',
        queryParameters: {
          'sources': 'google-news-br',
          'page': '$page',
          'pageSize': '5',
        },
      ),
    );

    if (response.statusCode != 200) throw Exception(response.body);

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return NewsResultModel.fromJson(jsonResponse);
  }
}
