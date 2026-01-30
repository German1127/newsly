import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/news_remote_data_source.dart';

// News repository implementation.
// Connects the data source (NewsApi) with the domain.
class NewsRepositoryImpl implements ArticleRepository {
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({required this.newsRemoteDataSource});

  @override
  Future<List<ArticleEntity>> getTopHeadlines() async {
    try {
      final articles = await newsRemoteDataSource.fetchTopHeadlines();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}