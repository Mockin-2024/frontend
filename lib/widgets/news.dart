import 'package:flutter/material.dart';
import 'package:mockin/widgets/one_line.dart';

class News extends StatelessWidget {
  final String newsTitle, newsDay, newsTime, country, stockName;

  const News({
    super.key,
    required this.newsTitle,
    required this.newsDay,
    required this.newsTime,
    required this.country,
    required this.stockName,
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
            OneLine(A: newsTitle, B: ''),
            OneLine(A: country, B: stockName),
            OneLine(A: newsDay, B: newsTime),
          ],
        ),
      ),
    );
  }
}
