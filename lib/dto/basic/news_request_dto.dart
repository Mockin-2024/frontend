class NewsRequestDTO {
  final String queryDate, queryTime, email;

  NewsRequestDTO({
    required this.email,
    this.queryDate = '',
    this.queryTime = '',
  });

  Uri convert(String baseUrl) {
    return Uri.parse(
        '$baseUrl?email=$email&queryDate=$queryDate&queryTime=$queryTime');
  }
}
