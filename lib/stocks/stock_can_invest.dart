import 'package:flutter/material.dart';
import 'package:mockin/search/search.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/base_rank.dart';
import 'package:mockin/widgets/main_container.dart';
import 'package:mockin/widgets/news.dart';
import 'package:mockin/widgets/rank_content.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:provider/provider.dart';

class StockCanInvest extends StatefulWidget {
  const StockCanInvest({super.key});

  @override
  State<StockCanInvest> createState() => _StockCanInvestState();
}

class _StockCanInvestState extends State<StockCanInvest> {
  final _ranking = ['거래대금', '거래량', '인기', '급상승', '급하락'];
  var _selectedRank = '거래대금';

  Map<String, int> trans = {
    '거래대금': 1,
    '거래량': 2,
    '인기': 3,
    '급상승': 4,
    '급하락': 5,
  };

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Exchange(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Search(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
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
              mainContainer(
                context,
                rankContent(trade, trans[_selectedRank]!),
              ),
            ]),
          ),
          Container(
            child: Column(children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
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
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
