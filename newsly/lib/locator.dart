import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/news_api.dart';
import 'data/repositories/news_repository.dart';

/// Global instance of the service locator.
final GetIt locator = GetIt.instance;

/// Sets up the service locator by registering dependencies.
void setupLocator() {
  // Register http.Client as a lazy singleton. It will be created only when first requested.
  locator.registerLazySingleton(() => http.Client());

  // Register NewsApi, which depends on http.Client. 
  // GetIt will automatically resolve the http.Client dependency.
  locator.registerLazySingleton(() => NewsApi(httpClient: locator<http.Client>()));

  // Register NewsRepository. We inject the implementation (NewsRepositoryImpl)
  // but type it as the interface (NewsRepository) for abstraction.
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(newsApi: locator<NewsApi>()));
}