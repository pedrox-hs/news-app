import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entity/article.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  factory NewsState.loading() = _LoadingState;

  factory NewsState.loaded(List<Article> articles) = _LoadedState;

  factory NewsState.error() = _ErrorState;
}