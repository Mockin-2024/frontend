import 'package:flutter/material.dart';

class LineBar extends StatelessWidget {
  const LineBar({
    super.key,
    required this.progressData,
    required this.period,
    required this.low,
    required this.curPrice,
    required this.high,
    required this.sign,
  });

  final double progressData;
  final String period, low, curPrice, high, sign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LinearProgressIndicator(
            value: progressData,
            minHeight: 10,
            color: Colors.black,
            backgroundColor: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('$period 최저가',
                    style: const TextStyle(color: Colors.black)),
                Text('${double.parse(low).toStringAsFixed(2)}$sign',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              children: [
                const Text('현재 가격', style: TextStyle(color: Colors.black)),
                Text('$curPrice$sign',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              children: [
                Text('$period 최고가',
                    style: const TextStyle(color: Colors.black)),
                Text('${double.parse(high).toStringAsFixed(2)}$sign',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
