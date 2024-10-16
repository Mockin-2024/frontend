import 'package:flutter/material.dart';
import 'package:mockin/stocks/buy_or_sell.dart';
import 'package:mockin/widgets/news.dart';

// ignore: must_be_immutable
class StockDetail extends StatelessWidget {
  final String excd, stockName, stockSymb;
  String stockPrice, stockRate;

  StockDetail({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
    this.stockPrice = '',
    this.stockRate = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      stockName,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          stockPrice,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' ($stockRate)',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(
                    '차트',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  // 여기는 차트가 들어갈 것임.
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  height: 200,
                  width: 200,
                ),
                const Row(
                  // 하나하나 체크해주는 과정 필요
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '1일',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1주',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1달',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '3달',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1년',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '5년',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
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
                        '재무 정보',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Buy(
                          stockName: stockName,
                          stockPrice: stockPrice,
                          stockRate: stockRate,
                          buy: false,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '판매',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Buy(
                          stockName: stockName,
                          stockPrice: stockPrice,
                          stockRate: stockRate,
                          buy: true,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '구매',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
