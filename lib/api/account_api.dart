import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mockin/dto/account/acnt_num_register_dto.dart';
import 'package:mockin/dto/account/key_pair_register_dto.dart';
import 'package:mockin/dto/account/user_email_dto.dart';

class AccountApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String account = 'account';
  static const String user = 'user';
  static const String mock = 'mock-key';
  static const String real = 'real-key';
  static const String mockWebSocket = 'mock-approval-key';
  static const String realWebSocket = 'real-approval-key';
  static const String mockToken = 'mock-token';
  static const String realToken = 'real-token';

  // 모의계좌 번호 등록 api
  static Future accountRegister({
    required AcntNumRegisterDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$user');
    final response = await http.patch(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': DTO.email,
        'accountNumber': DTO.accountNumber,
      }),
    );
    print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // 모의투자용 키 등록 api
  static Future mockKeyRegister({
    required KeyPairRegisterDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$mock');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': DTO.email,
        'appKey': DTO.appKey,
        'appSecret': DTO.appSecret,
      }),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // 실전투자용 키 등록 api
  static Future realKeyRegister({
    required KeyPairRegisterDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$real');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': DTO.email,
        'appKey': DTO.appKey,
        'appSecret': DTO.appSecret,
      }),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // 모의 웹소켓 키 get api
  static Future getMockSocketKey({
    required UserEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$mockWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": DTO.email,
      }),
    );
    if (response.statusCode == 200) {
      print('>>> mockSocket Body: ${response.body}');
      return true;
    }
    return false;
  }

  // 실전 웹소켓 키 get api
  static Future getRealSocketKey({
    required UserEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$realWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": DTO.email,
      }),
    );
    if (response.statusCode == 200) {
      print('>>> realSocket Body: ${response.body}');
      return true;
    }
    return false;
  }

  // 모의 토큰 get api
  static Future getMockToken({
    required UserEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$mockToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": DTO.email,
      }),
    );
    if (response.statusCode == 200) {
      print('>>> mockToken Body: ${response.body}');
      return true;
    }
    return false;
  }

  // 실전 토큰 get api
  static Future getRealToken({
    required UserEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$realToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": DTO.email,
      }),
    );
    if (response.statusCode == 200) {
      print('>>> realToken Body: ${response.body}');
      return true;
    }
    return false;
  }
}
