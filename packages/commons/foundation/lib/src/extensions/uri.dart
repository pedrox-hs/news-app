extension UriX on Uri {
  Uri withoutQuery() => replace(queryParameters: {});
}
