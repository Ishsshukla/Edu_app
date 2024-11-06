// import 'dart:convert';

// import 'package:edu_app/models/headline.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// // import 'package:models/news_model.dart';
// // import 'package:models/news_models.dart';
// import 'package:edu_app/models/news_model.dart';
// // import 'package:cyber_secure/modules/categories_new_model.dart';
// // import 'package:cyber_secure/modules/news_channels_headline_model.dart';
// // import 'package:cyber_secure/modules/news_channels_headline_models.dart';

// class NewsRepository {
//   // Future<NewsChannelsHeadlineModels> fetchNewsChannelHeadlineApi() async {
//   //   String url = 'https://cyber-secure.onrender.com/v1/cyberTrends';

//   //   final response = await http.get(Uri.parse(url));
//   //   if (kDebugMode) {
//   //     print(response.body);
//   //   }
//   //   if (response.statusCode == 200) {
//   //     final body = jsonDecode(response.body);
//   //     return NewsChannelsHeadlineModels.fromJson(body);
//   //   }
//   //   throw Exception('Error');
//   // }

//   Future<NewsChannelsHeadlineModels> fetchNewsChannelHeadlineApi() async {
//     String url =
//         'https://newsapi.org/v2/everything?q=Loan+Fraud&apiKey=65f8ae3b4a8b41bb813bd0b06074aa5f';

//     final response = await http.get(Uri.parse(url));
//     if (kDebugMode) {
//       print(response.body);
//     }
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       return NewsChannelsHeadlineModels.fromJson(body);
//     }
//     throw Exception('Error');
//   }

//   Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
//     String Url =
//         'https://newsapi.org/v2/everything?q=$category&apiKey=65f8ae3b4a8b41bb813bd0b06074aa5f';
//     print(Url);
//     final response = await http.get(Uri.parse(Url));
//     if (kDebugMode) {
//       print(response.body);
//     }
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);

//       return CategoriesNewsModel.fromJson(body);
//     }
//     throw Exception('Error');
//   }

//   // Future<CategoriesFraudTrends> fetchCategoriesFraudTrends(String category) async {
//   //   String Url =
//   //       'https://newsapi.org/v2/everything?q=${category}&apiKey=65f8ae3b4a8b41bb813bd0b06074aa5f';
//   //   print(Url);
//   //   final response = await http.get(Uri.parse(Url));
//   //   if (kDebugMode) {
//   //     print(response.body);
//   //   }
//   //   if (response.statusCode == 200) {
//   //     final body = jsonDecode(response.body);

//   //     return CategoriesNewsModel.fromJson(body);
//   //   }
//   //   throw Exception('Error');
//   // }
// }

import 'dart:convert';
import 'package:edu_app/models/headline.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:edu_app/models/news_model.dart';

class NewsRepository {
  final String _apiKey =
      '65f8ae3b4a8b41bb813bd0b06074aa5f';
  final String _baseUrl = 'https://newsapi.org/v2/everything';

  Future<NewsChannelsHeadlineModels> fetchNewsChannelHeadlineApi() async {
    // Query to fetch news related to Sainik School exams, RIMC, and defense sector
    final String query = 'latest current affairs in India';
    final String url = '$_baseUrl?q=$query&language=en&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlineModels.fromJson(body);
    }
    throw Exception('Error fetching news headlines');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    // Adjusted to fetch category-based news by passing specific category parameter
    final String url = '$_baseUrl?q=$category&language=en&apiKey=$_apiKey';

    if (kDebugMode) {
      print("Requesting: $url");
    }

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error fetching category news');
  }
}
