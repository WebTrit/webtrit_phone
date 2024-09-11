// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_compose_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UiComposeSettings _$UiComposeSettingsFromJson(Map<String, dynamic> json) {
  return _UiComposeSettings.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettings {
  List<UiComposeSettingsBottomMenuTabs> get bottomMenuTabs =>
      throw _privateConstructorUsedError;
  set bottomMenuTabs(List<UiComposeSettingsBottomMenuTabs> value) =>
      throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsCopyWith<UiComposeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsCopyWith<$Res> {
  factory $UiComposeSettingsCopyWith(
          UiComposeSettings value, $Res Function(UiComposeSettings) then) =
      _$UiComposeSettingsCopyWithImpl<$Res, UiComposeSettings>;
  @useResult
  $Res call({List<UiComposeSettingsBottomMenuTabs> bottomMenuTabs});
}

/// @nodoc
class _$UiComposeSettingsCopyWithImpl<$Res, $Val extends UiComposeSettings>
    implements $UiComposeSettingsCopyWith<$Res> {
  _$UiComposeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenuTabs = null,
  }) {
    return _then(_value.copyWith(
      bottomMenuTabs: null == bottomMenuTabs
          ? _value.bottomMenuTabs
          : bottomMenuTabs // ignore: cast_nullable_to_non_nullable
              as List<UiComposeSettingsBottomMenuTabs>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsImplCopyWith<$Res>
    implements $UiComposeSettingsCopyWith<$Res> {
  factory _$$UiComposeSettingsImplCopyWith(_$UiComposeSettingsImpl value,
          $Res Function(_$UiComposeSettingsImpl) then) =
      __$$UiComposeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UiComposeSettingsBottomMenuTabs> bottomMenuTabs});
}

/// @nodoc
class __$$UiComposeSettingsImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsCopyWithImpl<$Res, _$UiComposeSettingsImpl>
    implements _$$UiComposeSettingsImplCopyWith<$Res> {
  __$$UiComposeSettingsImplCopyWithImpl(_$UiComposeSettingsImpl _value,
      $Res Function(_$UiComposeSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bottomMenuTabs = null,
  }) {
    return _then(_$UiComposeSettingsImpl(
      bottomMenuTabs: null == bottomMenuTabs
          ? _value.bottomMenuTabs
          : bottomMenuTabs // ignore: cast_nullable_to_non_nullable
              as List<UiComposeSettingsBottomMenuTabs>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsImpl implements _UiComposeSettings {
  _$UiComposeSettingsImpl({required this.bottomMenuTabs});

  factory _$UiComposeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiComposeSettingsImplFromJson(json);

  @override
  List<UiComposeSettingsBottomMenuTabs> bottomMenuTabs;

  @override
  String toString() {
    return 'UiComposeSettings(bottomMenuTabs: $bottomMenuTabs)';
  }

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsImplCopyWith<_$UiComposeSettingsImpl> get copyWith =>
      __$$UiComposeSettingsImplCopyWithImpl<_$UiComposeSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettings implements UiComposeSettings {
  factory _UiComposeSettings(
          {required List<UiComposeSettingsBottomMenuTabs> bottomMenuTabs}) =
      _$UiComposeSettingsImpl;

  factory _UiComposeSettings.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsImpl.fromJson;

  @override
  List<UiComposeSettingsBottomMenuTabs> get bottomMenuTabs;
  set bottomMenuTabs(List<UiComposeSettingsBottomMenuTabs> value);

  /// Create a copy of UiComposeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsImplCopyWith<_$UiComposeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UiComposeSettingsBottomMenuTabs _$UiComposeSettingsBottomMenuTabsFromJson(
    Map<String, dynamic> json) {
  return _UiComposeSettingsBottomMenuTabs.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsBottomMenuTabs {
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  @IconDataConverter()
  set icon(IconData value) =>
      throw _privateConstructorUsedError; // Apply the converter here
  String get type =>
      throw _privateConstructorUsedError; // Apply the converter here
  set type(String value) => throw _privateConstructorUsedError;
  bool get initial => throw _privateConstructorUsedError;
  set initial(bool value) => throw _privateConstructorUsedError;
  UiComposeSettingsBottomMenuTabsData? get data =>
      throw _privateConstructorUsedError;
  set data(UiComposeSettingsBottomMenuTabsData? value) =>
      throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsBottomMenuTabs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsBottomMenuTabsCopyWith<UiComposeSettingsBottomMenuTabs>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsBottomMenuTabsCopyWith<$Res> {
  factory $UiComposeSettingsBottomMenuTabsCopyWith(
          UiComposeSettingsBottomMenuTabs value,
          $Res Function(UiComposeSettingsBottomMenuTabs) then) =
      _$UiComposeSettingsBottomMenuTabsCopyWithImpl<$Res,
          UiComposeSettingsBottomMenuTabs>;
  @useResult
  $Res call(
      {String title,
      @IconDataConverter() IconData icon,
      String type,
      bool initial,
      UiComposeSettingsBottomMenuTabsData? data});

  $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$UiComposeSettingsBottomMenuTabsCopyWithImpl<$Res,
        $Val extends UiComposeSettingsBottomMenuTabs>
    implements $UiComposeSettingsBottomMenuTabsCopyWith<$Res> {
  _$UiComposeSettingsBottomMenuTabsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? icon = null,
    Object? type = null,
    Object? initial = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsBottomMenuTabsData?,
    ) as $Val);
  }

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsBottomMenuTabsImplCopyWith<$Res>
    implements $UiComposeSettingsBottomMenuTabsCopyWith<$Res> {
  factory _$$UiComposeSettingsBottomMenuTabsImplCopyWith(
          _$UiComposeSettingsBottomMenuTabsImpl value,
          $Res Function(_$UiComposeSettingsBottomMenuTabsImpl) then) =
      __$$UiComposeSettingsBottomMenuTabsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      @IconDataConverter() IconData icon,
      String type,
      bool initial,
      UiComposeSettingsBottomMenuTabsData? data});

  @override
  $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$UiComposeSettingsBottomMenuTabsImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsBottomMenuTabsCopyWithImpl<$Res,
        _$UiComposeSettingsBottomMenuTabsImpl>
    implements _$$UiComposeSettingsBottomMenuTabsImplCopyWith<$Res> {
  __$$UiComposeSettingsBottomMenuTabsImplCopyWithImpl(
      _$UiComposeSettingsBottomMenuTabsImpl _value,
      $Res Function(_$UiComposeSettingsBottomMenuTabsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? icon = null,
    Object? type = null,
    Object? initial = null,
    Object? data = freezed,
  }) {
    return _then(_$UiComposeSettingsBottomMenuTabsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UiComposeSettingsBottomMenuTabsData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsBottomMenuTabsImpl
    implements _UiComposeSettingsBottomMenuTabs {
  _$UiComposeSettingsBottomMenuTabsImpl(
      {required this.title,
      @IconDataConverter() required this.icon,
      required this.type,
      this.initial = false,
      this.data});

  factory _$UiComposeSettingsBottomMenuTabsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UiComposeSettingsBottomMenuTabsImplFromJson(json);

  @override
  String title;
  @override
  @IconDataConverter()
  IconData icon;
// Apply the converter here
  @override
  String type;
  @override
  @JsonKey()
  bool initial;
  @override
  UiComposeSettingsBottomMenuTabsData? data;

  @override
  String toString() {
    return 'UiComposeSettingsBottomMenuTabs(title: $title, icon: $icon, type: $type, initial: $initial, data: $data)';
  }

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsBottomMenuTabsImplCopyWith<
          _$UiComposeSettingsBottomMenuTabsImpl>
      get copyWith => __$$UiComposeSettingsBottomMenuTabsImplCopyWithImpl<
          _$UiComposeSettingsBottomMenuTabsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsBottomMenuTabsImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsBottomMenuTabs
    implements UiComposeSettingsBottomMenuTabs {
  factory _UiComposeSettingsBottomMenuTabs(
          {required String title,
          @IconDataConverter() required IconData icon,
          required String type,
          bool initial,
          UiComposeSettingsBottomMenuTabsData? data}) =
      _$UiComposeSettingsBottomMenuTabsImpl;

  factory _UiComposeSettingsBottomMenuTabs.fromJson(Map<String, dynamic> json) =
      _$UiComposeSettingsBottomMenuTabsImpl.fromJson;

  @override
  String get title;
  set title(String value);
  @override
  @IconDataConverter()
  IconData get icon;
  @IconDataConverter()
  set icon(IconData value); // Apply the converter here
  @override
  String get type; // Apply the converter here
  set type(String value);
  @override
  bool get initial;
  set initial(bool value);
  @override
  UiComposeSettingsBottomMenuTabsData? get data;
  set data(UiComposeSettingsBottomMenuTabsData? value);

  /// Create a copy of UiComposeSettingsBottomMenuTabs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsBottomMenuTabsImplCopyWith<
          _$UiComposeSettingsBottomMenuTabsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UiComposeSettingsBottomMenuTabsData
    _$UiComposeSettingsBottomMenuTabsDataFromJson(Map<String, dynamic> json) {
  return _UiComposeSettingsBottomMenuTabsData.fromJson(json);
}

/// @nodoc
mixin _$UiComposeSettingsBottomMenuTabsData {
  String get url => throw _privateConstructorUsedError;
  set url(String value) => throw _privateConstructorUsedError;

  /// Serializes this UiComposeSettingsBottomMenuTabsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiComposeSettingsBottomMenuTabsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiComposeSettingsBottomMenuTabsDataCopyWith<
          UiComposeSettingsBottomMenuTabsData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res> {
  factory $UiComposeSettingsBottomMenuTabsDataCopyWith(
          UiComposeSettingsBottomMenuTabsData value,
          $Res Function(UiComposeSettingsBottomMenuTabsData) then) =
      _$UiComposeSettingsBottomMenuTabsDataCopyWithImpl<$Res,
          UiComposeSettingsBottomMenuTabsData>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$UiComposeSettingsBottomMenuTabsDataCopyWithImpl<$Res,
        $Val extends UiComposeSettingsBottomMenuTabsData>
    implements $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res> {
  _$UiComposeSettingsBottomMenuTabsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiComposeSettingsBottomMenuTabsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UiComposeSettingsBottomMenuTabsDataImplCopyWith<$Res>
    implements $UiComposeSettingsBottomMenuTabsDataCopyWith<$Res> {
  factory _$$UiComposeSettingsBottomMenuTabsDataImplCopyWith(
          _$UiComposeSettingsBottomMenuTabsDataImpl value,
          $Res Function(_$UiComposeSettingsBottomMenuTabsDataImpl) then) =
      __$$UiComposeSettingsBottomMenuTabsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$UiComposeSettingsBottomMenuTabsDataImplCopyWithImpl<$Res>
    extends _$UiComposeSettingsBottomMenuTabsDataCopyWithImpl<$Res,
        _$UiComposeSettingsBottomMenuTabsDataImpl>
    implements _$$UiComposeSettingsBottomMenuTabsDataImplCopyWith<$Res> {
  __$$UiComposeSettingsBottomMenuTabsDataImplCopyWithImpl(
      _$UiComposeSettingsBottomMenuTabsDataImpl _value,
      $Res Function(_$UiComposeSettingsBottomMenuTabsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiComposeSettingsBottomMenuTabsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$UiComposeSettingsBottomMenuTabsDataImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiComposeSettingsBottomMenuTabsDataImpl
    implements _UiComposeSettingsBottomMenuTabsData {
  _$UiComposeSettingsBottomMenuTabsDataImpl({required this.url});

  factory _$UiComposeSettingsBottomMenuTabsDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UiComposeSettingsBottomMenuTabsDataImplFromJson(json);

  @override
  String url;

  @override
  String toString() {
    return 'UiComposeSettingsBottomMenuTabsData(url: $url)';
  }

  /// Create a copy of UiComposeSettingsBottomMenuTabsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiComposeSettingsBottomMenuTabsDataImplCopyWith<
          _$UiComposeSettingsBottomMenuTabsDataImpl>
      get copyWith => __$$UiComposeSettingsBottomMenuTabsDataImplCopyWithImpl<
          _$UiComposeSettingsBottomMenuTabsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiComposeSettingsBottomMenuTabsDataImplToJson(
      this,
    );
  }
}

abstract class _UiComposeSettingsBottomMenuTabsData
    implements UiComposeSettingsBottomMenuTabsData {
  factory _UiComposeSettingsBottomMenuTabsData({required String url}) =
      _$UiComposeSettingsBottomMenuTabsDataImpl;

  factory _UiComposeSettingsBottomMenuTabsData.fromJson(
          Map<String, dynamic> json) =
      _$UiComposeSettingsBottomMenuTabsDataImpl.fromJson;

  @override
  String get url;
  set url(String value);

  /// Create a copy of UiComposeSettingsBottomMenuTabsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiComposeSettingsBottomMenuTabsDataImplCopyWith<
          _$UiComposeSettingsBottomMenuTabsDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
