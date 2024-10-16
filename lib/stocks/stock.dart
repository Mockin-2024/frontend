import 'package:flutter/material.dart';
import 'package:mockin/widgets/search_button.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/news.dart';
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
  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '추천 종목',
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
              mainContainer(context, rankContent(trade)),
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
              mainContainer(
                context,
                const Column(
                  // 차후 ListView로 바꿀 예정
                  children: [
                    News(
                      newsTitle: "넷플릭스, 광고 전망 낙관 제프리스",
                      stockName: '넷플릭스',
                      stockPrice: '160.9500',
                      stockRate: '-4.09',
                    ),
                    News(
                      newsTitle: '패스틀리, 단기 악재 직면 - BofA',
                      stockName: '패스틀리',
                      stockPrice: '160.7500',
                      stockRate: '-0.64',
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
