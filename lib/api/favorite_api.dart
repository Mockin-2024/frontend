import 'package:mockin/dto/favorite/favorite_stock_dto.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:mockin/storage/user_email.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String favorite = 'favorite';
  static const String select = 'select';
  static const String add = 'add';
  static const String delete = 'delete';
  static const String read = 'read';

  // 선호 종목 추가/삭제 api
  static Future<bool> addDeleteFavorite({
    required FavoriteStockDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$favorite/$select');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken().read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
    );
    // print('>>> 즐찾 종목 추가/삭제 ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      // if (jsonDecode(utf8.decode(response.bodyBytes))['message']
      //     .toString()
      //     .contains('Add')) {
      //   print('>>> 추가 성공');
      // } else {
      //   print('>>> 삭제 성공');
      // }
      return true;
    }
    // print('>>> 선호 종목 추가/삭제 실패');
    return false;
  }

  // 선호 종목 읽기 api
  static Future<Map<String, List<String>>> readFavoriteStock() async {
    Map<String, List<String>> data = {
      'NAS': [],
      'NYS': [],
      'HKS': [],
      'AMS': [],
      'SHS': [],
      'SZS': [],
      'HSX': [],
      'HNX': [],
      'TSE': [],
    };
    final url = Uri.parse('$baseUrl/$favorite/$read');
    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer ${await JwtToken().read(UserEmail().getEmail()!)}',
      },
    );
    // print('>>> 선호 종목 읽기 ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      var favoriteData = jsonDecode(utf8.decode(response.bodyBytes))['output1'];
      for (var favorite in favoriteData) {
        data[favorite['excd']]!.add(favorite['symb']);
      }
      return data;
    }
    // print('>>> 선호 종목 읽기 실패');
    return data;
  }
}
