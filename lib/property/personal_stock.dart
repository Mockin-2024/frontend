import 'package:flutter/material.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/models/personal_stock_item.dart';
import 'package:mockin/property/order_list.dart';
import 'package:mockin/property/personal_stock_detailed.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/text/one_line.dart';
import 'package:mockin/api/trade_api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalStock extends StatelessWidget {
  const PersonalStock({super.key});

  // final Future<String> test = MoneyApi.getPersonalStockList();
  String thousand(String st) {
    if (st.length > 2) {
      return NumberFormat('#,###').format(int.parse(st));
    }
    return st;
  }

  @override
  Widget build(BuildContext context) {
    var trade = Provider.of<ExchangeProvider>(context).selectedTrade;
    final Future<List<dynamic>> balance = TradeApi.balance(
      DTO: BalanceDTO(
        overseasExchangeCode:
            ExchangeTrans.orderTrade[ExchangeTrans.trade[trade]]!,
        transactionCurrencyCode:
            ExchangeTrans.transactionCurrency[ExchangeTrans.trade[trade]]!,
      ),
    );
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 60,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(children: [
            const Text('총 자산', style: TextStyle(color: Colors.black)),
            FutureBuilder(
                future: TradeApi.presentBalance(
                  DTO: PresentBalanceDTO(
                    currencyDivisonCode: '02',
                    countryCode: '000',
                    marketCode: '00',
                    inquiryDivisionCode: '00',
                  ),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${thousand(snapshot.data)}원',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                  return const Text(
                    '-',
                    style: TextStyle(color: Colors.black),
                  );
                }),
          ]),
          const Exchange(),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 10,
          ),
          child: FutureBuilder(
              future: balance,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> dt = snapshot.data!.sublist(1);
                  return Column(
                    children: [
                      OneLine(
                          A: '투자 금액',
                          B: '${double.parse(dt[0]).toStringAsFixed(2)}원'),
                      const SizedBox(height: 10),
                      OneLine(
                        A: '총 수익',
                        B: '${double.parse(dt[1]).toStringAsFixed(2)}원',
                        bIsNum: true,
                      ),
                      const SizedBox(height: 10),
                      OneLine(
                        A: '총 수익율',
                        B: '${double.parse(dt[2]).toStringAsFixed(2)}%',
                        bIsNum: true,
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    OneLine(A: '투자 금액', B: '-원'),
                    const SizedBox(height: 10),
                    OneLine(A: '총 수익', B: '-원'),
                    const SizedBox(height: 10),
                    OneLine(A: '총 수익율', B: '-%'),
                  ],
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderList(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '주문 내역  >>',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '구매 주식',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: balance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PersonalStockItem> li = snapshot.data![0];
              var sign = ExchangeTrans.sign[trade];

              List<DataRow> rows = li.map((stock) {
                return DataRow(
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalStockDetailed(
                            name: stock.name,
                            symb: stock.symb,
                            amountGainsLosses: stock.amountGainsLosses,
                            rateGainsLosses: stock.rateGainsLosses,
                            howMuchStock: stock.howMuchStock,
                            amountEvaluation: stock.amountEvaluation,
                            buyAverage: stock.buyAverage,
                            buyAmount: stock.buyAmount,
                            curPrice: stock.curPrice,
                            currency: stock.currency,
                            excd: trade,
                            sign: sign!,
                          ),
                        ),
                      );
                    },
                    cells: [
                      DataCell(
                        Center(
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              stock.name,
                              style: const TextStyle(color: Colors.black),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '${double.parse(stock.amountGainsLosses).toStringAsFixed(2)}$sign',
                                style: TextStyle(
                                    color: stock.amountGainsLosses[0] == '-'
                                        ? Colors.blue
                                        : Colors.red),
                              ),
                              Text(
                                '${double.parse(stock.rateGainsLosses).toStringAsFixed(2)}%',
                                style: TextStyle(
                                    color: stock.rateGainsLosses[0] == '-'
                                        ? Colors.blue
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '${stock.howMuchStock}주',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${double.parse(stock.amountEvaluation).toStringAsFixed(2)}$sign',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '${double.parse(stock.buyAverage).toStringAsFixed(3)}$sign',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${double.parse(stock.buyAmount).toStringAsFixed(3)}$sign',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '${double.parse(stock.curPrice).toStringAsFixed(3)}$sign',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                stock.currency,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
              }).toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    dividerThickness: 0,
                    columns: const [
                      DataColumn(
                        label: Center(
                          child: Text(
                            '종목명',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '외화평가손익금액',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '평가손익율',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '보유수량',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '해외주식평가금액',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '매입평균가격',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '외화매입금액',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '현재가격',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '거래통화코드',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: rows,
                  ),
                ),
              );
            }
            return const Text('');
          },
        ),
      ]),
    );
  }
}
