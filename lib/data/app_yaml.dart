import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/services.dart';
import 'package:style/style.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:yaml/yaml.dart';

import '../app/assets.gen.dart';

class AppYaml {
  static late AppYaml _instance;

  static Future<void> init() async {
    final yamlString = await rootBundle.loadString('publisher.yaml');
    final yamlMap = loadYaml(yamlString);

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
