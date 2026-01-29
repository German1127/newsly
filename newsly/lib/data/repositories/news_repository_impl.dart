import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/news_api.dart';

// News repository implementation.
// Connects the data source (NewsApi) with the domain.
class NewsRepositoryImpl implements ArticleRepository {
  final NewsApi newsApi;

  NewsRepositoryImpl({required this.newsApi});

  @override
  Future<List<ArticleEntity>> getTopHeadlines() async {
    try {
      final articles = await newsApi.fetchTopHeadlines();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}