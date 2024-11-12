import 'package:flutter/material.dart';

class HogaContent extends StatelessWidget {
  const HogaContent({
    super.key,
    required this.curPrice,
    required this.price,
    required this.amount,
    required this.sign,
    required this.maxAmount,
    required this.isSellOrder,
  });

  final String curPrice, price, amount, sign;
  final double maxAmount;
  final bool isSellOrder;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double priceWidth = screenWidth * 0.2;
    double maxBoxWidth = screenWidth * 0.4;
    double nowPrice = double.parse(curPrice);
    double hogaPrice = double.parse(price);
    int hogaAmount = int.parse(amount);
    double rate = (nowPrice - hogaPrice) / hogaPrice * 100;
    return Row(
      mainAxisAlignment:
          isSellOrder ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isSellOrder)
          SizedBox(
            width: maxBoxWidth,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  width:
                      maxBoxWidth * (double.parse(amount) / (maxAmount + 100)),
                  height: 30,
                  color: Colors.blue.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '$hogaAmount주',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          width: priceWidth,
          height: 50,
          child: Center(
            child: Column(
              children: [
                Text(
                  '${hogaPrice.toStringAsFixed(3)}$sign',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSellOrder ? Colors.blue : Colors.red,
                  ),
                ),
                Text(
                  rate < 0
                      ? '${rate.toStringAsFixed(2)}%'
                      : '+${rate.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSellOrder ? Colors.blue : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isSellOrder)
          SizedBox(
            width: maxBoxWidth,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width:
                      maxBoxWidth * (double.parse(amount) / (maxAmount + 500)),
                  height: 30,
                  color: Colors.red.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '$hogaAmount주',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
