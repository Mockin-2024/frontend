import 'package:http/http.dart' as http;
import 'package:mockin/dto/condition_search_dto.dart';
import 'dart:convert';

import 'package:mockin/models/basic_stock_model.dart';

class BasicApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String basic = 'basic';
  static const String search = 'search';

  static Future<List<BasicStockModel>> conditionSearch({
    required ConditionSearchDTO DTO,
  }) async {
    List<BasicStockModel> stockInstances = [];
    final url = DTO.convert('$baseUrl/$basic/$search');

    // GET 요청 보내기
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> stocks =
          jsonDecode(utf8.decode(response.bodyBytes))['output2'];
      for (var stock in stocks) {
        stockInstances.add(
          BasicStockModel.fromJson(stock),
        );
      }
      return stockInstances;
    }
    throw Error();
  }
}
