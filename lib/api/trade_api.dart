// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/cancel_correction_dto.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/dto/trading/nccs_dto.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/dto/trading/psamount_dto.dart';
import 'dart:convert';
import 'package:mockin/dto/trading/stock_order_dto.dart';
import 'package:mockin/models/personal_stock_item.dart';
import 'package:mockin/models/stock_breakdown.dart';
import 'package:mockin/models/stock_own.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:mockin/afterlogin/user_email.dart';

class TradeApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String trading = 'trading';
  static const String order = 'order';
  static const String cancor = 'order-reverse'; // 정정취소 주문
  static const String psamount = 'psamount';
  static const String pBalance = 'present-balance';
  static const String lBalance = 'balance'; // balance list
  static const String mcnj = 'nccs'; // 미체결내역 조회
  static const String jmcn = 'ccnl'; // 주문체결 내역

  // 매수 api
  static Future<String> buyOrder({
    required StockOrderDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$order');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['msg1'] ?? '매수 주문 완료';
    }
    return '매수 시도 실패';
  }

  // 매도 api
  static Future<String> sellOrder({
    required StockOrderDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$order');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['msg1'] ?? '매도 주문 완료';
    }
    return '매도 주문 실패';
  }

  // 정정취소주문 api
  static Future cancelCorrection({
    required CancelCorrectionDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$trading/$cancor');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
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
    List<String> tmp = [];
    final url = DTO.convert('$baseUrl/$trading/$psamount');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

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
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['output3']
          ['tot_asst_amt'];
    }
    print('>>> failed');
    return '';
  }

  // 잔고 api - 투자 종목 + 총 자산 등등
  static Future<List<dynamic>> balance({
    required BalanceDTO DTO,
  }) async {
    List<PersonalStockItem> li = [];
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      List<dynamic> yours =
          jsonDecode(utf8.decode(response.bodyBytes))['output1'];
      for (var your in yours) {
        li.add(
          PersonalStockItem.fromJson(your),
        );
      }
      dynamic a = jsonDecode(utf8.decode(response.bodyBytes))['output2'];
      return [li, a['frcr_pchs_amt1'], a['ovrs_tot_pfls'], a['tot_pftrt']];
    }
    print('>>> failed');
    return [li, '0.0', '0.0', '0.0'];
  }

  // 잔고 api - 매매 화면 : 보유한 주식인지 확인 - 없으면 판매 비활성화
  static Future balanceDoIHave({
    required BalanceDTO DTO,
    required String stockName,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

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

  // 잔고 api - 매도 : 매입 평균 가격 + 해외잔고수량
  static Future<List<String>> balanceHowMuch({
    required BalanceDTO DTO,
    required String stockName,
  }) async {
    final url = DTO.convert('$baseUrl/$trading/$lBalance');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

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
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
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
    Uri url = DTO.convert('$baseUrl/$trading/$jmcn');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
    });

    if (response.statusCode == 200) {
      // print('>>> 체결내역 조회 결과 : ${jsonDecode(utf8.decode(response.bodyBytes))}');
      // print(
      //     '>>> 체결내역 조회 결과 : ${jsonDecode(utf8.decode(response.bodyBytes))['ctx_area_fk200']}');
      // print(
      //     '>>> 체결내역 조회 결과 : ${jsonDecode(utf8.decode(response.bodyBytes))['ctx_area_nk200']}');
      var jd = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> li = jd['output'];
      for (var l in li) {
        nc.add(StockOwn.fromJson(l));
      }
      // while (jd['ctx_area_nk200'] != '') {
      //   url = CcnlDTO(
      //           orderStartDate: DTO.orderStartDate,
      //           orderEndDate: DTO.orderEndDate,
      //           email: DTO.email)
      //       .convert('$baseUrl/$trading/$jmcn');
      // }
      return nc;
    }
    print('>>> failed');
    return nc;
  }
}
