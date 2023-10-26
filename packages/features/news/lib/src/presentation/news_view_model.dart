import 'package:flutter/foundation.dart';
import 'package:navigation/navigation.dart';

import '../domain/entity/article.dart';
import '../domain/get_news_usecase.dart';
import 'news_state.dart';

class NewsViewModel with ChangeNotifier {
  NewsViewModel({
    required GetNewsUseCase getNews,
    required this.navigator,
  }) : _getNews = getNews {
    _load();
  }

  final GetNewsUseCase _getNews;
  final IAppNavigator navigator;

  NewsState state = NewsState.loading();

  final List<Article> _articles = [];
  int _currentPage = 0;
  bool _hasMore = true;

  void _load({int page = 1}) async {
    final articles = await _getNews(page: page);

    _currentPage = page;
    _hasMore = articles.isNotEmpty;
    _articles.addAll(articles);
    state = NewsState.loaded(_articles);

    notifyListeners();
  }

  void readMore(Article article) async {
    await navigator.openUrl(article.url);
  }

  void loadMore() {
    if (!_hasMore) return;
    _load(page: _currentPage + 1);
  }
}
