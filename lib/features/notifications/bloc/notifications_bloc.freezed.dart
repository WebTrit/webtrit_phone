// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationsIssued {
  Notification get notification => throw _privateConstructorUsedError;
}

/// @nodoc

class _$NotificationsIssuedImpl implements _NotificationsIssued {
  const _$NotificationsIssuedImpl(this.notification);

  @override
  final Notification notification;

  @override
  String toString() {
    return 'NotificationsIssued(notification: $notification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsIssuedImpl &&
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notification);
}

abstract class _NotificationsIssued implements NotificationsIssued {
  const factory _NotificationsIssued(final Notification notification) =
      _$NotificationsIssuedImpl;

  @override
  Notification get notification;
}

/// @nodoc
mixin _$NotificationsCleared {}

/// @nodoc

class _$NotificationsClearedImpl implements _NotificationsCleared {
  const _$NotificationsClearedImpl();

  @override
  String toString() {
    return 'NotificationsCleared()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsClearedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _NotificationsCleared implements NotificationsCleared {
  const factory _NotificationsCleared() = _$NotificationsClearedImpl;
}

/// @nodoc
mixin _$NotificationsState {
  Notification? get lastNotification => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationsStateCopyWith<NotificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsStateCopyWith<$Res> {
  factory $NotificationsStateCopyWith(
          NotificationsState value, $Res Function(NotificationsState) then) =
      _$NotificationsStateCopyWithImpl<$Res, NotificationsState>;
  @useResult
  $Res call({Notification? lastNotification});
}

/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res, $Val extends NotificationsState>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastNotification = freezed,
  }) {
    return _then(_value.copyWith(
      lastNotification: freezed == lastNotification
          ? _value.lastNotification
          : lastNotification // ignore: cast_nullable_to_non_nullable
              as Notification?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsStateImplCopyWith<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  factory _$$NotificationsStateImplCopyWith(_$NotificationsStateImpl value,
          $Res Function(_$NotificationsStateImpl) then) =
      __$$NotificationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Notification? lastNotification});
}

/// @nodoc
class __$$NotificationsStateImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsStateImpl>
    implements _$$NotificationsStateImplCopyWith<$Res> {
  __$$NotificationsStateImplCopyWithImpl(_$NotificationsStateImpl _value,
      $Res Function(_$NotificationsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastNotification = freezed,
  }) {
    return _then(_$NotificationsStateImpl(
      freezed == lastNotification
          ? _value.lastNotification
          : lastNotification // ignore: cast_nullable_to_non_nullable
              as Notification?,
    ));
  }
}

/// @nodoc

class _$NotificationsStateImpl implements _NotificationsState {
  const _$NotificationsStateImpl([this.lastNotification]);

  @override
  final Notification? lastNotification;

  @override
  String toString() {
    return 'NotificationsState(lastNotification: $lastNotification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsStateImpl &&
            (identical(other.lastNotification, lastNotification) ||
                other.lastNotification == lastNotification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastNotification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      __$$NotificationsStateImplCopyWithImpl<_$NotificationsStateImpl>(
          this, _$identity);
}

abstract class _NotificationsState implements NotificationsState {
  const factory _NotificationsState([final Notification? lastNotification]) =
      _$NotificationsStateImpl;

  @override
  Notification? get lastNotification;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
