import 'package:flutter/material.dart';
import 'package:mockin/login/find_pw.dart';
import 'package:mockin/login/signup.dart';
import 'package:mockin/service/login_service.dart';
import 'package:mockin/widgets/etc/double_backbutton_quit.dart';
import 'package:mockin/widgets/navigator/text_gesture_navigator.dart';
import 'package:mockin/widgets/input_box/password_input.dart';
import 'package:mockin/widgets/input_box/get_input.dart';
import 'package:mockin/widgets/signup/signup_button.dart';
import 'package:mockin/widgets/text/mockin_text.dart';
import 'package:mockin/widgets/text/title_text_no_bold.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoginService.isCanAutoLogin(context: context);
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
                    signUpFunction: LoginService.touchLoginButton(
                      email: email.text,
                      password: password.text,
                      context: context,
                    ),
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
