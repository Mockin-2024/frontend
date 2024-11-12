import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/stocks/stock_opt_all.dart';
import 'package:mockin/widgets/text/one_line.dart';
import 'package:mockin/widgets/base_rank.dart';
import 'package:mockin/dto/basic/condition_search_dto.dart';
import 'package:mockin/models/basic_stock_model.dart';
import 'package:mockin/provider/exchange_trans.dart';

class RankContent extends StatelessWidget {
  const RankContent({
    super.key,
    required this.trade,
    required this.opt,
  });

  final String trade;
  final int opt;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BasicApi.conditionSearch(
        DTO: ConditionSearchDTO(
          EXCD: ExchangeTrans.trade[trade]!,
        ),
        opt: opt,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BasicStockModel> stocks = snapshot.data!;
          return Column(
            children: [
              for (var i = 0; i < min(5, stocks.length); i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BaseRank(
                      excd: stocks[i].excd,
                      stockName: stocks[i].name,
                      stockSymb: stocks[i].symb,
                      stockPrice: '${double.parse(stocks[i].last)}',
                      stockRate: stocks[i].rate,
                    ),
                  ],
                ),
              if (stocks.length > 5)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockOptAll(
                          stocks: stocks,
                          opt: opt,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '더 보기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          );
        } else {
          return OneLine(A: '', B: '');
        }
      },
    );
  }
}
