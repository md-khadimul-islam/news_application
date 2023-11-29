
import 'package:news_application/models/news_categories.dart';
import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/repository/news_repository.dart';

class NewsView {

  final _rep = NewsRepository();

  Future<NewsHeadlines> fetchNewsHeadlines(String newsChannel) async {
    final response = await _rep.fetchNewsHeadlines(newsChannel);
    return response;
  }
  Future<NewsCategories> fetchNewsCategories(String category) async {
    final response = await _rep.fetchNewsCategories(category);
    return response;
  }
}