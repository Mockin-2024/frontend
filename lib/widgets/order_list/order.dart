import 'package:flutter/material.dart';
import 'package:mockin/widgets/text/one_line.dart';

class Order extends StatelessWidget {
  final String stockName, buySell, date, time, amount, price;

  const Order({
    super.key,
    required this.stockName,
    required this.buySell,
    required this.date,
    required this.time,
    required this.amount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(
          children: [
            OneLine(A: stockName, B: buySell),
            OneLine(A: '$amount주', B: price),
            OneLine(A: date, B: time),
          ],
        ),
      ),
    );
  }
}
