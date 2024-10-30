import 'package:flutter/material.dart';
import 'package:mockin/provider/exchange_trans.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            newsTitle,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          OneLine(
              A: ExchangeTrans.nationCode[country]!,
              B: '${newsDay.substring(4, 6)}월 ${newsDay.substring(6, 8)}일 ${newsTime.substring(0, 2)}:${newsTime.substring(2, 4)}'),
        ]),
      ),
    );
  }
}
