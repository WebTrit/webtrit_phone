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

 AppLifecycleStatus get status; Session get session; ThemeSettings get themeSettings; ThemeMode get themeMode; Locale get locale; AgreementStatus get userAgreementStatus; AgreementStatus get contactsAgreementStatus;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.status, status) || other.status == status)&&(identical(other.session, session) || other.session == session)&&(identical(other.themeSettings, themeSettings) || other.themeSettings == themeSettings)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.userAgreementStatus, userAgreementStatus) || other.userAgreementStatus == userAgreementStatus)&&(identical(other.contactsAgreementStatus, contactsAgreementStatus) || other.contactsAgreementStatus == contactsAgreementStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,session,themeSettings,themeMode,locale,userAgreementStatus,contactsAgreementStatus);

@override
String toString() {
  return 'AppState(status: $status, session: $session, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 AppLifecycleStatus status, Session session, ThemeSettings themeSettings, ThemeMode themeMode, Locale locale, AgreementStatus userAgreementStatus, AgreementStatus contactsAgreementStatus
});


$SessionCopyWith<$Res> get session;$ThemeSettingsCopyWith<$Res> get themeSettings;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? session = null,Object? themeSettings = null,Object? themeMode = null,Object? locale = null,Object? userAgreementStatus = null,Object? contactsAgreementStatus = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppLifecycleStatus,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,themeSettings: null == themeSettings ? _self.themeSettings : themeSettings // ignore: cast_nullable_to_non_nullable
as ThemeSettings,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,userAgreementStatus: null == userAgreementStatus ? _self.userAgreementStatus : userAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,contactsAgreementStatus: null == contactsAgreementStatus ? _self.contactsAgreementStatus : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,
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
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeSettingsCopyWith<$Res> get themeSettings {
  
  return $ThemeSettingsCopyWith<$Res>(_self.themeSettings, (value) {
    return _then(_self.copyWith(themeSettings: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLifecycleStatus status,  Session session,  ThemeSettings themeSettings,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.status,_that.session,_that.themeSettings,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLifecycleStatus status,  Session session,  ThemeSettings themeSettings,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.status,_that.session,_that.themeSettings,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLifecycleStatus status,  Session session,  ThemeSettings themeSettings,  ThemeMode themeMode,  Locale locale,  AgreementStatus userAgreementStatus,  AgreementStatus contactsAgreementStatus)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.status,_that.session,_that.themeSettings,_that.themeMode,_that.locale,_that.userAgreementStatus,_that.contactsAgreementStatus);case _:
  return null;

}
}

}

/// @nodoc


class _AppState extends AppState {
  const _AppState({this.status = AppLifecycleStatus.unauthenticated, this.session = const Session(), required this.themeSettings, required this.themeMode, required this.locale, required this.userAgreementStatus, required this.contactsAgreementStatus}): super._();
  

@override@JsonKey() final  AppLifecycleStatus status;
@override@JsonKey() final  Session session;
@override final  ThemeSettings themeSettings;
@override final  ThemeMode themeMode;
@override final  Locale locale;
@override final  AgreementStatus userAgreementStatus;
@override final  AgreementStatus contactsAgreementStatus;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.status, status) || other.status == status)&&(identical(other.session, session) || other.session == session)&&(identical(other.themeSettings, themeSettings) || other.themeSettings == themeSettings)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.userAgreementStatus, userAgreementStatus) || other.userAgreementStatus == userAgreementStatus)&&(identical(other.contactsAgreementStatus, contactsAgreementStatus) || other.contactsAgreementStatus == contactsAgreementStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,session,themeSettings,themeMode,locale,userAgreementStatus,contactsAgreementStatus);

@override
String toString() {
  return 'AppState(status: $status, session: $session, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 AppLifecycleStatus status, Session session, ThemeSettings themeSettings, ThemeMode themeMode, Locale locale, AgreementStatus userAgreementStatus, AgreementStatus contactsAgreementStatus
});


@override $SessionCopyWith<$Res> get session;@override $ThemeSettingsCopyWith<$Res> get themeSettings;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? session = null,Object? themeSettings = null,Object? themeMode = null,Object? locale = null,Object? userAgreementStatus = null,Object? contactsAgreementStatus = null,}) {
  return _then(_AppState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppLifecycleStatus,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,themeSettings: null == themeSettings ? _self.themeSettings : themeSettings // ignore: cast_nullable_to_non_nullable
as ThemeSettings,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,userAgreementStatus: null == userAgreementStatus ? _self.userAgreementStatus : userAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,contactsAgreementStatus: null == contactsAgreementStatus ? _self.contactsAgreementStatus : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
as AgreementStatus,
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
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeSettingsCopyWith<$Res> get themeSettings {
  
  return $ThemeSettingsCopyWith<$Res>(_self.themeSettings, (value) {
    return _then(_self.copyWith(themeSettings: value));
  });
}
}

// dart format on
