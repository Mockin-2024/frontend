// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:mockin/dto/basic/condition_search_dto.dart';
import 'package:mockin/dto/basic/current_detailed_dto.dart';
import 'package:mockin/dto/basic/current_price_dto.dart';
import 'package:mockin/dto/basic/index_chart_dto.dart';
import 'package:mockin/dto/basic/payment_day_dto.dart';
import 'package:mockin/dto/basic/stock_chart_dto.dart';
import 'package:mockin/dto/basic/term_dto.dart';
import 'package:mockin/dto/basic/year_dto.dart';
import 'dart:convert';
import 'package:mockin/models/basic_stock_model.dart';

class BasicApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String basic = 'basic';
  static const String search = 'search';
  static const String current = 'current';
  static const String term = 'term';
  static const String forYear = 'daily-chart-price';
  static const String paymentDay = 'countries-holiday';
  static const String cpd = 'price-detail';
  static const String chart = 'item-chart-price';
  static const String indexChart = 'index-chart-price';

  // 조건검색 api
  static Future<List<BasicStockModel>> conditionSearch({
    required ConditionSearchDTO DTO,
  }) async {
    List<BasicStockModel> stockInstances = [];
    final url = DTO.convert('$baseUrl/$basic/$search');
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

  // 현재체결가 api
  static Future currentPrice({
    required CurrentPriceDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$current');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes))['output']['ordy']);
      return;
    }
    throw Error();
  }

  // 기간별시세 api
  static Future termPrice({
    required TermDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$term');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 종목/지수/환율기간별시세 api
  static Future yearPrice({
    required YearDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$term');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 결제일자조회 api
  static Future getPaymentDay({
    required PaymentDayDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$paymentDay');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 현재가상세 api
  static Future currentDetailed({
    required CurrentDetailedDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$cpd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 주식분봉조회 api
  static Future minutesChart({
    required StockChartDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$chart');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 지수분봉조회 api
  static Future minutesIndexChart({
    required IndexChartDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$basic/$indexChart');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }
}
