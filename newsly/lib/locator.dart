import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/news_api.dart';
import 'data/datasources/news_remote_data_source.dart';
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
  locator.registerLazySingleton<ArticleRepository>(
      () => NewsRepositoryImpl(newsRemoteDataSource: locator<NewsRemoteDataSource>()));

  // DATA SOURCES & EXTERNAL
  locator.registerLazySingleton(() => http.Client());

  // GetIt will automatically resolve the http.Client dependency.
  locator.registerLazySingleton<NewsRemoteDataSource>(() => NewsApi(httpClient: locator<http.Client>()));
}