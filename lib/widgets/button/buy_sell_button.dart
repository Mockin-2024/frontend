import 'package:flutter/material.dart';
import 'package:mockin/stocks/buy_or_sell.dart';
import 'package:mockin/stocks/stock_detail.dart';

class BuySellButton extends StatelessWidget {
  const BuySellButton({
    super.key,
    required this.widget,
    required this.buySell,
    required this.bs,
    required this.have,
  });

  final StockDetail widget;
  final String buySell;
  final bool bs, have;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: have
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyOrSell(
                    excd: widget.excd,
                    stockName: widget.stockName,
                    stockSymb: widget.stockSymb,
                    buy: bs,
                  ),
                ),
              );
            }
          : null,
      child: Text(
        buySell,
        style: TextStyle(
          color: have ? Colors.black : Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
