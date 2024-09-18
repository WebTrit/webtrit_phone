class ConfigData {
  final Uri url;

  ConfigData({
    required this.url,
  });

  factory ConfigData.url(String url) {
    return ConfigData(
      url: Uri.parse(url),
    );
  }
}
