// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_widget_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeWidgetConfig {
  FontsConfig get fonts;
  ButtonWidgetConfig get button;
  GroupWidgetConfig? get group;
  BarWidgetConfig get bar;
  ImageAssetsConfig get imageAssets;
  InputWidgetConfig get input;
  TextWidgetConfig get text;
  DialogWidgetConfig get dialog;
  ActionPadWidgetConfig get actionPad;
  StatusesWidgetConfig get statuses;
  DecorationConfig get decorationConfig;

  /// Create a copy of ThemeWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThemeWidgetConfigCopyWith<ThemeWidgetConfig> get copyWith =>
      _$ThemeWidgetConfigCopyWithImpl<ThemeWidgetConfig>(
          this as ThemeWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemeWidgetConfig &&
            (identical(other.fonts, fonts) || other.fonts == fonts) &&
            (identical(other.button, button) || other.button == button) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.bar, bar) || other.bar == bar) &&
            (identical(other.imageAssets, imageAssets) ||
                other.imageAssets == imageAssets) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.dialog, dialog) || other.dialog == dialog) &&
            (identical(other.actionPad, actionPad) ||
                other.actionPad == actionPad) &&
            (identical(other.statuses, statuses) ||
                other.statuses == statuses) &&
            (identical(other.decorationConfig, decorationConfig) ||
                other.decorationConfig == decorationConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fonts, button, group, bar,
      imageAssets, input, text, dialog, actionPad, statuses, decorationConfig);

  @override
  String toString() {
    return 'ThemeWidgetConfig(fonts: $fonts, button: $button, group: $group, bar: $bar, imageAssets: $imageAssets, input: $input, text: $text, dialog: $dialog, actionPad: $actionPad, statuses: $statuses, decorationConfig: $decorationConfig)';
  }
}

/// @nodoc
abstract mixin class $ThemeWidgetConfigCopyWith<$Res> {
  factory $ThemeWidgetConfigCopyWith(
          ThemeWidgetConfig value, $Res Function(ThemeWidgetConfig) _then) =
      _$ThemeWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {FontsConfig fonts,
      ButtonWidgetConfig button,
      GroupWidgetConfig? group,
      BarWidgetConfig bar,
      ImageAssetsConfig imageAssets,
      InputWidgetConfig input,
      TextWidgetConfig text,
      DialogWidgetConfig dialog,
      ActionPadWidgetConfig actionPad,
      StatusesWidgetConfig statuses,
      DecorationConfig decorationConfig});
}

