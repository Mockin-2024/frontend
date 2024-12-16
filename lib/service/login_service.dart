import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/dto/login/login_dto.dart';
import 'package:mockin/dto/login/token_validation_dto.dart';
import 'package:mockin/login/info_register.dart';
import 'package:mockin/service/setting_service.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:mockin/storage/user_email.dart';
import 'package:mockin/widgets/etc/alert.dart';

class LoginService {
  // 마지막 접속 이메일과 토큰을 사용해 자동 로그인 가능 여부 확인
  static Future<void> isCanAutoLogin({
    required BuildContext context,
  }) async {
    var auto = await SettingService.getAutoLogin();
    if (auto) {
      // 마지막으로 접속한 이메일
      var lastEmail = await JwtToken().read('lastEmail');
      if (lastEmail != null) {
        // 그 이메일의 토큰이 있는지 확인
        var token = await JwtToken().read(lastEmail);
        if (token != null) {
          var rst = await isTokenValid(email: lastEmail, token: token);
          if (rst[0] != '') {
            // 토큰이 유효하면 자동 로그인
            if (!context.mounted) return;
            autoLogin(
              email: lastEmail,
              token: rst[0],
              rst: rst,
              context: context,
            );
          }
        }
      }
    }
    FlutterNativeSplash.remove();
  }

  // 토큰이 아직 유효한지 확인 후, 정보 등록 여부와 함께 반환
  static Future<List<dynamic>> isTokenValid({
    required String email,
    required String token,
  }) async {
    return await LoginApi.tokenValidation(
      DTO: TokenValidationDTO(
        email: email,
        token: token,
      ),
    );
  }

  // 자동 로그인
  static Future<void> autoLogin({
    required String email,
    required String token,
    required List<dynamic> rst,
    required BuildContext context,
  }) async {
    autoLoginTokenSave(email: email, token: token);
    if (rst[1] == '' || !rst[2] || !rst[3]) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InfoRegister()),
          (route) => false,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WaitToken()),
          (route) => false,
        );
      });
    }
  }

  // 이메일 및 토큰 로컬 저장
  static void autoLoginTokenSave({
    required String email,
    required String token,
  }) async {
    UserEmail().saveEmail(email);
    await JwtToken().save('lastEmail', email);
    await JwtToken().save(email, token);
  }

  // 로그인 시도
  static Future<String> loginRequest({
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      return await LoginApi.loginRequest(
        DTO: LoginDTO(
          email: email,
          pw: password,
        ),
      );
    }
    return '';
  }

  static Future<void> touchLoginButton({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    var loginToken = await loginRequest(email: email, password: password);
    if (loginToken != '') {
      var rst = await isTokenValid(email: email, token: loginToken);
      autoLoginTokenSave(email: email, token: rst[0]);
      Future.delayed(Duration.zero, () {
        if (!context.mounted) return;
        if (rst[1] == '' || !rst[2] || !rst[3]) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InfoRegister(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WaitToken(),
            ),
          );
        }
      });
    } else {
      if (!context.mounted) return;
      Alert.showAlert(context, '로그인', '실패');
    }
  }
}
