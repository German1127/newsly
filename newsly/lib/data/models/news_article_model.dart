import '../../domain/entities/article_entity.dart';

// Data model for a news article. Extends the domain entity
class NewsArticle extends ArticleEntity {
  const NewsArticle({
    super.author,
    required super.title,
    super.description,
    super.url,
    super.urlToImage,
    required super.publishedAt,
    super.content,
    super.sourceName,
  });

  /// Factory constructor to create a NewsArticle instance from a JSON map.
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'] as String?,
      title: json['title'] as String? ?? 'Título no disponible',
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String? ?? DateTime.now().toIso8601String(),
      content: json['content'] as String?,
      sourceName: json['source'] != null ? json['source']['name'] as String? : 'Fuente desconocida',
    );
  }
}