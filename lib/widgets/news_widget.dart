import 'package:flutter/material.dart';
import 'package:mockin/api/analysis_api.dart';
import 'package:mockin/dto/analysis/news_request_dto.dart';
import 'package:mockin/models/news_content_model.dart';
import 'package:mockin/widgets/news.dart';

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
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return News(
                    newsTitle: news[index].title,
                    newsDay: news[index].day,
                    newsTime: news[index].time,
                    country: news[index].country,
                    stockName: news[index].name,
                  );
                });
          }
          return const Text('');
        });
  }
}