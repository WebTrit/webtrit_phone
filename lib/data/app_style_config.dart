import 'dart:convert';

import 'package:flutter/services.dart';

//TODO: Merge with app theme
class AppStyleConfig {
  static late AppStyleConfig _instance;

  static Future<void> init() async {
    final jsonString = await rootBundle.loadString('publisher.json');
    final map = json.decode(jsonString);

    final publisherConfig = PublisherConfig(
      themeId: map['mapping']['themeId'],
      applicationId: map['mapping']['applicationId'],
      // TODO: Handle prod and stage env
      host: map['hosts']['configurator']['prod'],
    );

    _instance = AppStyleConfig._(publisherConfig);
  }

  factory AppStyleConfig() {
    return _instance;
  }

  AppStyleConfig._(this._publisherConfig);

  PublisherConfig _publisherConfig;

  PublisherConfig get publisherConfig => _publisherConfig;
}

//TODO: After adding dependency for publisher it will be moved there
class PublisherConfig {
  final String? themeId;
  final String? applicationId;
  final String host;

  PublisherConfig({
    required this.themeId,
    required this.applicationId,
    required this.host,
  });
}
