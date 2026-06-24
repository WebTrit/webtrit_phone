// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 AppLifecycleStatus get status; AppLogoutReason? get logoutReason; Session get session; ThemeMode get themeMode; Locale get locale; AgreementStatus get userAgreementStatus; AgreementStatus get contactsAgreementStatus; AppCompatibility get appCompatibility;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.status, status) || other.status == status)&&(identical(other.logoutReason, logoutReason) || other.logoutReason == logoutReason)&&(identical(other.session, session) || other.session == session)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.userAgreementStatus, userAgreementStatus) || other.userAgreementStatus == userAgreementStatus)&&(identical(other.contactsAgreementStatus, contactsAgreementStatus) || other.contactsAgreementStatus == contactsAgreementStatus)&&(identical(other.appCompatibility, appCompatibility) || other.appCompatibility == appCompatibility));
}


@override
int get hashCode => Object.hash(runtimeType,status,logoutReason,session,themeMode,locale,userAgreementStatus,contactsAgreementStatus,appCompatibility);

@override
String toString() {
  return 'AppState(status: $status, logoutReason: $logoutReason, session: $session, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus, appCompatibility: $appCompatibility)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 AppLifecycleStatus status, AppLogoutReason? logoutReason, Session session, ThemeMode themeMode, Locale locale, AgreementStatus userAgreementStatus, AgreementStatus contactsAgreementStatus, AppCompatibility appCompatibility
});


$SessionCopyWith<$Res> get session;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? logoutReason = freezed,Object? session = null,Object? themeMode = null,Object? locale = null,Object? userAgreementStatus = null,Object? contactsAgreementStatus = null,Object? appCompatibility = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppLifecycleStatus,logoutReason: freezed == logoutReason ? _self.logoutReason : logoutReason // ignore: cast_nullable_to_non_nullable
as AppLogoutReason?,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,userAgreementStatus: null == userAgreementStatus ? _self.userAgreementStatus : userAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,contactsAgreementStatus: null == contactsAgreementStatus ? _self.contactsAgreementStatus : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,appCompatibility: null == appCompatibility ? _self.appCompatibility : appCompatibility // ignore: cast_nullable_to_non_nullable
as AppCompatibility,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLifecycleStatus status,  AppLogoutReason? logoutReason,  Session session,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus,  AppCompatibility appCompatibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.status,_that.logoutReason,_that.session,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus,_that.appCompatibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLifecycleStatus status,  AppLogoutReason? logoutReason,  Session session,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus,  AppCompatibility appCompatibility)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.status,_that.logoutReason,_that.session,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus,_that.appCompatibility);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLifecycleStatus status,  AppLogoutReason? logoutReason,  Session session,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus,  AppCompatibility appCompatibility)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.status,_that.logoutReason,_that.session,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus,_that.appCompatibility);case _:
  return null;

}
}

}

/// @nodoc


class _AppState extends AppState {
  const _AppState({this.status = AppLifecycleStatus.unauthenticated, this.logoutReason = null, this.session = const Session(), required this.themeMode, required this.locale, required this.userAgreementStatus, required this.contactsAgreementStatus, this.appCompatibility = const AppCompatible()}): super._();
  

@override@JsonKey() final  AppLifecycleStatus status;
@override@JsonKey() final  AppLogoutReason? logoutReason;
@override@JsonKey() final  Session session;
@override final  ThemeMode themeMode;
@override final  Locale locale;
@override final  AgreementStatus userAgreementStatus;
@override final  AgreementStatus contactsAgreementStatus;
@override@JsonKey() final  AppCompatibility appCompatibility;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.status, status) || other.status == status)&&(identical(other.logoutReason, logoutReason) || other.logoutReason == logoutReason)&&(identical(other.session, session) || other.session == session)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.userAgreementStatus, userAgreementStatus) || other.userAgreementStatus == userAgreementStatus)&&(identical(other.contactsAgreementStatus, contactsAgreementStatus) || other.contactsAgreementStatus == contactsAgreementStatus)&&(identical(other.appCompatibility, appCompatibility) || other.appCompatibility == appCompatibility));
}


@override
int get hashCode => Object.hash(runtimeType,status,logoutReason,session,themeMode,locale,userAgreementStatus,contactsAgreementStatus,appCompatibility);

@override
String toString() {
  return 'AppState(status: $status, logoutReason: $logoutReason, session: $session, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus, appCompatibility: $appCompatibility)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 AppLifecycleStatus status, AppLogoutReason? logoutReason, Session session, ThemeMode themeMode, Locale locale, AgreementStatus userAgreementStatus, AgreementStatus contactsAgreementStatus, AppCompatibility appCompatibility
});


@override $SessionCopyWith<$Res> get session;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? logoutReason = freezed,Object? session = null,Object? themeMode = null,Object? locale = null,Object? userAgreementStatus = null,Object? contactsAgreementStatus = null,Object? appCompatibility = null,}) {
  return _then(_AppState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppLifecycleStatus,logoutReason: freezed == logoutReason ? _self.logoutReason : logoutReason // ignore: cast_nullable_to_non_nullable
as AppLogoutReason?,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,userAgreementStatus: null == userAgreementStatus ? _self.userAgreementStatus : userAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,contactsAgreementStatus: null == contactsAgreementStatus ? _self.contactsAgreementStatus : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,appCompatibility: null == appCompatibility ? _self.appCompatibility : appCompatibility // ignore: cast_nullable_to_non_nullable
as AppCompatibility,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
