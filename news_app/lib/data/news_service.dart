import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'package:news_app/models/news.dart';
class NewsService{
  static NewsService _singleton=NewsService._internal();
  NewsService._internal();

  factory NewsService(){
    return _singleton;
  }

  static Future<List<Articles>> getNews() async{
      String url = 
          'http://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c46c918cf4f144b0a5a69a166b77c6df';
      
      final response = await http.get(Uri.parse(url));
      if(response.body.isNotEmpty){
          final responseJson= json.decode(response.body);
          News news=News.fromJson(responseJson);
          return news.articles;
      }
      return null;

  }

}