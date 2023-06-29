import 'dart:convert';

import 'package:flutter/services.dart';

class AppStyleConfig {
  static late AppStyleConfig _instance;

  static Future<void> init() async {
    final yamlString = await rootBundle.loadString('publisher.json');
    final yamlMap = json.decode(yamlString);

    final publisherConfig = PublisherConfig(
      themeId: yamlMap['credential']['themeId'],
      applicationId: yamlMap['credential']['applicationId'],
      // TODO: Handle prod and stage env
      host: yamlMap['hosts']['configurator']['stage'],
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
  final String themeId;
  final String applicationId;
  final String host;

  PublisherConfig({
    required this.themeId,
    required this.applicationId,
    required this.host,
  });
}
