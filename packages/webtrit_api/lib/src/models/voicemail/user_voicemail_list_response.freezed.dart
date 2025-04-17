// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_voicemail_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserVoicemailListResponse _$UserVoicemailListResponseFromJson(
    Map<String, dynamic> json) {
  return _UserVoicemailListResponse.fromJson(json);
}

/// @nodoc
mixin _$UserVoicemailListResponse {
  @JsonKey(name: 'has_new_messages')
  bool get hasNewMessages => throw _privateConstructorUsedError;
  List<UserVoicemailItem> get items => throw _privateConstructorUsedError;

  /// Serializes this UserVoicemailListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoicemailListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoicemailListResponseCopyWith<UserVoicemailListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVoicemailListResponseCopyWith<$Res> {
  factory $UserVoicemailListResponseCopyWith(UserVoicemailListResponse value,
          $Res Function(UserVoicemailListResponse) then) =
      _$UserVoicemailListResponseCopyWithImpl<$Res, UserVoicemailListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'has_new_messages') bool hasNewMessages,
      List<UserVoicemailItem> items});
}

/// @nodoc
class _$UserVoicemailListResponseCopyWithImpl<$Res,
        $Val extends UserVoicemailListResponse>
    implements $UserVoicemailListResponseCopyWith<$Res> {
  _$UserVoicemailListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVoicemailListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasNewMessages = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      hasNewMessages: null == hasNewMessages
          ? _value.hasNewMessages
          : hasNewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserVoicemailItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVoicemailListResponseImplCopyWith<$Res>
    implements $UserVoicemailListResponseCopyWith<$Res> {
  factory _$$UserVoicemailListResponseImplCopyWith(
          _$UserVoicemailListResponseImpl value,
          $Res Function(_$UserVoicemailListResponseImpl) then) =
      __$$UserVoicemailListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'has_new_messages') bool hasNewMessages,
      List<UserVoicemailItem> items});
}

/// @nodoc
class __$$UserVoicemailListResponseImplCopyWithImpl<$Res>
    extends _$UserVoicemailListResponseCopyWithImpl<$Res,
        _$UserVoicemailListResponseImpl>
    implements _$$UserVoicemailListResponseImplCopyWith<$Res> {
  __$$UserVoicemailListResponseImplCopyWithImpl(
      _$UserVoicemailListResponseImpl _value,
      $Res Function(_$UserVoicemailListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVoicemailListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasNewMessages = null,
    Object? items = null,
  }) {
    return _then(_$UserVoicemailListResponseImpl(
      hasNewMessages: null == hasNewMessages
          ? _value.hasNewMessages
          : hasNewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserVoicemailItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoicemailListResponseImpl implements _UserVoicemailListResponse {
  const _$UserVoicemailListResponseImpl(
      {@JsonKey(name: 'has_new_messages') required this.hasNewMessages,
      required final List<UserVoicemailItem> items})
      : _items = items;

  factory _$UserVoicemailListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoicemailListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'has_new_messages')
  final bool hasNewMessages;
  final List<UserVoicemailItem> _items;
  @override
  List<UserVoicemailItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'UserVoicemailListResponse(hasNewMessages: $hasNewMessages, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoicemailListResponseImpl &&
            (identical(other.hasNewMessages, hasNewMessages) ||
                other.hasNewMessages == hasNewMessages) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, hasNewMessages, const DeepCollectionEquality().hash(_items));

  /// Create a copy of UserVoicemailListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoicemailListResponseImplCopyWith<_$UserVoicemailListResponseImpl>
      get copyWith => __$$UserVoicemailListResponseImplCopyWithImpl<
          _$UserVoicemailListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoicemailListResponseImplToJson(
      this,
    );
  }
}

abstract class _UserVoicemailListResponse implements UserVoicemailListResponse {
  const factory _UserVoicemailListResponse(
      {@JsonKey(name: 'has_new_messages') required final bool hasNewMessages,
      required final List<UserVoicemailItem>
          items}) = _$UserVoicemailListResponseImpl;

  factory _UserVoicemailListResponse.fromJson(Map<String, dynamic> json) =
      _$UserVoicemailListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'has_new_messages')
  bool get hasNewMessages;
  @override
  List<UserVoicemailItem> get items;

  /// Create a copy of UserVoicemailListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoicemailListResponseImplCopyWith<_$UserVoicemailListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserVoicemailItem _$UserVoicemailItemFromJson(Map<String, dynamic> json) {
  return _UserVoicemailItem.fromJson(json);
}

