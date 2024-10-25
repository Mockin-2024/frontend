import 'package:http/http.dart' as http;
import 'package:mockin/dto/login/email_auth_dto.dart';
import 'package:mockin/dto/login/login_dto.dart';
import 'package:mockin/dto/login/send_to_email_dto.dart';
import 'dart:convert';

import 'package:mockin/dto/login/signup_dto.dart';

class LoginApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String auth = 'auth';
  static const String signup = 'signup';
  static const String send = 'send';
  static const String login = 'login';
  static const String check = 'check';

  // 유저 회원가입 api
  static Future<String> userSignUp({
    required SignupDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$auth/$signup');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(DTO.toJson()),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['message'];
    }
    return '-';
  }

  // 이메일 전송 api
  static Future<String> sendEmail({
    required SendToEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$auth/$send');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(DTO.toJson()),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['message'];
    }
    return '-';
  }

  // 로그인 api
  static Future<String> loginRequest({
    required LoginDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$auth/$login');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(DTO.toJson()),
    );
    print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['token'];
    }
    return '';
  }

  // 이메일 인증 api
  static Future<String> emailCheck({
    required EmailAuthDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$auth/$check');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(DTO.toJson()),
    );
    print('>>> ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['message'];
    }
    return '-';
  }
}
