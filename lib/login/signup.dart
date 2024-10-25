import 'package:flutter/material.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/dto/login/email_auth_dto.dart';
import 'package:mockin/dto/login/send_to_email_dto.dart';
import 'package:mockin/dto/login/signup_dto.dart';
import 'package:mockin/widgets/alert.dart';
import 'package:mockin/widgets/text_input.dart';
import 'package:mockin/widgets/password_input.dart';
import 'dart:async';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nickName = TextEditingController();
  final email = TextEditingController();
  final certified = TextEditingController();
  final password = TextEditingController();
  final checkPassword = TextEditingController();
  bool emailNotCertified = true;
  bool userSignupGoing = true;
  int seconds = 180;
  bool isRunning = false;
  late Timer timer;

  void _startTimer() {
    seconds = 180;
    isRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      onTick(timer);
    });
  }

  void onTick(Timer timer) {
    if (seconds == 0) {
      setState(() {
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        seconds--;
      });
    }
  }

  bool isEqualPassword() {
    if (password.text.isNotEmpty &&
        checkPassword.text.isNotEmpty &&
        (password.text == checkPassword.text)) {
      return true;
    }
    return false;
  }

  bool validateEmail() {
    final emailPattern1 = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    final emailPattern2 =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.text.isNotEmpty &&
        (emailPattern1.hasMatch(email.text) ||
            emailPattern2.hasMatch(email.text))) {
      return true;
    }
    return false;
  }

  Future<String> sendToEmail() async {
    if (validateEmail()) {
      var rst = await LoginApi.sendEmail(
        DTO: SendToEmailDTO(
          email: email.text,
        ),
      );
      if (rst != '-') {
        _startTimer();
        return rst;
      }
    }
    return '';
  }

  Future<String> checkEmail() async {
    print('>>> ${certified.text}');
    if (certified.text.isNotEmpty) {
      var rst = await LoginApi.emailCheck(
        DTO: EmailAuthDTO(
          email: email.text,
          authNum: certified.text,
        ),
      );
      if (rst != '-') {
        return rst;
      }
    }
    return '';
  }

  Future<String> signup() async {
    if (nickName.text.isNotEmpty) {
      var rst = await LoginApi.userSignUp(
        DTO: SignupDTO(
          email: email.text,
          pw: password.text,
          name: nickName.text,
        ),
      );
      if (rst != '-') {
        return rst;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
            ),
            TextInput(
              name: 'email',
              tec: email,
              isChecking: userSignupGoing,
            ),
            TextInput(
              name: 'nickname',
              tec: nickName,
              isChecking: userSignupGoing,
            ),
            PasswordInput(
              name: 'password',
              tec: password,
              isChecking: userSignupGoing,
            ),
            PasswordInput(
              name: 'check password',
              tec: checkPassword,
              isChecking: userSignupGoing,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: userSignupGoing
                    ? () async {
                        if (validateEmail()) {
                          if (isEqualPassword()) {
                            var rst = await signup();
                            if (rst != '') {
                              if (!context.mounted) return;
                              userSignupGoing = false;
                              setState(() {});
                              Alert.showAlert(context, rst, '');
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
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: emailNotCertified
                      ? Colors.black
                      : Colors.black.withOpacity(0.5),
                ),
                child: const Text(
                  '회원 가입',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: !userSignupGoing && !isRunning
                      ? () async {
                          var rst = await sendToEmail();
                          if (rst != '') {
                            if (!context.mounted) return;
                            Alert.showAlert(context, rst, '');
                            return;
                          }
                          if (!context.mounted) return;
                          Alert.showAlert(context, '이메일 발송', '실패');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    '이메일 인증',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            isRunning
                ? Column(
                    children: [
                      Text(
                        '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextInput(name: '인증번호 입력', tec: certified),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 3, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                var rst = await checkEmail();
                                if (rst != '') {
                                  isRunning = false;
                                  timer.cancel();
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  Alert.showAlert(context, rst, '');
                                  setState(() {});
                                  return;
                                }
                                if (!context.mounted) return;
                                Alert.showAlert(context, '이메일 인증', '실패');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text(
                                '인증',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
