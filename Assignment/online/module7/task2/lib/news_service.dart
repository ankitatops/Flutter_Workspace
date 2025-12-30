import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article.dart';

class NewsService {
  // Public JSON endpoint without API key
  final String apiUrl =
      'https://saurav.tech/NewsAPI/top-headlines/category/general/in.json';

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson
          .map((jsonItem) => Article.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
