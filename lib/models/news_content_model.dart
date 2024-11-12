class NewsContentModel {
  final String title, day, time, country, name;

  NewsContentModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        day = json['data_dt'],
        time = json['data_tm'],
        country = json['nation_cd'],
        name = json['symb_name'];
}
