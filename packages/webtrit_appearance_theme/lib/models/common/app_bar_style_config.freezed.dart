// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bar_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppBarStyleConfig _$AppBarStyleConfigFromJson(Map<String, dynamic> json) {
  return _AppBarStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$AppBarStyleConfig {
  /// Background color for the AppBar (hex, e.g. "#FFFFFF")
  String? get backgroundColor => throw _privateConstructorUsedError;

  /// Foreground color for icons & text (hex)
  String? get foregroundColor => throw _privateConstructorUsedError;

  /// Whether the AppBar is considered primary
  bool get primary => throw _privateConstructorUsedError;

  /// Optional flag for showing back button
  bool get showBackButton => throw _privateConstructorUsedError;

  /// Serializes this AppBarStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppBarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppBarStyleConfigCopyWith<AppBarStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBarStyleConfigCopyWith<$Res> {
  factory $AppBarStyleConfigCopyWith(
    AppBarStyleConfig value,
    $Res Function(AppBarStyleConfig) then,
  ) = _$AppBarStyleConfigCopyWithImpl<$Res, AppBarStyleConfig>;
  @useResult
  $Res call({
    String? backgroundColor,
    String? foregroundColor,
    bool primary,
    bool showBackButton,
  });
}

/// @nodoc
class _$AppBarStyleConfigCopyWithImpl<$Res, $Val extends AppBarStyleConfig>
    implements $AppBarStyleConfigCopyWith<$Res> {
  _$AppBarStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppBarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? foregroundColor = freezed,
    Object? primary = null,
    Object? showBackButton = null,
  }) {
    return _then(
      _value.copyWith(
            backgroundColor: freezed == backgroundColor
                ? _value.backgroundColor
                : backgroundColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            foregroundColor: freezed == foregroundColor
                ? _value.foregroundColor
                : foregroundColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            primary: null == primary
                ? _value.primary
                : primary // ignore: cast_nullable_to_non_nullable
                      as bool,
            showBackButton: null == showBackButton
                ? _value.showBackButton
                : showBackButton // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppBarStyleConfigImplCopyWith<$Res>
    implements $AppBarStyleConfigCopyWith<$Res> {
  factory _$$AppBarStyleConfigImplCopyWith(
    _$AppBarStyleConfigImpl value,
    $Res Function(_$AppBarStyleConfigImpl) then,
  ) = __$$AppBarStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? backgroundColor,
    String? foregroundColor,
    bool primary,
    bool showBackButton,
  });
}

/// @nodoc
class __$$AppBarStyleConfigImplCopyWithImpl<$Res>
    extends _$AppBarStyleConfigCopyWithImpl<$Res, _$AppBarStyleConfigImpl>
    implements _$$AppBarStyleConfigImplCopyWith<$Res> {
  __$$AppBarStyleConfigImplCopyWithImpl(
    _$AppBarStyleConfigImpl _value,
    $Res Function(_$AppBarStyleConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppBarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? foregroundColor = freezed,
    Object? primary = null,
    Object? showBackButton = null,
  }) {
    return _then(
      _$AppBarStyleConfigImpl(
        backgroundColor: freezed == backgroundColor
            ? _value.backgroundColor
            : backgroundColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        foregroundColor: freezed == foregroundColor
            ? _value.foregroundColor
            : foregroundColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        primary: null == primary
            ? _value.primary
            : primary // ignore: cast_nullable_to_non_nullable
                  as bool,
        showBackButton: null == showBackButton
            ? _value.showBackButton
            : showBackButton // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AppBarStyleConfigImpl implements _AppBarStyleConfig {
  const _$AppBarStyleConfigImpl({
    this.backgroundColor,
    this.foregroundColor,
    this.primary = true,
    this.showBackButton = true,
  });

  factory _$AppBarStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBarStyleConfigImplFromJson(json);

  /// Background color for the AppBar (hex, e.g. "#FFFFFF")
  @override
  final String? backgroundColor;

  /// Foreground color for icons & text (hex)
  @override
  final String? foregroundColor;

  /// Whether the AppBar is considered primary
  @override
  @JsonKey()
  final bool primary;

  /// Optional flag for showing back button
  @override
  @JsonKey()
  final bool showBackButton;

  @override
  String toString() {
    return 'AppBarStyleConfig(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, primary: $primary, showBackButton: $showBackButton)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBarStyleConfigImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.foregroundColor, foregroundColor) ||
                other.foregroundColor == foregroundColor) &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.showBackButton, showBackButton) ||
                other.showBackButton == showBackButton));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    backgroundColor,
    foregroundColor,
    primary,
    showBackButton,
  );

  /// Create a copy of AppBarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBarStyleConfigImplCopyWith<_$AppBarStyleConfigImpl> get copyWith =>
      __$$AppBarStyleConfigImplCopyWithImpl<_$AppBarStyleConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBarStyleConfigImplToJson(this);
  }
}

abstract class _AppBarStyleConfig implements AppBarStyleConfig {
  const factory _AppBarStyleConfig({
    final String? backgroundColor,
    final String? foregroundColor,
    final bool primary,
    final bool showBackButton,
  }) = _$AppBarStyleConfigImpl;

  factory _AppBarStyleConfig.fromJson(Map<String, dynamic> json) =
      _$AppBarStyleConfigImpl.fromJson;

  /// Background color for the AppBar (hex, e.g. "#FFFFFF")
  @override
  String? get backgroundColor;

  /// Foreground color for icons & text (hex)
  @override
  String? get foregroundColor;

  /// Whether the AppBar is considered primary
  @override
  bool get primary;

  /// Optional flag for showing back button
  @override
  bool get showBackButton;

  /// Create a copy of AppBarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppBarStyleConfigImplCopyWith<_$AppBarStyleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
