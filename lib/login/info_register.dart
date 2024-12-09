import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/storage/user_email.dart';
import 'package:mockin/dto/account/acnt_num_register_dto.dart';
import 'package:mockin/dto/account/key_pair_register_dto.dart';
import 'package:mockin/widgets/button/register_button.dart';
import 'package:mockin/widgets/etc/double_backbutton_quit.dart';
import 'package:mockin/widgets/navigator/text_gesture_navigator_replacement.dart';
import 'package:mockin/widgets/input_box/get_input.dart';
import 'package:mockin/api/account_api.dart';
import 'package:mockin/widgets/text/basic_text.dart';
import 'dart:async';

import 'package:mockin/widgets/text/content_text.dart';

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
      return await AccountApi.accountRegister(
        DTO: AcntNumRegisterDTO(
          accountNumber: accountNumber.text,
        ),
      );
    }
    return false;
  }

  Future<bool> mockKeyRegister() async {
    if (mockAppkey.text.isNotEmpty && mockAppsecretkey.text.isNotEmpty) {
      return await AccountApi.mockKeyRegister(
        DTO: KeyPairRegisterDTO(
          appKey: mockAppkey.text,
          appSecret: mockAppsecretkey.text,
        ),
      );
    }
    return false;
  }

  Future<bool> realKeyRegister() async {
    if (realAppkey.text.isNotEmpty && realAppsecretkey.text.isNotEmpty) {
      return await AccountApi.realKeyRegister(
        DTO: KeyPairRegisterDTO(
          appKey: realAppkey.text,
          appSecret: realAppsecretkey.text,
        ),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackbuttonQuit(
      w: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContentText(tt: '모의투자를 진행하기 위해선'),
                  ContentText(tt: '다음과 같은 정보가 필요합니다!'),
                ],
              ),
              const SizedBox(height: 45),
              const BasicText(tt: '모의투자용 키 등록'),
              GetInput(name: '모의투자 appkey', tec: mockAppkey),
              GetInput(name: '모의 appsecretkey', tec: mockAppsecretkey),
              RegisterButton(
                name: '모의키 등록',
                first: '모의투자 키 등록',
                onPressed: mockKeyRegister,
              ),
              const SizedBox(height: 10),
              const BasicText(tt: '실전투자용 키 등록'),
              GetInput(name: '실전 appkey', tec: realAppkey),
              GetInput(name: '실전 appsecretkey', tec: realAppsecretkey),
              RegisterButton(
                name: '실전키 등록',
                first: '실전투자 키 등록',
                onPressed: realKeyRegister,
              ),
              const SizedBox(height: 10),
              const BasicText(tt: '모의 계좌번호 등록(8자리)'),
              GetInput(name: '한국투자증권 모의계좌번호', tec: accountNumber),
              RegisterButton(
                name: '모의계좌 등록',
                first: '모의계좌번호 등록',
                onPressed: accountRegister,
              ),
              const SizedBox(height: 20),
              const Center(
                child: TextGestureNavigatorReplacement(
                    movePage: WaitToken(), name: '모두 등록했습니다!  >>>'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
