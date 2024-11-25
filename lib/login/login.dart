import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockin/dto/login/login_dto.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/dto/login/token_validation_dto.dart';
import 'package:mockin/login/find_pw.dart';
import 'package:mockin/login/info_register.dart';
import 'package:mockin/login/signup.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/widgets/password_input.dart';
import 'package:mockin/storage/user_email.dart';
import 'dart:async';
import 'package:mockin/widgets/get_input.dart';
import 'package:mockin/storage/jwt_token.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _autoLogin = false;
  String? lastEmail, token, rst;
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
        if (rst != '-') {
          setState(() {
            _autoLogin = true;
          });
        }
      }
    }
    if (_autoLogin) {
      UserEmail().saveEmail(lastEmail!);
      autoLoginTokenSave();
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => InfoRegister()),
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

  void autoLoginTokenSave() async {
    await JwtToken().save('lastEmail', UserEmail().getEmail()!);
    await JwtToken().save(UserEmail().getEmail()!, rst!);
  }

  @override
  void initState() {
    super.initState();
    tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;
    const Duration backPressDuration = Duration(seconds: 2);

    void showExitWarning(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('한 번 더 뒤로가기를 누르면 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print('>>> didPop 호출');
          return;
        }
        final now = DateTime.now();

        if (lastPressedAt == null ||
            now.difference(lastPressedAt!) > backPressDuration) {
          print('>>> $now');
          lastPressedAt = now;
          showExitWarning(context);
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Column(
                children: [
                  Text(
                    'mockin',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '모의투자 시스템',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetInput(name: 'email', tec: email),
                  PasswordInput(name: 'password', tec: password),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(25, 0, 25, 3),
                  //   child: Row(
                  //     children: [
                  //       Checkbox(
                  //           activeColor: Colors.white,
                  //           checkColor: Colors.black,
                  //           value: _autoLogin,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               _autoLogin = value!;
                  //             });
                  //           }),
                  //       Text(
                  //         '자동 로그인',
                  //         style: TextStyle(
                  //           color: Theme.of(context).textTheme.bodySmall!.color,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        String result = await loginReq();
                        if (result != '') {
                          UserEmail().saveEmail(email.text);
                          await JwtToken()
                              .save('lastEmail', UserEmail().getEmail()!);
                          await JwtToken()
                              .save(UserEmail().getEmail()!, result);
                          Future.delayed(Duration.zero, () {
                            if (!context.mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoRegister(),
                              ),
                            );
                          });
                        } else {
                          if (!context.mounted) return;
                          Alert.showAlert(context, '로그인', '실패');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FindPw(),
                            ),
                          );
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
