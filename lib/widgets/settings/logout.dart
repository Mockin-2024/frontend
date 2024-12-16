import 'package:flutter/material.dart';
import 'package:mockin/service/setting_service.dart';
import 'package:mockin/widgets/signup/signup_button.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupButton(
        tt: '로그아웃',
        signUpFunction: () async {
          SettingService.logout(context: context);
        });
  }
}
