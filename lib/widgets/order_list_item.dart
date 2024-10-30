import 'package:flutter/material.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(orderDate, style: const TextStyle(color: Colors.black)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('$signed($buyOrSell)',
                    style: const TextStyle(color: Colors.black)),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
