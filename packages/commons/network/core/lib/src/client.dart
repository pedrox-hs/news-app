import 'package:http/http.dart';
import 'package:network_extensions/network_extensions.dart';

class HttpClient extends BaseClient {
  HttpClient({
    required String baseUrl,
    Map<String, String> defaultHeaders = const {},
    Client? inner,
  })  : _inner = inner ?? Client(),
        _baseUrl = Uri.parse(baseUrl),
        _defaultHeaders = defaultHeaders;

  final Client _inner;

  final Uri _baseUrl;
  final Map<String, String> _defaultHeaders;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final url = request.url;

    BaseRequest newRequest = request.copyWith(
      url: _baseUrl.resolveUri(url),
      headers: {
        ..._defaultHeaders,
        ...request.headers,
      },
    );

    return await _inner.send(newRequest);
  }

  @override
  void close() {
    _inner.close();
  }
}
