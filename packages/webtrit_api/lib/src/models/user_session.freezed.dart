// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSession {

 String get id; bool get current; UserSessionStatus get status; String? get userAgent; String? get ip; String? get location; String? get lastActivityIp; String? get lastActivityLocation; AppType? get appType; String? get appIdentifier; String? get appBundleId; DateTime? get createdAt; DateTime? get lastActivityAt;
/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSessionCopyWith<UserSession> get copyWith => _$UserSessionCopyWithImpl<UserSession>(this as UserSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSession&&(identical(other.id, id) || other.id == id)&&(identical(other.current, current) || other.current == current)&&(identical(other.status, status) || other.status == status)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.location, location) || other.location == location)&&(identical(other.lastActivityIp, lastActivityIp) || other.lastActivityIp == lastActivityIp)&&(identical(other.lastActivityLocation, lastActivityLocation) || other.lastActivityLocation == lastActivityLocation)&&(identical(other.appType, appType) || other.appType == appType)&&(identical(other.appIdentifier, appIdentifier) || other.appIdentifier == appIdentifier)&&(identical(other.appBundleId, appBundleId) || other.appBundleId == appBundleId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,current,status,userAgent,ip,location,lastActivityIp,lastActivityLocation,appType,appIdentifier,appBundleId,createdAt,lastActivityAt);

@override
String toString() {
  return 'UserSession(id: $id, current: $current, status: $status, userAgent: $userAgent, ip: $ip, location: $location, lastActivityIp: $lastActivityIp, lastActivityLocation: $lastActivityLocation, appType: $appType, appIdentifier: $appIdentifier, appBundleId: $appBundleId, createdAt: $createdAt, lastActivityAt: $lastActivityAt)';
}


}

/// @nodoc
abstract mixin class $UserSessionCopyWith<$Res>  {
  factory $UserSessionCopyWith(UserSession value, $Res Function(UserSession) _then) = _$UserSessionCopyWithImpl;
@useResult
$Res call({
 String id, bool current, UserSessionStatus status, String? userAgent, String? ip, String? location, String? lastActivityIp, String? lastActivityLocation, AppType? appType, String? appIdentifier, String? appBundleId, DateTime? createdAt, DateTime? lastActivityAt
});




}
/// @nodoc
class _$UserSessionCopyWithImpl<$Res>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._self, this._then);

  final UserSession _self;
  final $Res Function(UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? current = null,Object? status = null,Object? userAgent = freezed,Object? ip = freezed,Object? location = freezed,Object? lastActivityIp = freezed,Object? lastActivityLocation = freezed,Object? appType = freezed,Object? appIdentifier = freezed,Object? appBundleId = freezed,Object? createdAt = freezed,Object? lastActivityAt = freezed,}) {
  return _then(UserSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserSessionStatus,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,lastActivityIp: freezed == lastActivityIp ? _self.lastActivityIp : lastActivityIp // ignore: cast_nullable_to_non_nullable
as String?,lastActivityLocation: freezed == lastActivityLocation ? _self.lastActivityLocation : lastActivityLocation // ignore: cast_nullable_to_non_nullable
as String?,appType: freezed == appType ? _self.appType : appType // ignore: cast_nullable_to_non_nullable
as AppType?,appIdentifier: freezed == appIdentifier ? _self.appIdentifier : appIdentifier // ignore: cast_nullable_to_non_nullable
as String?,appBundleId: freezed == appBundleId ? _self.appBundleId : appBundleId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActivityAt: freezed == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSession].
extension UserSessionPatterns on UserSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
