import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/api_constants.dart';
import '../models/news_article_model.dart';
import 'news_remote_data_source.dart';

/// Handles communication with the News API.
class NewsApi implements NewsRemoteDataSource {
  
  /// The HTTP client for making requests.
  final http.Client httpClient;

  NewsApi({required this.httpClient});

  /// Fetches the top headlines from the API.
  @override
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final apiKey = dotenv.env['NEWS_API_KEY'];
    final url = Uri.parse(
        '$kBaseUrl$kTopHeadlinesPath?country=$kCountryCode&apiKey=$apiKey');
    
    try {
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['status'] == 'ok' && data['articles'] != null) {
          final List<dynamic> articlesJson = data['articles'];
          
          return articlesJson
              .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Error en la respuesta de la API: ${data['message']}');
        }
      } else {
        // Handle HTTP errors (e.g., 404, 500).
        throw Exception('Fallo al cargar noticias. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción al realizar la petición: $e');
    }
  }
}