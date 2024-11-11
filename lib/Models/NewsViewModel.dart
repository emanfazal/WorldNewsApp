import 'package:news_app/Models/CategoriesModel.dart';
import 'package:news_app/Models/NewsChannelHeadlinesModel.dart';
import 'package:news_app/Repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String value) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(value); // Pass the value here
    return response;
  }
  Future<Categories> fetchNewsCategoriesApi(String category) async {
    final c_response = await _rep.fetchCategoriesApi(category); // Pass the value here
    return c_response;
  }
}
