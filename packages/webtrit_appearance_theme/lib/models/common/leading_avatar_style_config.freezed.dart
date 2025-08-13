// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leading_avatar_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeadingAvatarStyleConfig _$LeadingAvatarStyleConfigFromJson(
    Map<String, dynamic> json) {
  return _LeadingAvatarStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$LeadingAvatarStyleConfig {
  /// Circle background color. Defaults to theme.secondaryContainer when null.
  String? get backgroundColor => throw _privateConstructorUsedError;

  /// Avatar radius (defaults to 20.0 in widget if null).
  double? get radius => throw _privateConstructorUsedError;

  /// Text style for initials fallback.
  TextStyleConfig? get initialsTextStyle => throw _privateConstructorUsedError;

  /// Placeholder icon when no username/thumbnail is available.
  IconDataConfig? get placeholderIcon => throw _privateConstructorUsedError;

  /// Loading overlay appearance.
  LoadingOverlayStyleConfig? get loading => throw _privateConstructorUsedError;

  /// "Smart" badge indicator appearance.
  SmartIndicatorStyleConfig? get smartIndicator =>
      throw _privateConstructorUsedError;

  /// Registered/unregistered badge appearance.
  RegisteredBadgeStyleConfig? get registeredBadge =>
      throw _privateConstructorUsedError;

  /// Serializes this LeadingAvatarStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeadingAvatarStyleConfigCopyWith<LeadingAvatarStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeadingAvatarStyleConfigCopyWith<$Res> {
  factory $LeadingAvatarStyleConfigCopyWith(LeadingAvatarStyleConfig value,
          $Res Function(LeadingAvatarStyleConfig) then) =
      _$LeadingAvatarStyleConfigCopyWithImpl<$Res, LeadingAvatarStyleConfig>;
  @useResult
  $Res call(
      {String? backgroundColor,
      double? radius,
      TextStyleConfig? initialsTextStyle,
      IconDataConfig? placeholderIcon,
      LoadingOverlayStyleConfig? loading,
      SmartIndicatorStyleConfig? smartIndicator,
      RegisteredBadgeStyleConfig? registeredBadge});

  $TextStyleConfigCopyWith<$Res>? get initialsTextStyle;
  $IconDataConfigCopyWith<$Res>? get placeholderIcon;
  $LoadingOverlayStyleConfigCopyWith<$Res>? get loading;
  $SmartIndicatorStyleConfigCopyWith<$Res>? get smartIndicator;
  $RegisteredBadgeStyleConfigCopyWith<$Res>? get registeredBadge;
}

/// @nodoc
class _$LeadingAvatarStyleConfigCopyWithImpl<$Res,
        $Val extends LeadingAvatarStyleConfig>
    implements $LeadingAvatarStyleConfigCopyWith<$Res> {
  _$LeadingAvatarStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? radius = freezed,
    Object? initialsTextStyle = freezed,
    Object? placeholderIcon = freezed,
    Object? loading = freezed,
    Object? smartIndicator = freezed,
    Object? registeredBadge = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      initialsTextStyle: freezed == initialsTextStyle
          ? _value.initialsTextStyle
          : initialsTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      placeholderIcon: freezed == placeholderIcon
          ? _value.placeholderIcon
          : placeholderIcon // ignore: cast_nullable_to_non_nullable
              as IconDataConfig?,
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as LoadingOverlayStyleConfig?,
      smartIndicator: freezed == smartIndicator
          ? _value.smartIndicator
          : smartIndicator // ignore: cast_nullable_to_non_nullable
              as SmartIndicatorStyleConfig?,
      registeredBadge: freezed == registeredBadge
          ? _value.registeredBadge
          : registeredBadge // ignore: cast_nullable_to_non_nullable
              as RegisteredBadgeStyleConfig?,
    ) as $Val);
  }

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleConfigCopyWith<$Res>? get initialsTextStyle {
    if (_value.initialsTextStyle == null) {
      return null;
    }

    return $TextStyleConfigCopyWith<$Res>(_value.initialsTextStyle!, (value) {
      return _then(_value.copyWith(initialsTextStyle: value) as $Val);
    });
  }

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IconDataConfigCopyWith<$Res>? get placeholderIcon {
    if (_value.placeholderIcon == null) {
      return null;
    }

    return $IconDataConfigCopyWith<$Res>(_value.placeholderIcon!, (value) {
      return _then(_value.copyWith(placeholderIcon: value) as $Val);
    });
  }

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadingOverlayStyleConfigCopyWith<$Res>? get loading {
    if (_value.loading == null) {
      return null;
    }

    return $LoadingOverlayStyleConfigCopyWith<$Res>(_value.loading!, (value) {
      return _then(_value.copyWith(loading: value) as $Val);
    });
  }

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmartIndicatorStyleConfigCopyWith<$Res>? get smartIndicator {
    if (_value.smartIndicator == null) {
      return null;
    }

    return $SmartIndicatorStyleConfigCopyWith<$Res>(_value.smartIndicator!,
        (value) {
      return _then(_value.copyWith(smartIndicator: value) as $Val);
    });
  }

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegisteredBadgeStyleConfigCopyWith<$Res>? get registeredBadge {
    if (_value.registeredBadge == null) {
      return null;
    }

    return $RegisteredBadgeStyleConfigCopyWith<$Res>(_value.registeredBadge!,
        (value) {
      return _then(_value.copyWith(registeredBadge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeadingAvatarStyleConfigImplCopyWith<$Res>
    implements $LeadingAvatarStyleConfigCopyWith<$Res> {
  factory _$$LeadingAvatarStyleConfigImplCopyWith(
          _$LeadingAvatarStyleConfigImpl value,
          $Res Function(_$LeadingAvatarStyleConfigImpl) then) =
      __$$LeadingAvatarStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? backgroundColor,
      double? radius,
      TextStyleConfig? initialsTextStyle,
      IconDataConfig? placeholderIcon,
      LoadingOverlayStyleConfig? loading,
      SmartIndicatorStyleConfig? smartIndicator,
      RegisteredBadgeStyleConfig? registeredBadge});

  @override
  $TextStyleConfigCopyWith<$Res>? get initialsTextStyle;
  @override
  $IconDataConfigCopyWith<$Res>? get placeholderIcon;
  @override
  $LoadingOverlayStyleConfigCopyWith<$Res>? get loading;
  @override
  $SmartIndicatorStyleConfigCopyWith<$Res>? get smartIndicator;
  @override
  $RegisteredBadgeStyleConfigCopyWith<$Res>? get registeredBadge;
}

/// @nodoc
class __$$LeadingAvatarStyleConfigImplCopyWithImpl<$Res>
    extends _$LeadingAvatarStyleConfigCopyWithImpl<$Res,
        _$LeadingAvatarStyleConfigImpl>
    implements _$$LeadingAvatarStyleConfigImplCopyWith<$Res> {
  __$$LeadingAvatarStyleConfigImplCopyWithImpl(
      _$LeadingAvatarStyleConfigImpl _value,
      $Res Function(_$LeadingAvatarStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? radius = freezed,
    Object? initialsTextStyle = freezed,
    Object? placeholderIcon = freezed,
    Object? loading = freezed,
    Object? smartIndicator = freezed,
    Object? registeredBadge = freezed,
  }) {
    return _then(_$LeadingAvatarStyleConfigImpl(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      initialsTextStyle: freezed == initialsTextStyle
          ? _value.initialsTextStyle
          : initialsTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      placeholderIcon: freezed == placeholderIcon
          ? _value.placeholderIcon
          : placeholderIcon // ignore: cast_nullable_to_non_nullable
              as IconDataConfig?,
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as LoadingOverlayStyleConfig?,
      smartIndicator: freezed == smartIndicator
          ? _value.smartIndicator
          : smartIndicator // ignore: cast_nullable_to_non_nullable
              as SmartIndicatorStyleConfig?,
      registeredBadge: freezed == registeredBadge
          ? _value.registeredBadge
          : registeredBadge // ignore: cast_nullable_to_non_nullable
              as RegisteredBadgeStyleConfig?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LeadingAvatarStyleConfigImpl implements _LeadingAvatarStyleConfig {
  const _$LeadingAvatarStyleConfigImpl(
      {this.backgroundColor,
      this.radius,
      this.initialsTextStyle,
      this.placeholderIcon,
      this.loading,
      this.smartIndicator,
      this.registeredBadge});

  factory _$LeadingAvatarStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeadingAvatarStyleConfigImplFromJson(json);

  /// Circle background color. Defaults to theme.secondaryContainer when null.
  @override
  final String? backgroundColor;

  /// Avatar radius (defaults to 20.0 in widget if null).
  @override
  final double? radius;

  /// Text style for initials fallback.
  @override
  final TextStyleConfig? initialsTextStyle;

  /// Placeholder icon when no username/thumbnail is available.
  @override
  final IconDataConfig? placeholderIcon;

  /// Loading overlay appearance.
  @override
  final LoadingOverlayStyleConfig? loading;

  /// "Smart" badge indicator appearance.
  @override
  final SmartIndicatorStyleConfig? smartIndicator;

  /// Registered/unregistered badge appearance.
  @override
  final RegisteredBadgeStyleConfig? registeredBadge;

  @override
  String toString() {
    return 'LeadingAvatarStyleConfig(backgroundColor: $backgroundColor, radius: $radius, initialsTextStyle: $initialsTextStyle, placeholderIcon: $placeholderIcon, loading: $loading, smartIndicator: $smartIndicator, registeredBadge: $registeredBadge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeadingAvatarStyleConfigImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.initialsTextStyle, initialsTextStyle) ||
                other.initialsTextStyle == initialsTextStyle) &&
            (identical(other.placeholderIcon, placeholderIcon) ||
                other.placeholderIcon == placeholderIcon) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.smartIndicator, smartIndicator) ||
                other.smartIndicator == smartIndicator) &&
            (identical(other.registeredBadge, registeredBadge) ||
                other.registeredBadge == registeredBadge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      radius,
      initialsTextStyle,
      placeholderIcon,
      loading,
      smartIndicator,
      registeredBadge);

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeadingAvatarStyleConfigImplCopyWith<_$LeadingAvatarStyleConfigImpl>
      get copyWith => __$$LeadingAvatarStyleConfigImplCopyWithImpl<
          _$LeadingAvatarStyleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeadingAvatarStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _LeadingAvatarStyleConfig implements LeadingAvatarStyleConfig {
  const factory _LeadingAvatarStyleConfig(
          {final String? backgroundColor,
          final double? radius,
          final TextStyleConfig? initialsTextStyle,
          final IconDataConfig? placeholderIcon,
          final LoadingOverlayStyleConfig? loading,
          final SmartIndicatorStyleConfig? smartIndicator,
          final RegisteredBadgeStyleConfig? registeredBadge}) =
      _$LeadingAvatarStyleConfigImpl;

  factory _LeadingAvatarStyleConfig.fromJson(Map<String, dynamic> json) =
      _$LeadingAvatarStyleConfigImpl.fromJson;

  /// Circle background color. Defaults to theme.secondaryContainer when null.
  @override
  String? get backgroundColor;

  /// Avatar radius (defaults to 20.0 in widget if null).
  @override
  double? get radius;

  /// Text style for initials fallback.
  @override
  TextStyleConfig? get initialsTextStyle;

  /// Placeholder icon when no username/thumbnail is available.
  @override
  IconDataConfig? get placeholderIcon;

  /// Loading overlay appearance.
  @override
  LoadingOverlayStyleConfig? get loading;

  /// "Smart" badge indicator appearance.
  @override
  SmartIndicatorStyleConfig? get smartIndicator;

  /// Registered/unregistered badge appearance.
  @override
  RegisteredBadgeStyleConfig? get registeredBadge;

  /// Create a copy of LeadingAvatarStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeadingAvatarStyleConfigImplCopyWith<_$LeadingAvatarStyleConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LoadingOverlayStyleConfig _$LoadingOverlayStyleConfigFromJson(
    Map<String, dynamic> json) {
  return _LoadingOverlayStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$LoadingOverlayStyleConfig {
  /// Whether the overlay should be shown by default (widget may still override).
  bool get showByDefault => throw _privateConstructorUsedError;

  /// Padding around the loading indicator.
  PaddingConfig get padding => throw _privateConstructorUsedError;

  /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
  double? get strokeWidth => throw _privateConstructorUsedError;

  /// Serializes this LoadingOverlayStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoadingOverlayStyleConfigCopyWith<LoadingOverlayStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingOverlayStyleConfigCopyWith<$Res> {
  factory $LoadingOverlayStyleConfigCopyWith(LoadingOverlayStyleConfig value,
          $Res Function(LoadingOverlayStyleConfig) then) =
      _$LoadingOverlayStyleConfigCopyWithImpl<$Res, LoadingOverlayStyleConfig>;
  @useResult
  $Res call({bool showByDefault, PaddingConfig padding, double? strokeWidth});

  $PaddingConfigCopyWith<$Res> get padding;
}

/// @nodoc
class _$LoadingOverlayStyleConfigCopyWithImpl<$Res,
        $Val extends LoadingOverlayStyleConfig>
    implements $LoadingOverlayStyleConfigCopyWith<$Res> {
  _$LoadingOverlayStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showByDefault = null,
    Object? padding = null,
    Object? strokeWidth = freezed,
  }) {
    return _then(_value.copyWith(
      showByDefault: null == showByDefault
          ? _value.showByDefault
          : showByDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      padding: null == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as PaddingConfig,
      strokeWidth: freezed == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaddingConfigCopyWith<$Res> get padding {
    return $PaddingConfigCopyWith<$Res>(_value.padding, (value) {
      return _then(_value.copyWith(padding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingOverlayStyleConfigImplCopyWith<$Res>
    implements $LoadingOverlayStyleConfigCopyWith<$Res> {
  factory _$$LoadingOverlayStyleConfigImplCopyWith(
          _$LoadingOverlayStyleConfigImpl value,
          $Res Function(_$LoadingOverlayStyleConfigImpl) then) =
      __$$LoadingOverlayStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showByDefault, PaddingConfig padding, double? strokeWidth});

  @override
  $PaddingConfigCopyWith<$Res> get padding;
}

/// @nodoc
class __$$LoadingOverlayStyleConfigImplCopyWithImpl<$Res>
    extends _$LoadingOverlayStyleConfigCopyWithImpl<$Res,
        _$LoadingOverlayStyleConfigImpl>
    implements _$$LoadingOverlayStyleConfigImplCopyWith<$Res> {
  __$$LoadingOverlayStyleConfigImplCopyWithImpl(
      _$LoadingOverlayStyleConfigImpl _value,
      $Res Function(_$LoadingOverlayStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showByDefault = null,
    Object? padding = null,
    Object? strokeWidth = freezed,
  }) {
    return _then(_$LoadingOverlayStyleConfigImpl(
      showByDefault: null == showByDefault
          ? _value.showByDefault
          : showByDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      padding: null == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as PaddingConfig,
      strokeWidth: freezed == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadingOverlayStyleConfigImpl implements _LoadingOverlayStyleConfig {
  const _$LoadingOverlayStyleConfigImpl(
      {this.showByDefault = false,
      this.padding = PaddingConfig.default2,
      this.strokeWidth});

  factory _$LoadingOverlayStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadingOverlayStyleConfigImplFromJson(json);

  /// Whether the overlay should be shown by default (widget may still override).
  @override
  @JsonKey()
  final bool showByDefault;

  /// Padding around the loading indicator.
  @override
  @JsonKey()
  final PaddingConfig padding;

  /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
  @override
  final double? strokeWidth;

  @override
  String toString() {
    return 'LoadingOverlayStyleConfig(showByDefault: $showByDefault, padding: $padding, strokeWidth: $strokeWidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingOverlayStyleConfigImpl &&
            (identical(other.showByDefault, showByDefault) ||
                other.showByDefault == showByDefault) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showByDefault, padding, strokeWidth);

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingOverlayStyleConfigImplCopyWith<_$LoadingOverlayStyleConfigImpl>
      get copyWith => __$$LoadingOverlayStyleConfigImplCopyWithImpl<
          _$LoadingOverlayStyleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadingOverlayStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _LoadingOverlayStyleConfig implements LoadingOverlayStyleConfig {
  const factory _LoadingOverlayStyleConfig(
      {final bool showByDefault,
      final PaddingConfig padding,
      final double? strokeWidth}) = _$LoadingOverlayStyleConfigImpl;

  factory _LoadingOverlayStyleConfig.fromJson(Map<String, dynamic> json) =
      _$LoadingOverlayStyleConfigImpl.fromJson;

  /// Whether the overlay should be shown by default (widget may still override).
  @override
  bool get showByDefault;

  /// Padding around the loading indicator.
  @override
  PaddingConfig get padding;

  /// CircularProgressIndicator stroke width (defaults to 1.0 in widget).
  @override
  double? get strokeWidth;

  /// Create a copy of LoadingOverlayStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingOverlayStyleConfigImplCopyWith<_$LoadingOverlayStyleConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SmartIndicatorStyleConfig _$SmartIndicatorStyleConfigFromJson(
    Map<String, dynamic> json) {
  return _SmartIndicatorStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$SmartIndicatorStyleConfig {
  /// Background color of the smart indicator circle.
  String? get backgroundColor => throw _privateConstructorUsedError;

  /// Icon displayed inside the smart indicator.
  IconDataConfig? get icon => throw _privateConstructorUsedError;

  /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
  double? get sizeFactor => throw _privateConstructorUsedError;

  /// Serializes this SmartIndicatorStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmartIndicatorStyleConfigCopyWith<SmartIndicatorStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartIndicatorStyleConfigCopyWith<$Res> {
  factory $SmartIndicatorStyleConfigCopyWith(SmartIndicatorStyleConfig value,
          $Res Function(SmartIndicatorStyleConfig) then) =
      _$SmartIndicatorStyleConfigCopyWithImpl<$Res, SmartIndicatorStyleConfig>;
  @useResult
  $Res call(
      {String? backgroundColor, IconDataConfig? icon, double? sizeFactor});

  $IconDataConfigCopyWith<$Res>? get icon;
}

/// @nodoc
class _$SmartIndicatorStyleConfigCopyWithImpl<$Res,
        $Val extends SmartIndicatorStyleConfig>
    implements $SmartIndicatorStyleConfigCopyWith<$Res> {
  _$SmartIndicatorStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? icon = freezed,
    Object? sizeFactor = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconDataConfig?,
      sizeFactor: freezed == sizeFactor
          ? _value.sizeFactor
          : sizeFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IconDataConfigCopyWith<$Res>? get icon {
    if (_value.icon == null) {
      return null;
    }

    return $IconDataConfigCopyWith<$Res>(_value.icon!, (value) {
      return _then(_value.copyWith(icon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SmartIndicatorStyleConfigImplCopyWith<$Res>
    implements $SmartIndicatorStyleConfigCopyWith<$Res> {
  factory _$$SmartIndicatorStyleConfigImplCopyWith(
          _$SmartIndicatorStyleConfigImpl value,
          $Res Function(_$SmartIndicatorStyleConfigImpl) then) =
      __$$SmartIndicatorStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? backgroundColor, IconDataConfig? icon, double? sizeFactor});

  @override
  $IconDataConfigCopyWith<$Res>? get icon;
}

/// @nodoc
class __$$SmartIndicatorStyleConfigImplCopyWithImpl<$Res>
    extends _$SmartIndicatorStyleConfigCopyWithImpl<$Res,
        _$SmartIndicatorStyleConfigImpl>
    implements _$$SmartIndicatorStyleConfigImplCopyWith<$Res> {
  __$$SmartIndicatorStyleConfigImplCopyWithImpl(
      _$SmartIndicatorStyleConfigImpl _value,
      $Res Function(_$SmartIndicatorStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? icon = freezed,
    Object? sizeFactor = freezed,
  }) {
    return _then(_$SmartIndicatorStyleConfigImpl(
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconDataConfig?,
      sizeFactor: freezed == sizeFactor
          ? _value.sizeFactor
          : sizeFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartIndicatorStyleConfigImpl implements _SmartIndicatorStyleConfig {
  const _$SmartIndicatorStyleConfigImpl(
      {this.backgroundColor, this.icon, this.sizeFactor});

  factory _$SmartIndicatorStyleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartIndicatorStyleConfigImplFromJson(json);

  /// Background color of the smart indicator circle.
  @override
  final String? backgroundColor;

  /// Icon displayed inside the smart indicator.
  @override
  final IconDataConfig? icon;

  /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
  @override
  final double? sizeFactor;

  @override
  String toString() {
    return 'SmartIndicatorStyleConfig(backgroundColor: $backgroundColor, icon: $icon, sizeFactor: $sizeFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartIndicatorStyleConfigImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.sizeFactor, sizeFactor) ||
                other.sizeFactor == sizeFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, backgroundColor, icon, sizeFactor);

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartIndicatorStyleConfigImplCopyWith<_$SmartIndicatorStyleConfigImpl>
      get copyWith => __$$SmartIndicatorStyleConfigImplCopyWithImpl<
          _$SmartIndicatorStyleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartIndicatorStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _SmartIndicatorStyleConfig implements SmartIndicatorStyleConfig {
  const factory _SmartIndicatorStyleConfig(
      {final String? backgroundColor,
      final IconDataConfig? icon,
      final double? sizeFactor}) = _$SmartIndicatorStyleConfigImpl;

  factory _SmartIndicatorStyleConfig.fromJson(Map<String, dynamic> json) =
      _$SmartIndicatorStyleConfigImpl.fromJson;

  /// Background color of the smart indicator circle.
  @override
  String? get backgroundColor;

  /// Icon displayed inside the smart indicator.
  @override
  IconDataConfig? get icon;

  /// Size factor relative to avatar diameter (widget uses ~0.4 by default).
  @override
  double? get sizeFactor;

  /// Create a copy of SmartIndicatorStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartIndicatorStyleConfigImplCopyWith<_$SmartIndicatorStyleConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RegisteredBadgeStyleConfig _$RegisteredBadgeStyleConfigFromJson(
    Map<String, dynamic> json) {
  return _RegisteredBadgeStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$RegisteredBadgeStyleConfig {
  /// Color used when `registered == true`.
  String? get registeredColor => throw _privateConstructorUsedError;

  /// Color used when `registered == false`.
  String? get unregisteredColor => throw _privateConstructorUsedError;

  /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
  double? get sizeFactor => throw _privateConstructorUsedError;

  /// Serializes this RegisteredBadgeStyleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisteredBadgeStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisteredBadgeStyleConfigCopyWith<RegisteredBadgeStyleConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisteredBadgeStyleConfigCopyWith<$Res> {
  factory $RegisteredBadgeStyleConfigCopyWith(RegisteredBadgeStyleConfig value,
          $Res Function(RegisteredBadgeStyleConfig) then) =
      _$RegisteredBadgeStyleConfigCopyWithImpl<$Res,
          RegisteredBadgeStyleConfig>;
  @useResult
  $Res call(
      {String? registeredColor, String? unregisteredColor, double? sizeFactor});
}

/// @nodoc
class _$RegisteredBadgeStyleConfigCopyWithImpl<$Res,
        $Val extends RegisteredBadgeStyleConfig>
    implements $RegisteredBadgeStyleConfigCopyWith<$Res> {
  _$RegisteredBadgeStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisteredBadgeStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registeredColor = freezed,
    Object? unregisteredColor = freezed,
    Object? sizeFactor = freezed,
  }) {
    return _then(_value.copyWith(
      registeredColor: freezed == registeredColor
          ? _value.registeredColor
          : registeredColor // ignore: cast_nullable_to_non_nullable
              as String?,
      unregisteredColor: freezed == unregisteredColor
          ? _value.unregisteredColor
          : unregisteredColor // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeFactor: freezed == sizeFactor
          ? _value.sizeFactor
          : sizeFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisteredBadgeStyleConfigImplCopyWith<$Res>
    implements $RegisteredBadgeStyleConfigCopyWith<$Res> {
  factory _$$RegisteredBadgeStyleConfigImplCopyWith(
          _$RegisteredBadgeStyleConfigImpl value,
          $Res Function(_$RegisteredBadgeStyleConfigImpl) then) =
      __$$RegisteredBadgeStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? registeredColor, String? unregisteredColor, double? sizeFactor});
}

/// @nodoc
class __$$RegisteredBadgeStyleConfigImplCopyWithImpl<$Res>
    extends _$RegisteredBadgeStyleConfigCopyWithImpl<$Res,
        _$RegisteredBadgeStyleConfigImpl>
    implements _$$RegisteredBadgeStyleConfigImplCopyWith<$Res> {
  __$$RegisteredBadgeStyleConfigImplCopyWithImpl(
      _$RegisteredBadgeStyleConfigImpl _value,
      $Res Function(_$RegisteredBadgeStyleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisteredBadgeStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registeredColor = freezed,
    Object? unregisteredColor = freezed,
    Object? sizeFactor = freezed,
  }) {
    return _then(_$RegisteredBadgeStyleConfigImpl(
      registeredColor: freezed == registeredColor
          ? _value.registeredColor
          : registeredColor // ignore: cast_nullable_to_non_nullable
              as String?,
      unregisteredColor: freezed == unregisteredColor
          ? _value.unregisteredColor
          : unregisteredColor // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeFactor: freezed == sizeFactor
          ? _value.sizeFactor
          : sizeFactor // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisteredBadgeStyleConfigImpl implements _RegisteredBadgeStyleConfig {
  const _$RegisteredBadgeStyleConfigImpl(
      {this.registeredColor, this.unregisteredColor, this.sizeFactor});

  factory _$RegisteredBadgeStyleConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RegisteredBadgeStyleConfigImplFromJson(json);

  /// Color used when `registered == true`.
  @override
  final String? registeredColor;

  /// Color used when `registered == false`.
  @override
  final String? unregisteredColor;

  /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
  @override
  final double? sizeFactor;

  @override
  String toString() {
    return 'RegisteredBadgeStyleConfig(registeredColor: $registeredColor, unregisteredColor: $unregisteredColor, sizeFactor: $sizeFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisteredBadgeStyleConfigImpl &&
            (identical(other.registeredColor, registeredColor) ||
                other.registeredColor == registeredColor) &&
            (identical(other.unregisteredColor, unregisteredColor) ||
                other.unregisteredColor == unregisteredColor) &&
            (identical(other.sizeFactor, sizeFactor) ||
                other.sizeFactor == sizeFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, registeredColor, unregisteredColor, sizeFactor);

  /// Create a copy of RegisteredBadgeStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisteredBadgeStyleConfigImplCopyWith<_$RegisteredBadgeStyleConfigImpl>
      get copyWith => __$$RegisteredBadgeStyleConfigImplCopyWithImpl<
          _$RegisteredBadgeStyleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisteredBadgeStyleConfigImplToJson(
      this,
    );
  }
}

abstract class _RegisteredBadgeStyleConfig
    implements RegisteredBadgeStyleConfig {
  const factory _RegisteredBadgeStyleConfig(
      {final String? registeredColor,
      final String? unregisteredColor,
      final double? sizeFactor}) = _$RegisteredBadgeStyleConfigImpl;

  factory _RegisteredBadgeStyleConfig.fromJson(Map<String, dynamic> json) =
      _$RegisteredBadgeStyleConfigImpl.fromJson;

  /// Color used when `registered == true`.
  @override
  String? get registeredColor;

  /// Color used when `registered == false`.
  @override
  String? get unregisteredColor;

  /// Size factor relative to avatar diameter (widget uses ~0.2 by default).
  @override
  double? get sizeFactor;

  /// Create a copy of RegisteredBadgeStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisteredBadgeStyleConfigImplCopyWith<_$RegisteredBadgeStyleConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
