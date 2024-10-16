import 'package:flutter/material.dart';
import 'package:mockin/widgets/order.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
              child: Text(
                '주문 내역',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
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
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 173, 173),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: const Column(
                    children: [
                      Order(
                        stockName: '테슬라',
                        buySell: '매수',
                        date: '241012',
                        time: '061023',
                        amount: '0.2',
                        price: '336000',
                      ),
                      Order(
                        stockName: '인텔',
                        buySell: '매수',
                        date: '241013',
                        time: '061024',
                        amount: '0.3',
                        price: '33600',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
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
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 173, 173, 173),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: const Column(
                    children: [
                      Order(
                        stockName: '팡둬둬 네트워크 그룹',
                        buySell: '매도',
                        date: '241012',
                        time: '061023',
                        amount: '20',
                        price: '1657',
                      ),
                      Order(
                        stockName: '인텔',
                        buySell: '매수',
                        date: '241013',
                        time: '061024',
                        amount: '2',
                        price: '31390',
                      ),
                    ],
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
