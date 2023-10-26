import 'entity/article.dart';
import 'repository/news_repository.dart';

class GetNewsUseCase {
  const GetNewsUseCase({
    required INewsRepository repository,
  }) : _repository = repository;

  final INewsRepository _repository;

  Future<List<Article>> call({required int page}) async {
    return await _repository.getArticles(page: page);
  }
}
