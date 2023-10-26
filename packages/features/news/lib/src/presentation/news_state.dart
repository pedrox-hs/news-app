import 'package:ds/ds.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entity/article.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsState with _$NewsState {
  factory NewsState.loading() = _LoadingState;

  factory NewsState.loaded(List<Article> articles) = _LoadedState;

  factory NewsState.error(
    ErrorData data,
  ) = _ErrorState;
}

class ErrorData {
  ErrorData({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final PictureAsset icon;
  final String title;
  final String description;
  final String buttonText;
}
