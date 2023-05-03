class ApplicationModel {
  ApplicationModel({
    this.platformIdentifier,
    this.id,
    this.theme,
    this.title,
    this.version,
  });

  ApplicationModel.fromJson(dynamic json) {
    platformIdentifier = json['platformIdentifier'];
    id = json['id'];
    theme = json['theme'];
    title = json['name'];
    version = json['version'];
  }

  String? platformIdentifier;
  String? id;
  String? theme;
  String? title;
  int? version;
}
