import 'package:http/http.dart';

import 'ext/request.dart';

/// https://newsapi.org/s/google-news-br-api
const String _newsApiUrl = String.fromEnvironment('NEWS_API_URL');
const String _newsApiKey = String.fromEnvironment('NEWS_API_KEY');

class NewsHttpClient extends BaseClient {
  NewsHttpClient({
    String baseUrl = _newsApiUrl,
    String apiKey = _newsApiKey,
    Client? inner,
  })  : _inner = inner ?? Client(),
        _baseUrl = Uri.parse(baseUrl),
        _apiKey = apiKey;

  final Client _inner;

  final Uri _baseUrl;
  final String _apiKey;

  @override
  void close() {
    _inner.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final url = request.url;

    BaseRequest newRequest = request.copyWith(
      url: _baseUrl.resolveUri(url),
      headers: {
        ...request.headers,
        'X-Api-Key': _apiKey,
      },
    );

    return await _inner.send(newRequest);
  }
}
