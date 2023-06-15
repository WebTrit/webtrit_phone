import 'dart:convert';

import 'package:flutter/services.dart';


class AppYaml {
  static late AppYaml _instance;

  static Future<void> init() async {
    final yamlString = await rootBundle.loadString('publisher.json');
    final yamlMap = json.decode(yamlString);

    final publisherConfig = PublisherConfig(
      themeId: yamlMap['credential']['themeId'],
      applicationId: yamlMap['credential']['applicationId'],
      // TODO: Handle prod and stage env
      host: yamlMap['hosts']['configurator']['stage'],
    );

    _instance = AppYaml._(publisherConfig);
  }

  factory AppYaml() {
    return _instance;
  }

  AppYaml._(this._publisherConfig);

  PublisherConfig _publisherConfig;

  PublisherConfig get publisherConfig => _publisherConfig;
}

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
