// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SystemNotification _$SystemNotificationFromJson(Map<String, dynamic> json) {
  return _SystemNotification.fromJson(json);
}

/// @nodoc
mixin _$SystemNotification {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;

  /// Serializes this SystemNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemNotificationCopyWith<SystemNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemNotificationCopyWith<$Res> {
  factory $SystemNotificationCopyWith(
          SystemNotification value, $Res Function(SystemNotification) then) =
      _$SystemNotificationCopyWithImpl<$Res, SystemNotification>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      bool seen,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? readAt});
}

/// @nodoc
class _$SystemNotificationCopyWithImpl<$Res, $Val extends SystemNotification>
    implements $SystemNotificationCopyWith<$Res> {
  _$SystemNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? seen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? readAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SystemNotificationImplCopyWith<$Res>
    implements $SystemNotificationCopyWith<$Res> {
  factory _$$SystemNotificationImplCopyWith(_$SystemNotificationImpl value,
          $Res Function(_$SystemNotificationImpl) then) =
      __$$SystemNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      bool seen,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? readAt});
}

/// @nodoc
class __$$SystemNotificationImplCopyWithImpl<$Res>
    extends _$SystemNotificationCopyWithImpl<$Res, _$SystemNotificationImpl>
    implements _$$SystemNotificationImplCopyWith<$Res> {
  __$$SystemNotificationImplCopyWithImpl(_$SystemNotificationImpl _value,
      $Res Function(_$SystemNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of SystemNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? seen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? readAt = freezed,
  }) {
    return _then(_$SystemNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SystemNotificationImpl implements _SystemNotification {
  const _$SystemNotificationImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.seen,
      required this.createdAt,
      required this.updatedAt,
      this.readAt});

  factory _$SystemNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemNotificationImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final bool seen;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? readAt;

  @override
  String toString() {
    return 'SystemNotification(id: $id, title: $title, content: $content, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, content, seen, createdAt, updatedAt, readAt);

  /// Create a copy of SystemNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemNotificationImplCopyWith<_$SystemNotificationImpl> get copyWith =>
      __$$SystemNotificationImplCopyWithImpl<_$SystemNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemNotificationImplToJson(
      this,
    );
  }
}

abstract class _SystemNotification implements SystemNotification {
  const factory _SystemNotification(
      {required final int id,
      required final String title,
      required final String content,
      required final bool seen,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? readAt}) = _$SystemNotificationImpl;

  factory _SystemNotification.fromJson(Map<String, dynamic> json) =
      _$SystemNotificationImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  bool get seen;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get readAt;

  /// Create a copy of SystemNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemNotificationImplCopyWith<_$SystemNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SystemNotificationResponce _$SystemNotificationResponceFromJson(
    Map<String, dynamic> json) {
  return _SystemNotificationResponce.fromJson(json);
}

/// @nodoc
mixin _$SystemNotificationResponce {
  List<SystemNotification> get notifications =>
      throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this SystemNotificationResponce to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemNotificationResponce
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemNotificationResponceCopyWith<SystemNotificationResponce>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemNotificationResponceCopyWith<$Res> {
  factory $SystemNotificationResponceCopyWith(SystemNotificationResponce value,
          $Res Function(SystemNotificationResponce) then) =
      _$SystemNotificationResponceCopyWithImpl<$Res,
          SystemNotificationResponce>;
  @useResult
  $Res call({List<SystemNotification> notifications, int total});
}

/// @nodoc
class _$SystemNotificationResponceCopyWithImpl<$Res,
        $Val extends SystemNotificationResponce>
    implements $SystemNotificationResponceCopyWith<$Res> {
  _$SystemNotificationResponceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemNotificationResponce
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<SystemNotification>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SystemNotificationResponceImplCopyWith<$Res>
    implements $SystemNotificationResponceCopyWith<$Res> {
  factory _$$SystemNotificationResponceImplCopyWith(
          _$SystemNotificationResponceImpl value,
          $Res Function(_$SystemNotificationResponceImpl) then) =
      __$$SystemNotificationResponceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SystemNotification> notifications, int total});
}

/// @nodoc
class __$$SystemNotificationResponceImplCopyWithImpl<$Res>
    extends _$SystemNotificationResponceCopyWithImpl<$Res,
        _$SystemNotificationResponceImpl>
    implements _$$SystemNotificationResponceImplCopyWith<$Res> {
  __$$SystemNotificationResponceImplCopyWithImpl(
      _$SystemNotificationResponceImpl _value,
      $Res Function(_$SystemNotificationResponceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SystemNotificationResponce
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? total = null,
  }) {
    return _then(_$SystemNotificationResponceImpl(
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<SystemNotification>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SystemNotificationResponceImpl implements _SystemNotificationResponce {
  const _$SystemNotificationResponceImpl(
      {required final List<SystemNotification> notifications,
      required this.total})
      : _notifications = notifications;

  factory _$SystemNotificationResponceImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SystemNotificationResponceImplFromJson(json);

  final List<SystemNotification> _notifications;
  @override
  List<SystemNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  final int total;

  @override
  String toString() {
    return 'SystemNotificationResponce(notifications: $notifications, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemNotificationResponceImpl &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_notifications), total);

  /// Create a copy of SystemNotificationResponce
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemNotificationResponceImplCopyWith<_$SystemNotificationResponceImpl>
      get copyWith => __$$SystemNotificationResponceImplCopyWithImpl<
          _$SystemNotificationResponceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemNotificationResponceImplToJson(
      this,
    );
  }
}

abstract class _SystemNotificationResponce
    implements SystemNotificationResponce {
  const factory _SystemNotificationResponce(
      {required final List<SystemNotification> notifications,
      required final int total}) = _$SystemNotificationResponceImpl;

  factory _SystemNotificationResponce.fromJson(Map<String, dynamic> json) =
      _$SystemNotificationResponceImpl.fromJson;

  @override
  List<SystemNotification> get notifications;
  @override
  int get total;

  /// Create a copy of SystemNotificationResponce
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemNotificationResponceImplCopyWith<_$SystemNotificationResponceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
