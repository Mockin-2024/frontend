import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtToken {
  static final JwtToken _instance = JwtToken._internal();

  factory JwtToken() {
    return _instance;
  }

  JwtToken._internal();

  // Android, iOS
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Web
  SharedPreferences? _prefs;

  // 초기화
  Future<void> init() async {
    // web에서는 shared_preferences 사용
    if (kIsWeb) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // 데이터 저장
  Future<void> save(String key, String value) async {
    if (kIsWeb) {
      await _prefs?.setString(key, value);
    } else {
      await _storage.write(key: key, value: value);
    }
  }

  // 데이터 읽어오기
  Future<String?> read(String key) async {
    if (kIsWeb) {
      return _prefs?.getString(key);
    } else {
      return await _storage.read(key: key);
    }
  }

  // 데이터 삭제
  Future<void> delete(String key) async {
    if (kIsWeb) {
      await _prefs?.remove(key);
    } else {
      await _storage.delete(key: key);
    }
  }
}
