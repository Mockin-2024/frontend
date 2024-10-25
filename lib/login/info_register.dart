import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/dto/account/acnt_num_register_dto.dart';
import 'package:mockin/dto/account/key_pair_register_dto.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';
import 'package:mockin/api/account_api.dart';
import 'dart:async';

class InfoRegister extends StatelessWidget {
  InfoRegister({super.key});

  final email = UserEmail().getEmail()!;
  final mockAppkey = TextEditingController();
  final mockAppsecretkey = TextEditingController();
  final realAppkey = TextEditingController();
  final realAppsecretkey = TextEditingController();
  final accountNumber = TextEditingController();

  Future<bool> accountRegister() async {
    if (accountNumber.text.isNotEmpty) {
      var tmp = await AccountApi.accountRegister(
        DTO: AcntNumRegisterDTO(
          email: email,
          accountNumber: accountNumber.text,
        ),
      );
      return tmp;
    }
    return false;
  }

  Future<bool> mockKeyRegister() async {
    if (mockAppkey.text.isNotEmpty && mockAppsecretkey.text.isNotEmpty) {
      var tmp = await AccountApi.mockKeyRegister(
        DTO: KeyPairRegisterDTO(
          email: email,
          appKey: mockAppkey.text,
          appSecret: mockAppsecretkey.text,
        ),
      );
      return tmp;
    }
    return false;
  }

  Future<bool> realKeyRegister() async {
    if (realAppkey.text.isNotEmpty && realAppsecretkey.text.isNotEmpty) {
      var tmp = await AccountApi.realKeyRegister(
        DTO: KeyPairRegisterDTO(
          email: email,
          appKey: realAppkey.text,
          appSecret: realAppsecretkey.text,
        ),
      );
      return tmp;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
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
            RegisterButton(
              name: '모의키 등록',
              first: '모의투자 키 등록',
              onPressed: mockKeyRegister,
            ),
            const SizedBox(height: 10),
            const Text('실전투자용 키 등록', style: TextStyle(color: Colors.black)),
            TextInput(name: '실전 appkey', tec: realAppkey),
            TextInput(name: '실전 appsecretkey', tec: realAppsecretkey),
            RegisterButton(
              name: '실전키 등록',
              first: '실전투자 키 등록',
              onPressed: realKeyRegister,
            ),
            const SizedBox(height: 10),
            const Text('모의 계좌번호 등록(8자리)',
                style: TextStyle(color: Colors.black)),
            TextInput(name: '한국투자증권 모의계좌번호', tec: accountNumber),
            RegisterButton(
              name: '모의계좌 등록',
              first: '모의계좌번호 등록',
              onPressed: accountRegister,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaitToken(),
                    ),
                  );
                },
                child: Text(
                  '모두 등록했습니다!  >>>',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final String name, first;
  final Function onPressed;

  const RegisterButton({
    super.key,
    required this.name,
    required this.first,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (await onPressed()) {
            if (!context.mounted) return;
            Alert.showAlert(context, first, '성공!');
          } else {
            if (!context.mounted) return;
            Alert.showAlert(context, first, '실패');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
