import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockin/provider/exchange_provider.dart';

class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => ExchangeState();
}

class ExchangeState extends State<Exchange> {
  final _trade = ['나스닥', '뉴욕', '홍콩', '아멕스', '상해', '심천', '호치민', '하노이', '도쿄'];

  @override
  Widget build(BuildContext context) {
    final exchangeProvider = Provider.of<ExchangeProvider>(context);

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
                value: exchangeProvider.selectedTrade,
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
                    exchangeProvider.selectTrade(value);
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
