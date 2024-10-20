// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/dto/trading/nccs_dto.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'dart:convert';
import 'package:mockin/dto/trading/stock_order_dto.dart';
import 'package:mockin/models/stock_breakdown.dart';
import 'package:mockin/models/stock_own.dart';
import 'package:mockin/provider/exchange_trans.dart';

class TradeApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String trading = 'trading';
  static const String order = 'order';
  static const String psamount = 'psamount';
  static const String pBalance = 'present-balance';
  static const String lBalance = 'balance'; // balance list
  static const String mcnj = 'nccs'; // 미체결내역 조회
  static const String jmcn = 'ccnl'; // 주문체결 내역

  // 구매 api
  static Future<String> buyOrder({
    required StockOrderDTO dto,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$order');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "transactionId": ExchangeTrans.buyOrder[dto.excd],
        "overseasExchangeCode": ExchangeTrans.orderTrade[dto.excd],
        "productNumber": dto.symb,
        "orderQuantity": dto.orderQuantity,
        "overseasOrderUnitPrice": "0",
        "email": dto.email,
      }),
    );
    print('>>> ${response.statusCode}');
    print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200 || response.statusCode == 502) {
      return jsonDecode(utf8.decode(response.bodyBytes))['message'];
    }
    return '구매 시도 실패';
  }

  // 판매 api
  static Future<String> sellOrder({
    required StockOrderDTO dto,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$order');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "transactionId": ExchangeTrans.sellOrder[dto.excd],
        "overseasExchangeCode": ExchangeTrans.orderTrade[dto.excd],
        "productNumber": dto.symb,
        "orderQuantity": dto.orderQuantity,
        "overseasOrderUnitPrice": "0",
        "email": dto.email,
      }),
    );
    print('>>> ${response.statusCode}');
    print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200 || response.statusCode == 502) {
      return jsonDecode(utf8.decode(response.bodyBytes))['message'];
    }
    return '판매 시도 실패';
  }

  // 매수가능금액조회 api
  static Future psAmount({
    required PsamountDTO DTO,
  }) async {
    List<String> tmp = [];
    final url = DTO.convert('$baseUrl/$trading/$psamount');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic how = jsonDecode(utf8.decode(response.bodyBytes))['output'];
      tmp.add(how['frcr_ord_psbl_amt1']);
      tmp.add(how['ovrs_max_ord_psbl_qty']);
      return tmp;
    }
    return ['0', '0'];
  }

  // 체결기준현재잔고 api (총 자산)
  static Future presentBalance({
    required PresentBalanceDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$pBalance');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes))['output3']);
      return jsonDecode(utf8.decode(response.bodyBytes))['output3']
          ['tot_asst_amt'];
    }
    print('>>> failed');
    return '';
  }
  // TradeApi.presentBalanceStockHave(
  //                   DTO: PresentBalanceDTO(
  //                     currencyDivisonCode: '02',
  //                     countryCode: '000',
  //                     marketCode: '00',
  //                     inquiryDivisionCode: '00',
  //                     email: UserEmail().getEmail()!,
  //                   ),
  //                   stock: widget.stockName,
  //                 ),

  // 잔고 api
  static Future balance({
    required BalanceDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return true;
    }
    print('>>> failed');
    return false;
  }

  // 잔고 api - 보유한 주식인지 확인
  static Future balanceDoIHave({
    required BalanceDTO DTO,
    required String stockName,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url);

    print(jsonDecode(utf8.decode(response.bodyBytes))['output1']);
    if (response.statusCode == 200) {
      final List<dynamic> how =
          jsonDecode(utf8.decode(response.bodyBytes))['output1'];
      for (var many in how) {
        if (many['ovrs_item_name'] == stockName) {
          print('>>> you have!');
          return true;
        }
      }
    }
    print('>>> don\'t have');
    return false;
  }

  // 잔고 api - 매입 평균 가격 + 해외잔고수량
  static Future<List<String>> balanceHowMuch({
    required BalanceDTO DTO,
    required String stockName,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url);

    print(jsonDecode(utf8.decode(response.bodyBytes))['output1']);
    if (response.statusCode == 200) {
      final List<dynamic> how =
          jsonDecode(utf8.decode(response.bodyBytes))['output1'];
      for (var much in how) {
        if (much['ovrs_item_name'] == stockName) {
          return [much['pchs_avg_pric'], much['ovrs_cblc_qty']];
        }
      }
    }
    print('>>> don\'t have');
    return ['0.0', '0.0'];
  }

  // 미체결내역 조회 api
  static Future<List<StockBreakdown>> nccs({
    required NccsDTO DTO,
  }) async {
    List<StockBreakdown> nc = [];
    final url = DTO.convert('$baseUrl/$trading/$mcnj');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes))['output']);
      List<dynamic> li = jsonDecode(utf8.decode(response.bodyBytes))['output'];
      for (var l in li) {
        nc.add(StockBreakdown.fromJson(l));
      }
      return nc;
    }
    print('>>> failed');
    return nc;
  }

  // 주문체결 내역 api
  static Future<List<StockOwn>> ccnl({
    required CcnlDTO DTO,
  }) async {
    List<StockOwn> nc = [];
    final url = DTO.convert('$baseUrl/$trading/$jmcn');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes))['output']);
      List<dynamic> li = jsonDecode(utf8.decode(response.bodyBytes))['output'];
      for (var l in li) {
        nc.add(StockOwn.fromJson(l));
      }
      return nc;
    }
    print('>>> failed');
    return nc;
  }
}
