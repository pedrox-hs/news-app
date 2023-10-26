import 'package:commons/commons.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/entity/article.dart';
import 'news_view_model.dart';
import 'widgets/article.dart';

part 'widgets/states.dart';

/// A page that shows a list of news articles.
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google News App'),
      ),
      body: const _ContentWidget(),
    );
  }
}

/// The content of the page.
/// It shows a loading indicator, a list of articles or an error message.
class _ContentWidget extends StatelessWidget {
  const _ContentWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewsViewModel>().state;

    return state.when(
      loading: () => const _LoadingStateWidget(),
      loaded: (articles) => _LoadedStateWidget(articles),
      error: () => const _ErrorStateWidget(),
    );
  }
}
