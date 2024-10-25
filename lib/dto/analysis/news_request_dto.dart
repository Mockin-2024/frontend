class NewsRequestDTO {
  final String queryDate, queryTime;

  NewsRequestDTO({
    this.queryDate = '',
    this.queryTime = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?queryDate=$queryDate&queryTime=$queryTime');
  }
}
