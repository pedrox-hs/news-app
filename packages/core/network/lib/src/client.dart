import 'package:http/http.dart' as http;

import 'ext/request.dart';

/// https://newsapi.org/s/google-news-br-api
const String newsApiUrl = String.fromEnvironment('NEWS_API_URL');
const String newsApiKey = String.fromEnvironment('NEWS_API_KEY');

class NewsHttpClient extends http.BaseClient {
  NewsHttpClient({
    String baseUrl = newsApiUrl,
    http.Client? inner,
  })  : _inner = inner ?? http.Client(),
        baseUrl = Uri.parse(baseUrl);

  final http.Client _inner;
  final Uri baseUrl;

  @override
  void close() {
    _inner.close();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final url = request.url;

    http.BaseRequest newRequest = request.copyWith(
      url: baseUrl.resolveUri(url),
      headers: {
        ...request.headers,
        'X-Api-Key': newsApiKey,
      },
    );

    return await _inner.send(newRequest);
  }
}