/// @nodoc
mixin _$UserVoicemailItem {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this UserVoicemailItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoicemailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoicemailItemCopyWith<UserVoicemailItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVoicemailItemCopyWith<$Res> {
  factory $UserVoicemailItemCopyWith(
          UserVoicemailItem value, $Res Function(UserVoicemailItem) then) =
      _$UserVoicemailItemCopyWithImpl<$Res, UserVoicemailItem>;
  @useResult
  $Res call(
      {String id,
      String date,
      double duration,
      bool seen,
      int size,
      String type});
}

/// @nodoc
class _$UserVoicemailItemCopyWithImpl<$Res, $Val extends UserVoicemailItem>
    implements $UserVoicemailItemCopyWith<$Res> {
  _$UserVoicemailItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVoicemailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? duration = null,
    Object? seen = null,
    Object? size = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVoicemailItemImplCopyWith<$Res>
    implements $UserVoicemailItemCopyWith<$Res> {
  factory _$$UserVoicemailItemImplCopyWith(_$UserVoicemailItemImpl value,
          $Res Function(_$UserVoicemailItemImpl) then) =
      __$$UserVoicemailItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String date,
      double duration,
      bool seen,
      int size,
      String type});
}

/// @nodoc
class __$$UserVoicemailItemImplCopyWithImpl<$Res>
    extends _$UserVoicemailItemCopyWithImpl<$Res, _$UserVoicemailItemImpl>
    implements _$$UserVoicemailItemImplCopyWith<$Res> {
  __$$UserVoicemailItemImplCopyWithImpl(_$UserVoicemailItemImpl _value,
      $Res Function(_$UserVoicemailItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVoicemailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? duration = null,
    Object? seen = null,
    Object? size = null,
    Object? type = null,
  }) {
    return _then(_$UserVoicemailItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoicemailItemImpl implements _UserVoicemailItem {
  const _$UserVoicemailItemImpl(
      {required this.id,
      required this.date,
      required this.duration,
      required this.seen,
      required this.size,
      required this.type});

  factory _$UserVoicemailItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoicemailItemImplFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final double duration;
  @override
  final bool seen;
  @override
  final int size;
  @override
  final String type;

  @override
  String toString() {
    return 'UserVoicemailItem(id: $id, date: $date, duration: $duration, seen: $seen, size: $size, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoicemailItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, duration, seen, size, type);

  /// Create a copy of UserVoicemailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoicemailItemImplCopyWith<_$UserVoicemailItemImpl> get copyWith =>
      __$$UserVoicemailItemImplCopyWithImpl<_$UserVoicemailItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoicemailItemImplToJson(
      this,
    );
  }
}

abstract class _UserVoicemailItem implements UserVoicemailItem {
  const factory _UserVoicemailItem(
      {required final String id,
      required final String date,
      required final double duration,
      required final bool seen,
      required final int size,
      required final String type}) = _$UserVoicemailItemImpl;

  factory _UserVoicemailItem.fromJson(Map<String, dynamic> json) =
      _$UserVoicemailItemImpl.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  double get duration;
  @override
  bool get seen;
  @override
  int get size;
  @override
  String get type;

  /// Create a copy of UserVoicemailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoicemailItemImplCopyWith<_$UserVoicemailItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
