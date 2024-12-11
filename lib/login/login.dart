import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/dto/login/login_dto.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/dto/login/token_validation_dto.dart';
import 'package:mockin/login/find_pw.dart';
import 'package:mockin/login/info_register.dart';
import 'package:mockin/login/signup.dart';
import 'package:mockin/widgets/etc/alert.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/widgets/etc/double_backbutton_quit.dart';
import 'package:mockin/widgets/navigator/text_gesture_navigator.dart';
import 'package:mockin/widgets/input_box/password_input.dart';
import 'package:mockin/storage/user_email.dart';
import 'dart:async';
import 'package:mockin/widgets/input_box/get_input.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:mockin/widgets/signup/signup_button.dart';
import 'package:mockin/widgets/text/mockin_text.dart';
import 'package:mockin/widgets/text/title_text_no_bold.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _autoLogin = false;
  String? lastEmail, token, loginToken;
  List<dynamic>? rst;
  final email = TextEditingController();
  final password = TextEditingController();

  void tryAutoLogin() async {
    // 마지막으로 접속한 이메일이 있음
    lastEmail = await JwtToken().read('lastEmail');
    if (lastEmail != null) {
      // 그 이메일의 토큰이 있음
      token = await JwtToken().read(lastEmail!);
      if (token != null) {
        rst = await LoginApi.tokenValidation(
          DTO: TokenValidationDTO(
            email: lastEmail!,
            token: token!,
          ),
        );
        // 토큰이 유효함
        if (rst![0] != '') {
          setState(() {
            _autoLogin = true;
          });
        }
      }
    }
    if (_autoLogin) {
      UserEmail().saveEmail(lastEmail!); // 얜 마지막으로 저장된 이메일 저장
      autoLoginTokenSave(token: rst![0]);
      if (mounted) {
        if (rst![1] != '' && rst![2] && rst![3]) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => InfoRegister()),
              (route) => false,
            );
          });
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WaitToken()),
            (route) => false,
          );
        });
      }
    }
    FlutterNativeSplash.remove();
  }

  Future<String> loginReq() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      return await LoginApi.loginRequest(
        DTO: LoginDTO(
          email: email.text,
          pw: password.text,
        ),
      );
    }
    return '';
  }

  void autoLoginTokenSave({
    required String token,
  }) async {
    await JwtToken().save('lastEmail', UserEmail().getEmail()!);
    await JwtToken().save(UserEmail().getEmail()!, token);
  }

  @override
  void initState() {
    super.initState();
    tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackbuttonQuit(
      w: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Column(
                children: [
                  const MockinText(tt: 'mockin'),
                  const TitleTextNoBold(tt: '모의투자 시스템', color: Colors.black),
                  const SizedBox(height: 20),
                  GetInput(name: 'email', tec: email),
                  PasswordInput(name: 'password', tec: password),
                  const SizedBox(height: 30),
                  SignupButton(
                    tt: '로그인',
                    signUpFunction: () async {
                      loginToken = await loginReq(); // 로그인 시도
                      if (loginToken != '') {
                        UserEmail().saveEmail(email.text); // 얜 사용자가 입력한 이메일 저장
                        autoLoginTokenSave(token: loginToken!); // 토큰 저장
                        Future.delayed(Duration.zero, () {
                          if (!context.mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InfoRegister(), // 성공 시 정보 등록 화면으로 이동
                            ),
                          );
                        });
                      } else {
                        if (!context.mounted) return;
                        Alert.showAlert(context, '로그인', '실패');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const TextGestureNavigator(movePage: SignUp(), name: '회원가입'),
                  const SizedBox(height: 10),
                  const TextGestureNavigator(
                      movePage: FindPw(), name: '비밀번호 찾기'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
