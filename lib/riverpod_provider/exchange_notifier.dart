import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExchangeNotifier extends StateNotifier<String> {
  ExchangeNotifier({required String initialExchange})
      : super(initialExchange); // 초기 거래소는 나스닥

  void selectExchange(String excd) {
    if (excd.isNotEmpty) {
      state = excd;
    } else {
      throw Exception('유효하지 않은 거래소 코드입니다.');
    }
  }
}

final exchangeProvider = StateNotifierProvider<ExchangeNotifier, String>(
  (ref) => ExchangeNotifier(initialExchange: '나스닥'),
);
