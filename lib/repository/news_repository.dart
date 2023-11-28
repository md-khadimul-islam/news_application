import 'dart:convert';

import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/utils/constant.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsHeadlines> fetchNewsHeadlines () async {
    final String baseUrl = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&';
    final endUrl = 'apiKey=$newsApiKey';
    final url = Uri.parse('$baseUrl$endUrl');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NewsHeadlines.fromJson(json);
    }
    throw Exception('error');
  }
}