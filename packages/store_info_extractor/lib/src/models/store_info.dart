import 'package:pub_semver/pub_semver.dart';

class StoreInfo {
  const StoreInfo({
    required this.version,
    required this.viewUrl,
  });

  final Version version;
  final Uri viewUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreInfo && runtimeType == other.runtimeType && version == other.version && viewUrl == other.viewUrl;

  @override
  int get hashCode => runtimeType.hashCode ^ version.hashCode ^ viewUrl.hashCode;

  @override
  String toString() {
    return 'StoreInfo($version, $viewUrl)';
  }
}
