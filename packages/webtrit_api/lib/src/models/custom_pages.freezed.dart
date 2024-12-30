// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_pages.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomPagesResponse _$CustomPagesResponseFromJson(Map<String, dynamic> json) {
  return _CustomPagesResponse.fromJson(json);
}

/// @nodoc
mixin _$CustomPagesResponse {
  List<CustomPageResponse> get pages => throw _privateConstructorUsedError;

  /// Serializes this CustomPagesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomPagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomPagesResponseCopyWith<CustomPagesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomPagesResponseCopyWith<$Res> {
  factory $CustomPagesResponseCopyWith(
          CustomPagesResponse value, $Res Function(CustomPagesResponse) then) =
      _$CustomPagesResponseCopyWithImpl<$Res, CustomPagesResponse>;
  @useResult
  $Res call({List<CustomPageResponse> pages});
}

/// @nodoc
class _$CustomPagesResponseCopyWithImpl<$Res, $Val extends CustomPagesResponse>
    implements $CustomPagesResponseCopyWith<$Res> {
  _$CustomPagesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomPagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<CustomPageResponse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomPagesResponseImplCopyWith<$Res>
    implements $CustomPagesResponseCopyWith<$Res> {
  factory _$$CustomPagesResponseImplCopyWith(_$CustomPagesResponseImpl value,
          $Res Function(_$CustomPagesResponseImpl) then) =
      __$$CustomPagesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CustomPageResponse> pages});
}

/// @nodoc
class __$$CustomPagesResponseImplCopyWithImpl<$Res>
    extends _$CustomPagesResponseCopyWithImpl<$Res, _$CustomPagesResponseImpl>
    implements _$$CustomPagesResponseImplCopyWith<$Res> {
  __$$CustomPagesResponseImplCopyWithImpl(_$CustomPagesResponseImpl _value,
      $Res Function(_$CustomPagesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomPagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_$CustomPagesResponseImpl(
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<CustomPageResponse>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CustomPagesResponseImpl implements _CustomPagesResponse {
  const _$CustomPagesResponseImpl(
      {required final List<CustomPageResponse> pages})
      : _pages = pages;

  factory _$CustomPagesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomPagesResponseImplFromJson(json);

  final List<CustomPageResponse> _pages;
  @override
  List<CustomPageResponse> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'CustomPagesResponse(pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomPagesResponseImpl &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pages));

  /// Create a copy of CustomPagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomPagesResponseImplCopyWith<_$CustomPagesResponseImpl> get copyWith =>
      __$$CustomPagesResponseImplCopyWithImpl<_$CustomPagesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomPagesResponseImplToJson(
      this,
    );
  }
}

abstract class _CustomPagesResponse implements CustomPagesResponse {
  const factory _CustomPagesResponse(
          {required final List<CustomPageResponse> pages}) =
      _$CustomPagesResponseImpl;

  factory _CustomPagesResponse.fromJson(Map<String, dynamic> json) =
      _$CustomPagesResponseImpl.fromJson;

  @override
  List<CustomPageResponse> get pages;

  /// Create a copy of CustomPagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomPagesResponseImplCopyWith<_$CustomPagesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomPageResponse _$CustomPageResponseFromJson(Map<String, dynamic> json) {
  return _CustomPageResponse.fromJson(json);
}

/// @nodoc
mixin _$CustomPageResponse {
  String get title => throw _privateConstructorUsedError;
  Uri get url => throw _privateConstructorUsedError;
  Map<String, dynamic> get extraData => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this CustomPageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomPageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomPageResponseCopyWith<CustomPageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomPageResponseCopyWith<$Res> {
  factory $CustomPageResponseCopyWith(
          CustomPageResponse value, $Res Function(CustomPageResponse) then) =
      _$CustomPageResponseCopyWithImpl<$Res, CustomPageResponse>;
  @useResult
  $Res call(
      {String title,
      Uri url,
      Map<String, dynamic> extraData,
      String? description,
      DateTime? expiresAt});
}

/// @nodoc
class _$CustomPageResponseCopyWithImpl<$Res, $Val extends CustomPageResponse>
    implements $CustomPageResponseCopyWith<$Res> {
  _$CustomPageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomPageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? extraData = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      extraData: null == extraData
          ? _value.extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomPageResponseImplCopyWith<$Res>
    implements $CustomPageResponseCopyWith<$Res> {
  factory _$$CustomPageResponseImplCopyWith(_$CustomPageResponseImpl value,
          $Res Function(_$CustomPageResponseImpl) then) =
      __$$CustomPageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      Uri url,
      Map<String, dynamic> extraData,
      String? description,
      DateTime? expiresAt});
}

/// @nodoc
class __$$CustomPageResponseImplCopyWithImpl<$Res>
    extends _$CustomPageResponseCopyWithImpl<$Res, _$CustomPageResponseImpl>
    implements _$$CustomPageResponseImplCopyWith<$Res> {
  __$$CustomPageResponseImplCopyWithImpl(_$CustomPageResponseImpl _value,
      $Res Function(_$CustomPageResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomPageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? extraData = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$CustomPageResponseImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      extraData: null == extraData
          ? _value._extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CustomPageResponseImpl implements _CustomPageResponse {
  const _$CustomPageResponseImpl(
      {required this.title,
      required this.url,
      required final Map<String, dynamic> extraData,
      required this.description,
      required this.expiresAt})
      : _extraData = extraData;

  factory _$CustomPageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomPageResponseImplFromJson(json);

  @override
  final String title;
  @override
  final Uri url;
  final Map<String, dynamic> _extraData;
  @override
  Map<String, dynamic> get extraData {
    if (_extraData is EqualUnmodifiableMapView) return _extraData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extraData);
  }

  @override
  final String? description;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'CustomPageResponse(title: $title, url: $url, extraData: $extraData, description: $description, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomPageResponseImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality()
                .equals(other._extraData, _extraData) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url,
      const DeepCollectionEquality().hash(_extraData), description, expiresAt);

  /// Create a copy of CustomPageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomPageResponseImplCopyWith<_$CustomPageResponseImpl> get copyWith =>
      __$$CustomPageResponseImplCopyWithImpl<_$CustomPageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomPageResponseImplToJson(
      this,
    );
  }
}

abstract class _CustomPageResponse implements CustomPageResponse {
  const factory _CustomPageResponse(
      {required final String title,
      required final Uri url,
      required final Map<String, dynamic> extraData,
      required final String? description,
      required final DateTime? expiresAt}) = _$CustomPageResponseImpl;

  factory _CustomPageResponse.fromJson(Map<String, dynamic> json) =
      _$CustomPageResponseImpl.fromJson;

  @override
  String get title;
  @override
  Uri get url;
  @override
  Map<String, dynamic> get extraData;
  @override
  String? get description;
  @override
  DateTime? get expiresAt;

  /// Create a copy of CustomPageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomPageResponseImplCopyWith<_$CustomPageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
