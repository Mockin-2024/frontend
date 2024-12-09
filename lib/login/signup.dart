import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockin/riverpod_provider/email_certification_notifier.dart';
import 'package:mockin/widgets/signup/email_certification.dart';
import 'package:mockin/widgets/signup/signup_certification.dart';
import 'package:mockin/widgets/text/mockin_text.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailNotCertified = ref.watch(emailCertificationNotifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const MockinText(tt: '회원가입'),
            const SizedBox(height: 45),
            const EmailCertification(),
            if (!emailNotCertified) SignupCertification(),
          ],
        ),
      ),
    );
  }
}
