import 'package:equatable/equatable.dart';

class SettingsSyncMetadata with EquatableMixin {
  const SettingsSyncMetadata({required this.version, required this.modifiedAt, required this.dirty});

  final int version;
  final DateTime modifiedAt;
  final bool dirty;

  @override
  List<Object?> get props => [version, modifiedAt, dirty];

  SettingsSyncMetadata copyWith({int? version, DateTime? modifiedAt, bool? dirty}) {
    return SettingsSyncMetadata(
      version: version ?? this.version,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      dirty: dirty ?? this.dirty,
    );
  }
}
