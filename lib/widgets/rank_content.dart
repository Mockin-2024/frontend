import 'package:flutter/material.dart';
import 'package:mockin/api/basic_api.dart';
import 'package:mockin/widgets/one_line.dart';
import 'package:mockin/widgets/base_rank.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/basic/condition_search_dto.dart';
import 'package:mockin/models/basic_stock_model.dart';
import 'package:mockin/provider/exchange_trans.dart';

FutureBuilder<List<BasicStockModel>> rankContent(String trade) {
  return FutureBuilder(
    future: BasicApi.conditionSearch(
      DTO: ConditionSearchDTO(
        EXCD: ExchangeTrans.trade[trade]!,
        email: UserEmail().getEmail()!,
      ),
    ),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<BasicStockModel> stocks = snapshot.data!;
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return BaseRank(
              excd: stocks[index].excd,
              stockName: stocks[index].name,
              stockSymb: stocks[index].symb,
              stockPrice: '${double.parse(stocks[index].last)}',
              stockRate: stocks[index].rate,
            );
          },
        );
      } else {
        return OneLine(A: '', B: '');
      }
    },
  );
}
