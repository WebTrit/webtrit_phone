class ConfigData {
  final Uri url;
  final String? titleL10n;

  ConfigData({
    required this.url,
    this.titleL10n,
  });

  factory ConfigData.url(String url) {
    return ConfigData(
      url: Uri.parse(url),
    );
  }

  factory ConfigData.create(String url, String titleL10n) {
    return ConfigData(
      url: Uri.parse(url),
      titleL10n: titleL10n,
    );
  }
}
