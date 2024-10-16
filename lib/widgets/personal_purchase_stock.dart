import 'package:flutter/material.dart';
import 'package:mockin/widgets/one_line.dart';

class PersonalPurchaseStock extends StatelessWidget {
  final String stockName,
      nowPrice,
      stockAmount,
      stockRate,
      avgPurchasePrice,
      foreignCurrencyPurchases,
      plusMinusValuation,
      currentMoney;

  const PersonalPurchaseStock({
    super.key,
    required this.stockName,
    required this.nowPrice,
    required this.stockAmount,
    required this.stockRate,
    required this.avgPurchasePrice,
    required this.foreignCurrencyPurchases,
    required this.plusMinusValuation,
    required this.currentMoney,
  });
  // 터치하면 해당하는 주식 상세 페이지로 갈 수 있게 ㄱㄱ
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Column(
        children: [
          OneLine(A: stockName, B: nowPrice),
          OneLine(A: '$stockAmount주', B: avgPurchasePrice),
          OneLine(A: '$stockRate%', B: plusMinusValuation),
          OneLine(A: foreignCurrencyPurchases, B: currentMoney),
        ],
      ),
    );
  }
}
