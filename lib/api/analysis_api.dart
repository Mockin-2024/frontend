import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/analysis/news_request_dto.dart';
import 'package:mockin/models/news_content_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mockin/storage/jwt_token.dart';

class AnalysisApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String quo = 'quotations';
  static const String analysis = 'analysis';
  static const String reqnews = 'news-title';

  // 해외뉴스종합 api
  static Future<List<NewsContentModel>> reqNews({
    required NewsRequestDTO DTO,
  }) async {
    List<NewsContentModel> news = [];
    final url = DTO.convert('$baseUrl/$quo/$analysis/$reqnews');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    // print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      List<dynamic> newsblocks =
          jsonDecode(utf8.decode(response.bodyBytes))['outblock1'];
      for (var newsblock in newsblocks) {
        news.add(
          NewsContentModel.fromJson(newsblock),
        );
      }
      return news;
    }
    print('failed');
    return news;
  }
}
