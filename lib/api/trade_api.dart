import 'package:http/http.dart' as http;
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/dto/trading/nccs_dto.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'dart:convert';
import 'package:mockin/dto/trading/stock_order_dto.dart';
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
  static Future buyOrder({
    required StockOrderDTO dto,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$order');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "transactionId": '',
        "overseasExchangeCode": ExchangeTrans.orderTrade[dto.excd],
        "productNumber": dto.symb,
        "orderQuantity": dto.orderQuantity,
        "overseasOrderUnitPrice": "0",
        "email": dto.email,
      }),
    );
    print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
      return true;
    }
    return false;
  }

  // 판매 api
  static Future sellOrder({
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
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // 매수가능금액조회 api
  static Future psAmount({
    required PsamountDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$psamount');
    final response = await http.get(url);

    print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return true;
    }
    print('>>> failed');
    return false;
  }

  // 체결기준현재잔고 api
  static Future presentBalance({
    required PresentBalanceDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$pBalance');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return true;
    }
    print('>>> failed');
    return false;
  }

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

  // 미체결내역 조회 api
  static Future nccs({
    required NccsDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$mcnj');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return true;
    }
    print('>>> failed');
    return false;
  }

  // 주문체결 내역 api
  static Future ccnl({
    required CcnlDTO DTO,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$jmcn');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      return true;
    }
    print('>>> failed');
    return false;
  }
}
