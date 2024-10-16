import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';
import 'package:mockin/api/login_api.dart';
import 'dart:async';

class InfoRegister extends StatelessWidget {
  InfoRegister({super.key});

  final email = UserEmail().getEmail();
  final mockAppkey = TextEditingController();
  final mockAppsecretkey = TextEditingController();
  final realAppkey = TextEditingController();
  final realAppsecretkey = TextEditingController();
  final accountNumber = TextEditingController();

  Future<bool> accountRegister() async {
    if (accountNumber.text.isNotEmpty) {
      var tmp = await LoginApi.accountRegister(email!, accountNumber.text);
      return tmp;
    }
    return false;
  }

  Future<bool> mockKeyRegister() async {
    if (mockAppkey.text.isNotEmpty && mockAppsecretkey.text.isNotEmpty) {
      var tmp = await LoginApi.mockKeyRegister(
          mockAppkey.text, mockAppsecretkey.text, email!);
      return tmp;
    }
    return false;
  }

  Future<bool> realKeyRegister() async {
    if (realAppkey.text.isNotEmpty && realAppsecretkey.text.isNotEmpty) {
      var tmp = await LoginApi.realKeyRegister(
          realAppkey.text, realAppsecretkey.text, email!);
      return tmp;
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
                '   모의투자를 진행하기 위해선\n다음과 같은 정보가 필요합니다!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          const Text('모의투자용 키 등록', style: TextStyle(color: Colors.black)),
          TextInput(name: '모의투자 appkey', tec: mockAppkey),
          TextInput(name: '모의 appsecretkey', tec: mockAppsecretkey),
          const Text('실전투자용 키 등록', style: TextStyle(color: Colors.black)),
          TextInput(name: '실전 appkey', tec: realAppkey),
          TextInput(name: '실전 appsecretkey', tec: realAppsecretkey),
          const Text('계좌번호 등록', style: TextStyle(color: Colors.black)),
          TextInput(name: 'KIS 계좌번호', tec: accountNumber),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (await accountRegister()) {
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaitToken(),
                    ),
                  );
                } else {
                  if (!context.mounted) return;
                  Alert.showAlert(context, '계좌 등록', '실패');
                }
                // if (await mockKeyRegister()) {
                //   if (await realKeyRegister()) {
                //     if (await accountRegister()) {
                //       if (!context.mounted) return;
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const WaitToken(),
                //         ),
                //       );
                //     } else {
                //       if (!context.mounted) return;
                //       Alert.showAlert(context, '계좌 등록', '실패');
                //     }
                //   } else {
                //     if (!context.mounted) return;
                //     Alert.showAlert(context, '실전투자 키 등록', '실패');
                //   }
                // } else {
                //   if (!context.mounted) return;
                //   Alert.showAlert(context, '모의투자 키 등록', '실패');
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                '정보 등록',
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
