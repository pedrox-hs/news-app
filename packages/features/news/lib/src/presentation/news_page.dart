import 'dart:async';

import 'package:commons_foundation/foundation.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/entity/article.dart';
import 'news_state.dart';
import 'news_view_model.dart';
import 'widgets/article.dart';

part 'widgets/states.dart';

/// A page that shows a list of news articles.
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsViewModel>();
    unawaited(viewModel.load());

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
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
    return RefreshIndicator.adaptive(
      onRefresh: () => context.read<NewsViewModel>().refresh(),
      child: Builder(builder: (context) {
        final state = context.watch<NewsViewModel>().state;

        return state.when(
          loading: () => const _LoadingStateWidget(),
          loaded: (_, articles) => _LoadedStateWidget(articles),
          completed: (_, articles) => _LoadedStateWidget(articles),
          error: (data) => _ErrorStateWidget(data),
        );
      }),
    );
  }
}