/// @nodoc
class _$ThemeWidgetConfigCopyWithImpl<$Res>
    implements $ThemeWidgetConfigCopyWith<$Res> {
  _$ThemeWidgetConfigCopyWithImpl(this._self, this._then);

  final ThemeWidgetConfig _self;
  final $Res Function(ThemeWidgetConfig) _then;

  /// Create a copy of ThemeWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fonts = null,
    Object? button = null,
    Object? group = freezed,
    Object? bar = null,
    Object? imageAssets = null,
    Object? input = null,
    Object? text = null,
    Object? dialog = null,
    Object? actionPad = null,
    Object? statuses = null,
    Object? decorationConfig = null,
  }) {
    return _then(ThemeWidgetConfig(
      fonts: null == fonts
          ? _self.fonts
          : fonts // ignore: cast_nullable_to_non_nullable
              as FontsConfig,
      button: null == button
          ? _self.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonWidgetConfig,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupWidgetConfig?,
      bar: null == bar
          ? _self.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as BarWidgetConfig,
      imageAssets: null == imageAssets
          ? _self.imageAssets
          : imageAssets // ignore: cast_nullable_to_non_nullable
              as ImageAssetsConfig,
      input: null == input
          ? _self.input
          : input // ignore: cast_nullable_to_non_nullable
              as InputWidgetConfig,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as TextWidgetConfig,
      dialog: null == dialog
          ? _self.dialog
          : dialog // ignore: cast_nullable_to_non_nullable
              as DialogWidgetConfig,
      actionPad: null == actionPad
          ? _self.actionPad
          : actionPad // ignore: cast_nullable_to_non_nullable
              as ActionPadWidgetConfig,
      statuses: null == statuses
          ? _self.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as StatusesWidgetConfig,
      decorationConfig: null == decorationConfig
          ? _self.decorationConfig
          : decorationConfig // ignore: cast_nullable_to_non_nullable
              as DecorationConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThemeWidgetConfig].
extension ThemeWidgetConfigPatterns on ThemeWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$FontsConfig {
  String? get fontFamily;

  /// Create a copy of FontsConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FontsConfigCopyWith<FontsConfig> get copyWith =>
      _$FontsConfigCopyWithImpl<FontsConfig>(this as FontsConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FontsConfig &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fontFamily);

  @override
  String toString() {
    return 'FontsConfig(fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class $FontsConfigCopyWith<$Res> {
  factory $FontsConfigCopyWith(
          FontsConfig value, $Res Function(FontsConfig) _then) =
      _$FontsConfigCopyWithImpl;
  @useResult
  $Res call({String? fontFamily});
}

/// @nodoc
class _$FontsConfigCopyWithImpl<$Res> implements $FontsConfigCopyWith<$Res> {
  _$FontsConfigCopyWithImpl(this._self, this._then);

  final FontsConfig _self;
  final $Res Function(FontsConfig) _then;

  /// Create a copy of FontsConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontFamily = freezed,
  }) {
    return _then(FontsConfig(
      fontFamily: freezed == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FontsConfig].
extension FontsConfigPatterns on FontsConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ButtonWidgetConfig {
  ElevatedButtonWidgetConfig get primaryElevatedButton;

  /// Create a copy of ButtonWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonWidgetConfigCopyWith<ButtonWidgetConfig> get copyWith =>
      _$ButtonWidgetConfigCopyWithImpl<ButtonWidgetConfig>(
          this as ButtonWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonWidgetConfig &&
            (identical(other.primaryElevatedButton, primaryElevatedButton) ||
                other.primaryElevatedButton == primaryElevatedButton));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, primaryElevatedButton);

  @override
  String toString() {
    return 'ButtonWidgetConfig(primaryElevatedButton: $primaryElevatedButton)';
  }
}

/// @nodoc
abstract mixin class $ButtonWidgetConfigCopyWith<$Res> {
  factory $ButtonWidgetConfigCopyWith(
          ButtonWidgetConfig value, $Res Function(ButtonWidgetConfig) _then) =
      _$ButtonWidgetConfigCopyWithImpl;
  @useResult
  $Res call({ElevatedButtonWidgetConfig primaryElevatedButton});
}

/// @nodoc
class _$ButtonWidgetConfigCopyWithImpl<$Res>
    implements $ButtonWidgetConfigCopyWith<$Res> {
  _$ButtonWidgetConfigCopyWithImpl(this._self, this._then);

  final ButtonWidgetConfig _self;
  final $Res Function(ButtonWidgetConfig) _then;

  /// Create a copy of ButtonWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryElevatedButton = null,
  }) {
    return _then(ButtonWidgetConfig(
      primaryElevatedButton: null == primaryElevatedButton
          ? _self.primaryElevatedButton
          : primaryElevatedButton // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ButtonWidgetConfig].
extension ButtonWidgetConfigPatterns on ButtonWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ElevatedButtonWidgetConfig {
  String? get backgroundColor;
  String? get foregroundColor;
  String? get textColor;
  String? get iconColor;
  String? get disabledIconColor;
  String? get disabledBackgroundColor;
  String? get disabledForegroundColor;

  /// Create a copy of ElevatedButtonWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ElevatedButtonWidgetConfigCopyWith<ElevatedButtonWidgetConfig>
      get copyWith =>
          _$ElevatedButtonWidgetConfigCopyWithImpl<ElevatedButtonWidgetConfig>(
              this as ElevatedButtonWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ElevatedButtonWidgetConfig &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.foregroundColor, foregroundColor) ||
                other.foregroundColor == foregroundColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.iconColor, iconColor) ||
                other.iconColor == iconColor) &&
            (identical(other.disabledIconColor, disabledIconColor) ||
                other.disabledIconColor == disabledIconColor) &&
            (identical(
                    other.disabledBackgroundColor, disabledBackgroundColor) ||
                other.disabledBackgroundColor == disabledBackgroundColor) &&
            (identical(
                    other.disabledForegroundColor, disabledForegroundColor) ||
                other.disabledForegroundColor == disabledForegroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      foregroundColor,
      textColor,
      iconColor,
      disabledIconColor,
      disabledBackgroundColor,
      disabledForegroundColor);

  @override
  String toString() {
    return 'ElevatedButtonWidgetConfig(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, textColor: $textColor, iconColor: $iconColor, disabledIconColor: $disabledIconColor, disabledBackgroundColor: $disabledBackgroundColor, disabledForegroundColor: $disabledForegroundColor)';
  }
}

/// @nodoc
abstract mixin class $ElevatedButtonWidgetConfigCopyWith<$Res> {
  factory $ElevatedButtonWidgetConfigCopyWith(ElevatedButtonWidgetConfig value,
          $Res Function(ElevatedButtonWidgetConfig) _then) =
      _$ElevatedButtonWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? backgroundColor,
      String? foregroundColor,
      String? textColor,
      String? iconColor,
      String? disabledIconColor,
      String? disabledBackgroundColor,
      String? disabledForegroundColor});
}

/// @nodoc
class _$ElevatedButtonWidgetConfigCopyWithImpl<$Res>
    implements $ElevatedButtonWidgetConfigCopyWith<$Res> {
  _$ElevatedButtonWidgetConfigCopyWithImpl(this._self, this._then);

  final ElevatedButtonWidgetConfig _self;
  final $Res Function(ElevatedButtonWidgetConfig) _then;

  /// Create a copy of ElevatedButtonWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? foregroundColor = freezed,
    Object? textColor = freezed,
    Object? iconColor = freezed,
    Object? disabledIconColor = freezed,
    Object? disabledBackgroundColor = freezed,
    Object? disabledForegroundColor = freezed,
  }) {
    return _then(ElevatedButtonWidgetConfig(
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      foregroundColor: freezed == foregroundColor
          ? _self.foregroundColor
          : foregroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      textColor: freezed == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String?,
      iconColor: freezed == iconColor
          ? _self.iconColor
          : iconColor // ignore: cast_nullable_to_non_nullable
              as String?,
      disabledIconColor: freezed == disabledIconColor
          ? _self.disabledIconColor
          : disabledIconColor // ignore: cast_nullable_to_non_nullable
              as String?,
      disabledBackgroundColor: freezed == disabledBackgroundColor
          ? _self.disabledBackgroundColor
          : disabledBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      disabledForegroundColor: freezed == disabledForegroundColor
          ? _self.disabledForegroundColor
          : disabledForegroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ElevatedButtonWidgetConfig].
extension ElevatedButtonWidgetConfigPatterns on ElevatedButtonWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$GroupWidgetConfig {
  GroupTitleListTileWidgetConfig get groupTitleListTile;
  CallActionsWidgetConfig get callActions;

  /// Create a copy of GroupWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupWidgetConfigCopyWith<GroupWidgetConfig> get copyWith =>
      _$GroupWidgetConfigCopyWithImpl<GroupWidgetConfig>(
          this as GroupWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupWidgetConfig &&
            (identical(other.groupTitleListTile, groupTitleListTile) ||
                other.groupTitleListTile == groupTitleListTile) &&
            (identical(other.callActions, callActions) ||
                other.callActions == callActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, groupTitleListTile, callActions);

  @override
  String toString() {
    return 'GroupWidgetConfig(groupTitleListTile: $groupTitleListTile, callActions: $callActions)';
  }
}

/// @nodoc
abstract mixin class $GroupWidgetConfigCopyWith<$Res> {
  factory $GroupWidgetConfigCopyWith(
          GroupWidgetConfig value, $Res Function(GroupWidgetConfig) _then) =
      _$GroupWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {GroupTitleListTileWidgetConfig groupTitleListTile,
      CallActionsWidgetConfig callActions});
}

/// @nodoc
class _$GroupWidgetConfigCopyWithImpl<$Res>
    implements $GroupWidgetConfigCopyWith<$Res> {
  _$GroupWidgetConfigCopyWithImpl(this._self, this._then);

  final GroupWidgetConfig _self;
  final $Res Function(GroupWidgetConfig) _then;

  /// Create a copy of GroupWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupTitleListTile = null,
    Object? callActions = null,
  }) {
    return _then(GroupWidgetConfig(
      groupTitleListTile: null == groupTitleListTile
          ? _self.groupTitleListTile
          : groupTitleListTile // ignore: cast_nullable_to_non_nullable
              as GroupTitleListTileWidgetConfig,
      callActions: null == callActions
          ? _self.callActions
          : callActions // ignore: cast_nullable_to_non_nullable
              as CallActionsWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [GroupWidgetConfig].
extension GroupWidgetConfigPatterns on GroupWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$BarWidgetConfig {
  BottomNavigationBarWidgetConfig get bottomNavigationBar;
  ExtTabBarWidgetConfig get extTabBar;

  /// Create a copy of BarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BarWidgetConfigCopyWith<BarWidgetConfig> get copyWith =>
      _$BarWidgetConfigCopyWithImpl<BarWidgetConfig>(
          this as BarWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BarWidgetConfig &&
            (identical(other.bottomNavigationBar, bottomNavigationBar) ||
                other.bottomNavigationBar == bottomNavigationBar) &&
            (identical(other.extTabBar, extTabBar) ||
                other.extTabBar == extTabBar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bottomNavigationBar, extTabBar);

  @override
  String toString() {
    return 'BarWidgetConfig(bottomNavigationBar: $bottomNavigationBar, extTabBar: $extTabBar)';
  }
}

/// @nodoc
abstract mixin class $BarWidgetConfigCopyWith<$Res> {
  factory $BarWidgetConfigCopyWith(
          BarWidgetConfig value, $Res Function(BarWidgetConfig) _then) =
      _$BarWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {BottomNavigationBarWidgetConfig bottomNavigationBar,
      ExtTabBarWidgetConfig extTabBar});
}

/// @nodoc
class _$BarWidgetConfigCopyWithImpl<$Res>
    implements $BarWidgetConfigCopyWith<$Res> {
  _$BarWidgetConfigCopyWithImpl(this._self, this._then);

  final BarWidgetConfig _self;
  final $Res Function(BarWidgetConfig) _then;

  /// Create a copy of BarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomNavigationBar = null,
    Object? extTabBar = null,
  }) {
    return _then(BarWidgetConfig(
      bottomNavigationBar: null == bottomNavigationBar
          ? _self.bottomNavigationBar
          : bottomNavigationBar // ignore: cast_nullable_to_non_nullable
              as BottomNavigationBarWidgetConfig,
      extTabBar: null == extTabBar
          ? _self.extTabBar
          : extTabBar // ignore: cast_nullable_to_non_nullable
              as ExtTabBarWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [BarWidgetConfig].
extension BarWidgetConfigPatterns on BarWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$BottomNavigationBarWidgetConfig {
  String? get backgroundColor;
  String? get selectedItemColor;
  String? get unSelectedItemColor;

  /// Create a copy of BottomNavigationBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BottomNavigationBarWidgetConfigCopyWith<BottomNavigationBarWidgetConfig>
      get copyWith => _$BottomNavigationBarWidgetConfigCopyWithImpl<
              BottomNavigationBarWidgetConfig>(
          this as BottomNavigationBarWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BottomNavigationBarWidgetConfig &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.selectedItemColor, selectedItemColor) ||
                other.selectedItemColor == selectedItemColor) &&
            (identical(other.unSelectedItemColor, unSelectedItemColor) ||
                other.unSelectedItemColor == unSelectedItemColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, backgroundColor, selectedItemColor, unSelectedItemColor);

  @override
  String toString() {
    return 'BottomNavigationBarWidgetConfig(backgroundColor: $backgroundColor, selectedItemColor: $selectedItemColor, unSelectedItemColor: $unSelectedItemColor)';
  }
}

/// @nodoc
abstract mixin class $BottomNavigationBarWidgetConfigCopyWith<$Res> {
  factory $BottomNavigationBarWidgetConfigCopyWith(
          BottomNavigationBarWidgetConfig value,
          $Res Function(BottomNavigationBarWidgetConfig) _then) =
      _$BottomNavigationBarWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? backgroundColor,
      String? selectedItemColor,
      String? unSelectedItemColor});
}

/// @nodoc
class _$BottomNavigationBarWidgetConfigCopyWithImpl<$Res>
    implements $BottomNavigationBarWidgetConfigCopyWith<$Res> {
  _$BottomNavigationBarWidgetConfigCopyWithImpl(this._self, this._then);

  final BottomNavigationBarWidgetConfig _self;
  final $Res Function(BottomNavigationBarWidgetConfig) _then;

  /// Create a copy of BottomNavigationBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? selectedItemColor = freezed,
    Object? unSelectedItemColor = freezed,
  }) {
    return _then(BottomNavigationBarWidgetConfig(
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedItemColor: freezed == selectedItemColor
          ? _self.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      unSelectedItemColor: freezed == unSelectedItemColor
          ? _self.unSelectedItemColor
          : unSelectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BottomNavigationBarWidgetConfig].
extension BottomNavigationBarWidgetConfigPatterns
    on BottomNavigationBarWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ExtTabBarWidgetConfig {
  String? get foregroundColor;
  String? get backgroundColor;
  String? get selectedItemColor;
  String? get unSelectedItemColor;

  /// Create a copy of ExtTabBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtTabBarWidgetConfigCopyWith<ExtTabBarWidgetConfig> get copyWith =>
      _$ExtTabBarWidgetConfigCopyWithImpl<ExtTabBarWidgetConfig>(
          this as ExtTabBarWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtTabBarWidgetConfig &&
            (identical(other.foregroundColor, foregroundColor) ||
                other.foregroundColor == foregroundColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.selectedItemColor, selectedItemColor) ||
                other.selectedItemColor == selectedItemColor) &&
            (identical(other.unSelectedItemColor, unSelectedItemColor) ||
                other.unSelectedItemColor == unSelectedItemColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, foregroundColor, backgroundColor,
      selectedItemColor, unSelectedItemColor);

  @override
  String toString() {
    return 'ExtTabBarWidgetConfig(foregroundColor: $foregroundColor, backgroundColor: $backgroundColor, selectedItemColor: $selectedItemColor, unSelectedItemColor: $unSelectedItemColor)';
  }
}

/// @nodoc
abstract mixin class $ExtTabBarWidgetConfigCopyWith<$Res> {
  factory $ExtTabBarWidgetConfigCopyWith(ExtTabBarWidgetConfig value,
          $Res Function(ExtTabBarWidgetConfig) _then) =
      _$ExtTabBarWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? foregroundColor,
      String? backgroundColor,
      String? selectedItemColor,
      String? unSelectedItemColor});
}

/// @nodoc
class _$ExtTabBarWidgetConfigCopyWithImpl<$Res>
    implements $ExtTabBarWidgetConfigCopyWith<$Res> {
  _$ExtTabBarWidgetConfigCopyWithImpl(this._self, this._then);

  final ExtTabBarWidgetConfig _self;
  final $Res Function(ExtTabBarWidgetConfig) _then;

  /// Create a copy of ExtTabBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foregroundColor = freezed,
    Object? backgroundColor = freezed,
    Object? selectedItemColor = freezed,
    Object? unSelectedItemColor = freezed,
  }) {
    return _then(ExtTabBarWidgetConfig(
      foregroundColor: freezed == foregroundColor
          ? _self.foregroundColor
          : foregroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedItemColor: freezed == selectedItemColor
          ? _self.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      unSelectedItemColor: freezed == unSelectedItemColor
          ? _self.unSelectedItemColor
          : unSelectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExtTabBarWidgetConfig].
extension ExtTabBarWidgetConfigPatterns on ExtTabBarWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$GroupTitleListTileWidgetConfig {
  String? get backgroundColor;
  String? get textColor;

  /// Create a copy of GroupTitleListTileWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupTitleListTileWidgetConfigCopyWith<GroupTitleListTileWidgetConfig>
      get copyWith => _$GroupTitleListTileWidgetConfigCopyWithImpl<
              GroupTitleListTileWidgetConfig>(
          this as GroupTitleListTileWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupTitleListTileWidgetConfig &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, backgroundColor, textColor);

  @override
  String toString() {
    return 'GroupTitleListTileWidgetConfig(backgroundColor: $backgroundColor, textColor: $textColor)';
  }
}

/// @nodoc
abstract mixin class $GroupTitleListTileWidgetConfigCopyWith<$Res> {
  factory $GroupTitleListTileWidgetConfigCopyWith(
          GroupTitleListTileWidgetConfig value,
          $Res Function(GroupTitleListTileWidgetConfig) _then) =
      _$GroupTitleListTileWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String? backgroundColor, String? textColor});
}

/// @nodoc
class _$GroupTitleListTileWidgetConfigCopyWithImpl<$Res>
    implements $GroupTitleListTileWidgetConfigCopyWith<$Res> {
  _$GroupTitleListTileWidgetConfigCopyWithImpl(this._self, this._then);

  final GroupTitleListTileWidgetConfig _self;
  final $Res Function(GroupTitleListTileWidgetConfig) _then;

  /// Create a copy of GroupTitleListTileWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? textColor = freezed,
  }) {
    return _then(GroupTitleListTileWidgetConfig(
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      textColor: freezed == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [GroupTitleListTileWidgetConfig].
extension GroupTitleListTileWidgetConfigPatterns
    on GroupTitleListTileWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$CallActionsWidgetConfig {
  String? get callStartBackgroundColor;
  String? get hangupBackgroundColor;
  String? get transferBackgroundColor;
  String? get cameraBackgroundColor;
  String? get cameraActiveBackgroundColor;
  String? get mutedBackgroundColor;
  String? get mutedActiveBackgroundColor;
  String? get speakerBackgroundColor;
  String? get speakerActiveBackgroundColor;
  String? get heldBackgroundColor;
  String? get heldActiveBackgroundColor;
  String? get swapBackgroundColor;
  String? get keyBackgroundColor;
  String? get keypadBackgroundColor;
  String? get keypadActiveBackgroundColor;

  /// Create a copy of CallActionsWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallActionsWidgetConfigCopyWith<CallActionsWidgetConfig> get copyWith =>
      _$CallActionsWidgetConfigCopyWithImpl<CallActionsWidgetConfig>(
          this as CallActionsWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallActionsWidgetConfig &&
            (identical(other.callStartBackgroundColor, callStartBackgroundColor) ||
                other.callStartBackgroundColor == callStartBackgroundColor) &&
            (identical(other.hangupBackgroundColor, hangupBackgroundColor) ||
                other.hangupBackgroundColor == hangupBackgroundColor) &&
            (identical(other.transferBackgroundColor, transferBackgroundColor) ||
                other.transferBackgroundColor == transferBackgroundColor) &&
            (identical(other.cameraBackgroundColor, cameraBackgroundColor) ||
                other.cameraBackgroundColor == cameraBackgroundColor) &&
            (identical(other.cameraActiveBackgroundColor, cameraActiveBackgroundColor) ||
                other.cameraActiveBackgroundColor ==
                    cameraActiveBackgroundColor) &&
            (identical(other.mutedBackgroundColor, mutedBackgroundColor) ||
                other.mutedBackgroundColor == mutedBackgroundColor) &&
            (identical(other.mutedActiveBackgroundColor, mutedActiveBackgroundColor) ||
                other.mutedActiveBackgroundColor ==
                    mutedActiveBackgroundColor) &&
            (identical(other.speakerBackgroundColor, speakerBackgroundColor) ||
                other.speakerBackgroundColor == speakerBackgroundColor) &&
            (identical(other.speakerActiveBackgroundColor,
                    speakerActiveBackgroundColor) ||
                other.speakerActiveBackgroundColor ==
                    speakerActiveBackgroundColor) &&
            (identical(other.heldBackgroundColor, heldBackgroundColor) ||
                other.heldBackgroundColor == heldBackgroundColor) &&
            (identical(other.heldActiveBackgroundColor, heldActiveBackgroundColor) ||
                other.heldActiveBackgroundColor == heldActiveBackgroundColor) &&
            (identical(other.swapBackgroundColor, swapBackgroundColor) ||
                other.swapBackgroundColor == swapBackgroundColor) &&
            (identical(other.keyBackgroundColor, keyBackgroundColor) ||
                other.keyBackgroundColor == keyBackgroundColor) &&
            (identical(other.keypadBackgroundColor, keypadBackgroundColor) ||
                other.keypadBackgroundColor == keypadBackgroundColor) &&
            (identical(other.keypadActiveBackgroundColor, keypadActiveBackgroundColor) ||
                other.keypadActiveBackgroundColor ==
                    keypadActiveBackgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      callStartBackgroundColor,
      hangupBackgroundColor,
      transferBackgroundColor,
      cameraBackgroundColor,
      cameraActiveBackgroundColor,
      mutedBackgroundColor,
      mutedActiveBackgroundColor,
      speakerBackgroundColor,
      speakerActiveBackgroundColor,
      heldBackgroundColor,
      heldActiveBackgroundColor,
      swapBackgroundColor,
      keyBackgroundColor,
      keypadBackgroundColor,
      keypadActiveBackgroundColor);

  @override
  String toString() {
    return 'CallActionsWidgetConfig(callStartBackgroundColor: $callStartBackgroundColor, hangupBackgroundColor: $hangupBackgroundColor, transferBackgroundColor: $transferBackgroundColor, cameraBackgroundColor: $cameraBackgroundColor, cameraActiveBackgroundColor: $cameraActiveBackgroundColor, mutedBackgroundColor: $mutedBackgroundColor, mutedActiveBackgroundColor: $mutedActiveBackgroundColor, speakerBackgroundColor: $speakerBackgroundColor, speakerActiveBackgroundColor: $speakerActiveBackgroundColor, heldBackgroundColor: $heldBackgroundColor, heldActiveBackgroundColor: $heldActiveBackgroundColor, swapBackgroundColor: $swapBackgroundColor, keyBackgroundColor: $keyBackgroundColor, keypadBackgroundColor: $keypadBackgroundColor, keypadActiveBackgroundColor: $keypadActiveBackgroundColor)';
  }
}

/// @nodoc
abstract mixin class $CallActionsWidgetConfigCopyWith<$Res> {
  factory $CallActionsWidgetConfigCopyWith(CallActionsWidgetConfig value,
          $Res Function(CallActionsWidgetConfig) _then) =
      _$CallActionsWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? callStartBackgroundColor,
      String? hangupBackgroundColor,
      String? transferBackgroundColor,
      String? cameraBackgroundColor,
      String? cameraActiveBackgroundColor,
      String? mutedBackgroundColor,
      String? mutedActiveBackgroundColor,
      String? speakerBackgroundColor,
      String? speakerActiveBackgroundColor,
      String? heldBackgroundColor,
      String? heldActiveBackgroundColor,
      String? swapBackgroundColor,
      String? keyBackgroundColor,
      String? keypadBackgroundColor,
      String? keypadActiveBackgroundColor});
}

/// @nodoc
class _$CallActionsWidgetConfigCopyWithImpl<$Res>
    implements $CallActionsWidgetConfigCopyWith<$Res> {
  _$CallActionsWidgetConfigCopyWithImpl(this._self, this._then);

  final CallActionsWidgetConfig _self;
  final $Res Function(CallActionsWidgetConfig) _then;

  /// Create a copy of CallActionsWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callStartBackgroundColor = freezed,
    Object? hangupBackgroundColor = freezed,
    Object? transferBackgroundColor = freezed,
    Object? cameraBackgroundColor = freezed,
    Object? cameraActiveBackgroundColor = freezed,
    Object? mutedBackgroundColor = freezed,
    Object? mutedActiveBackgroundColor = freezed,
    Object? speakerBackgroundColor = freezed,
    Object? speakerActiveBackgroundColor = freezed,
    Object? heldBackgroundColor = freezed,
    Object? heldActiveBackgroundColor = freezed,
    Object? swapBackgroundColor = freezed,
    Object? keyBackgroundColor = freezed,
    Object? keypadBackgroundColor = freezed,
    Object? keypadActiveBackgroundColor = freezed,
  }) {
    return _then(CallActionsWidgetConfig(
      callStartBackgroundColor: freezed == callStartBackgroundColor
          ? _self.callStartBackgroundColor
          : callStartBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      hangupBackgroundColor: freezed == hangupBackgroundColor
          ? _self.hangupBackgroundColor
          : hangupBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      transferBackgroundColor: freezed == transferBackgroundColor
          ? _self.transferBackgroundColor
          : transferBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      cameraBackgroundColor: freezed == cameraBackgroundColor
          ? _self.cameraBackgroundColor
          : cameraBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      cameraActiveBackgroundColor: freezed == cameraActiveBackgroundColor
          ? _self.cameraActiveBackgroundColor
          : cameraActiveBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      mutedBackgroundColor: freezed == mutedBackgroundColor
          ? _self.mutedBackgroundColor
          : mutedBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      mutedActiveBackgroundColor: freezed == mutedActiveBackgroundColor
          ? _self.mutedActiveBackgroundColor
          : mutedActiveBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerBackgroundColor: freezed == speakerBackgroundColor
          ? _self.speakerBackgroundColor
          : speakerBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      speakerActiveBackgroundColor: freezed == speakerActiveBackgroundColor
          ? _self.speakerActiveBackgroundColor
          : speakerActiveBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      heldBackgroundColor: freezed == heldBackgroundColor
          ? _self.heldBackgroundColor
          : heldBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      heldActiveBackgroundColor: freezed == heldActiveBackgroundColor
          ? _self.heldActiveBackgroundColor
          : heldActiveBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      swapBackgroundColor: freezed == swapBackgroundColor
          ? _self.swapBackgroundColor
          : swapBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      keyBackgroundColor: freezed == keyBackgroundColor
          ? _self.keyBackgroundColor
          : keyBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      keypadBackgroundColor: freezed == keypadBackgroundColor
          ? _self.keypadBackgroundColor
          : keypadBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      keypadActiveBackgroundColor: freezed == keypadActiveBackgroundColor
          ? _self.keypadActiveBackgroundColor
          : keypadActiveBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallActionsWidgetConfig].
extension CallActionsWidgetConfigPatterns on CallActionsWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ImageAssetsConfig {
  ImageSource? get defaultPlaceholderImage;
  AppIconWidgetConfig get appIcon;
  LeadingAvatarStyleConfig get leadingAvatarStyle;

  /// Create a copy of ImageAssetsConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageAssetsConfigCopyWith<ImageAssetsConfig> get copyWith =>
      _$ImageAssetsConfigCopyWithImpl<ImageAssetsConfig>(
          this as ImageAssetsConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageAssetsConfig &&
            (identical(
                    other.defaultPlaceholderImage, defaultPlaceholderImage) ||
                other.defaultPlaceholderImage == defaultPlaceholderImage) &&
            (identical(other.appIcon, appIcon) || other.appIcon == appIcon) &&
            (identical(other.leadingAvatarStyle, leadingAvatarStyle) ||
                other.leadingAvatarStyle == leadingAvatarStyle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, defaultPlaceholderImage, appIcon, leadingAvatarStyle);

  @override
  String toString() {
    return 'ImageAssetsConfig(defaultPlaceholderImage: $defaultPlaceholderImage, appIcon: $appIcon, leadingAvatarStyle: $leadingAvatarStyle)';
  }
}

/// @nodoc
abstract mixin class $ImageAssetsConfigCopyWith<$Res> {
  factory $ImageAssetsConfigCopyWith(
          ImageAssetsConfig value, $Res Function(ImageAssetsConfig) _then) =
      _$ImageAssetsConfigCopyWithImpl;
  @useResult
  $Res call(
      {ImageSource? defaultPlaceholderImage,
      AppIconWidgetConfig appIcon,
      LeadingAvatarStyleConfig leadingAvatarStyle});
}

/// @nodoc
class _$ImageAssetsConfigCopyWithImpl<$Res>
    implements $ImageAssetsConfigCopyWith<$Res> {
  _$ImageAssetsConfigCopyWithImpl(this._self, this._then);

  final ImageAssetsConfig _self;
  final $Res Function(ImageAssetsConfig) _then;

  /// Create a copy of ImageAssetsConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultPlaceholderImage = freezed,
    Object? appIcon = null,
    Object? leadingAvatarStyle = null,
  }) {
    return _then(ImageAssetsConfig(
      defaultPlaceholderImage: freezed == defaultPlaceholderImage
          ? _self.defaultPlaceholderImage
          : defaultPlaceholderImage // ignore: cast_nullable_to_non_nullable
              as ImageSource?,
      appIcon: null == appIcon
          ? _self.appIcon
          : appIcon // ignore: cast_nullable_to_non_nullable
              as AppIconWidgetConfig,
      leadingAvatarStyle: null == leadingAvatarStyle
          ? _self.leadingAvatarStyle
          : leadingAvatarStyle // ignore: cast_nullable_to_non_nullable
              as LeadingAvatarStyleConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImageAssetsConfig].
extension ImageAssetsConfigPatterns on ImageAssetsConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ImageAssetConfig {
  ImageSource? get imageSource;
  double get widthFactor;
  String get labelColor;
  Metadata get metadata;
  String? get uri;

  /// Create a copy of ImageAssetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageAssetConfigCopyWith<ImageAssetConfig> get copyWith =>
      _$ImageAssetConfigCopyWithImpl<ImageAssetConfig>(
          this as ImageAssetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageAssetConfig &&
            (identical(other.imageSource, imageSource) ||
                other.imageSource == imageSource) &&
            (identical(other.widthFactor, widthFactor) ||
                other.widthFactor == widthFactor) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, imageSource, widthFactor, labelColor, metadata, uri);

  @override
  String toString() {
    return 'ImageAssetConfig(imageSource: $imageSource, widthFactor: $widthFactor, labelColor: $labelColor, metadata: $metadata, uri: $uri)';
  }
}

/// @nodoc
abstract mixin class $ImageAssetConfigCopyWith<$Res> {
  factory $ImageAssetConfigCopyWith(
          ImageAssetConfig value, $Res Function(ImageAssetConfig) _then) =
      _$ImageAssetConfigCopyWithImpl;
  @useResult
  $Res call(
      {ImageSource? imageSource,
      double widthFactor,
      String labelColor,
      Metadata metadata,
      @Deprecated('Use source.uri instead') String? uri});
}

/// @nodoc
class _$ImageAssetConfigCopyWithImpl<$Res>
    implements $ImageAssetConfigCopyWith<$Res> {
  _$ImageAssetConfigCopyWithImpl(this._self, this._then);

  final ImageAssetConfig _self;
  final $Res Function(ImageAssetConfig) _then;

  /// Create a copy of ImageAssetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageSource = freezed,
    Object? widthFactor = null,
    Object? labelColor = null,
    Object? metadata = null,
    Object? uri = freezed,
  }) {
    return _then(ImageAssetConfig(
      imageSource: freezed == imageSource
          ? _self.imageSource
          : imageSource // ignore: cast_nullable_to_non_nullable
              as ImageSource?,
      widthFactor: null == widthFactor
          ? _self.widthFactor
          : widthFactor // ignore: cast_nullable_to_non_nullable
              as double,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
      uri: freezed == uri
          ? _self.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImageAssetConfig].
extension ImageAssetConfigPatterns on ImageAssetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$AppIconWidgetConfig {
  String? get color;

  /// Create a copy of AppIconWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppIconWidgetConfigCopyWith<AppIconWidgetConfig> get copyWith =>
      _$AppIconWidgetConfigCopyWithImpl<AppIconWidgetConfig>(
          this as AppIconWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppIconWidgetConfig &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color);

  @override
  String toString() {
    return 'AppIconWidgetConfig(color: $color)';
  }
}

/// @nodoc
abstract mixin class $AppIconWidgetConfigCopyWith<$Res> {
  factory $AppIconWidgetConfigCopyWith(
          AppIconWidgetConfig value, $Res Function(AppIconWidgetConfig) _then) =
      _$AppIconWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String? color});
}

/// @nodoc
class _$AppIconWidgetConfigCopyWithImpl<$Res>
    implements $AppIconWidgetConfigCopyWith<$Res> {
  _$AppIconWidgetConfigCopyWithImpl(this._self, this._then);

  final AppIconWidgetConfig _self;
  final $Res Function(AppIconWidgetConfig) _then;

  /// Create a copy of AppIconWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
  }) {
    return _then(AppIconWidgetConfig(
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppIconWidgetConfig].
extension AppIconWidgetConfigPatterns on AppIconWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$InputWidgetConfig {
  TextFormFieldWidgetConfig get primary;

  /// Create a copy of InputWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InputWidgetConfigCopyWith<InputWidgetConfig> get copyWith =>
      _$InputWidgetConfigCopyWithImpl<InputWidgetConfig>(
          this as InputWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InputWidgetConfig &&
            (identical(other.primary, primary) || other.primary == primary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, primary);

  @override
  String toString() {
    return 'InputWidgetConfig(primary: $primary)';
  }
}

/// @nodoc
abstract mixin class $InputWidgetConfigCopyWith<$Res> {
  factory $InputWidgetConfigCopyWith(
          InputWidgetConfig value, $Res Function(InputWidgetConfig) _then) =
      _$InputWidgetConfigCopyWithImpl;
  @useResult
  $Res call({TextFormFieldWidgetConfig primary});
}

/// @nodoc
class _$InputWidgetConfigCopyWithImpl<$Res>
    implements $InputWidgetConfigCopyWith<$Res> {
  _$InputWidgetConfigCopyWithImpl(this._self, this._then);

  final InputWidgetConfig _self;
  final $Res Function(InputWidgetConfig) _then;

  /// Create a copy of InputWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
  }) {
    return _then(InputWidgetConfig(
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as TextFormFieldWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [InputWidgetConfig].
extension InputWidgetConfigPatterns on InputWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$TextFormFieldWidgetConfig {
  String? get labelColor;
  InputBorderWidgetConfig get border;

  /// Create a copy of TextFormFieldWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextFormFieldWidgetConfigCopyWith<TextFormFieldWidgetConfig> get copyWith =>
      _$TextFormFieldWidgetConfigCopyWithImpl<TextFormFieldWidgetConfig>(
          this as TextFormFieldWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextFormFieldWidgetConfig &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.border, border) || other.border == border));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, labelColor, border);

  @override
  String toString() {
    return 'TextFormFieldWidgetConfig(labelColor: $labelColor, border: $border)';
  }
}

/// @nodoc
abstract mixin class $TextFormFieldWidgetConfigCopyWith<$Res> {
  factory $TextFormFieldWidgetConfigCopyWith(TextFormFieldWidgetConfig value,
          $Res Function(TextFormFieldWidgetConfig) _then) =
      _$TextFormFieldWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String? labelColor, InputBorderWidgetConfig border});
}

/// @nodoc
class _$TextFormFieldWidgetConfigCopyWithImpl<$Res>
    implements $TextFormFieldWidgetConfigCopyWith<$Res> {
  _$TextFormFieldWidgetConfigCopyWithImpl(this._self, this._then);

  final TextFormFieldWidgetConfig _self;
  final $Res Function(TextFormFieldWidgetConfig) _then;

  /// Create a copy of TextFormFieldWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labelColor = freezed,
    Object? border = null,
  }) {
    return _then(TextFormFieldWidgetConfig(
      labelColor: freezed == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String?,
      border: null == border
          ? _self.border
          : border // ignore: cast_nullable_to_non_nullable
              as InputBorderWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [TextFormFieldWidgetConfig].
extension TextFormFieldWidgetConfigPatterns on TextFormFieldWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$InputBorderWidgetConfig {
  BorderWidgetConfig get disabled;
  BorderWidgetConfig get focused;
  BorderWidgetConfig get any;

  /// Create a copy of InputBorderWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InputBorderWidgetConfigCopyWith<InputBorderWidgetConfig> get copyWith =>
      _$InputBorderWidgetConfigCopyWithImpl<InputBorderWidgetConfig>(
          this as InputBorderWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InputBorderWidgetConfig &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            (identical(other.focused, focused) || other.focused == focused) &&
            (identical(other.any, any) || other.any == any));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, disabled, focused, any);

  @override
  String toString() {
    return 'InputBorderWidgetConfig(disabled: $disabled, focused: $focused, any: $any)';
  }
}

/// @nodoc
abstract mixin class $InputBorderWidgetConfigCopyWith<$Res> {
  factory $InputBorderWidgetConfigCopyWith(InputBorderWidgetConfig value,
          $Res Function(InputBorderWidgetConfig) _then) =
      _$InputBorderWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {BorderWidgetConfig disabled,
      BorderWidgetConfig focused,
      BorderWidgetConfig any});
}

/// @nodoc
class _$InputBorderWidgetConfigCopyWithImpl<$Res>
    implements $InputBorderWidgetConfigCopyWith<$Res> {
  _$InputBorderWidgetConfigCopyWithImpl(this._self, this._then);

  final InputBorderWidgetConfig _self;
  final $Res Function(InputBorderWidgetConfig) _then;

  /// Create a copy of InputBorderWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disabled = null,
    Object? focused = null,
    Object? any = null,
  }) {
    return _then(InputBorderWidgetConfig(
      disabled: null == disabled
          ? _self.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as BorderWidgetConfig,
      focused: null == focused
          ? _self.focused
          : focused // ignore: cast_nullable_to_non_nullable
              as BorderWidgetConfig,
      any: null == any
          ? _self.any
          : any // ignore: cast_nullable_to_non_nullable
              as BorderWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [InputBorderWidgetConfig].
extension InputBorderWidgetConfigPatterns on InputBorderWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$BorderWidgetConfig {
  String? get typicalColor;
  String? get errorColor;

  /// Create a copy of BorderWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BorderWidgetConfigCopyWith<BorderWidgetConfig> get copyWith =>
      _$BorderWidgetConfigCopyWithImpl<BorderWidgetConfig>(
          this as BorderWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BorderWidgetConfig &&
            (identical(other.typicalColor, typicalColor) ||
                other.typicalColor == typicalColor) &&
            (identical(other.errorColor, errorColor) ||
                other.errorColor == errorColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, typicalColor, errorColor);

  @override
  String toString() {
    return 'BorderWidgetConfig(typicalColor: $typicalColor, errorColor: $errorColor)';
  }
}

/// @nodoc
abstract mixin class $BorderWidgetConfigCopyWith<$Res> {
  factory $BorderWidgetConfigCopyWith(
          BorderWidgetConfig value, $Res Function(BorderWidgetConfig) _then) =
      _$BorderWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String? typicalColor, String? errorColor});
}

/// @nodoc
class _$BorderWidgetConfigCopyWithImpl<$Res>
    implements $BorderWidgetConfigCopyWith<$Res> {
  _$BorderWidgetConfigCopyWithImpl(this._self, this._then);

  final BorderWidgetConfig _self;
  final $Res Function(BorderWidgetConfig) _then;

  /// Create a copy of BorderWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typicalColor = freezed,
    Object? errorColor = freezed,
  }) {
    return _then(BorderWidgetConfig(
      typicalColor: freezed == typicalColor
          ? _self.typicalColor
          : typicalColor // ignore: cast_nullable_to_non_nullable
              as String?,
      errorColor: freezed == errorColor
          ? _self.errorColor
          : errorColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BorderWidgetConfig].
extension BorderWidgetConfigPatterns on BorderWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$TextWidgetConfig {
  TextSelectionWidgetConfig get selection;
  LinkifyWidgetConfig get linkify;

  /// Create a copy of TextWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextWidgetConfigCopyWith<TextWidgetConfig> get copyWith =>
      _$TextWidgetConfigCopyWithImpl<TextWidgetConfig>(
          this as TextWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextWidgetConfig &&
            (identical(other.selection, selection) ||
                other.selection == selection) &&
            (identical(other.linkify, linkify) || other.linkify == linkify));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, selection, linkify);

  @override
  String toString() {
    return 'TextWidgetConfig(selection: $selection, linkify: $linkify)';
  }
}

/// @nodoc
abstract mixin class $TextWidgetConfigCopyWith<$Res> {
  factory $TextWidgetConfigCopyWith(
          TextWidgetConfig value, $Res Function(TextWidgetConfig) _then) =
      _$TextWidgetConfigCopyWithImpl;
  @useResult
  $Res call({TextSelectionWidgetConfig selection, LinkifyWidgetConfig linkify});
}

/// @nodoc
class _$TextWidgetConfigCopyWithImpl<$Res>
    implements $TextWidgetConfigCopyWith<$Res> {
  _$TextWidgetConfigCopyWithImpl(this._self, this._then);

  final TextWidgetConfig _self;
  final $Res Function(TextWidgetConfig) _then;

  /// Create a copy of TextWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selection = null,
    Object? linkify = null,
  }) {
    return _then(TextWidgetConfig(
      selection: null == selection
          ? _self.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelectionWidgetConfig,
      linkify: null == linkify
          ? _self.linkify
          : linkify // ignore: cast_nullable_to_non_nullable
              as LinkifyWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [TextWidgetConfig].
extension TextWidgetConfigPatterns on TextWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$TextSelectionWidgetConfig {
  String? get cursorColor;
  String? get selectionColor;
  String? get selectionHandleColor;

  /// Create a copy of TextSelectionWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextSelectionWidgetConfigCopyWith<TextSelectionWidgetConfig> get copyWith =>
      _$TextSelectionWidgetConfigCopyWithImpl<TextSelectionWidgetConfig>(
          this as TextSelectionWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextSelectionWidgetConfig &&
            (identical(other.cursorColor, cursorColor) ||
                other.cursorColor == cursorColor) &&
            (identical(other.selectionColor, selectionColor) ||
                other.selectionColor == selectionColor) &&
            (identical(other.selectionHandleColor, selectionHandleColor) ||
                other.selectionHandleColor == selectionHandleColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cursorColor, selectionColor, selectionHandleColor);

  @override
  String toString() {
    return 'TextSelectionWidgetConfig(cursorColor: $cursorColor, selectionColor: $selectionColor, selectionHandleColor: $selectionHandleColor)';
  }
}

/// @nodoc
abstract mixin class $TextSelectionWidgetConfigCopyWith<$Res> {
  factory $TextSelectionWidgetConfigCopyWith(TextSelectionWidgetConfig value,
          $Res Function(TextSelectionWidgetConfig) _then) =
      _$TextSelectionWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? cursorColor,
      String? selectionColor,
      String? selectionHandleColor});
}

/// @nodoc
class _$TextSelectionWidgetConfigCopyWithImpl<$Res>
    implements $TextSelectionWidgetConfigCopyWith<$Res> {
  _$TextSelectionWidgetConfigCopyWithImpl(this._self, this._then);

  final TextSelectionWidgetConfig _self;
  final $Res Function(TextSelectionWidgetConfig) _then;

  /// Create a copy of TextSelectionWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursorColor = freezed,
    Object? selectionColor = freezed,
    Object? selectionHandleColor = freezed,
  }) {
    return _then(TextSelectionWidgetConfig(
      cursorColor: freezed == cursorColor
          ? _self.cursorColor
          : cursorColor // ignore: cast_nullable_to_non_nullable
              as String?,
      selectionColor: freezed == selectionColor
          ? _self.selectionColor
          : selectionColor // ignore: cast_nullable_to_non_nullable
              as String?,
      selectionHandleColor: freezed == selectionHandleColor
          ? _self.selectionHandleColor
          : selectionHandleColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TextSelectionWidgetConfig].
extension TextSelectionWidgetConfigPatterns on TextSelectionWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LinkifyWidgetConfig {
  String? get styleColor;
  String? get linkifyStyleColor;

  /// Create a copy of LinkifyWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LinkifyWidgetConfigCopyWith<LinkifyWidgetConfig> get copyWith =>
      _$LinkifyWidgetConfigCopyWithImpl<LinkifyWidgetConfig>(
          this as LinkifyWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LinkifyWidgetConfig &&
            (identical(other.styleColor, styleColor) ||
                other.styleColor == styleColor) &&
            (identical(other.linkifyStyleColor, linkifyStyleColor) ||
                other.linkifyStyleColor == linkifyStyleColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, styleColor, linkifyStyleColor);

  @override
  String toString() {
    return 'LinkifyWidgetConfig(styleColor: $styleColor, linkifyStyleColor: $linkifyStyleColor)';
  }
}

/// @nodoc
abstract mixin class $LinkifyWidgetConfigCopyWith<$Res> {
  factory $LinkifyWidgetConfigCopyWith(
          LinkifyWidgetConfig value, $Res Function(LinkifyWidgetConfig) _then) =
      _$LinkifyWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String? styleColor, String? linkifyStyleColor});
}

/// @nodoc
class _$LinkifyWidgetConfigCopyWithImpl<$Res>
    implements $LinkifyWidgetConfigCopyWith<$Res> {
  _$LinkifyWidgetConfigCopyWithImpl(this._self, this._then);

  final LinkifyWidgetConfig _self;
  final $Res Function(LinkifyWidgetConfig) _then;

  /// Create a copy of LinkifyWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? styleColor = freezed,
    Object? linkifyStyleColor = freezed,
  }) {
    return _then(LinkifyWidgetConfig(
      styleColor: freezed == styleColor
          ? _self.styleColor
          : styleColor // ignore: cast_nullable_to_non_nullable
              as String?,
      linkifyStyleColor: freezed == linkifyStyleColor
          ? _self.linkifyStyleColor
          : linkifyStyleColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LinkifyWidgetConfig].
extension LinkifyWidgetConfigPatterns on LinkifyWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$DialogWidgetConfig {
  ConfirmDialogWidgetConfig get confirmDialog;
  SnackBarWidgetConfig get snackBar;

  /// Create a copy of DialogWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DialogWidgetConfigCopyWith<DialogWidgetConfig> get copyWith =>
      _$DialogWidgetConfigCopyWithImpl<DialogWidgetConfig>(
          this as DialogWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DialogWidgetConfig &&
            (identical(other.confirmDialog, confirmDialog) ||
                other.confirmDialog == confirmDialog) &&
            (identical(other.snackBar, snackBar) ||
                other.snackBar == snackBar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, confirmDialog, snackBar);

  @override
  String toString() {
    return 'DialogWidgetConfig(confirmDialog: $confirmDialog, snackBar: $snackBar)';
  }
}

/// @nodoc
abstract mixin class $DialogWidgetConfigCopyWith<$Res> {
  factory $DialogWidgetConfigCopyWith(
          DialogWidgetConfig value, $Res Function(DialogWidgetConfig) _then) =
      _$DialogWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {ConfirmDialogWidgetConfig confirmDialog, SnackBarWidgetConfig snackBar});
}

/// @nodoc
class _$DialogWidgetConfigCopyWithImpl<$Res>
    implements $DialogWidgetConfigCopyWith<$Res> {
  _$DialogWidgetConfigCopyWithImpl(this._self, this._then);

  final DialogWidgetConfig _self;
  final $Res Function(DialogWidgetConfig) _then;

  /// Create a copy of DialogWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmDialog = null,
    Object? snackBar = null,
  }) {
    return _then(DialogWidgetConfig(
      confirmDialog: null == confirmDialog
          ? _self.confirmDialog
          : confirmDialog // ignore: cast_nullable_to_non_nullable
              as ConfirmDialogWidgetConfig,
      snackBar: null == snackBar
          ? _self.snackBar
          : snackBar // ignore: cast_nullable_to_non_nullable
              as SnackBarWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [DialogWidgetConfig].
extension DialogWidgetConfigPatterns on DialogWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ConfirmDialogWidgetConfig {
  String? get activeButtonColor1;
  String? get activeButtonColor2;
  String? get defaultButtonColor;

  /// Create a copy of ConfirmDialogWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfirmDialogWidgetConfigCopyWith<ConfirmDialogWidgetConfig> get copyWith =>
      _$ConfirmDialogWidgetConfigCopyWithImpl<ConfirmDialogWidgetConfig>(
          this as ConfirmDialogWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmDialogWidgetConfig &&
            (identical(other.activeButtonColor1, activeButtonColor1) ||
                other.activeButtonColor1 == activeButtonColor1) &&
            (identical(other.activeButtonColor2, activeButtonColor2) ||
                other.activeButtonColor2 == activeButtonColor2) &&
            (identical(other.defaultButtonColor, defaultButtonColor) ||
                other.defaultButtonColor == defaultButtonColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, activeButtonColor1, activeButtonColor2, defaultButtonColor);

  @override
  String toString() {
    return 'ConfirmDialogWidgetConfig(activeButtonColor1: $activeButtonColor1, activeButtonColor2: $activeButtonColor2, defaultButtonColor: $defaultButtonColor)';
  }
}

/// @nodoc
abstract mixin class $ConfirmDialogWidgetConfigCopyWith<$Res> {
  factory $ConfirmDialogWidgetConfigCopyWith(ConfirmDialogWidgetConfig value,
          $Res Function(ConfirmDialogWidgetConfig) _then) =
      _$ConfirmDialogWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? activeButtonColor1,
      String? activeButtonColor2,
      String? defaultButtonColor});
}

/// @nodoc
class _$ConfirmDialogWidgetConfigCopyWithImpl<$Res>
    implements $ConfirmDialogWidgetConfigCopyWith<$Res> {
  _$ConfirmDialogWidgetConfigCopyWithImpl(this._self, this._then);

  final ConfirmDialogWidgetConfig _self;
  final $Res Function(ConfirmDialogWidgetConfig) _then;

  /// Create a copy of ConfirmDialogWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeButtonColor1 = freezed,
    Object? activeButtonColor2 = freezed,
    Object? defaultButtonColor = freezed,
  }) {
    return _then(ConfirmDialogWidgetConfig(
      activeButtonColor1: freezed == activeButtonColor1
          ? _self.activeButtonColor1
          : activeButtonColor1 // ignore: cast_nullable_to_non_nullable
              as String?,
      activeButtonColor2: freezed == activeButtonColor2
          ? _self.activeButtonColor2
          : activeButtonColor2 // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultButtonColor: freezed == defaultButtonColor
          ? _self.defaultButtonColor
          : defaultButtonColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConfirmDialogWidgetConfig].
extension ConfirmDialogWidgetConfigPatterns on ConfirmDialogWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$SnackBarWidgetConfig {
  String get successBackgroundColor;
  String get errorBackgroundColor;
  String get infoBackgroundColor;
  String get warningBackgroundColor;

  /// Create a copy of SnackBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnackBarWidgetConfigCopyWith<SnackBarWidgetConfig> get copyWith =>
      _$SnackBarWidgetConfigCopyWithImpl<SnackBarWidgetConfig>(
          this as SnackBarWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnackBarWidgetConfig &&
            (identical(other.successBackgroundColor, successBackgroundColor) ||
                other.successBackgroundColor == successBackgroundColor) &&
            (identical(other.errorBackgroundColor, errorBackgroundColor) ||
                other.errorBackgroundColor == errorBackgroundColor) &&
            (identical(other.infoBackgroundColor, infoBackgroundColor) ||
                other.infoBackgroundColor == infoBackgroundColor) &&
            (identical(other.warningBackgroundColor, warningBackgroundColor) ||
                other.warningBackgroundColor == warningBackgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, successBackgroundColor,
      errorBackgroundColor, infoBackgroundColor, warningBackgroundColor);

  @override
  String toString() {
    return 'SnackBarWidgetConfig(successBackgroundColor: $successBackgroundColor, errorBackgroundColor: $errorBackgroundColor, infoBackgroundColor: $infoBackgroundColor, warningBackgroundColor: $warningBackgroundColor)';
  }
}

/// @nodoc
abstract mixin class $SnackBarWidgetConfigCopyWith<$Res> {
  factory $SnackBarWidgetConfigCopyWith(SnackBarWidgetConfig value,
          $Res Function(SnackBarWidgetConfig) _then) =
      _$SnackBarWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String successBackgroundColor,
      String errorBackgroundColor,
      String infoBackgroundColor,
      String warningBackgroundColor});
}

/// @nodoc
class _$SnackBarWidgetConfigCopyWithImpl<$Res>
    implements $SnackBarWidgetConfigCopyWith<$Res> {
  _$SnackBarWidgetConfigCopyWithImpl(this._self, this._then);

  final SnackBarWidgetConfig _self;
  final $Res Function(SnackBarWidgetConfig) _then;

  /// Create a copy of SnackBarWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successBackgroundColor = null,
    Object? errorBackgroundColor = null,
    Object? infoBackgroundColor = null,
    Object? warningBackgroundColor = null,
  }) {
    return _then(SnackBarWidgetConfig(
      successBackgroundColor: null == successBackgroundColor
          ? _self.successBackgroundColor
          : successBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      errorBackgroundColor: null == errorBackgroundColor
          ? _self.errorBackgroundColor
          : errorBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      infoBackgroundColor: null == infoBackgroundColor
          ? _self.infoBackgroundColor
          : infoBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      warningBackgroundColor: null == warningBackgroundColor
          ? _self.warningBackgroundColor
          : warningBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SnackBarWidgetConfig].
extension SnackBarWidgetConfigPatterns on SnackBarWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ActionPadWidgetConfig {
  ElevatedButtonWidgetConfig get callStart;
  ElevatedButtonWidgetConfig get callTransfer;
  ElevatedButtonWidgetConfig get backspacePressed;

  /// Create a copy of ActionPadWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActionPadWidgetConfigCopyWith<ActionPadWidgetConfig> get copyWith =>
      _$ActionPadWidgetConfigCopyWithImpl<ActionPadWidgetConfig>(
          this as ActionPadWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionPadWidgetConfig &&
            (identical(other.callStart, callStart) ||
                other.callStart == callStart) &&
            (identical(other.callTransfer, callTransfer) ||
                other.callTransfer == callTransfer) &&
            (identical(other.backspacePressed, backspacePressed) ||
                other.backspacePressed == backspacePressed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, callStart, callTransfer, backspacePressed);

  @override
  String toString() {
    return 'ActionPadWidgetConfig(callStart: $callStart, callTransfer: $callTransfer, backspacePressed: $backspacePressed)';
  }
}

/// @nodoc
abstract mixin class $ActionPadWidgetConfigCopyWith<$Res> {
  factory $ActionPadWidgetConfigCopyWith(ActionPadWidgetConfig value,
          $Res Function(ActionPadWidgetConfig) _then) =
      _$ActionPadWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {ElevatedButtonWidgetConfig callStart,
      ElevatedButtonWidgetConfig callTransfer,
      ElevatedButtonWidgetConfig backspacePressed});
}

/// @nodoc
class _$ActionPadWidgetConfigCopyWithImpl<$Res>
    implements $ActionPadWidgetConfigCopyWith<$Res> {
  _$ActionPadWidgetConfigCopyWithImpl(this._self, this._then);

  final ActionPadWidgetConfig _self;
  final $Res Function(ActionPadWidgetConfig) _then;

  /// Create a copy of ActionPadWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callStart = null,
    Object? callTransfer = null,
    Object? backspacePressed = null,
  }) {
    return _then(ActionPadWidgetConfig(
      callStart: null == callStart
          ? _self.callStart
          : callStart // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      callTransfer: null == callTransfer
          ? _self.callTransfer
          : callTransfer // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      backspacePressed: null == backspacePressed
          ? _self.backspacePressed
          : backspacePressed // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ActionPadWidgetConfig].
extension ActionPadWidgetConfigPatterns on ActionPadWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$StatusesWidgetConfig {
  RegistrationStatusesWidgetConfig get registrationStatuses;
  CallStatusesWidgetConfig get callStatuses;

  /// Create a copy of StatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatusesWidgetConfigCopyWith<StatusesWidgetConfig> get copyWith =>
      _$StatusesWidgetConfigCopyWithImpl<StatusesWidgetConfig>(
          this as StatusesWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatusesWidgetConfig &&
            (identical(other.registrationStatuses, registrationStatuses) ||
                other.registrationStatuses == registrationStatuses) &&
            (identical(other.callStatuses, callStatuses) ||
                other.callStatuses == callStatuses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, registrationStatuses, callStatuses);

  @override
  String toString() {
    return 'StatusesWidgetConfig(registrationStatuses: $registrationStatuses, callStatuses: $callStatuses)';
  }
}

/// @nodoc
abstract mixin class $StatusesWidgetConfigCopyWith<$Res> {
  factory $StatusesWidgetConfigCopyWith(StatusesWidgetConfig value,
          $Res Function(StatusesWidgetConfig) _then) =
      _$StatusesWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {RegistrationStatusesWidgetConfig registrationStatuses,
      CallStatusesWidgetConfig callStatuses});
}

/// @nodoc
class _$StatusesWidgetConfigCopyWithImpl<$Res>
    implements $StatusesWidgetConfigCopyWith<$Res> {
  _$StatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final StatusesWidgetConfig _self;
  final $Res Function(StatusesWidgetConfig) _then;

  /// Create a copy of StatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationStatuses = null,
    Object? callStatuses = null,
  }) {
    return _then(StatusesWidgetConfig(
      registrationStatuses: null == registrationStatuses
          ? _self.registrationStatuses
          : registrationStatuses // ignore: cast_nullable_to_non_nullable
              as RegistrationStatusesWidgetConfig,
      callStatuses: null == callStatuses
          ? _self.callStatuses
          : callStatuses // ignore: cast_nullable_to_non_nullable
              as CallStatusesWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [StatusesWidgetConfig].
extension StatusesWidgetConfigPatterns on StatusesWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$RegistrationStatusesWidgetConfig {
  String get online;
  String get offline;

  /// Create a copy of RegistrationStatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegistrationStatusesWidgetConfigCopyWith<RegistrationStatusesWidgetConfig>
      get copyWith => _$RegistrationStatusesWidgetConfigCopyWithImpl<
              RegistrationStatusesWidgetConfig>(
          this as RegistrationStatusesWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegistrationStatusesWidgetConfig &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.offline, offline) || other.offline == offline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, online, offline);

  @override
  String toString() {
    return 'RegistrationStatusesWidgetConfig(online: $online, offline: $offline)';
  }
}

/// @nodoc
abstract mixin class $RegistrationStatusesWidgetConfigCopyWith<$Res> {
  factory $RegistrationStatusesWidgetConfigCopyWith(
          RegistrationStatusesWidgetConfig value,
          $Res Function(RegistrationStatusesWidgetConfig) _then) =
      _$RegistrationStatusesWidgetConfigCopyWithImpl;
  @useResult
  $Res call({String online, String offline});
}

/// @nodoc
class _$RegistrationStatusesWidgetConfigCopyWithImpl<$Res>
    implements $RegistrationStatusesWidgetConfigCopyWith<$Res> {
  _$RegistrationStatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final RegistrationStatusesWidgetConfig _self;
  final $Res Function(RegistrationStatusesWidgetConfig) _then;

  /// Create a copy of RegistrationStatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? online = null,
    Object? offline = null,
  }) {
    return _then(RegistrationStatusesWidgetConfig(
      online: null == online
          ? _self.online
          : online // ignore: cast_nullable_to_non_nullable
              as String,
      offline: null == offline
          ? _self.offline
          : offline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegistrationStatusesWidgetConfig].
extension RegistrationStatusesWidgetConfigPatterns
    on RegistrationStatusesWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$CallStatusesWidgetConfig {
  String get connectivityNone;
  String get connectError;
  String get appUnregistered;
  String get connectIssue;
  String get inProgress;
  String get ready;

  /// Create a copy of CallStatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallStatusesWidgetConfigCopyWith<CallStatusesWidgetConfig> get copyWith =>
      _$CallStatusesWidgetConfigCopyWithImpl<CallStatusesWidgetConfig>(
          this as CallStatusesWidgetConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallStatusesWidgetConfig &&
            (identical(other.connectivityNone, connectivityNone) ||
                other.connectivityNone == connectivityNone) &&
            (identical(other.connectError, connectError) ||
                other.connectError == connectError) &&
            (identical(other.appUnregistered, appUnregistered) ||
                other.appUnregistered == appUnregistered) &&
            (identical(other.connectIssue, connectIssue) ||
                other.connectIssue == connectIssue) &&
            (identical(other.inProgress, inProgress) ||
                other.inProgress == inProgress) &&
            (identical(other.ready, ready) || other.ready == ready));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, connectivityNone, connectError,
      appUnregistered, connectIssue, inProgress, ready);

  @override
  String toString() {
    return 'CallStatusesWidgetConfig(connectivityNone: $connectivityNone, connectError: $connectError, appUnregistered: $appUnregistered, connectIssue: $connectIssue, inProgress: $inProgress, ready: $ready)';
  }
}

/// @nodoc
abstract mixin class $CallStatusesWidgetConfigCopyWith<$Res> {
  factory $CallStatusesWidgetConfigCopyWith(CallStatusesWidgetConfig value,
          $Res Function(CallStatusesWidgetConfig) _then) =
      _$CallStatusesWidgetConfigCopyWithImpl;
  @useResult
  $Res call(
      {String connectivityNone,
      String connectError,
      String appUnregistered,
      String connectIssue,
      String inProgress,
      String ready});
}

/// @nodoc
class _$CallStatusesWidgetConfigCopyWithImpl<$Res>
    implements $CallStatusesWidgetConfigCopyWith<$Res> {
  _$CallStatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final CallStatusesWidgetConfig _self;
  final $Res Function(CallStatusesWidgetConfig) _then;

  /// Create a copy of CallStatusesWidgetConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectivityNone = null,
    Object? connectError = null,
    Object? appUnregistered = null,
    Object? connectIssue = null,
    Object? inProgress = null,
    Object? ready = null,
  }) {
    return _then(CallStatusesWidgetConfig(
      connectivityNone: null == connectivityNone
          ? _self.connectivityNone
          : connectivityNone // ignore: cast_nullable_to_non_nullable
              as String,
      connectError: null == connectError
          ? _self.connectError
          : connectError // ignore: cast_nullable_to_non_nullable
              as String,
      appUnregistered: null == appUnregistered
          ? _self.appUnregistered
          : appUnregistered // ignore: cast_nullable_to_non_nullable
              as String,
      connectIssue: null == connectIssue
          ? _self.connectIssue
          : connectIssue // ignore: cast_nullable_to_non_nullable
              as String,
      inProgress: null == inProgress
          ? _self.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as String,
      ready: null == ready
          ? _self.ready
          : ready // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallStatusesWidgetConfig].
extension CallStatusesWidgetConfigPatterns on CallStatusesWidgetConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$DecorationConfig {
  GradientColorsConfig get primaryGradientColorsConfig;

  /// Create a copy of DecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecorationConfigCopyWith<DecorationConfig> get copyWith =>
      _$DecorationConfigCopyWithImpl<DecorationConfig>(
          this as DecorationConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DecorationConfig &&
            (identical(other.primaryGradientColorsConfig,
                    primaryGradientColorsConfig) ||
                other.primaryGradientColorsConfig ==
                    primaryGradientColorsConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, primaryGradientColorsConfig);

  @override
  String toString() {
    return 'DecorationConfig(primaryGradientColorsConfig: $primaryGradientColorsConfig)';
  }
}

/// @nodoc
abstract mixin class $DecorationConfigCopyWith<$Res> {
  factory $DecorationConfigCopyWith(
          DecorationConfig value, $Res Function(DecorationConfig) _then) =
      _$DecorationConfigCopyWithImpl;
  @useResult
  $Res call({GradientColorsConfig primaryGradientColorsConfig});
}

/// @nodoc
class _$DecorationConfigCopyWithImpl<$Res>
    implements $DecorationConfigCopyWith<$Res> {
  _$DecorationConfigCopyWithImpl(this._self, this._then);

  final DecorationConfig _self;
  final $Res Function(DecorationConfig) _then;

  /// Create a copy of DecorationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryGradientColorsConfig = null,
  }) {
    return _then(DecorationConfig(
      primaryGradientColorsConfig: null == primaryGradientColorsConfig
          ? _self.primaryGradientColorsConfig
          : primaryGradientColorsConfig // ignore: cast_nullable_to_non_nullable
              as GradientColorsConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [DecorationConfig].
extension DecorationConfigPatterns on DecorationConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$GradientColorsConfig {
  List<CustomColor> get colors;

  /// Create a copy of GradientColorsConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GradientColorsConfigCopyWith<GradientColorsConfig> get copyWith =>
      _$GradientColorsConfigCopyWithImpl<GradientColorsConfig>(
          this as GradientColorsConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GradientColorsConfig &&
            const DeepCollectionEquality().equals(other.colors, colors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(colors));

  @override
  String toString() {
    return 'GradientColorsConfig(colors: $colors)';
  }
}

/// @nodoc
abstract mixin class $GradientColorsConfigCopyWith<$Res> {
  factory $GradientColorsConfigCopyWith(GradientColorsConfig value,
          $Res Function(GradientColorsConfig) _then) =
      _$GradientColorsConfigCopyWithImpl;
  @useResult
  $Res call({List<CustomColor> colors});
}

/// @nodoc
class _$GradientColorsConfigCopyWithImpl<$Res>
    implements $GradientColorsConfigCopyWith<$Res> {
  _$GradientColorsConfigCopyWithImpl(this._self, this._then);

  final GradientColorsConfig _self;
  final $Res Function(GradientColorsConfig) _then;

  /// Create a copy of GradientColorsConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
  }) {
    return _then(GradientColorsConfig(
      colors: null == colors
          ? _self.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<CustomColor>,
    ));
  }
}

/// Adds pattern-matching-related methods to [GradientColorsConfig].
extension GradientColorsConfigPatterns on GradientColorsConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

// dart format on
