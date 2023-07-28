// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  String? get name => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  bool get autoUpdate => throw _privateConstructorUsedError;
  Mapping get mapping => throw _privateConstructorUsedError;
  Hosts get hosts => throw _privateConstructorUsedError;
  Output? get output => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call(
      {String? name,
      String? version,
      bool autoUpdate,
      Mapping mapping,
      Hosts hosts,
      Output? output});

  $MappingCopyWith<$Res> get mapping;
  $HostsCopyWith<$Res> get hosts;
  $OutputCopyWith<$Res>? get output;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? version = freezed,
    Object? autoUpdate = null,
    Object? mapping = null,
    Object? hosts = null,
    Object? output = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      mapping: null == mapping
          ? _value.mapping
          : mapping // ignore: cast_nullable_to_non_nullable
              as Mapping,
      hosts: null == hosts
          ? _value.hosts
          : hosts // ignore: cast_nullable_to_non_nullable
              as Hosts,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Output?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MappingCopyWith<$Res> get mapping {
    return $MappingCopyWith<$Res>(_value.mapping, (value) {
      return _then(_value.copyWith(mapping: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HostsCopyWith<$Res> get hosts {
    return $HostsCopyWith<$Res>(_value.hosts, (value) {
      return _then(_value.copyWith(hosts: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputCopyWith<$Res>? get output {
    if (_value.output == null) {
      return null;
    }

    return $OutputCopyWith<$Res>(_value.output!, (value) {
      return _then(_value.copyWith(output: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? version,
      bool autoUpdate,
      Mapping mapping,
      Hosts hosts,
      Output? output});

  @override
  $MappingCopyWith<$Res> get mapping;
  @override
  $HostsCopyWith<$Res> get hosts;
  @override
  $OutputCopyWith<$Res>? get output;
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$_Config>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? version = freezed,
    Object? autoUpdate = null,
    Object? mapping = null,
    Object? hosts = null,
    Object? output = freezed,
  }) {
    return _then(_$_Config(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      mapping: null == mapping
          ? _value.mapping
          : mapping // ignore: cast_nullable_to_non_nullable
              as Mapping,
      hosts: null == hosts
          ? _value.hosts
          : hosts // ignore: cast_nullable_to_non_nullable
              as Hosts,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Output?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  const _$_Config(
      {this.name,
      this.version,
      this.autoUpdate = false,
      required this.mapping,
      required this.hosts,
      this.output});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  @override
  final String? name;
  @override
  final String? version;
  @override
  @JsonKey()
  final bool autoUpdate;
  @override
  final Mapping mapping;
  @override
  final Hosts hosts;
  @override
  final Output? output;

  @override
  String toString() {
    return 'Config(name: $name, version: $version, autoUpdate: $autoUpdate, mapping: $mapping, hosts: $hosts, output: $output)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.autoUpdate, autoUpdate) ||
                other.autoUpdate == autoUpdate) &&
            (identical(other.mapping, mapping) || other.mapping == mapping) &&
            (identical(other.hosts, hosts) || other.hosts == hosts) &&
            (identical(other.output, output) || other.output == output));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, version, autoUpdate, mapping, hosts, output);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  const factory _Config(
      {final String? name,
      final String? version,
      final bool autoUpdate,
      required final Mapping mapping,
      required final Hosts hosts,
      final Output? output}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override
  String? get name;
  @override
  String? get version;
  @override
  bool get autoUpdate;
  @override
  Mapping get mapping;
  @override
  Hosts get hosts;
  @override
  Output? get output;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}

Output _$OutputFromJson(Map<String, dynamic> json) {
  return _Output.fromJson(json);
}

/// @nodoc
mixin _$Output {
  Path? get theme => throw _privateConstructorUsedError;
  Path? get primaryOnboardingLogo => throw _privateConstructorUsedError;
  Path? get secondaryOnboardingLogo => throw _privateConstructorUsedError;
  Path? get pushNotificationIcon => throw _privateConstructorUsedError;
  Path? get adaptiveIconBackground => throw _privateConstructorUsedError;
  Path? get adaptiveIconForeground => throw _privateConstructorUsedError;
  Path? get androidLauncherIcon => throw _privateConstructorUsedError;
  Path? get iosLauncherIcon => throw _privateConstructorUsedError;
  Path? get webLauncherIcon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutputCopyWith<Output> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputCopyWith<$Res> {
  factory $OutputCopyWith(Output value, $Res Function(Output) then) =
      _$OutputCopyWithImpl<$Res, Output>;
  @useResult
  $Res call(
      {Path? theme,
      Path? primaryOnboardingLogo,
      Path? secondaryOnboardingLogo,
      Path? pushNotificationIcon,
      Path? adaptiveIconBackground,
      Path? adaptiveIconForeground,
      Path? androidLauncherIcon,
      Path? iosLauncherIcon,
      Path? webLauncherIcon});

  $PathCopyWith<$Res>? get theme;
  $PathCopyWith<$Res>? get primaryOnboardingLogo;
  $PathCopyWith<$Res>? get secondaryOnboardingLogo;
  $PathCopyWith<$Res>? get pushNotificationIcon;
  $PathCopyWith<$Res>? get adaptiveIconBackground;
  $PathCopyWith<$Res>? get adaptiveIconForeground;
  $PathCopyWith<$Res>? get androidLauncherIcon;
  $PathCopyWith<$Res>? get iosLauncherIcon;
  $PathCopyWith<$Res>? get webLauncherIcon;
}

/// @nodoc
class _$OutputCopyWithImpl<$Res, $Val extends Output>
    implements $OutputCopyWith<$Res> {
  _$OutputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = freezed,
    Object? primaryOnboardingLogo = freezed,
    Object? secondaryOnboardingLogo = freezed,
    Object? pushNotificationIcon = freezed,
    Object? adaptiveIconBackground = freezed,
    Object? adaptiveIconForeground = freezed,
    Object? androidLauncherIcon = freezed,
    Object? iosLauncherIcon = freezed,
    Object? webLauncherIcon = freezed,
  }) {
    return _then(_value.copyWith(
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as Path?,
      primaryOnboardingLogo: freezed == primaryOnboardingLogo
          ? _value.primaryOnboardingLogo
          : primaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as Path?,
      secondaryOnboardingLogo: freezed == secondaryOnboardingLogo
          ? _value.secondaryOnboardingLogo
          : secondaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as Path?,
      pushNotificationIcon: freezed == pushNotificationIcon
          ? _value.pushNotificationIcon
          : pushNotificationIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      adaptiveIconBackground: freezed == adaptiveIconBackground
          ? _value.adaptiveIconBackground
          : adaptiveIconBackground // ignore: cast_nullable_to_non_nullable
              as Path?,
      adaptiveIconForeground: freezed == adaptiveIconForeground
          ? _value.adaptiveIconForeground
          : adaptiveIconForeground // ignore: cast_nullable_to_non_nullable
              as Path?,
      androidLauncherIcon: freezed == androidLauncherIcon
          ? _value.androidLauncherIcon
          : androidLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      iosLauncherIcon: freezed == iosLauncherIcon
          ? _value.iosLauncherIcon
          : iosLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      webLauncherIcon: freezed == webLauncherIcon
          ? _value.webLauncherIcon
          : webLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get theme {
    if (_value.theme == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.theme!, (value) {
      return _then(_value.copyWith(theme: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get primaryOnboardingLogo {
    if (_value.primaryOnboardingLogo == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.primaryOnboardingLogo!, (value) {
      return _then(_value.copyWith(primaryOnboardingLogo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get secondaryOnboardingLogo {
    if (_value.secondaryOnboardingLogo == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.secondaryOnboardingLogo!, (value) {
      return _then(_value.copyWith(secondaryOnboardingLogo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get pushNotificationIcon {
    if (_value.pushNotificationIcon == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.pushNotificationIcon!, (value) {
      return _then(_value.copyWith(pushNotificationIcon: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get adaptiveIconBackground {
    if (_value.adaptiveIconBackground == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.adaptiveIconBackground!, (value) {
      return _then(_value.copyWith(adaptiveIconBackground: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get adaptiveIconForeground {
    if (_value.adaptiveIconForeground == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.adaptiveIconForeground!, (value) {
      return _then(_value.copyWith(adaptiveIconForeground: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get androidLauncherIcon {
    if (_value.androidLauncherIcon == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.androidLauncherIcon!, (value) {
      return _then(_value.copyWith(androidLauncherIcon: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get iosLauncherIcon {
    if (_value.iosLauncherIcon == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.iosLauncherIcon!, (value) {
      return _then(_value.copyWith(iosLauncherIcon: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PathCopyWith<$Res>? get webLauncherIcon {
    if (_value.webLauncherIcon == null) {
      return null;
    }

    return $PathCopyWith<$Res>(_value.webLauncherIcon!, (value) {
      return _then(_value.copyWith(webLauncherIcon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OutputCopyWith<$Res> implements $OutputCopyWith<$Res> {
  factory _$$_OutputCopyWith(_$_Output value, $Res Function(_$_Output) then) =
      __$$_OutputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Path? theme,
      Path? primaryOnboardingLogo,
      Path? secondaryOnboardingLogo,
      Path? pushNotificationIcon,
      Path? adaptiveIconBackground,
      Path? adaptiveIconForeground,
      Path? androidLauncherIcon,
      Path? iosLauncherIcon,
      Path? webLauncherIcon});

  @override
  $PathCopyWith<$Res>? get theme;
  @override
  $PathCopyWith<$Res>? get primaryOnboardingLogo;
  @override
  $PathCopyWith<$Res>? get secondaryOnboardingLogo;
  @override
  $PathCopyWith<$Res>? get pushNotificationIcon;
  @override
  $PathCopyWith<$Res>? get adaptiveIconBackground;
  @override
  $PathCopyWith<$Res>? get adaptiveIconForeground;
  @override
  $PathCopyWith<$Res>? get androidLauncherIcon;
  @override
  $PathCopyWith<$Res>? get iosLauncherIcon;
  @override
  $PathCopyWith<$Res>? get webLauncherIcon;
}

/// @nodoc
class __$$_OutputCopyWithImpl<$Res>
    extends _$OutputCopyWithImpl<$Res, _$_Output>
    implements _$$_OutputCopyWith<$Res> {
  __$$_OutputCopyWithImpl(_$_Output _value, $Res Function(_$_Output) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = freezed,
    Object? primaryOnboardingLogo = freezed,
    Object? secondaryOnboardingLogo = freezed,
    Object? pushNotificationIcon = freezed,
    Object? adaptiveIconBackground = freezed,
    Object? adaptiveIconForeground = freezed,
    Object? androidLauncherIcon = freezed,
    Object? iosLauncherIcon = freezed,
    Object? webLauncherIcon = freezed,
  }) {
    return _then(_$_Output(
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as Path?,
      primaryOnboardingLogo: freezed == primaryOnboardingLogo
          ? _value.primaryOnboardingLogo
          : primaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as Path?,
      secondaryOnboardingLogo: freezed == secondaryOnboardingLogo
          ? _value.secondaryOnboardingLogo
          : secondaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as Path?,
      pushNotificationIcon: freezed == pushNotificationIcon
          ? _value.pushNotificationIcon
          : pushNotificationIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      adaptiveIconBackground: freezed == adaptiveIconBackground
          ? _value.adaptiveIconBackground
          : adaptiveIconBackground // ignore: cast_nullable_to_non_nullable
              as Path?,
      adaptiveIconForeground: freezed == adaptiveIconForeground
          ? _value.adaptiveIconForeground
          : adaptiveIconForeground // ignore: cast_nullable_to_non_nullable
              as Path?,
      androidLauncherIcon: freezed == androidLauncherIcon
          ? _value.androidLauncherIcon
          : androidLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      iosLauncherIcon: freezed == iosLauncherIcon
          ? _value.iosLauncherIcon
          : iosLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
      webLauncherIcon: freezed == webLauncherIcon
          ? _value.webLauncherIcon
          : webLauncherIcon // ignore: cast_nullable_to_non_nullable
              as Path?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Output implements _Output {
  const _$_Output(
      {this.theme,
      this.primaryOnboardingLogo,
      this.secondaryOnboardingLogo,
      this.pushNotificationIcon,
      this.adaptiveIconBackground,
      this.adaptiveIconForeground,
      this.androidLauncherIcon,
      this.iosLauncherIcon,
      this.webLauncherIcon});

  factory _$_Output.fromJson(Map<String, dynamic> json) =>
      _$$_OutputFromJson(json);

  @override
  final Path? theme;
  @override
  final Path? primaryOnboardingLogo;
  @override
  final Path? secondaryOnboardingLogo;
  @override
  final Path? pushNotificationIcon;
  @override
  final Path? adaptiveIconBackground;
  @override
  final Path? adaptiveIconForeground;
  @override
  final Path? androidLauncherIcon;
  @override
  final Path? iosLauncherIcon;
  @override
  final Path? webLauncherIcon;

  @override
  String toString() {
    return 'Output(theme: $theme, primaryOnboardingLogo: $primaryOnboardingLogo, secondaryOnboardingLogo: $secondaryOnboardingLogo, pushNotificationIcon: $pushNotificationIcon, adaptiveIconBackground: $adaptiveIconBackground, adaptiveIconForeground: $adaptiveIconForeground, androidLauncherIcon: $androidLauncherIcon, iosLauncherIcon: $iosLauncherIcon, webLauncherIcon: $webLauncherIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Output &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.primaryOnboardingLogo, primaryOnboardingLogo) ||
                other.primaryOnboardingLogo == primaryOnboardingLogo) &&
            (identical(
                    other.secondaryOnboardingLogo, secondaryOnboardingLogo) ||
                other.secondaryOnboardingLogo == secondaryOnboardingLogo) &&
            (identical(other.pushNotificationIcon, pushNotificationIcon) ||
                other.pushNotificationIcon == pushNotificationIcon) &&
            (identical(other.adaptiveIconBackground, adaptiveIconBackground) ||
                other.adaptiveIconBackground == adaptiveIconBackground) &&
            (identical(other.adaptiveIconForeground, adaptiveIconForeground) ||
                other.adaptiveIconForeground == adaptiveIconForeground) &&
            (identical(other.androidLauncherIcon, androidLauncherIcon) ||
                other.androidLauncherIcon == androidLauncherIcon) &&
            (identical(other.iosLauncherIcon, iosLauncherIcon) ||
                other.iosLauncherIcon == iosLauncherIcon) &&
            (identical(other.webLauncherIcon, webLauncherIcon) ||
                other.webLauncherIcon == webLauncherIcon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      theme,
      primaryOnboardingLogo,
      secondaryOnboardingLogo,
      pushNotificationIcon,
      adaptiveIconBackground,
      adaptiveIconForeground,
      androidLauncherIcon,
      iosLauncherIcon,
      webLauncherIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutputCopyWith<_$_Output> get copyWith =>
      __$$_OutputCopyWithImpl<_$_Output>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OutputToJson(
      this,
    );
  }
}

abstract class _Output implements Output {
  const factory _Output(
      {final Path? theme,
      final Path? primaryOnboardingLogo,
      final Path? secondaryOnboardingLogo,
      final Path? pushNotificationIcon,
      final Path? adaptiveIconBackground,
      final Path? adaptiveIconForeground,
      final Path? androidLauncherIcon,
      final Path? iosLauncherIcon,
      final Path? webLauncherIcon}) = _$_Output;

  factory _Output.fromJson(Map<String, dynamic> json) = _$_Output.fromJson;

  @override
  Path? get theme;
  @override
  Path? get primaryOnboardingLogo;
  @override
  Path? get secondaryOnboardingLogo;
  @override
  Path? get pushNotificationIcon;
  @override
  Path? get adaptiveIconBackground;
  @override
  Path? get adaptiveIconForeground;
  @override
  Path? get androidLauncherIcon;
  @override
  Path? get iosLauncherIcon;
  @override
  Path? get webLauncherIcon;
  @override
  @JsonKey(ignore: true)
  _$$_OutputCopyWith<_$_Output> get copyWith =>
      throw _privateConstructorUsedError;
}

Path _$PathFromJson(Map<String, dynamic> json) {
  return _Path.fromJson(json);
}

/// @nodoc
mixin _$Path {
  String? get path => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PathCopyWith<Path> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathCopyWith<$Res> {
  factory $PathCopyWith(Path value, $Res Function(Path) then) =
      _$PathCopyWithImpl<$Res, Path>;
  @useResult
  $Res call({String? path, String? name});
}

/// @nodoc
class _$PathCopyWithImpl<$Res, $Val extends Path>
    implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PathCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$$_PathCopyWith(_$_Path value, $Res Function(_$_Path) then) =
      __$$_PathCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? path, String? name});
}

/// @nodoc
class __$$_PathCopyWithImpl<$Res> extends _$PathCopyWithImpl<$Res, _$_Path>
    implements _$$_PathCopyWith<$Res> {
  __$$_PathCopyWithImpl(_$_Path _value, $Res Function(_$_Path) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Path(
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Path implements _Path {
  const _$_Path({this.path, this.name});

  factory _$_Path.fromJson(Map<String, dynamic> json) => _$$_PathFromJson(json);

  @override
  final String? path;
  @override
  final String? name;

  @override
  String toString() {
    return 'Path(path: $path, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Path &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PathCopyWith<_$_Path> get copyWith =>
      __$$_PathCopyWithImpl<_$_Path>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PathToJson(
      this,
    );
  }
}

abstract class _Path implements Path {
  const factory _Path({final String? path, final String? name}) = _$_Path;

  factory _Path.fromJson(Map<String, dynamic> json) = _$_Path.fromJson;

  @override
  String? get path;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_PathCopyWith<_$_Path> get copyWith => throw _privateConstructorUsedError;
}

Hosts _$HostsFromJson(Map<String, dynamic> json) {
  return _Hosts.fromJson(json);
}

/// @nodoc
mixin _$Hosts {
  String? get stage => throw _privateConstructorUsedError;
  String get prod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HostsCopyWith<Hosts> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostsCopyWith<$Res> {
  factory $HostsCopyWith(Hosts value, $Res Function(Hosts) then) =
      _$HostsCopyWithImpl<$Res, Hosts>;
  @useResult
  $Res call({String? stage, String prod});
}

/// @nodoc
class _$HostsCopyWithImpl<$Res, $Val extends Hosts>
    implements $HostsCopyWith<$Res> {
  _$HostsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = freezed,
    Object? prod = null,
  }) {
    return _then(_value.copyWith(
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      prod: null == prod
          ? _value.prod
          : prod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HostsCopyWith<$Res> implements $HostsCopyWith<$Res> {
  factory _$$_HostsCopyWith(_$_Hosts value, $Res Function(_$_Hosts) then) =
      __$$_HostsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? stage, String prod});
}

/// @nodoc
class __$$_HostsCopyWithImpl<$Res> extends _$HostsCopyWithImpl<$Res, _$_Hosts>
    implements _$$_HostsCopyWith<$Res> {
  __$$_HostsCopyWithImpl(_$_Hosts _value, $Res Function(_$_Hosts) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = freezed,
    Object? prod = null,
  }) {
    return _then(_$_Hosts(
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      prod: null == prod
          ? _value.prod
          : prod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Hosts implements _Hosts {
  const _$_Hosts({this.stage, required this.prod});

  factory _$_Hosts.fromJson(Map<String, dynamic> json) =>
      _$$_HostsFromJson(json);

  @override
  final String? stage;
  @override
  final String prod;

  @override
  String toString() {
    return 'Hosts(stage: $stage, prod: $prod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Hosts &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.prod, prod) || other.prod == prod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stage, prod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HostsCopyWith<_$_Hosts> get copyWith =>
      __$$_HostsCopyWithImpl<_$_Hosts>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HostsToJson(
      this,
    );
  }
}

abstract class _Hosts implements Hosts {
  const factory _Hosts({final String? stage, required final String prod}) =
      _$_Hosts;

  factory _Hosts.fromJson(Map<String, dynamic> json) = _$_Hosts.fromJson;

  @override
  String? get stage;
  @override
  String get prod;
  @override
  @JsonKey(ignore: true)
  _$$_HostsCopyWith<_$_Hosts> get copyWith =>
      throw _privateConstructorUsedError;
}

Mapping _$MappingFromJson(Map<String, dynamic> json) {
  return _CredentialBean.fromJson(json);
}

/// @nodoc
mixin _$Mapping {
  String? get themeId => throw _privateConstructorUsedError;
  String? get applicationId => throw _privateConstructorUsedError;
  String? get themePath => throw _privateConstructorUsedError;
  String? get applicationPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MappingCopyWith<Mapping> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MappingCopyWith<$Res> {
  factory $MappingCopyWith(Mapping value, $Res Function(Mapping) then) =
      _$MappingCopyWithImpl<$Res, Mapping>;
  @useResult
  $Res call(
      {String? themeId,
      String? applicationId,
      String? themePath,
      String? applicationPath});
}

/// @nodoc
class _$MappingCopyWithImpl<$Res, $Val extends Mapping>
    implements $MappingCopyWith<$Res> {
  _$MappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeId = freezed,
    Object? applicationId = freezed,
    Object? themePath = freezed,
    Object? applicationPath = freezed,
  }) {
    return _then(_value.copyWith(
      themeId: freezed == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
      themePath: freezed == themePath
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationPath: freezed == applicationPath
          ? _value.applicationPath
          : applicationPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CredentialBeanCopyWith<$Res>
    implements $MappingCopyWith<$Res> {
  factory _$$_CredentialBeanCopyWith(
          _$_CredentialBean value, $Res Function(_$_CredentialBean) then) =
      __$$_CredentialBeanCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? themeId,
      String? applicationId,
      String? themePath,
      String? applicationPath});
}

/// @nodoc
class __$$_CredentialBeanCopyWithImpl<$Res>
    extends _$MappingCopyWithImpl<$Res, _$_CredentialBean>
    implements _$$_CredentialBeanCopyWith<$Res> {
  __$$_CredentialBeanCopyWithImpl(
      _$_CredentialBean _value, $Res Function(_$_CredentialBean) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeId = freezed,
    Object? applicationId = freezed,
    Object? themePath = freezed,
    Object? applicationPath = freezed,
  }) {
    return _then(_$_CredentialBean(
      themeId: freezed == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
      themePath: freezed == themePath
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationPath: freezed == applicationPath
          ? _value.applicationPath
          : applicationPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CredentialBean implements _CredentialBean {
  const _$_CredentialBean(
      {this.themeId, this.applicationId, this.themePath, this.applicationPath});

  factory _$_CredentialBean.fromJson(Map<String, dynamic> json) =>
      _$$_CredentialBeanFromJson(json);

  @override
  final String? themeId;
  @override
  final String? applicationId;
  @override
  final String? themePath;
  @override
  final String? applicationPath;

  @override
  String toString() {
    return 'Mapping(themeId: $themeId, applicationId: $applicationId, themePath: $themePath, applicationPath: $applicationPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CredentialBean &&
            (identical(other.themeId, themeId) || other.themeId == themeId) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.themePath, themePath) ||
                other.themePath == themePath) &&
            (identical(other.applicationPath, applicationPath) ||
                other.applicationPath == applicationPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, themeId, applicationId, themePath, applicationPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CredentialBeanCopyWith<_$_CredentialBean> get copyWith =>
      __$$_CredentialBeanCopyWithImpl<_$_CredentialBean>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CredentialBeanToJson(
      this,
    );
  }
}

abstract class _CredentialBean implements Mapping {
  const factory _CredentialBean(
      {final String? themeId,
      final String? applicationId,
      final String? themePath,
      final String? applicationPath}) = _$_CredentialBean;

  factory _CredentialBean.fromJson(Map<String, dynamic> json) =
      _$_CredentialBean.fromJson;

  @override
  String? get themeId;
  @override
  String? get applicationId;
  @override
  String? get themePath;
  @override
  String? get applicationPath;
  @override
  @JsonKey(ignore: true)
  _$$_CredentialBeanCopyWith<_$_CredentialBean> get copyWith =>
      throw _privateConstructorUsedError;
}
