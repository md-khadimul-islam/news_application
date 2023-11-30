import 'dart:convert';

import 'package:news_application/models/news.dart';
import 'package:news_application/models/news_categories.dart';
import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/utils/constant.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsHeadlines> fetchNewsHeadlines (String newsChannel) async {
    final String baseUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&';
    final endUrl = 'apiKey=$newsApiKey';
    final url = Uri.parse('$baseUrl$endUrl');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NewsHeadlines.fromJson(json);
    }
    throw Exception('error');
  }
  Future<NewsCategories> fetchNewsCategories (String category) async {
    final String baseUrl = 'https://newsapi.org/v2/everything?q=${category}&';
    final endUrl = 'apiKey=$newsApiKey';
    final url = Uri.parse('$baseUrl$endUrl');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NewsCategories.fromJson(json);
    }
    throw Exception('error');
  }
  Future<News> getNews() async {
    final String baseUrl = 'https://newsapi.org/v2/everything?q=apple&from=2023-11-29&to=${toDate}&sortBy=popularity&';
    final endUrl = 'apiKey=$newsApiKey';
    final url = Uri.parse('$baseUrl$endUrl');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return News.fromJson(json);
    }
    throw Exception('error');
  }
}