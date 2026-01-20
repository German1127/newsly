import '../models/news_article_model.dart';
import '../news_api.dart';

/// Abstract interface defining the contract for data retrieval.
abstract class NewsRepository {
  Future<List<NewsArticle>> getTopHeadlines();
}

/// Concrete implementation that fetches data from the API.
class NewsRepositoryImpl implements NewsRepository {
  final NewsApi newsApi;

  NewsRepositoryImpl({required this.newsApi});

  @override
  Future<List<NewsArticle>> getTopHeadlines() async {
    return await newsApi.fetchTopHeadlines();
  }
}