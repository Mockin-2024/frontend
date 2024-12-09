import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockin/riverpod_provider/exchange_notifier.dart';

class Exchange extends ConsumerStatefulWidget {
  const Exchange({super.key});

  @override
  ConsumerState<Exchange> createState() => ExchangeState();
}

class ExchangeState extends ConsumerState<Exchange> {
  final _trade = ['나스닥', '뉴욕', '아멕스', '홍콩', '상해', '심천', '호치민', '하노이', '도쿄'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                '거래소 선택',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              DropdownButton(
                value: ref.watch(exchangeProvider),
                items: _trade.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(exchangeProvider.notifier).selectExchange(value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
