import 'package:flutter/material.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';
import 'package:mockin/widgets/password_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nickName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final checkPassword = TextEditingController();

  bool isEqualPassword() {
    if (password.text == checkPassword.text) {
      return true;
    }
    return false;
  }

  bool validateEmail() {
    final emailPattern = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (emailPattern.hasMatch(email.text)) {
      return true;
    }
    return false;
  }

  Future<bool> checkInput() async {
    if (email.text.isNotEmpty && nickName.text.isNotEmpty) {
      var rst = await LoginApi.userAccount(email.text, nickName.text);
      return rst;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          TextInput(name: 'email', tec: email),
          TextInput(name: 'nickname', tec: nickName),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 3, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    '중복 확인',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PasswordInput(name: 'password', tec: password),
          PasswordInput(name: 'check password', tec: checkPassword),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (validateEmail()) {
                  if (isEqualPassword()) {
                    if (await checkInput()) {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      Alert.showAlert(context, '회원가입', '성공!');
                    } else {
                      if (!context.mounted) return;
                      Alert.showAlert(context, '회원가입', '실패');
                    }
                  } else {
                    if (!context.mounted) return;
                    Alert.showAlert(context, '비밀번호가', '일치하지 않습니다.');
                  }
                } else {
                  if (!context.mounted) return;
                  Alert.showAlert(context, '이메일 형식이', '유효하지 않습니다.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                '회원 가입',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
