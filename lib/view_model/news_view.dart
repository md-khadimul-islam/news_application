
import 'package:news_application/models/news_headlines.dart';
import 'package:news_application/repository/news_repository.dart';

class NewsView {

  final _rep = NewsRepository();

  Future<NewsHeadlines> fetchNewsHeadlines() async {
    final response = _rep.fetchNewsHeadlines();
    return response;
  }
}