import 'package:http/http.dart';

extension RequestX<T extends BaseRequest> on T {
  BaseRequest copyWith({
    String? method,
    Uri? url,
    Map<String, String>? headers,
  }) {
    final other = this;
    late final BaseRequest newRequest;

    if (other is Request) {
      newRequest = Request(method ?? other.method, url ?? other.url)
        ..encoding = other.encoding
        ..bodyBytes = other.bodyBytes;
    } else {
      throw UnsupportedError(
        'Unsupported request type `${runtimeType.toString()}`',
      );
    }

    return newRequest..headers.addAll(headers ?? other.headers);
  }
}
