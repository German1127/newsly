import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_top_headlines.dart';

// --- States ---
abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleEntity> articles;
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
  final GetTopHeadlines getTopHeadlines;

  NewsCubit({required this.getTopHeadlines}) : super(NewsInitial());

  /// Loads the top headlines.
  /// If [forceRefresh] is true, it will fetch news again even if they are already loaded.
  Future<void> loadTopHeadlines({bool forceRefresh = false}) async {
    if (state is NewsLoading) return;

    // If we already have data and refresh is not forced, do nothing (in-memory cache).
    if (state is NewsLoaded && !forceRefresh) return;

    emit(NewsLoading());

    try {
      final articles = await getTopHeadlines();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}