import 'dart:async';

import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../domain/entity/article.dart';
import '../domain/get_news_usecase.dart';
import 'news_state.dart';

class NewsViewModel with ChangeNotifier {
  NewsViewModel({
    required GetNewsUseCase getNews,
    required this.navigator,
  }) : _getNews = getNews {
    unawaited(_tryLoad());
  }

  final GetNewsUseCase _getNews;
  final IAppNavigator navigator;

  NewsState state = NewsState.loading();
  set _state(NewsState value) {
    state = value;
    notifyListeners();
  }

  final List<Article> _articles = [];
  int _currentPage = 0;
  bool _hasMore = true;

  Future<void> refresh() async {
    _articles.clear();
    _tryLoad();
  }

  void retry() async {
    _state = NewsState.loading();
    await _tryLoad();
  }

  void loadMore() async {
    if (!_hasMore) return;
    await _tryLoad(page: _currentPage + 1);
  }

  void readMore(Article article) async {
    await navigator.openUrl(article.url);
  }

  Future<void> _tryLoad({int page = 1}) async {
    _state = await _load(page: page).catchError(_onError);
  }

  Future<NewsState> _load({int page = 1}) async {
    final articles = await _getNews(page: page);

    _currentPage = page;
    _hasMore = articles.isNotEmpty;
    _articles.addAll(articles);
    return NewsState.loaded(_articles);
  }

  NewsState _onError(error) {
    return state.maybeMap(
      loaded: (state) => state,
      orElse: () => NewsState.error(
        ErrorData(
          icon: const LocalSvgAsset(AppAsset.illustrationError),
          title: 'Ops!',
          description: 'Não foi possível carregar as notícias.',
          buttonText: 'Tentar novamente',
        ),
      ),
    );
  }
}
