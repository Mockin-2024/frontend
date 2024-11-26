import 'package:flutter/material.dart';
import 'package:mockin/models/basic_stock_model.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/base_rank.dart';

class StockOptAll extends StatelessWidget {
  const StockOptAll({
    super.key,
    required this.stocks,
    required this.opt,
  });

  final List<BasicStockModel> stocks;
  final int opt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 0, 10),
            child: Text(
              '${ExchangeTrans.optToString[opt]} Top100',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      BaseRank(
                        excd: stocks[index].excd,
                        stockName: stocks[index].name,
                        stockSymb: stocks[index].symb,
                        stockPrice: '${double.parse(stocks[index].last)}',
                        stockRate: stocks[index].rate,
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
