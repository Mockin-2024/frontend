import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/login/find_pw.dart';
// import 'package:mockin/api/login_api.dart';
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
  List<String> checkList = ['test1014@naver.com', 'test@naver.com'];
  // 정보 등록한 적이 있는 사용자 리스트
  // 정보를 등록한 적이 있다면 정보 등록(info_register.dart)로 가지 않고,
  // 바로 Navi.dart로 넘어가기 위함
  // 지금은 임시로 이렇게 해두지만 그냥 계좌 번호가 null이 아니다 정도만
  // 확인하는 api가 있으면 될 듯?

  void initialization() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    FlutterNativeSplash.remove();
  }

  bool checkInput() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      // var rst = await LoginApi.userAccount(email.text, password.text);
      // 이메일과 pw가 db에 존재하는지 여부 확인
      return true;
    }
    return false;
  }

  // Future<bool> checkInput() async {
  //   if (email.text.isNotEmpty && password.text.isNotEmpty) {
  //     // var rst = await LoginApi.userAccount(email.text, password.text);
  //     // 이메일과 pw가 db에 존재하는지 여부 확인
  //     return true;
  //   }
  //   return false;
  // }

  // 정보 등록 유저 확인

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
                    onPressed: () {
                      bool result = checkInput();
                      if (result) {
                        UserEmail().saveEmail(email.text);
                        if (!context.mounted) return;
                        if (checkList.contains(email.text)) {
                          // 정보 등록 유저 확인
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WaitToken(),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
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
