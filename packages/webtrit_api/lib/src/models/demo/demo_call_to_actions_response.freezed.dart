// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_call_to_actions_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemoCallToActionsResponse _$DemoCallToActionsResponseFromJson(
    Map<String, dynamic> json) {
  return _DemoCallToActionsResponse.fromJson(json);
}

/// @nodoc
mixin _$DemoCallToActionsResponse {
  List<DemoCallToActionsResponseActions> get actions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoCallToActionsResponseCopyWith<DemoCallToActionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCallToActionsResponseCopyWith<$Res> {
  factory $DemoCallToActionsResponseCopyWith(DemoCallToActionsResponse value,
          $Res Function(DemoCallToActionsResponse) then) =
      _$DemoCallToActionsResponseCopyWithImpl<$Res, DemoCallToActionsResponse>;
  @useResult
  $Res call({List<DemoCallToActionsResponseActions> actions});
}

/// @nodoc
class _$DemoCallToActionsResponseCopyWithImpl<$Res,
        $Val extends DemoCallToActionsResponse>
    implements $DemoCallToActionsResponseCopyWith<$Res> {
  _$DemoCallToActionsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = null,
  }) {
    return _then(_value.copyWith(
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<DemoCallToActionsResponseActions>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoCallToActionsResponseImplCopyWith<$Res>
    implements $DemoCallToActionsResponseCopyWith<$Res> {
  factory _$$DemoCallToActionsResponseImplCopyWith(
          _$DemoCallToActionsResponseImpl value,
          $Res Function(_$DemoCallToActionsResponseImpl) then) =
      __$$DemoCallToActionsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DemoCallToActionsResponseActions> actions});
}

/// @nodoc
class __$$DemoCallToActionsResponseImplCopyWithImpl<$Res>
    extends _$DemoCallToActionsResponseCopyWithImpl<$Res,
        _$DemoCallToActionsResponseImpl>
    implements _$$DemoCallToActionsResponseImplCopyWith<$Res> {
  __$$DemoCallToActionsResponseImplCopyWithImpl(
      _$DemoCallToActionsResponseImpl _value,
      $Res Function(_$DemoCallToActionsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = null,
  }) {
    return _then(_$DemoCallToActionsResponseImpl(
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<DemoCallToActionsResponseActions>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DemoCallToActionsResponseImpl implements _DemoCallToActionsResponse {
  _$DemoCallToActionsResponseImpl(
      {required final List<DemoCallToActionsResponseActions> actions})
      : _actions = actions;

  factory _$DemoCallToActionsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoCallToActionsResponseImplFromJson(json);

  final List<DemoCallToActionsResponseActions> _actions;
  @override
  List<DemoCallToActionsResponseActions> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  String toString() {
    return 'DemoCallToActionsResponse(actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCallToActionsResponseImpl &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_actions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCallToActionsResponseImplCopyWith<_$DemoCallToActionsResponseImpl>
      get copyWith => __$$DemoCallToActionsResponseImplCopyWithImpl<
          _$DemoCallToActionsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCallToActionsResponseImplToJson(
      this,
    );
  }
}

abstract class _DemoCallToActionsResponse implements DemoCallToActionsResponse {
  factory _DemoCallToActionsResponse(
          {required final List<DemoCallToActionsResponseActions> actions}) =
      _$DemoCallToActionsResponseImpl;

  factory _DemoCallToActionsResponse.fromJson(Map<String, dynamic> json) =
      _$DemoCallToActionsResponseImpl.fromJson;

  @override
  List<DemoCallToActionsResponseActions> get actions;
  @override
  @JsonKey(ignore: true)
  _$$DemoCallToActionsResponseImplCopyWith<_$DemoCallToActionsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DemoCallToActionsResponseActions _$DemoCallToActionsResponseActionsFromJson(
    Map<String, dynamic> json) {
  return _DemoCallToActionsResponseActions.fromJson(json);
}

/// @nodoc
mixin _$DemoCallToActionsResponseActions {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'extra_data')
  DemoCallToActionsResponseActionsExtraData get extraData =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoCallToActionsResponseActionsCopyWith<DemoCallToActionsResponseActions>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCallToActionsResponseActionsCopyWith<$Res> {
  factory $DemoCallToActionsResponseActionsCopyWith(
          DemoCallToActionsResponseActions value,
          $Res Function(DemoCallToActionsResponseActions) then) =
      _$DemoCallToActionsResponseActionsCopyWithImpl<$Res,
          DemoCallToActionsResponseActions>;
  @useResult
  $Res call(
      {String? title,
      String? description,
      String url,
      @JsonKey(name: 'extra_data')
      DemoCallToActionsResponseActionsExtraData extraData});

  $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> get extraData;
}

/// @nodoc
class _$DemoCallToActionsResponseActionsCopyWithImpl<$Res,
        $Val extends DemoCallToActionsResponseActions>
    implements $DemoCallToActionsResponseActionsCopyWith<$Res> {
  _$DemoCallToActionsResponseActionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? url = null,
    Object? extraData = null,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      extraData: null == extraData
          ? _value.extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as DemoCallToActionsResponseActionsExtraData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> get extraData {
    return $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res>(
        _value.extraData, (value) {
      return _then(_value.copyWith(extraData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DemoCallToActionsResponseActionsImplCopyWith<$Res>
    implements $DemoCallToActionsResponseActionsCopyWith<$Res> {
  factory _$$DemoCallToActionsResponseActionsImplCopyWith(
          _$DemoCallToActionsResponseActionsImpl value,
          $Res Function(_$DemoCallToActionsResponseActionsImpl) then) =
      __$$DemoCallToActionsResponseActionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? description,
      String url,
      @JsonKey(name: 'extra_data')
      DemoCallToActionsResponseActionsExtraData extraData});

  @override
  $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> get extraData;
}

/// @nodoc
class __$$DemoCallToActionsResponseActionsImplCopyWithImpl<$Res>
    extends _$DemoCallToActionsResponseActionsCopyWithImpl<$Res,
        _$DemoCallToActionsResponseActionsImpl>
    implements _$$DemoCallToActionsResponseActionsImplCopyWith<$Res> {
  __$$DemoCallToActionsResponseActionsImplCopyWithImpl(
      _$DemoCallToActionsResponseActionsImpl _value,
      $Res Function(_$DemoCallToActionsResponseActionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? url = null,
    Object? extraData = null,
  }) {
    return _then(_$DemoCallToActionsResponseActionsImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      extraData: null == extraData
          ? _value.extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as DemoCallToActionsResponseActionsExtraData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DemoCallToActionsResponseActionsImpl
    implements _DemoCallToActionsResponseActions {
  _$DemoCallToActionsResponseActionsImpl(
      {this.title,
      this.description,
      required this.url,
      @JsonKey(name: 'extra_data') required this.extraData});

  factory _$DemoCallToActionsResponseActionsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DemoCallToActionsResponseActionsImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final String url;
  @override
  @JsonKey(name: 'extra_data')
  final DemoCallToActionsResponseActionsExtraData extraData;

  @override
  String toString() {
    return 'DemoCallToActionsResponseActions(title: $title, description: $description, url: $url, extraData: $extraData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCallToActionsResponseActionsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.extraData, extraData) ||
                other.extraData == extraData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, url, extraData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCallToActionsResponseActionsImplCopyWith<
          _$DemoCallToActionsResponseActionsImpl>
      get copyWith => __$$DemoCallToActionsResponseActionsImplCopyWithImpl<
          _$DemoCallToActionsResponseActionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCallToActionsResponseActionsImplToJson(
      this,
    );
  }
}

abstract class _DemoCallToActionsResponseActions
    implements DemoCallToActionsResponseActions {
  factory _DemoCallToActionsResponseActions(
          {final String? title,
          final String? description,
          required final String url,
          @JsonKey(name: 'extra_data')
          required final DemoCallToActionsResponseActionsExtraData extraData}) =
      _$DemoCallToActionsResponseActionsImpl;

  factory _DemoCallToActionsResponseActions.fromJson(
          Map<String, dynamic> json) =
      _$DemoCallToActionsResponseActionsImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  String get url;
  @override
  @JsonKey(name: 'extra_data')
  DemoCallToActionsResponseActionsExtraData get extraData;
  @override
  @JsonKey(ignore: true)
  _$$DemoCallToActionsResponseActionsImplCopyWith<
          _$DemoCallToActionsResponseActionsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DemoCallToActionsResponseActionsExtraData
    _$DemoCallToActionsResponseActionsExtraDataFromJson(
        Map<String, dynamic> json) {
  return _DemoCallToActionsResponseActionsExtraData.fromJson(json);
}

/// @nodoc
mixin _$DemoCallToActionsResponseActionsExtraData {
  @JsonKey(name: 'api_token')
  String get apiToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_expires')
  String get tokenExpires => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoCallToActionsResponseActionsExtraDataCopyWith<
          DemoCallToActionsResponseActionsExtraData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> {
  factory $DemoCallToActionsResponseActionsExtraDataCopyWith(
          DemoCallToActionsResponseActionsExtraData value,
          $Res Function(DemoCallToActionsResponseActionsExtraData) then) =
      _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl<$Res,
          DemoCallToActionsResponseActionsExtraData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'api_token') String apiToken,
      @JsonKey(name: 'token_expires') String tokenExpires});
}

/// @nodoc
class _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl<$Res,
        $Val extends DemoCallToActionsResponseActionsExtraData>
    implements $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> {
  _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiToken = null,
    Object? tokenExpires = null,
  }) {
    return _then(_value.copyWith(
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenExpires: null == tokenExpires
          ? _value.tokenExpires
          : tokenExpires // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith<$Res>
    implements $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> {
  factory _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith(
          _$DemoCallToActionsResponseActionsExtraDataImpl value,
          $Res Function(_$DemoCallToActionsResponseActionsExtraDataImpl) then) =
      __$$DemoCallToActionsResponseActionsExtraDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'api_token') String apiToken,
      @JsonKey(name: 'token_expires') String tokenExpires});
}

/// @nodoc
class __$$DemoCallToActionsResponseActionsExtraDataImplCopyWithImpl<$Res>
    extends _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl<$Res,
        _$DemoCallToActionsResponseActionsExtraDataImpl>
    implements _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith<$Res> {
  __$$DemoCallToActionsResponseActionsExtraDataImplCopyWithImpl(
      _$DemoCallToActionsResponseActionsExtraDataImpl _value,
      $Res Function(_$DemoCallToActionsResponseActionsExtraDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiToken = null,
    Object? tokenExpires = null,
  }) {
    return _then(_$DemoCallToActionsResponseActionsExtraDataImpl(
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenExpires: null == tokenExpires
          ? _value.tokenExpires
          : tokenExpires // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DemoCallToActionsResponseActionsExtraDataImpl
    implements _DemoCallToActionsResponseActionsExtraData {
  _$DemoCallToActionsResponseActionsExtraDataImpl(
      {@JsonKey(name: 'api_token') required this.apiToken,
      @JsonKey(name: 'token_expires') required this.tokenExpires});

  factory _$DemoCallToActionsResponseActionsExtraDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DemoCallToActionsResponseActionsExtraDataImplFromJson(json);

  @override
  @JsonKey(name: 'api_token')
  final String apiToken;
  @override
  @JsonKey(name: 'token_expires')
  final String tokenExpires;

  @override
  String toString() {
    return 'DemoCallToActionsResponseActionsExtraData(apiToken: $apiToken, tokenExpires: $tokenExpires)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCallToActionsResponseActionsExtraDataImpl &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.tokenExpires, tokenExpires) ||
                other.tokenExpires == tokenExpires));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, apiToken, tokenExpires);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith<
          _$DemoCallToActionsResponseActionsExtraDataImpl>
      get copyWith =>
          __$$DemoCallToActionsResponseActionsExtraDataImplCopyWithImpl<
                  _$DemoCallToActionsResponseActionsExtraDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCallToActionsResponseActionsExtraDataImplToJson(
      this,
    );
  }
}

abstract class _DemoCallToActionsResponseActionsExtraData
    implements DemoCallToActionsResponseActionsExtraData {
  factory _DemoCallToActionsResponseActionsExtraData(
          {@JsonKey(name: 'api_token') required final String apiToken,
          @JsonKey(name: 'token_expires') required final String tokenExpires}) =
      _$DemoCallToActionsResponseActionsExtraDataImpl;

  factory _DemoCallToActionsResponseActionsExtraData.fromJson(
          Map<String, dynamic> json) =
      _$DemoCallToActionsResponseActionsExtraDataImpl.fromJson;

  @override
  @JsonKey(name: 'api_token')
  String get apiToken;
  @override
  @JsonKey(name: 'token_expires')
  String get tokenExpires;
  @override
  @JsonKey(ignore: true)
  _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith<
          _$DemoCallToActionsResponseActionsExtraDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
