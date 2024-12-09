import 'package:flutter/material.dart';
import 'package:mockin/service/auth_service.dart';
import 'package:mockin/storage/user_email.dart';
import 'package:mockin/widgets/etc/alert.dart';
import 'package:mockin/widgets/input_box/get_input.dart';
import 'package:mockin/widgets/input_box/password_input.dart';
import 'package:mockin/widgets/signup/signup_button.dart';

class SignupCertification extends StatelessWidget {
  final nickName = TextEditingController();
  final password = TextEditingController();
  final checkPassword = TextEditingController();

  SignupCertification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetInput(
          name: 'nickname',
          tec: nickName,
        ),
        PasswordInput(
          name: 'password',
          tec: password,
        ),
        PasswordInput(
          name: 'check password',
          tec: checkPassword,
        ),
        const SizedBox(height: 10),
        SignupButton(
          tt: '회원 가입',
          signUpFunction: () async {
            if (nickName.text.isNotEmpty) {
              if (AuthService.isEqualPassword(
                  password: password.text, checkPassword: checkPassword.text)) {
                var rst = await AuthService.signup(
                    email: UserEmail().getEmail()!,
                    nickName: nickName.text,
                    password: password.text);
                if (rst != '') {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Alert.showAlert(context, '회원가입', '성공했습니다!');
                } else {
                  if (!context.mounted) return;
                  Alert.showAlert(context, '회원가입', '실패했습니다.');
                }
              } else {
                if (!context.mounted) return;
                Alert.showAlert(context, '비밀번호를', '제대로 입력해주세요.');
              }
            } else {
              if (!context.mounted) return;
              Alert.showAlert(context, '닉네임을', '입력해주세요.');
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
