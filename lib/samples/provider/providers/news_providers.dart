import 'dart:convert';

import '../models/news.dart';
import 'package:http/http.dart' as http;

class NewsProviders{
  Uri uri = Uri.parse("https://newsapi.org/v2/top-headlines?country=kr&apiKey=b526c8b83fb34be89a54447881072c1c");

  Future<List<News>> getNews() async {
    List<News> news = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      news = jsonDecode(response.body)['articles'].map<News>( (article111) {
        return News.fromMap(article111);
      }).toList();
    }

    return news;
  }


}