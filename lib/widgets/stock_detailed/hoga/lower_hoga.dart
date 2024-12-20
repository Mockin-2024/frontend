import 'package:flutter/material.dart';
import 'package:mockin/widgets/stock_detailed/hoga/hoga_content.dart';

class LowerHoga extends StatelessWidget {
  final String curPrice, sign;
  final Map<int, List<dynamic>> hoga;
  final double maxAmount;

  const LowerHoga({
    super.key,
    required this.curPrice,
    required this.sign,
    required this.hoga,
    required this.maxAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < hoga.length; i++)
          if (double.parse(hoga[i]![0]) != 0.0)
            HogaContent(
              curPrice: curPrice,
              price: hoga[i]![0],
              amount: hoga[i]![1],
              sign: sign,
              maxAmount: maxAmount,
              isSellOrder: hoga[i]![2],
            )
      ],
    );
  }
}
