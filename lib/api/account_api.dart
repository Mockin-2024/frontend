import 'package:http/http.dart' as http;
import 'package:mockin/afterlogin/user_email.dart';
import 'dart:convert';
import 'package:mockin/dto/account/acnt_num_register_dto.dart';
import 'package:mockin/dto/account/key_pair_register_dto.dart';
import 'package:mockin/storage/jwt_token.dart';

class AccountApi {
  static const String baseUrl = 'https://api.mockin2024.com';
  static const String account = 'account';
  static const String user = 'user';
  static const String mock = 'mock-key';
  static const String real = 'real-key';

  // 모의계좌 번호 등록 api
  static Future accountRegister({
    required AcntNumRegisterDTO DTO,
  }) async {
    final url = Uri.parse('$baseUrl/$account/$user');
    final response = await http.patch(
      url,
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
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
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
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
        'Authorization':
            'Bearer ${await JwtToken.read(UserEmail().getEmail()!)}',
      },
      body: jsonEncode(DTO.toJson()),
    );
    // print('>>> ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
