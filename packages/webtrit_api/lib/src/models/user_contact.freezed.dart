// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserContact {

 String? get userId; SipStatus? get sipStatus; Numbers get numbers; String? get email; String? get firstName; String? get lastName; String? get aliasName; String? get companyName; bool? get isCurrentUser; bool? get isRegisteredUser;
/// Create a copy of UserContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserContactCopyWith<UserContact> get copyWith => _$UserContactCopyWithImpl<UserContact>(this as UserContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserContact&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.sipStatus, sipStatus) || other.sipStatus == sipStatus)&&(identical(other.numbers, numbers) || other.numbers == numbers)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.aliasName, aliasName) || other.aliasName == aliasName)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.isCurrentUser, isCurrentUser) || other.isCurrentUser == isCurrentUser)&&(identical(other.isRegisteredUser, isRegisteredUser) || other.isRegisteredUser == isRegisteredUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,sipStatus,numbers,email,firstName,lastName,aliasName,companyName,isCurrentUser,isRegisteredUser);

@override
String toString() {
  return 'UserContact(userId: $userId, sipStatus: $sipStatus, numbers: $numbers, email: $email, firstName: $firstName, lastName: $lastName, aliasName: $aliasName, companyName: $companyName, isCurrentUser: $isCurrentUser, isRegisteredUser: $isRegisteredUser)';
}


}

/// @nodoc
abstract mixin class $UserContactCopyWith<$Res>  {
  factory $UserContactCopyWith(UserContact value, $Res Function(UserContact) _then) = _$UserContactCopyWithImpl;
@useResult
$Res call({
 String? userId, SipStatus? sipStatus, Numbers numbers, String? email, String? firstName, String? lastName, String? aliasName, String? companyName, bool? isCurrentUser, bool? isRegisteredUser
});




}
/// @nodoc
class _$UserContactCopyWithImpl<$Res>
    implements $UserContactCopyWith<$Res> {
  _$UserContactCopyWithImpl(this._self, this._then);

  final UserContact _self;
  final $Res Function(UserContact) _then;

/// Create a copy of UserContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? sipStatus = freezed,Object? numbers = null,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? aliasName = freezed,Object? companyName = freezed,Object? isCurrentUser = freezed,Object? isRegisteredUser = freezed,}) {
  return _then(UserContact(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,sipStatus: freezed == sipStatus ? _self.sipStatus : sipStatus // ignore: cast_nullable_to_non_nullable
as SipStatus?,numbers: null == numbers ? _self.numbers : numbers // ignore: cast_nullable_to_non_nullable
as Numbers,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,aliasName: freezed == aliasName ? _self.aliasName : aliasName // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentUser: freezed == isCurrentUser ? _self.isCurrentUser : isCurrentUser // ignore: cast_nullable_to_non_nullable
as bool?,isRegisteredUser: freezed == isRegisteredUser ? _self.isRegisteredUser : isRegisteredUser // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserContact].
extension UserContactPatterns on UserContact {
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
