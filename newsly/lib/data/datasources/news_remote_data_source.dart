import '../models/news_article_model.dart';

/// Interface for the remote data source.
/// Defines the contract for fetching news, allowing different implementations (Http, Dio, Mock).
abstract class NewsRemoteDataSource {
  /// Fetches the top headlines from the API.
  Future<List<NewsArticle>> fetchTopHeadlines();
}