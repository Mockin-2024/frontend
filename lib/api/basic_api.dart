// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/basic/condition_search_dto.dart';
import 'package:mockin/dto/basic/current_detailed_dto.dart';
import 'package:mockin/dto/basic/current_price_dto.dart';
import 'package:mockin/dto/basic/index_chart_dto.dart';

import 'package:mockin/dto/basic/payment_day_dto.dart';
import 'package:mockin/dto/basic/stock_chart_dto.dart';
import 'package:mockin/dto/basic/term_dto.dart';
import 'package:mockin/dto/basic/year_dto.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:mockin/models/basic_stock_model.dart';
import 'package:mockin/models/chart_data.dart';

import 'package:mockin/storage/jwt_token.dart';

class BasicApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String quo = 'quotations';
  static const String basic = 'basic';
  static const String search = 'inquire-search';
  static const String current = 'price';
  static const String term = 'inquire-daily-chartprice';
  static const String forYear = 'daily-chart-price';
  static const String paymentDay = 'countries-holiday';
  static const String cpd = 'price-detail';
  static const String chart = 'inquire-time-itemchartprice';
  static const String indexChart = 'inquire-time-indexchartprice';

  // 조건검색 api
  static Future<List<BasicStockModel>> conditionSearch({
    required ConditionSearchDTO DTO,
    required int opt,
  }) async {
    List<BasicStockModel> stockInstances = [];
    final url = DTO.convert('$baseUrl/$quo/$basic/$search');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      final List<dynamic> stocks =
          jsonDecode(utf8.decode(response.bodyBytes))['output2'];
      for (var stock in stocks) {
        stockInstances.add(
          BasicStockModel.fromJson(stock),
        );
      }
      if (opt < 3) {
        if (opt == 1) {
          // 거래대금
          stockInstances.sort(
            (a, b) => double.parse(b.avol).compareTo(double.parse(a.avol)),
          );
        } else if (opt == 2) {
          // 거래량
          stockInstances.sort(
            (a, b) => double.parse(b.tvol).compareTo(double.parse(a.tvol)),
          );
        }
      } else {
        if (opt == 3) {
          // 시가총액
          stockInstances.sort(
            (a, b) => double.parse(b.valx).compareTo(double.parse(a.valx)),
          );
        } else if (opt == 4) {
          // 급상승
          stockInstances.sort(
            (a, b) => double.parse(b.toRateSort)
                .compareTo(double.parse(a.toRateSort)),
          );
        } else if (opt == 5) {
          // 급하락
          stockInstances.sort(
            (a, b) => double.parse(a.toRateSort)
                .compareTo(double.parse(b.toRateSort)),
          );
        }
      }
    }
    return stockInstances;
  }

  // 현재체결가 api (매도불가)
  static Future currentPrice({
    required CurrentPriceDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$quo/$basic/$current');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['output']['ordy'];
    }
    return '-';
  }

  // 기간별시세 api
  static Future termPrice({
    required TermDTO DTO,
    required int idx,
  }) async {
    List<String> clsPrice = [];
    final url = DTO.convert('$baseUrl/$quo/$basic/$term');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      final List<dynamic> prices =
          jsonDecode(utf8.decode(response.bodyBytes))['output2'];
      for (var price in prices) {
        clsPrice.add(price['clos']);
      }
      return clsPrice[idx];
    }
    return '0';
  }

  // 종목/지수/환율기간별시세 api
  static Future yearPrice({
    required YearDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$quo/$basic/$term');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

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
    final url = DTO.convert('$baseUrl/$quo/$basic/$paymentDay');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

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
    final url = DTO.convert('$baseUrl/$quo/$basic/$cpd');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }

  // 주식분봉조회 api
  static Future minutesChart({
    required StockChartDTO DTO,
    required int period,
  }) async {
    List<ChartData> datas = [];
    Uri url = DTO.convert('$baseUrl/$quo/$basic/$chart');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      List<dynamic> bunbongs =
          jsonDecode(utf8.decode(response.bodyBytes))['output2'];
      for (var bun in bunbongs) {
        datas.add(
          ChartData(
            dt: stringToDateTime(
              bun['kymd'],
              bun['khms'],
            ),
            last: double.parse(bun['last']),
          ),
        );
      }
      for (var i = 0; i < period - 1; i++) {
        url = StockChartDTO(
          EXCD: DTO.EXCD,
          SYMB: DTO.SYMB,
          NMIN: DTO.NMIN,
          PINC: DTO.PINC,
          NREC: DTO.NREC,
          NEXT: '1',
          KEYB: get_next_keyb(datas.last.dt, '1'),
        ).convert('$baseUrl/$basic/$chart');
        response = await http.get(url, headers: {
          'Authorization':
              'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
        });
        if (response.statusCode == 200) {
          bunbongs = jsonDecode(utf8.decode(response.bodyBytes))['output2'];
          for (var bun in bunbongs) {
            datas.add(
              ChartData(
                dt: stringToDateTime(
                  bun['kymd'],
                  bun['khms'],
                ),
                last: double.parse(bun['last']),
              ),
            );
          }
        }
      }
    }
    datas.sort((a, b) => a.dt.compareTo(b.dt));
    return datas;
  }

  static DateTime stringToDateTime(String dateStr, String timeStr) {
    // 날짜 문자열 처리 (YYMMDD)
    int year = int.parse(dateStr.substring(0, 4));
    int month = int.parse(dateStr.substring(4, 6));
    int day = int.parse(dateStr.substring(6, 8));

    // 시간 문자열 처리 (HHMMSS)
    int hour = int.parse(timeStr.substring(0, 2));
    int minute = int.parse(timeStr.substring(2, 4));
    int second = int.parse(timeStr.substring(4, 6));

    // DateTime 객체 생성
    return DateTime(year, month, day, hour, minute, second);
  }

  // 다음 조회용 KEYB 값 계산 함수 (nmin에 따라 시간 조정)
  static String get_next_keyb(DateTime dt, String nMin) {
    return DateFormat('yyyyMMddHHmmss')
        .format(dt.subtract(Duration(minutes: int.parse(nMin))))
        .toString();
  }

  // 지수분봉조회 api
  static Future minutesIndexChart({
    required IndexChartDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$quo/$basic/$indexChart');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return;
    }
    throw Error();
  }
}
