import 'package:flutter/material.dart';
import 'package:mockin/search/search.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/main_container.dart';
import 'package:mockin/widgets/news_widget.dart';
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 60),
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
          Column(children: [
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
              const NewsWidget(),
            ),
          ]),
        ],
      )),
    );
  }
}
