import 'package:flutter/material.dart';
import 'package:mockin/models/news_content_model.dart';
import 'package:mockin/widgets/news.dart';

class NewsAll extends StatelessWidget {
  const NewsAll({
    super.key,
    required this.news,
  });

  final List<NewsContentModel> news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
            child: Text(
              '최신 금융 뉴스',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
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
                }),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
