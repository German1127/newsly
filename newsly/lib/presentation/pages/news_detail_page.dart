import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants.dart';
import '../../../core/helpers.dart';
import '../../../domain/entities/article_entity.dart';

/// A page that displays the details of a single news article.
class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  /// Launches the original article URL in an external browser.
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir la URL $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the article from the route arguments.
    final article = ModalRoute.of(context)?.settings.arguments as ArticleEntity?;

    if (article == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Artículo no encontrado.')),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: const BackButton(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                  )
                : _buildPlaceholderImage(),
          ),

          // Sliding Content Card
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 280),
                Container(
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Source Tag
                      if (article.sourceName != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: kAccentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.sourceName!,
                            style: const TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Metadata
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            formatArticleDate(article.publishedAt),
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (article.author != null)
                        Text(
                          'Por: ${article.author}',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                              fontSize: 13),
                        ),
                      
                      const Divider(height: 30),

                      if (article.description != null) ...[
                        Text(
                          article.description!,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.5),
                        ),
                        const SizedBox(height: 20),
                      ],

                      if (article.content != null)
                        Text(
                          article.content!
                              .replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), ''),
                          style: TextStyle(
                              fontSize: 16, height: 1.6, color: Colors.grey[800]),
                        )
                      else
                        const Text(
                          'Visita el enlace original para leer más.',
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),

                      const SizedBox(height: 40),

                      // "Read Full Article" Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: article.url != null
                              ? () => _launchUrl(article.url!)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text(
                            'Leer Noticia Completa',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a placeholder widget for the article image.
  Widget _buildPlaceholderImage({double? height}) {
    return Container(
      width: double.infinity,
      height: height,
      color: kBackgroundColor,
      alignment: Alignment.center,
      child: const Icon(
        Icons.newspaper,
        color: Colors.grey,
        size: 50,
      ),
    );
  }
}