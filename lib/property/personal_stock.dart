import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/trading/balance_dto.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/models/personal_stock_item.dart';
import 'package:mockin/property/order_list.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:mockin/provider/exchange_trans.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/main_container.dart';
import 'package:mockin/widgets/one_line.dart';
import 'package:mockin/widgets/personal_purchase_stock.dart';
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
        email: UserEmail().getEmail()!,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              width: 60,
            ),
            Column(children: [
              const Text('총 자산', style: TextStyle(color: Colors.black)),
              FutureBuilder(
                  future: TradeApi.presentBalance(
                    DTO: PresentBalanceDTO(
                      currencyDivisonCode: '02',
                      countryCode: '000',
                      marketCode: '00',
                      inquiryDivisionCode: '00',
                      email: UserEmail().getEmail()!,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${thousand(snapshot.data)}원',
                        style: const TextStyle(color: Colors.black),
                      );
                    }
                    return const Text(
                      '-',
                      style: TextStyle(color: Colors.black),
                    );
                  }),
            ]),
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
                        OneLine(A: '투자 금액', B: '${dt[0]}원'),
                        const SizedBox(height: 10),
                        OneLine(A: '총 수익', B: '${dt[1]}원'),
                        const SizedBox(height: 10),
                        OneLine(A: '총 수익율', B: '${dt[2]}%'),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderList(),
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
                      Text('주문 내역 >', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const Exchange(),
            ],
          ),
          mainContainer(
            context,
            UserCurrentStock(
              trade: trade,
              balance: balance,
            ),
          ),
        ]),
      ),
    );
  }
}

class UserCurrentStock extends StatelessWidget {
  const UserCurrentStock({
    super.key,
    required this.trade,
    required this.balance,
  });

  final String trade;
  final Future<List<dynamic>> balance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: balance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PersonalStockItem> li = snapshot.data![0];
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: li.length,
                itemBuilder: (context, index) {
                  return PersonalPurchaseStock(
                    stockName: li[index].name,
                    nowPrice: li[index].nowPrice,
                    stockAmount: li[index].stockAmount,
                    stockRate: li[index].pOrlrate,
                    avgPurchasePrice: li[index].avgPrice,
                    foreignCurrencyPurchases: li[index].overseasStockAmount,
                    plusMinusValuation: li[index].pOrlamount,
                    currentMoney: li[index].howMuchStock,
                  );
                });
          }
          return const Text('');
        });
  }
}
