/// Data model for a News Article.
class NewsArticle {
  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final String? sourceName;

  NewsArticle({
    this.author,
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.sourceName,
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