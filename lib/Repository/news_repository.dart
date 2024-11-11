import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/CategoriesModel.dart' ;
import '../Models/NewsChannelHeadlinesModel.dart';

class NewsRepository {


  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String value) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=$value&apiKey=a988c63d6a7244108b117ff471bb15a6';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print("API Response for $value: $body");
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<Categories> fetchCategoriesApi(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=a988c63d6a7244108b117ff471bb15a6';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print("API Response for $category: $body");
      return Categories.fromJson(body);
    }
    throw Exception('Error');
  }

}
