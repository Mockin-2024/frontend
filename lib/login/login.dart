import 'package:flutter/material.dart';
import 'package:mockin/dto/login/login_dto.dart';
import 'package:mockin/login/find_pw.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/login/info_register.dart';
import 'package:mockin/login/signup.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/widgets/password_input.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'dart:async';
import 'package:mockin/widgets/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // var _autoLogin = false;
  final email = TextEditingController();
  final password = TextEditingController();

  void initialization() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    FlutterNativeSplash.remove();
  }

  Future<bool> loginReq() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      return await LoginApi.loginRequest(
        DTO: LoginDTO(
          email: email.text,
          pw: password.text,
        ),
      );
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontWeight: FontWeight.bold,
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
                TextInput(name: 'email', tec: email),
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
                      bool result = await loginReq();
                      if (result) {
                        UserEmail().saveEmail(email.text);
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoRegister(),
                          ),
                        );
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
    );
  }
}
