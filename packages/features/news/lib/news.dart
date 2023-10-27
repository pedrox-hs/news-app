library news_feature;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/data/datasource/news_remote_datasource.dart';
import 'src/data/repository/news_repository.dart';
import 'src/domain/get_news_usecase.dart';
import 'src/presentation/news_page.dart';
import 'src/presentation/news_view_model.dart';

class NewsModule extends StatelessWidget {
  const NewsModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsViewModel>(
          create: (context) => NewsViewModel.create(
            navigator: context.read(),
            getNews: GetNewsUseCase(
              repository: NewsRepository(
                remoteDatasource: NewsRemoteDatasource(
                  client: context.read(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: const NewsPage(),
    );
  }
}
