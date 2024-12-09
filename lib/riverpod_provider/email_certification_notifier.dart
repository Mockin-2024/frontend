import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailCertificationNotifier extends StateNotifier<bool> {
  EmailCertificationNotifier({required bool certified}) : super(certified);

  void changeCertified() {
    state = !state;
  }
}

final emailCertificationNotifier =
    StateNotifierProvider<EmailCertificationNotifier, bool>(
  (ref) => EmailCertificationNotifier(certified: true),
);
