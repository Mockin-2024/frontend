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
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
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
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  stockName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$stockPrice${ExchangeTrans.signExchange[excd]}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    '$stockRate%',
                    style: TextStyle(
                        color:
                            stockRate.contains('-') ? Colors.blue : Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
