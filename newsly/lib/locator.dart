import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/news_api.dart';
import 'data/repositories/news_repository_impl.dart';
import 'package:newsly/domain/repositories/article_repository.dart';
import 'package:newsly/domain/usecases/get_top_headlines.dart';

/// Global instance of the service locator.
final GetIt locator = GetIt.instance;

/// Sets up the service locator by registering dependencies.
void setupLocator() {
  // USE CASES
  locator.registerFactory(() => GetTopHeadlines(locator<ArticleRepository>()));

  // REPOSITORIES
  // The implementation (NewsRepositoryImpl) is injected, but it is registered
  // using the interface type (ArticleRepository) to ensure abstraction.
  locator.registerLazySingleton<ArticleRepository>(
      () => NewsRepositoryImpl(newsApi: locator<NewsApi>()));

  // DATA SOURCES & EXTERNAL
  // Register http.Client as a lazy singleton. It will be created only when first requested.
  locator.registerLazySingleton(() => http.Client());

  // Register NewsApi, which depends on http.Client. 
  // GetIt will automatically resolve the http.Client dependency.
  locator.registerLazySingleton(() => NewsApi(httpClient: locator<http.Client>()));
}