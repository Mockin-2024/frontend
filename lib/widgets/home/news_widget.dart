import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockin/api/analysis_api.dart';
import 'package:mockin/dto/analysis/news_request_dto.dart';
import 'package:mockin/models/news_content_model.dart';
import 'package:mockin/stocks/news_all.dart';
import 'package:mockin/widgets/home/news.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AnalysisApi.reqNews(
          DTO: NewsRequestDTO(),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NewsContentModel> news = snapshot.data!;
            return Column(
              children: [
                for (var i = 0; i < min(5, news.length); i++)
                  News(
                    newsTitle: news[i].title,
                    newsDay: news[i].day,
                    newsTime: news[i].time,
                    country: news[i].country,
                    stockName: news[i].name,
                  ),
                if (news.length > 5)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsAll(
                            news: news,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      '더 보기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            );
          }
          return const Text('');
        });
  }
}
