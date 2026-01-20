import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/news_article_model.dart';
import '../data/repositories/news_repository.dart';

// --- States ---
abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;
  const NewsLoaded(this.articles);
  @override
  List<Object> get props => [articles];
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);
  @override
  List<Object> get props => [message];
}

// --- Cubit ---
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;

  NewsCubit({required this.newsRepository}) : super(NewsInitial());

  /// Loads the top headlines.
  /// If [forceRefresh] is true, it will fetch news again even if they are already loaded.
  Future<void> loadTopHeadlines({bool forceRefresh = false}) async {
    // Avoid unnecessary reloads if it's already in a loading state.
    if (state is NewsLoading) return;

    // If we already have data and refresh is not forced, do nothing (in-memory cache).
    if (state is NewsLoaded && !forceRefresh) return;

    emit(NewsLoading());

    try {
      final articles = await newsRepository.getTopHeadlines();
      emit(NewsLoaded(articles));
    } catch (e) {
      // Clean up the exception message for better display.
      emit(NewsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}