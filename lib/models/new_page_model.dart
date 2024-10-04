// import 'package:cyber_secure/modules/categories_new_model.dart';
// import 'package:cyber_secure/modules/news_channels_headline_models.dart';
// import 'package:cyber_secure/repositroy/news_repository.dart';
// import 'package:cyber_secure/modules/categories_new_model.dart';
import 'package:edu_app/models/headline.dart';
import 'package:edu_app/models/news_model.dart';
import 'package:edu_app/repository/news_repo.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlineModels> fetchNewsChannelHeadlineApi() async {
    final response = await _rep.fetchNewsChannelHeadlineApi();
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}