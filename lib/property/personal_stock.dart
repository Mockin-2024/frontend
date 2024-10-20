import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/user_email.dart';
import 'package:mockin/dto/trading/present_balance_dto.dart';
import 'package:mockin/property/order_list.dart';
import 'package:mockin/widgets/exchange.dart';
import 'package:mockin/widgets/personal_purchase_stock.dart';
import 'package:mockin/api/trade_api.dart';

class PersonalStock extends StatelessWidget {
  const PersonalStock({super.key});

  // final Future<String> test = MoneyApi.getPersonalStockList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                      '${snapshot.data}원',
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
        Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('원금', style: TextStyle(color: Colors.black)),
                    Text('71,589원', style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('총 수익', style: TextStyle(color: Colors.black)),
                    Text('+824원', style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('총 수익율', style: TextStyle(color: Colors.black)),
                    Text('+1.1%', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
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
                PersonalPurchaseStock(
                  stockName: '테슬라',
                  nowPrice: '1064.400000',
                  stockAmount: '744',
                  stockRate: '-81.75',
                  avgPurchasePrice: '5832.2148',
                  foreignCurrencyPurchases: '4339167.78523',
                  plusMinusValuation: '-3547254.185235',
                  currentMoney: '791913.60000000',
                ),
                PersonalPurchaseStock(
                  stockName: '인텔',
                  nowPrice: '31592',
                  stockAmount: '2',
                  stockRate: '-0.08',
                  avgPurchasePrice: '29590',
                  foreignCurrencyPurchases: '59180',
                  plusMinusValuation: '3888',
                  currentMoney: '63068',
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
