import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

// Use case to get the top headlines.
class GetTopHeadlines {
  final ArticleRepository repository;

  GetTopHeadlines(this.repository);

  Future<List<ArticleEntity>> call() => repository.getTopHeadlines();
}