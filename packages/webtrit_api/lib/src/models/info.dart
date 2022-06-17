import 'package:json_annotation/json_annotation.dart';
import 'package:version/version.dart';

import 'converters/converters.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  const Info({
    required this.core,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);

  final CoreInfo core;
}

@JsonSerializable()
class CoreInfo {
  const CoreInfo({
    required this.version,
  });

  factory CoreInfo.fromJson(Map<String, dynamic> json) => _$CoreInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CoreInfoToJson(this);

  @VersionConverter()
  final Version version;
}
