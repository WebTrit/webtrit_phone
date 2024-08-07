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
  set actions(List<DemoCallToActionsResponseActions> value) =>
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
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<DemoCallToActionsResponseActions>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DemoCallToActionsResponseImpl implements _DemoCallToActionsResponse {
  _$DemoCallToActionsResponseImpl({required this.actions});

  factory _$DemoCallToActionsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoCallToActionsResponseImplFromJson(json);

  @override
  List<DemoCallToActionsResponseActions> actions;

  @override
  String toString() {
    return 'DemoCallToActionsResponse(actions: $actions)';
  }

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
          {required List<DemoCallToActionsResponseActions> actions}) =
      _$DemoCallToActionsResponseImpl;

  factory _DemoCallToActionsResponse.fromJson(Map<String, dynamic> json) =
      _$DemoCallToActionsResponseImpl.fromJson;

  @override
  List<DemoCallToActionsResponseActions> get actions;
  set actions(List<DemoCallToActionsResponseActions> value);
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
  @JsonKey(name: 'extra_data')
  DemoCallToActionsResponseActionsExtraData get extraData =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'extra_data')
  set extraData(DemoCallToActionsResponseActionsExtraData value) =>
      throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  set title(String? value) => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  set description(String? value) => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  set url(String value) => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'extra_data')
      DemoCallToActionsResponseActionsExtraData extraData,
      String? title,
      String? description,
      String url});

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
    Object? extraData = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      extraData: null == extraData
          ? _value.extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as DemoCallToActionsResponseActionsExtraData,
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
      {@JsonKey(name: 'extra_data')
      DemoCallToActionsResponseActionsExtraData extraData,
      String? title,
      String? description,
      String url});

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
    Object? extraData = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = null,
  }) {
    return _then(_$DemoCallToActionsResponseActionsImpl(
      extraData: null == extraData
          ? _value.extraData
          : extraData // ignore: cast_nullable_to_non_nullable
              as DemoCallToActionsResponseActionsExtraData,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DemoCallToActionsResponseActionsImpl
    implements _DemoCallToActionsResponseActions {
  _$DemoCallToActionsResponseActionsImpl(
      {@JsonKey(name: 'extra_data') required this.extraData,
      this.title,
      this.description,
      required this.url});

  factory _$DemoCallToActionsResponseActionsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DemoCallToActionsResponseActionsImplFromJson(json);

  @override
  @JsonKey(name: 'extra_data')
  DemoCallToActionsResponseActionsExtraData extraData;
  @override
  String? title;
  @override
  String? description;
  @override
  String url;

  @override
  String toString() {
    return 'DemoCallToActionsResponseActions(extraData: $extraData, title: $title, description: $description, url: $url)';
  }

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
      {@JsonKey(name: 'extra_data')
      required DemoCallToActionsResponseActionsExtraData extraData,
      String? title,
      String? description,
      required String url}) = _$DemoCallToActionsResponseActionsImpl;

  factory _DemoCallToActionsResponseActions.fromJson(
          Map<String, dynamic> json) =
      _$DemoCallToActionsResponseActionsImpl.fromJson;

  @override
  @JsonKey(name: 'extra_data')
  DemoCallToActionsResponseActionsExtraData get extraData;
  @JsonKey(name: 'extra_data')
  set extraData(DemoCallToActionsResponseActionsExtraData value);
  @override
  String? get title;
  set title(String? value);
  @override
  String? get description;
  set description(String? value);
  @override
  String get url;
  set url(String value);
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
  @JsonKey(name: 'api_token')
  set apiToken(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_expires')
  String get tokenExpires => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_expires')
  set tokenExpires(String value) => throw _privateConstructorUsedError;

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
@JsonSerializable()
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
  String apiToken;
  @override
  @JsonKey(name: 'token_expires')
  String tokenExpires;

  @override
  String toString() {
    return 'DemoCallToActionsResponseActionsExtraData(apiToken: $apiToken, tokenExpires: $tokenExpires)';
  }

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
          {@JsonKey(name: 'api_token') required String apiToken,
          @JsonKey(name: 'token_expires') required String tokenExpires}) =
      _$DemoCallToActionsResponseActionsExtraDataImpl;

  factory _DemoCallToActionsResponseActionsExtraData.fromJson(
          Map<String, dynamic> json) =
      _$DemoCallToActionsResponseActionsExtraDataImpl.fromJson;

  @override
  @JsonKey(name: 'api_token')
  String get apiToken;
  @JsonKey(name: 'api_token')
  set apiToken(String value);
  @override
  @JsonKey(name: 'token_expires')
  String get tokenExpires;
  @JsonKey(name: 'token_expires')
  set tokenExpires(String value);
  @override
  @JsonKey(ignore: true)
  _$$DemoCallToActionsResponseActionsExtraDataImplCopyWith<
          _$DemoCallToActionsResponseActionsExtraDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
