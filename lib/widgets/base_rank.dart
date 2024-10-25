import 'package:flutter/material.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/stocks/stock_detail.dart';
import 'package:mockin/widgets/one_line.dart';

class BaseRank extends StatelessWidget {
  final String excd, stockName, stockSymb, stockPrice, stockRate;

  const BaseRank({
    super.key,
    required this.excd,
    required this.stockName,
    required this.stockSymb,
    required this.stockPrice,
    required this.stockRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StockDetail(
                  excd: excd,
                  stockName: stockName,
                  stockSymb: stockSymb,
                  stockPrice: stockPrice,
                  stockRate: stockRate,
                ),
              ),
            );
          },
          child: Column(
            children: [
              OneLine(
                  A: stockName,
                  B: '$stockPrice${ExchangeTrans.signExchange[excd]}'),
              OneLine(A: '', B: '$stockRate%', bIsNum: true),
            ],
          ),
        ),
      ),
    );
  }
}
