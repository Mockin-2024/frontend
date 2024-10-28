import 'package:http/http.dart' as http;
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/account/user_email_dto.dart';
import 'package:mockin/storage/jwt_token.dart';

class Oauth2Api {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String auth = 'oauth2';
  static const String mockWebSocket = 'mock-approval-key';
  static const String realWebSocket = 'real-approval-key';
  static const String mockToken = 'mock-token';
  static const String realToken = 'real-token';

  // 모의 웹소켓 키 get api
  static Future getMockSocketKey({
    required UserEmailDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$auth/$mockWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      // body: jsonEncode(DTO.toJson()),
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
    final url = Uri.parse('$baseUrl/$auth/$realWebSocket');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      // body: jsonEncode(DTO.toJson()),
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
    final url = Uri.parse('$baseUrl/$auth/$mockToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      // body: jsonEncode(DTO.toJson()),
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
    final url = Uri.parse('$baseUrl/$auth/$realToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      // body: jsonEncode(DTO.toJson()),
    );
    if (response.statusCode == 200) {
      print('>>> realToken Body: ${response.body}');
      return true;
    }
    return false;
  }
}
