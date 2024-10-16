import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String account = 'account';
  static const String user = 'user';
  static const String mock = 'mock-key';
  static const String real = 'real-key';
  static const String mockWebSocket = 'mock-approval-key';
  static const String realWebSocket = 'real-approval-key';
  static const String mockToken = 'mock-token';
  static const String realToken = 'real-token';

  static Future userAccount(String email, String name) async {
    final url = Uri.parse('$baseUrl/$account/$user');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'name': name,
      }),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } // 유저 등록 api

  static Future accountRegister(String email, String accountNumber) async {
    final url = Uri.parse('$baseUrl/$account/$user');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'accountNumber': accountNumber,
      }),
    );
    print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } // 계좌 등록 api

  static Future mockKeyRegister(
      String mockappkey, String mockappsecretkey, String email) async {
    final url = Uri.parse('$baseUrl/$account/$mock');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'appKey': mockappkey,
        'appSecret': mockappsecretkey,
        'email': email,
      }),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } // 모의투자용 키 등록 api

  static Future realKeyRegister(
      String realappkey, String realappsecretkey, String email) async {
    final url = Uri.parse('$baseUrl/$account/$real');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'appKey': realappkey,
        'appSecret': realappsecretkey,
        'email': email,
      }),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } // 실전투자용 키 등록 api

  static Future getMockSocketKey(String email) async {
    final url = Uri.parse('$baseUrl/$account/$mockWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    print('>>> mockSocket ${response.statusCode}');
    if (response.statusCode == 200) {
      print('>>> mockSocket Body: ${response.body}');
      return true;
    }
    return false;
  } // 모의 웹소켓 키 get api

  static Future getRealSocketKey(String email) async {
    final url = Uri.parse('$baseUrl/$account/$realWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    print('>>> realSocket ${response.statusCode}');
    if (response.statusCode == 200) {
      print('>>> realSocket Body: ${response.body}');
      return true;
    }
    return false;
  } // 실전 웹소켓 키 get api

  static Future getMockToken(String email) async {
    final url = Uri.parse('$baseUrl/$account/$mockToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    print('>>> mockToken ${response.statusCode}');
    if (response.statusCode == 200) {
      print('>>> mockToken Body: ${response.body}');
      return true;
    }
    return false;
  } // 모의 토큰 get api

  static Future getRealToken(String email) async {
    final url = Uri.parse('$baseUrl/$account/$realToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    print('>>> realToken ${response.statusCode}');
    if (response.statusCode == 200) {
      print('>>> realToken Body: ${response.body}');
      return true;
    }
    return false;
  } // 실전 토큰 get api
}
