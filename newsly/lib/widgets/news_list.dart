import 'package:flutter/material.dart';
import '../data/models/news_article_model.dart';
import 'news_card.dart';

/// Widget to display the list of news articles
class NewsList extends StatelessWidget {
  final List<NewsArticle> articles;

  const NewsList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const Center(child: Text('No se encontraron noticias.'));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return NewsCard(article: articles[index]);
      },
    );
  }
}