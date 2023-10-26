part of '../news_page.dart';

class _LoadingStateWidget extends StatelessWidget {
  const _LoadingStateWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorStateWidget extends StatelessWidget {
  const _ErrorStateWidget();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget(this.articles);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    final scrollController = InfiniteListenerController(() {
      final viewModel = Provider.of<NewsViewModel>(context, listen: false);
      viewModel.loadMore();
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: articles.length,
      padding: AppSpacingSquish.quarck,
      itemBuilder: (_, index) => ArticleWidget(
        articles[index],
        onReadMorePressed: (article) {
          final viewModel = context.read<NewsViewModel>();
          viewModel.readMore(article);
        },
      ),
    );
  }
}
