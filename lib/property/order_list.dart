import 'package:flutter/material.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:mockin/dto/trading/ccnl_dto.dart';
import 'package:mockin/dto/trading/nccs_dto.dart';
import 'package:mockin/models/stock_breakdown.dart';
import 'package:mockin/models/stock_own.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/main_container.dart';
import 'package:mockin/widgets/one_line.dart';
import 'package:mockin/widgets/order.dart';
import 'package:provider/provider.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 60,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '주문 내역',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Exchange(),
            ],
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                child: Text(
                  '미체결',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              mainContainer(
                context,
                FutureBuilder(
                    future: TradeApi.nccs(
                      DTO: NccsDTO(
                        overseasExchangeCode: ExchangeTrans
                            .orderTrade[ExchangeTrans.trade[trade]]!,
                        sortOrder: 'DS',
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<StockBreakdown> li = snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: li.length,
                          itemBuilder: (context, index) {
                            return Order(
                              stockName: li[index].name,
                              buySell: li[index].buyOrSell,
                              date: li[index].odDate,
                              time: li[index].odTime,
                              amount: li[index].amount,
                              price: li[index].price,
                            );
                          },
                        );
                      } else {
                        return OneLine(A: '', B: '');
                      }
                    }),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                child: Text(
                  '체결',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              mainContainer(
                context,
                FutureBuilder(
                    future: TradeApi.ccnl(
                      DTO: CcnlDTO(
                        orderStartDate: '20241010',
                        orderEndDate:
                            DateFormat('yyyyMMdd').format(DateTime.now()),
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<StockOwn> li = snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: li.length,
                          itemBuilder: (context, index) {
                            return Order(
                              stockName: li[index].name,
                              buySell: li[index].buyOrSell,
                              date: li[index].odDate,
                              time: li[index].odTime,
                              amount: li[index].amount,
                              price: li[index].price,
                            );
                          },
                        );
                      } else {
                        return OneLine(A: '', B: '');
                      }
                    }),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
