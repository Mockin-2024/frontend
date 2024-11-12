import 'package:flutter/material.dart';
import 'package:mockin/property/order_detailed.dart';
import 'package:mockin/provider/exchange_trans.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    super.key,
    required this.name,
    required this.excd,
    required this.symb,
    required this.orderNum,
    required this.buyOrSell,
    required this.orderDate,
    required this.orderTime,
    required this.originOrderNum,
    required this.price,
    required this.amount,
    required this.currency,
    required this.signed,
  });

  final String name, // 종목명
      excd, // 거래소
      symb, // 종목코드
      orderNum, // 주문#
      buyOrSell, // 매매구분
      orderDate, // 주문일자
      orderTime, // 주문시간
      originOrderNum, // 원주문#
      price, // 체결가격 or 주문가격
      amount, // 체결수량 or 미체결수량
      currency, // 통화 코드
      signed; // 체결/미체결

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
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
                builder: (context) => OrderDetailed(
                  name: name,
                  excd: excd,
                  symb: symb,
                  orderNum: orderNum,
                  buyOrSell: buyOrSell,
                  orderDate: orderDate,
                  orderTime: orderTime,
                  originOrderNum: originOrderNum,
                  price: price,
                  amount: amount,
                  currency: currency,
                  signed: signed,
                ),
              ),
            );
          },
          child: Table(columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          }, children: [
            TableRow(children: [
              TableCell(
                child: Column(
                  children: [
                    Text('$orderDate  ',
                        style: const TextStyle(color: Colors.black)),
                    const SizedBox(height: 5),
                    Text('$signed/$buyOrSell  ',
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              TableCell(
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableCell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('$amount주',
                        style: const TextStyle(color: Colors.black)),
                    Text(
                        '${double.parse(price).toStringAsFixed(3)}${ExchangeTrans.signExchange[ExchangeTrans.orderTradeReverse[excd]]}',
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
