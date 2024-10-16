import 'package:flutter/material.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';

class FindPw extends StatefulWidget {
  const FindPw({super.key});

  @override
  State<FindPw> createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  final nickName = TextEditingController();
  final email = TextEditingController();
  String _pw = '-';
  bool getPw = false;

  String checkInput() {
    if (email.text.isNotEmpty && nickName.text.isNotEmpty) {
      // var rst = await LoginApi.userAccount(email.text, password.text);
      // 이메일과 nickname을 확인하고 password 반환
      return 'password';
    }
    return '';
  }

  // Future<bool> checkInput() async {
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
                '비밀번호 찾기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
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
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _pw = checkInput();
                if (_pw != '') {
                  setState(() {
                    getPw = true;
                  });
                } else {
                  if (!context.mounted) return;
                  Alert.showAlert(context, '비밀번호 찾기', '실패');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                '찾기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              _pw,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
