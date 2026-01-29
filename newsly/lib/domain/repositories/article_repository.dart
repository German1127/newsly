import '../entities/article_entity.dart';

// (interface) for the news repository.
abstract class ArticleRepository {
  Future<List<ArticleEntity>> getTopHeadlines();
}