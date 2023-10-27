import 'package:ds/ds.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entity/article.dart';

part 'news_state.freezed.dart';

const kFirstPage = 1;

@freezed
class NewsState with _$NewsState {
  const NewsState._();

  const factory NewsState.loading() = _LoadingState;

  const factory NewsState.loaded(int currentPage, List<Article> articles) =
      _LoadedState;

  const factory NewsState.completed(int currentPage, List<Article> articles) =
      _CompletedState;

  const factory NewsState.error(ErrorData data) = _ErrorState;

  int get currentPage => 0;
  int get nextPage => currentPage + 1;

  List<Article> get articles => [];
}

class ErrorData extends Equatable {
  const ErrorData({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final PictureAsset icon;
  final String title;
  final String description;
  final String buttonText;

  @override
  List<Object?> get props => [icon, title, description, buttonText];
}

class GenericErrorData extends ErrorData {
  const GenericErrorData()
      : super(
          icon: const LocalSvgAsset(AppAsset.illustrationError),
          title: 'Ops!',
          description: 'Não foi possível carregar as notícias.',
          buttonText: 'Tentar novamente',
        );
}
