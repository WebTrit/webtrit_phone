// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfo {

 UserInfoStatus? get status; Balance? get balance; Numbers get numbers; String? get email; String? get firstName; String? get lastName; String? get aliasName; String? get companyName; String? get timeZone;
/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoCopyWith<UserInfo> get copyWith => _$UserInfoCopyWithImpl<UserInfo>(this as UserInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfo&&(identical(other.status, status) || other.status == status)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.numbers, numbers) || other.numbers == numbers)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.aliasName, aliasName) || other.aliasName == aliasName)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,balance,numbers,email,firstName,lastName,aliasName,companyName,timeZone);

@override
String toString() {
  return 'UserInfo(status: $status, balance: $balance, numbers: $numbers, email: $email, firstName: $firstName, lastName: $lastName, aliasName: $aliasName, companyName: $companyName, timeZone: $timeZone)';
}


}

/// @nodoc
abstract mixin class $UserInfoCopyWith<$Res>  {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) _then) = _$UserInfoCopyWithImpl;
@useResult
$Res call({
 UserInfoStatus? status, Balance? balance, Numbers numbers, String? email, String? firstName, String? lastName, String? aliasName, String? companyName, String? timeZone
});




}
/// @nodoc
class _$UserInfoCopyWithImpl<$Res>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._self, this._then);

  final UserInfo _self;
  final $Res Function(UserInfo) _then;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? balance = freezed,Object? numbers = null,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? aliasName = freezed,Object? companyName = freezed,Object? timeZone = freezed,}) {
  return _then(UserInfo(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserInfoStatus?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Balance?,numbers: null == numbers ? _self.numbers : numbers // ignore: cast_nullable_to_non_nullable
as Numbers,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,aliasName: freezed == aliasName ? _self.aliasName : aliasName // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,timeZone: freezed == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfo].
extension UserInfoPatterns on UserInfo {
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
