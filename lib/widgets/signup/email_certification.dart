import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockin/riverpod_provider/email_certification_notifier.dart';
import 'package:mockin/riverpod_provider/timer_notifier.dart';
import 'package:mockin/service/auth_service.dart';
import 'package:mockin/widgets/etc/alert.dart';
import 'package:mockin/widgets/input_box/get_input.dart';
import 'package:mockin/widgets/signup/signup_button.dart';
import 'package:mockin/widgets/text/basic_text.dart';

class EmailCertification extends ConsumerStatefulWidget {
  const EmailCertification({super.key});

  @override
  ConsumerState<EmailCertification> createState() => _EmailCertificationState();
}

class _EmailCertificationState extends ConsumerState<EmailCertification> {
  final email = TextEditingController();
  final certified = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);
    var emailNotCertified = ref.watch(emailCertificationNotifier);
    final certifiedNotifier = ref.read(emailCertificationNotifier.notifier);

    return Column(
      children: [
        GetInput(
          name: 'email',
          tec: email,
          isChecking: !timerState.isRunning && emailNotCertified,
        ),
        SignupButton(
          tt: '이메일 인증',
          signUpFunction: !timerState.isRunning && emailNotCertified
              ? () async {
                  if (AuthService.validateEmail(email: email.text)) {
                    var rst = await AuthService.sendToEmail(email: email.text);
                    if (rst) {
                      timerNotifier.startTimer();
                      if (!context.mounted) return;
                      Alert.showAlert(context, '3분 안에', '인증해주세요!');
                      return;
                    }
                    if (!context.mounted) return;
                    Alert.showAlert(context, '이메일 발송', '실패하였습니다.');
                  } else {
                    if (!context.mounted) return;
                    Alert.showAlert(context, '이메일 형식이', '아닙니다.');
                  }
                }
              : null,
        ),
        timerState.isRunning
            ? Column(
                children: [
                  BasicText(
                      tt: '${timerState.secondsRemaining ~/ 60}:${(timerState.secondsRemaining % 60).toString().padLeft(2, '0')}'),
                  GetInput(name: '인증번호 입력', tec: certified),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 3, 0, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SignupButton(
                          tt: '인증',
                          signUpFunction: () async {
                            var rst = await AuthService.checkEmail(
                                email: email.text, certified: certified.text);
                            if (rst) {
                              certifiedNotifier.changeCertified();
                              timerNotifier.stopTimer();
                              if (!context.mounted) return;
                              Alert.showAlert(context, '이메일 인증', '성공했습니다!');
                              setState(() {});
                              return;
                            }
                            if (!context.mounted) return;
                            Alert.showAlert(context, '이메일 인증', '실패했습니다.');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
