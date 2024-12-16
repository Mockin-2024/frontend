import 'package:flutter/material.dart';
import 'package:mockin/login/login.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:mockin/storage/user_email.dart';

class SettingService {
  static void logout({
    required BuildContext context,
  }) async {
    await JwtToken().delete('lastEmail');
    await JwtToken().delete(UserEmail().getEmail()!);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  static Future<bool> getAutoLogin() async {
    var rst = await JwtToken().read('autoLogin') ?? '';
    if (rst == '') {
      await JwtToken().save('autoLogin', 'false');
      return false;
    }
    if (rst == 'false') {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> setAutoLogin() async {
    var rst = await JwtToken().read('autoLogin');
    if (rst == 'false') {
      await JwtToken().save('autoLogin', 'true');
    } else {
      await JwtToken().save('autoLogin', 'false');
    }
  }
}
