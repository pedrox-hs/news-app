import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../domain/entity/article.dart';
import '../domain/get_news_usecase.dart';
import 'news_state.dart';

abstract class NewsViewModel with ChangeNotifier {
  NewsViewModel();

  factory NewsViewModel.create({
    required GetNewsUseCase getNews,
    required IUrlNavigation urlNavigation,
  }) = NewsViewModelBase;

  @visibleForTesting
  NewsState currentState = const NewsState.loading();
  NewsState get state => currentState;

  Future<void> load();
  Future<void> refresh();

  Future<void> retry();
  Future<void> loadMore();
  Future<void> readMore(Article article);
}

@visibleForTesting
class NewsViewModelBase extends NewsViewModel {
  NewsViewModelBase({
    required GetNewsUseCase getNews,
    required IUrlNavigation urlNavigation,
  })  : _getNews = getNews,
        _urlNavigation = urlNavigation;

  final GetNewsUseCase _getNews;
  final IUrlNavigation _urlNavigation;

  bool get _canLoadMore => state.maybeMap(
        completed: (state) => false,
        orElse: () => true,
      );

  set _state(NewsState value) {
    if (currentState != value) {
      currentState = value;
      notifyListeners();
    }
  }

  @override
  Future<void> load() => _loadFirstPage();

  @override
  Future<void> refresh() => _loadFirstPage();

  @override
  Future<void> retry() async {
    state.mapOrNull(
      error: (_) {
        _state = const NewsState.loading();
        _loadNextPage();
      },
    );
  }

  @override
  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    await _loadNextPage();
  }

  @override
  Future<void> readMore(Article article) async {
    await _urlNavigation.open(article.url);
  }

  Future<void> _loadFirstPage() async {
    await _loadToState(kFirstPage);
  }

  Future<void> _loadNextPage() async {
    await _loadToState(state.nextPage);
  }

  Future<void> _loadToState(int page) async {
    _state = await _load(page).catchError(_onError);
  }

  Future<NewsState> _load(int page) async {
    final articles = await _getNews(page: page);
    final updated = page == kFirstPage ? articles : state.articles + articles;

    return articles.isNotEmpty
        ? NewsState.loaded(page, updated)
        : NewsState.completed(page, updated);
  }

  NewsState _onError(error) {
    return state.maybeMap(
      loaded: (state) => state,
      orElse: () => const NewsState.error(GenericErrorData()),
    );
  }
}
