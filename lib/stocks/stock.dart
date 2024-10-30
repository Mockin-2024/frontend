import 'package:flutter/material.dart';
import 'package:mockin/widgets/search_button.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/news_widget.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:mockin/widgets/main_container.dart';
import 'package:provider/provider.dart';
import 'package:mockin/widgets/rank_content.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final _ranking = ['거래대금', '거래량', '시가총액', '급상승', '급하락'];
  var _selectedRank = '거래대금';

  Map<String, int> trans = {
    '거래대금': 1,
    '거래량': 2,
    '시가총액': 3,
    '급상승': 4,
    '급하락': 5,
  };

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Exchange(),
                  SearchButton(),
                ],
              ),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '실시간 차트',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                        value: _selectedRank,
                        items: _ranking.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRank = value!;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RankContent(trade: trade, opt: trans[_selectedRank]!),
            ]),
            Column(children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '최신 금융 뉴스',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const NewsWidget(),
            ]),
          ],
        ),
      ),
    );
  }
}
