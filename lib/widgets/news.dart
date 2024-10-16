import 'package:flutter/material.dart';

class News extends StatelessWidget {
  final String newsTitle, stockName, stockPrice, stockRate;

  const News(
      {super.key,
      required this.newsTitle,
      required this.stockName,
      required this.stockPrice,
      required this.stockRate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(newsTitle),
              Text(stockName),
            ],
          ),
          Column(
            children: [
              Text(stockPrice),
              Text('$stockRate%'),
            ],
          ),
        ],
      ),
    );
  }
}
