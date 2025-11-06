// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {

 AppConfigLogin get loginConfig; AppConfigMain get mainConfig; AppConfigSettings get settingsConfig; AppConfigCall get callConfig;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.loginConfig, loginConfig) || other.loginConfig == loginConfig)&&(identical(other.mainConfig, mainConfig) || other.mainConfig == mainConfig)&&(identical(other.settingsConfig, settingsConfig) || other.settingsConfig == settingsConfig)&&(identical(other.callConfig, callConfig) || other.callConfig == callConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loginConfig,mainConfig,settingsConfig,callConfig);

@override
String toString() {
  return 'AppConfig(loginConfig: $loginConfig, mainConfig: $mainConfig, settingsConfig: $settingsConfig, callConfig: $callConfig)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 AppConfigLogin loginConfig, AppConfigMain mainConfig, AppConfigSettings settingsConfig, AppConfigCall callConfig
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginConfig = null,Object? mainConfig = null,Object? settingsConfig = null,Object? callConfig = null,}) {
  return _then(AppConfig(
loginConfig: null == loginConfig ? _self.loginConfig : loginConfig // ignore: cast_nullable_to_non_nullable
as AppConfigLogin,mainConfig: null == mainConfig ? _self.mainConfig : mainConfig // ignore: cast_nullable_to_non_nullable
as AppConfigMain,settingsConfig: null == settingsConfig ? _self.settingsConfig : settingsConfig // ignore: cast_nullable_to_non_nullable
as AppConfigSettings,callConfig: null == callConfig ? _self.callConfig : callConfig // ignore: cast_nullable_to_non_nullable
as AppConfigCall,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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


/// @nodoc
mixin _$AppConfigLogin {

 AppConfigLoginCommon get common; AppConfigLoginModeSelect get modeSelect;
/// Create a copy of AppConfigLogin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigLoginCopyWith<AppConfigLogin> get copyWith => _$AppConfigLoginCopyWithImpl<AppConfigLogin>(this as AppConfigLogin, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigLogin&&(identical(other.common, common) || other.common == common)&&(identical(other.modeSelect, modeSelect) || other.modeSelect == modeSelect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,common,modeSelect);

@override
String toString() {
  return 'AppConfigLogin(common: $common, modeSelect: $modeSelect)';
}


}

/// @nodoc
abstract mixin class $AppConfigLoginCopyWith<$Res>  {
  factory $AppConfigLoginCopyWith(AppConfigLogin value, $Res Function(AppConfigLogin) _then) = _$AppConfigLoginCopyWithImpl;
@useResult
$Res call({
 AppConfigLoginCommon common, AppConfigLoginModeSelect modeSelect
});




}
/// @nodoc
class _$AppConfigLoginCopyWithImpl<$Res>
    implements $AppConfigLoginCopyWith<$Res> {
  _$AppConfigLoginCopyWithImpl(this._self, this._then);

  final AppConfigLogin _self;
  final $Res Function(AppConfigLogin) _then;

/// Create a copy of AppConfigLogin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? common = null,Object? modeSelect = null,}) {
  return _then(AppConfigLogin(
common: null == common ? _self.common : common // ignore: cast_nullable_to_non_nullable
as AppConfigLoginCommon,modeSelect: null == modeSelect ? _self.modeSelect : modeSelect // ignore: cast_nullable_to_non_nullable
as AppConfigLoginModeSelect,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigLogin].
extension AppConfigLoginPatterns on AppConfigLogin {
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


/// @nodoc
mixin _$AppConfigLoginCommon {

 String? get fullScreenLaunchEmbeddedResourceId;
/// Create a copy of AppConfigLoginCommon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigLoginCommonCopyWith<AppConfigLoginCommon> get copyWith => _$AppConfigLoginCommonCopyWithImpl<AppConfigLoginCommon>(this as AppConfigLoginCommon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigLoginCommon&&(identical(other.fullScreenLaunchEmbeddedResourceId, fullScreenLaunchEmbeddedResourceId) || other.fullScreenLaunchEmbeddedResourceId == fullScreenLaunchEmbeddedResourceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullScreenLaunchEmbeddedResourceId);

@override
String toString() {
  return 'AppConfigLoginCommon(fullScreenLaunchEmbeddedResourceId: $fullScreenLaunchEmbeddedResourceId)';
}


}

/// @nodoc
abstract mixin class $AppConfigLoginCommonCopyWith<$Res>  {
  factory $AppConfigLoginCommonCopyWith(AppConfigLoginCommon value, $Res Function(AppConfigLoginCommon) _then) = _$AppConfigLoginCommonCopyWithImpl;
@useResult
$Res call({
 String? fullScreenLaunchEmbeddedResourceId
});




}
/// @nodoc
class _$AppConfigLoginCommonCopyWithImpl<$Res>
    implements $AppConfigLoginCommonCopyWith<$Res> {
  _$AppConfigLoginCommonCopyWithImpl(this._self, this._then);

  final AppConfigLoginCommon _self;
  final $Res Function(AppConfigLoginCommon) _then;

/// Create a copy of AppConfigLoginCommon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullScreenLaunchEmbeddedResourceId = freezed,}) {
  return _then(AppConfigLoginCommon(
fullScreenLaunchEmbeddedResourceId: freezed == fullScreenLaunchEmbeddedResourceId ? _self.fullScreenLaunchEmbeddedResourceId : fullScreenLaunchEmbeddedResourceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigLoginCommon].
extension AppConfigLoginCommonPatterns on AppConfigLoginCommon {
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


/// @nodoc
mixin _$AppConfigLoginModeSelect {

 String? get greetingL10n; List<AppConfigModeSelectAction> get actions;
/// Create a copy of AppConfigLoginModeSelect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigLoginModeSelectCopyWith<AppConfigLoginModeSelect> get copyWith => _$AppConfigLoginModeSelectCopyWithImpl<AppConfigLoginModeSelect>(this as AppConfigLoginModeSelect, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigLoginModeSelect&&(identical(other.greetingL10n, greetingL10n) || other.greetingL10n == greetingL10n)&&const DeepCollectionEquality().equals(other.actions, actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,greetingL10n,const DeepCollectionEquality().hash(actions));

@override
String toString() {
  return 'AppConfigLoginModeSelect(greetingL10n: $greetingL10n, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $AppConfigLoginModeSelectCopyWith<$Res>  {
  factory $AppConfigLoginModeSelectCopyWith(AppConfigLoginModeSelect value, $Res Function(AppConfigLoginModeSelect) _then) = _$AppConfigLoginModeSelectCopyWithImpl;
@useResult
$Res call({
 String? greetingL10n, List<AppConfigModeSelectAction> actions
});




}
/// @nodoc
class _$AppConfigLoginModeSelectCopyWithImpl<$Res>
    implements $AppConfigLoginModeSelectCopyWith<$Res> {
  _$AppConfigLoginModeSelectCopyWithImpl(this._self, this._then);

  final AppConfigLoginModeSelect _self;
  final $Res Function(AppConfigLoginModeSelect) _then;

/// Create a copy of AppConfigLoginModeSelect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? greetingL10n = freezed,Object? actions = null,}) {
  return _then(AppConfigLoginModeSelect(
greetingL10n: freezed == greetingL10n ? _self.greetingL10n : greetingL10n // ignore: cast_nullable_to_non_nullable
as String?,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<AppConfigModeSelectAction>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigLoginModeSelect].
extension AppConfigLoginModeSelectPatterns on AppConfigLoginModeSelect {
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


/// @nodoc
mixin _$AppConfigModeSelectAction {

 bool get enabled; String get type; String get titleL10n; String? get embeddedId;
/// Create a copy of AppConfigModeSelectAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigModeSelectActionCopyWith<AppConfigModeSelectAction> get copyWith => _$AppConfigModeSelectActionCopyWithImpl<AppConfigModeSelectAction>(this as AppConfigModeSelectAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigModeSelectAction&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.type, type) || other.type == type)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.embeddedId, embeddedId) || other.embeddedId == embeddedId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,type,titleL10n,embeddedId);

@override
String toString() {
  return 'AppConfigModeSelectAction(enabled: $enabled, type: $type, titleL10n: $titleL10n, embeddedId: $embeddedId)';
}


}

/// @nodoc
abstract mixin class $AppConfigModeSelectActionCopyWith<$Res>  {
  factory $AppConfigModeSelectActionCopyWith(AppConfigModeSelectAction value, $Res Function(AppConfigModeSelectAction) _then) = _$AppConfigModeSelectActionCopyWithImpl;
@useResult
$Res call({
 bool enabled, String type, String titleL10n, String? embeddedId
});




}
/// @nodoc
class _$AppConfigModeSelectActionCopyWithImpl<$Res>
    implements $AppConfigModeSelectActionCopyWith<$Res> {
  _$AppConfigModeSelectActionCopyWithImpl(this._self, this._then);

  final AppConfigModeSelectAction _self;
  final $Res Function(AppConfigModeSelectAction) _then;

/// Create a copy of AppConfigModeSelectAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? type = null,Object? titleL10n = null,Object? embeddedId = freezed,}) {
  return _then(AppConfigModeSelectAction(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,embeddedId: freezed == embeddedId ? _self.embeddedId : embeddedId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigModeSelectAction].
extension AppConfigModeSelectActionPatterns on AppConfigModeSelectAction {
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


/// @nodoc
mixin _$AppConfigMain {

 AppConfigBottomMenu get bottomMenu; bool get systemNotificationsEnabled; bool get sipPresenceEnabled;
/// Create a copy of AppConfigMain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigMainCopyWith<AppConfigMain> get copyWith => _$AppConfigMainCopyWithImpl<AppConfigMain>(this as AppConfigMain, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigMain&&(identical(other.bottomMenu, bottomMenu) || other.bottomMenu == bottomMenu)&&(identical(other.systemNotificationsEnabled, systemNotificationsEnabled) || other.systemNotificationsEnabled == systemNotificationsEnabled)&&(identical(other.sipPresenceEnabled, sipPresenceEnabled) || other.sipPresenceEnabled == sipPresenceEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bottomMenu,systemNotificationsEnabled,sipPresenceEnabled);

@override
String toString() {
  return 'AppConfigMain(bottomMenu: $bottomMenu, systemNotificationsEnabled: $systemNotificationsEnabled, sipPresenceEnabled: $sipPresenceEnabled)';
}


}

/// @nodoc
abstract mixin class $AppConfigMainCopyWith<$Res>  {
  factory $AppConfigMainCopyWith(AppConfigMain value, $Res Function(AppConfigMain) _then) = _$AppConfigMainCopyWithImpl;
@useResult
$Res call({
 AppConfigBottomMenu bottomMenu, bool systemNotificationsEnabled, bool sipPresenceEnabled
});




}
/// @nodoc
class _$AppConfigMainCopyWithImpl<$Res>
    implements $AppConfigMainCopyWith<$Res> {
  _$AppConfigMainCopyWithImpl(this._self, this._then);

  final AppConfigMain _self;
  final $Res Function(AppConfigMain) _then;

/// Create a copy of AppConfigMain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bottomMenu = null,Object? systemNotificationsEnabled = null,Object? sipPresenceEnabled = null,}) {
  return _then(AppConfigMain(
bottomMenu: null == bottomMenu ? _self.bottomMenu : bottomMenu // ignore: cast_nullable_to_non_nullable
as AppConfigBottomMenu,systemNotificationsEnabled: null == systemNotificationsEnabled ? _self.systemNotificationsEnabled : systemNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,sipPresenceEnabled: null == sipPresenceEnabled ? _self.sipPresenceEnabled : sipPresenceEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigMain].
extension AppConfigMainPatterns on AppConfigMain {
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


/// @nodoc
mixin _$AppConfigBottomMenu {

 bool get cacheSelectedTab; List<BottomMenuTabScheme> get tabs;
/// Create a copy of AppConfigBottomMenu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigBottomMenuCopyWith<AppConfigBottomMenu> get copyWith => _$AppConfigBottomMenuCopyWithImpl<AppConfigBottomMenu>(this as AppConfigBottomMenu, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigBottomMenu&&(identical(other.cacheSelectedTab, cacheSelectedTab) || other.cacheSelectedTab == cacheSelectedTab)&&const DeepCollectionEquality().equals(other.tabs, tabs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cacheSelectedTab,const DeepCollectionEquality().hash(tabs));

@override
String toString() {
  return 'AppConfigBottomMenu(cacheSelectedTab: $cacheSelectedTab, tabs: $tabs)';
}


}

/// @nodoc
abstract mixin class $AppConfigBottomMenuCopyWith<$Res>  {
  factory $AppConfigBottomMenuCopyWith(AppConfigBottomMenu value, $Res Function(AppConfigBottomMenu) _then) = _$AppConfigBottomMenuCopyWithImpl;
@useResult
$Res call({
 bool cacheSelectedTab, List<BottomMenuTabScheme> tabs
});




}
/// @nodoc
class _$AppConfigBottomMenuCopyWithImpl<$Res>
    implements $AppConfigBottomMenuCopyWith<$Res> {
  _$AppConfigBottomMenuCopyWithImpl(this._self, this._then);

  final AppConfigBottomMenu _self;
  final $Res Function(AppConfigBottomMenu) _then;

/// Create a copy of AppConfigBottomMenu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cacheSelectedTab = null,Object? tabs = null,}) {
  return _then(AppConfigBottomMenu(
cacheSelectedTab: null == cacheSelectedTab ? _self.cacheSelectedTab : cacheSelectedTab // ignore: cast_nullable_to_non_nullable
as bool,tabs: null == tabs ? _self.tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<BottomMenuTabScheme>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigBottomMenu].
extension AppConfigBottomMenuPatterns on AppConfigBottomMenu {
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


/// @nodoc
mixin _$AppConfigCall {

 bool get videoEnabled; AppConfigTransfer get transfer; AppConfigEncoding get encoding; AppConfigPeerConnection get peerConnection;
/// Create a copy of AppConfigCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCallCopyWith<AppConfigCall> get copyWith => _$AppConfigCallCopyWithImpl<AppConfigCall>(this as AppConfigCall, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigCall&&(identical(other.videoEnabled, videoEnabled) || other.videoEnabled == videoEnabled)&&(identical(other.transfer, transfer) || other.transfer == transfer)&&(identical(other.encoding, encoding) || other.encoding == encoding)&&(identical(other.peerConnection, peerConnection) || other.peerConnection == peerConnection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,videoEnabled,transfer,encoding,peerConnection);

@override
String toString() {
  return 'AppConfigCall(videoEnabled: $videoEnabled, transfer: $transfer, encoding: $encoding, peerConnection: $peerConnection)';
}


}

/// @nodoc
abstract mixin class $AppConfigCallCopyWith<$Res>  {
  factory $AppConfigCallCopyWith(AppConfigCall value, $Res Function(AppConfigCall) _then) = _$AppConfigCallCopyWithImpl;
@useResult
$Res call({
 bool videoEnabled, AppConfigTransfer transfer, AppConfigEncoding encoding, AppConfigPeerConnection peerConnection
});




}
/// @nodoc
class _$AppConfigCallCopyWithImpl<$Res>
    implements $AppConfigCallCopyWith<$Res> {
  _$AppConfigCallCopyWithImpl(this._self, this._then);

  final AppConfigCall _self;
  final $Res Function(AppConfigCall) _then;

/// Create a copy of AppConfigCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? videoEnabled = null,Object? transfer = null,Object? encoding = null,Object? peerConnection = null,}) {
  return _then(AppConfigCall(
videoEnabled: null == videoEnabled ? _self.videoEnabled : videoEnabled // ignore: cast_nullable_to_non_nullable
as bool,transfer: null == transfer ? _self.transfer : transfer // ignore: cast_nullable_to_non_nullable
as AppConfigTransfer,encoding: null == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as AppConfigEncoding,peerConnection: null == peerConnection ? _self.peerConnection : peerConnection // ignore: cast_nullable_to_non_nullable
as AppConfigPeerConnection,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigCall].
extension AppConfigCallPatterns on AppConfigCall {
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


/// @nodoc
mixin _$AppConfigTransfer {

 bool get enableBlindTransfer; bool get enableAttendedTransfer;
/// Create a copy of AppConfigTransfer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigTransferCopyWith<AppConfigTransfer> get copyWith => _$AppConfigTransferCopyWithImpl<AppConfigTransfer>(this as AppConfigTransfer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigTransfer&&(identical(other.enableBlindTransfer, enableBlindTransfer) || other.enableBlindTransfer == enableBlindTransfer)&&(identical(other.enableAttendedTransfer, enableAttendedTransfer) || other.enableAttendedTransfer == enableAttendedTransfer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enableBlindTransfer,enableAttendedTransfer);

@override
String toString() {
  return 'AppConfigTransfer(enableBlindTransfer: $enableBlindTransfer, enableAttendedTransfer: $enableAttendedTransfer)';
}


}

/// @nodoc
abstract mixin class $AppConfigTransferCopyWith<$Res>  {
  factory $AppConfigTransferCopyWith(AppConfigTransfer value, $Res Function(AppConfigTransfer) _then) = _$AppConfigTransferCopyWithImpl;
@useResult
$Res call({
 bool enableBlindTransfer, bool enableAttendedTransfer
});




}
/// @nodoc
class _$AppConfigTransferCopyWithImpl<$Res>
    implements $AppConfigTransferCopyWith<$Res> {
  _$AppConfigTransferCopyWithImpl(this._self, this._then);

  final AppConfigTransfer _self;
  final $Res Function(AppConfigTransfer) _then;

/// Create a copy of AppConfigTransfer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableBlindTransfer = null,Object? enableAttendedTransfer = null,}) {
  return _then(AppConfigTransfer(
enableBlindTransfer: null == enableBlindTransfer ? _self.enableBlindTransfer : enableBlindTransfer // ignore: cast_nullable_to_non_nullable
as bool,enableAttendedTransfer: null == enableAttendedTransfer ? _self.enableAttendedTransfer : enableAttendedTransfer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigTransfer].
extension AppConfigTransferPatterns on AppConfigTransfer {
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


/// @nodoc
mixin _$AppConfigEncoding {

 bool get bypassConfig; EncodingDefaultPresetOverride get defaultPresetOverride;
/// Create a copy of AppConfigEncoding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigEncodingCopyWith<AppConfigEncoding> get copyWith => _$AppConfigEncodingCopyWithImpl<AppConfigEncoding>(this as AppConfigEncoding, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigEncoding&&(identical(other.bypassConfig, bypassConfig) || other.bypassConfig == bypassConfig)&&(identical(other.defaultPresetOverride, defaultPresetOverride) || other.defaultPresetOverride == defaultPresetOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bypassConfig,defaultPresetOverride);

@override
String toString() {
  return 'AppConfigEncoding(bypassConfig: $bypassConfig, defaultPresetOverride: $defaultPresetOverride)';
}


}

/// @nodoc
abstract mixin class $AppConfigEncodingCopyWith<$Res>  {
  factory $AppConfigEncodingCopyWith(AppConfigEncoding value, $Res Function(AppConfigEncoding) _then) = _$AppConfigEncodingCopyWithImpl;
@useResult
$Res call({
 bool bypassConfig, EncodingDefaultPresetOverride defaultPresetOverride
});




}
/// @nodoc
class _$AppConfigEncodingCopyWithImpl<$Res>
    implements $AppConfigEncodingCopyWith<$Res> {
  _$AppConfigEncodingCopyWithImpl(this._self, this._then);

  final AppConfigEncoding _self;
  final $Res Function(AppConfigEncoding) _then;

/// Create a copy of AppConfigEncoding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bypassConfig = null,Object? defaultPresetOverride = null,}) {
  return _then(AppConfigEncoding(
bypassConfig: null == bypassConfig ? _self.bypassConfig : bypassConfig // ignore: cast_nullable_to_non_nullable
as bool,defaultPresetOverride: null == defaultPresetOverride ? _self.defaultPresetOverride : defaultPresetOverride // ignore: cast_nullable_to_non_nullable
as EncodingDefaultPresetOverride,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigEncoding].
extension AppConfigEncodingPatterns on AppConfigEncoding {
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


/// @nodoc
mixin _$AppConfigPeerConnection {

 AppConfigNegotiationSettingsOverride get negotiation;
/// Create a copy of AppConfigPeerConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigPeerConnectionCopyWith<AppConfigPeerConnection> get copyWith => _$AppConfigPeerConnectionCopyWithImpl<AppConfigPeerConnection>(this as AppConfigPeerConnection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigPeerConnection&&(identical(other.negotiation, negotiation) || other.negotiation == negotiation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,negotiation);

@override
String toString() {
  return 'AppConfigPeerConnection(negotiation: $negotiation)';
}


}

/// @nodoc
abstract mixin class $AppConfigPeerConnectionCopyWith<$Res>  {
  factory $AppConfigPeerConnectionCopyWith(AppConfigPeerConnection value, $Res Function(AppConfigPeerConnection) _then) = _$AppConfigPeerConnectionCopyWithImpl;
@useResult
$Res call({
 AppConfigNegotiationSettingsOverride negotiation
});




}
/// @nodoc
class _$AppConfigPeerConnectionCopyWithImpl<$Res>
    implements $AppConfigPeerConnectionCopyWith<$Res> {
  _$AppConfigPeerConnectionCopyWithImpl(this._self, this._then);

  final AppConfigPeerConnection _self;
  final $Res Function(AppConfigPeerConnection) _then;

/// Create a copy of AppConfigPeerConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? negotiation = null,}) {
  return _then(AppConfigPeerConnection(
negotiation: null == negotiation ? _self.negotiation : negotiation // ignore: cast_nullable_to_non_nullable
as AppConfigNegotiationSettingsOverride,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigPeerConnection].
extension AppConfigPeerConnectionPatterns on AppConfigPeerConnection {
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


/// @nodoc
mixin _$AppConfigNegotiationSettingsOverride {

 bool get includeInactiveVideoInOfferAnswer;
/// Create a copy of AppConfigNegotiationSettingsOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigNegotiationSettingsOverrideCopyWith<AppConfigNegotiationSettingsOverride> get copyWith => _$AppConfigNegotiationSettingsOverrideCopyWithImpl<AppConfigNegotiationSettingsOverride>(this as AppConfigNegotiationSettingsOverride, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigNegotiationSettingsOverride&&(identical(other.includeInactiveVideoInOfferAnswer, includeInactiveVideoInOfferAnswer) || other.includeInactiveVideoInOfferAnswer == includeInactiveVideoInOfferAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includeInactiveVideoInOfferAnswer);

@override
String toString() {
  return 'AppConfigNegotiationSettingsOverride(includeInactiveVideoInOfferAnswer: $includeInactiveVideoInOfferAnswer)';
}


}

/// @nodoc
abstract mixin class $AppConfigNegotiationSettingsOverrideCopyWith<$Res>  {
  factory $AppConfigNegotiationSettingsOverrideCopyWith(AppConfigNegotiationSettingsOverride value, $Res Function(AppConfigNegotiationSettingsOverride) _then) = _$AppConfigNegotiationSettingsOverrideCopyWithImpl;
@useResult
$Res call({
 bool includeInactiveVideoInOfferAnswer
});




}
/// @nodoc
class _$AppConfigNegotiationSettingsOverrideCopyWithImpl<$Res>
    implements $AppConfigNegotiationSettingsOverrideCopyWith<$Res> {
  _$AppConfigNegotiationSettingsOverrideCopyWithImpl(this._self, this._then);

  final AppConfigNegotiationSettingsOverride _self;
  final $Res Function(AppConfigNegotiationSettingsOverride) _then;

/// Create a copy of AppConfigNegotiationSettingsOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includeInactiveVideoInOfferAnswer = null,}) {
  return _then(AppConfigNegotiationSettingsOverride(
includeInactiveVideoInOfferAnswer: null == includeInactiveVideoInOfferAnswer ? _self.includeInactiveVideoInOfferAnswer : includeInactiveVideoInOfferAnswer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigNegotiationSettingsOverride].
extension AppConfigNegotiationSettingsOverridePatterns on AppConfigNegotiationSettingsOverride {
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


/// @nodoc
mixin _$EncodingDefaultPresetOverride {

 int? get audioBitrate; int? get videoBitrate; int? get ptime; int? get maxptime; int? get opusSamplingRate; int? get opusBitrate; bool? get opusStereo; bool? get opusDtx; bool? get removeExtmaps; bool? get removeStaticAudioRtpMaps; bool? get remapTE8payloadTo101;
/// Create a copy of EncodingDefaultPresetOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncodingDefaultPresetOverrideCopyWith<EncodingDefaultPresetOverride> get copyWith => _$EncodingDefaultPresetOverrideCopyWithImpl<EncodingDefaultPresetOverride>(this as EncodingDefaultPresetOverride, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncodingDefaultPresetOverride&&(identical(other.audioBitrate, audioBitrate) || other.audioBitrate == audioBitrate)&&(identical(other.videoBitrate, videoBitrate) || other.videoBitrate == videoBitrate)&&(identical(other.ptime, ptime) || other.ptime == ptime)&&(identical(other.maxptime, maxptime) || other.maxptime == maxptime)&&(identical(other.opusSamplingRate, opusSamplingRate) || other.opusSamplingRate == opusSamplingRate)&&(identical(other.opusBitrate, opusBitrate) || other.opusBitrate == opusBitrate)&&(identical(other.opusStereo, opusStereo) || other.opusStereo == opusStereo)&&(identical(other.opusDtx, opusDtx) || other.opusDtx == opusDtx)&&(identical(other.removeExtmaps, removeExtmaps) || other.removeExtmaps == removeExtmaps)&&(identical(other.removeStaticAudioRtpMaps, removeStaticAudioRtpMaps) || other.removeStaticAudioRtpMaps == removeStaticAudioRtpMaps)&&(identical(other.remapTE8payloadTo101, remapTE8payloadTo101) || other.remapTE8payloadTo101 == remapTE8payloadTo101));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioBitrate,videoBitrate,ptime,maxptime,opusSamplingRate,opusBitrate,opusStereo,opusDtx,removeExtmaps,removeStaticAudioRtpMaps,remapTE8payloadTo101);

@override
String toString() {
  return 'EncodingDefaultPresetOverride(audioBitrate: $audioBitrate, videoBitrate: $videoBitrate, ptime: $ptime, maxptime: $maxptime, opusSamplingRate: $opusSamplingRate, opusBitrate: $opusBitrate, opusStereo: $opusStereo, opusDtx: $opusDtx, removeExtmaps: $removeExtmaps, removeStaticAudioRtpMaps: $removeStaticAudioRtpMaps, remapTE8payloadTo101: $remapTE8payloadTo101)';
}


}

/// @nodoc
abstract mixin class $EncodingDefaultPresetOverrideCopyWith<$Res>  {
  factory $EncodingDefaultPresetOverrideCopyWith(EncodingDefaultPresetOverride value, $Res Function(EncodingDefaultPresetOverride) _then) = _$EncodingDefaultPresetOverrideCopyWithImpl;
@useResult
$Res call({
 int? audioBitrate, int? videoBitrate, int? ptime, int? maxptime, int? opusSamplingRate, int? opusBitrate, bool? opusStereo, bool? opusDtx, bool? removeExtmaps, bool? removeStaticAudioRtpMaps, bool? remapTE8payloadTo101
});




}
/// @nodoc
class _$EncodingDefaultPresetOverrideCopyWithImpl<$Res>
    implements $EncodingDefaultPresetOverrideCopyWith<$Res> {
  _$EncodingDefaultPresetOverrideCopyWithImpl(this._self, this._then);

  final EncodingDefaultPresetOverride _self;
  final $Res Function(EncodingDefaultPresetOverride) _then;

/// Create a copy of EncodingDefaultPresetOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? audioBitrate = freezed,Object? videoBitrate = freezed,Object? ptime = freezed,Object? maxptime = freezed,Object? opusSamplingRate = freezed,Object? opusBitrate = freezed,Object? opusStereo = freezed,Object? opusDtx = freezed,Object? removeExtmaps = freezed,Object? removeStaticAudioRtpMaps = freezed,Object? remapTE8payloadTo101 = freezed,}) {
  return _then(EncodingDefaultPresetOverride(
audioBitrate: freezed == audioBitrate ? _self.audioBitrate : audioBitrate // ignore: cast_nullable_to_non_nullable
as int?,videoBitrate: freezed == videoBitrate ? _self.videoBitrate : videoBitrate // ignore: cast_nullable_to_non_nullable
as int?,ptime: freezed == ptime ? _self.ptime : ptime // ignore: cast_nullable_to_non_nullable
as int?,maxptime: freezed == maxptime ? _self.maxptime : maxptime // ignore: cast_nullable_to_non_nullable
as int?,opusSamplingRate: freezed == opusSamplingRate ? _self.opusSamplingRate : opusSamplingRate // ignore: cast_nullable_to_non_nullable
as int?,opusBitrate: freezed == opusBitrate ? _self.opusBitrate : opusBitrate // ignore: cast_nullable_to_non_nullable
as int?,opusStereo: freezed == opusStereo ? _self.opusStereo : opusStereo // ignore: cast_nullable_to_non_nullable
as bool?,opusDtx: freezed == opusDtx ? _self.opusDtx : opusDtx // ignore: cast_nullable_to_non_nullable
as bool?,removeExtmaps: freezed == removeExtmaps ? _self.removeExtmaps : removeExtmaps // ignore: cast_nullable_to_non_nullable
as bool?,removeStaticAudioRtpMaps: freezed == removeStaticAudioRtpMaps ? _self.removeStaticAudioRtpMaps : removeStaticAudioRtpMaps // ignore: cast_nullable_to_non_nullable
as bool?,remapTE8payloadTo101: freezed == remapTE8payloadTo101 ? _self.remapTE8payloadTo101 : remapTE8payloadTo101 // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EncodingDefaultPresetOverride].
extension EncodingDefaultPresetOverridePatterns on EncodingDefaultPresetOverride {
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

BottomMenuTabScheme _$BottomMenuTabSchemeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'favorites':
          return FavoritesTabScheme.fromJson(
            json
          );
                case 'recents':
          return RecentsTabScheme.fromJson(
            json
          );
                case 'contacts':
          return ContactsTabScheme.fromJson(
            json
          );
                case 'keypad':
          return KeypadTabScheme.fromJson(
            json
          );
                case 'messaging':
          return MessagingTabScheme.fromJson(
            json
          );
                case 'embedded':
          return EmbeddedTabScheme.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'BottomMenuTabScheme',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$BottomMenuTabScheme {

 bool get enabled; bool get initial; String get titleL10n; String get icon;
/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomMenuTabSchemeCopyWith<BottomMenuTabScheme> get copyWith => _$BottomMenuTabSchemeCopyWithImpl<BottomMenuTabScheme>(this as BottomMenuTabScheme, _$identity);

  /// Serializes this BottomMenuTabScheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomMenuTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon);

@override
String toString() {
  return 'BottomMenuTabScheme(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $BottomMenuTabSchemeCopyWith<$Res>  {
  factory $BottomMenuTabSchemeCopyWith(BottomMenuTabScheme value, $Res Function(BottomMenuTabScheme) _then) = _$BottomMenuTabSchemeCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon
});




}
/// @nodoc
class _$BottomMenuTabSchemeCopyWithImpl<$Res>
    implements $BottomMenuTabSchemeCopyWith<$Res> {
  _$BottomMenuTabSchemeCopyWithImpl(this._self, this._then);

  final BottomMenuTabScheme _self;
  final $Res Function(BottomMenuTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomMenuTabScheme].
extension BottomMenuTabSchemePatterns on BottomMenuTabScheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FavoritesTabScheme value)?  favorites,TResult Function( RecentsTabScheme value)?  recents,TResult Function( ContactsTabScheme value)?  contacts,TResult Function( KeypadTabScheme value)?  keypad,TResult Function( MessagingTabScheme value)?  messaging,TResult Function( EmbeddedTabScheme value)?  embedded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FavoritesTabScheme() when favorites != null:
return favorites(_that);case RecentsTabScheme() when recents != null:
return recents(_that);case ContactsTabScheme() when contacts != null:
return contacts(_that);case KeypadTabScheme() when keypad != null:
return keypad(_that);case MessagingTabScheme() when messaging != null:
return messaging(_that);case EmbeddedTabScheme() when embedded != null:
return embedded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FavoritesTabScheme value)  favorites,required TResult Function( RecentsTabScheme value)  recents,required TResult Function( ContactsTabScheme value)  contacts,required TResult Function( KeypadTabScheme value)  keypad,required TResult Function( MessagingTabScheme value)  messaging,required TResult Function( EmbeddedTabScheme value)  embedded,}){
final _that = this;
switch (_that) {
case FavoritesTabScheme():
return favorites(_that);case RecentsTabScheme():
return recents(_that);case ContactsTabScheme():
return contacts(_that);case KeypadTabScheme():
return keypad(_that);case MessagingTabScheme():
return messaging(_that);case EmbeddedTabScheme():
return embedded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FavoritesTabScheme value)?  favorites,TResult? Function( RecentsTabScheme value)?  recents,TResult? Function( ContactsTabScheme value)?  contacts,TResult? Function( KeypadTabScheme value)?  keypad,TResult? Function( MessagingTabScheme value)?  messaging,TResult? Function( EmbeddedTabScheme value)?  embedded,}){
final _that = this;
switch (_that) {
case FavoritesTabScheme() when favorites != null:
return favorites(_that);case RecentsTabScheme() when recents != null:
return recents(_that);case ContactsTabScheme() when contacts != null:
return contacts(_that);case KeypadTabScheme() when keypad != null:
return keypad(_that);case MessagingTabScheme() when messaging != null:
return messaging(_that);case EmbeddedTabScheme() when embedded != null:
return embedded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  favorites,TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon,  bool useCdrs)?  recents,TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon,  List<String> contactSourceTypes)?  contacts,TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  keypad,TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  messaging,TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon, @IntToStringConverter()  String embeddedResourceId)?  embedded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FavoritesTabScheme() when favorites != null:
return favorites(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case RecentsTabScheme() when recents != null:
return recents(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.useCdrs);case ContactsTabScheme() when contacts != null:
return contacts(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.contactSourceTypes);case KeypadTabScheme() when keypad != null:
return keypad(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case MessagingTabScheme() when messaging != null:
return messaging(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case EmbeddedTabScheme() when embedded != null:
return embedded(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.embeddedResourceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)  favorites,required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon,  bool useCdrs)  recents,required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon,  List<String> contactSourceTypes)  contacts,required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)  keypad,required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon)  messaging,required TResult Function( bool enabled,  bool initial,  String titleL10n,  String icon, @IntToStringConverter()  String embeddedResourceId)  embedded,}) {final _that = this;
switch (_that) {
case FavoritesTabScheme():
return favorites(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case RecentsTabScheme():
return recents(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.useCdrs);case ContactsTabScheme():
return contacts(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.contactSourceTypes);case KeypadTabScheme():
return keypad(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case MessagingTabScheme():
return messaging(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case EmbeddedTabScheme():
return embedded(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.embeddedResourceId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  favorites,TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon,  bool useCdrs)?  recents,TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon,  List<String> contactSourceTypes)?  contacts,TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  keypad,TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon)?  messaging,TResult? Function( bool enabled,  bool initial,  String titleL10n,  String icon, @IntToStringConverter()  String embeddedResourceId)?  embedded,}) {final _that = this;
switch (_that) {
case FavoritesTabScheme() when favorites != null:
return favorites(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case RecentsTabScheme() when recents != null:
return recents(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.useCdrs);case ContactsTabScheme() when contacts != null:
return contacts(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.contactSourceTypes);case KeypadTabScheme() when keypad != null:
return keypad(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case MessagingTabScheme() when messaging != null:
return messaging(_that.enabled,_that.initial,_that.titleL10n,_that.icon);case EmbeddedTabScheme() when embedded != null:
return embedded(_that.enabled,_that.initial,_that.titleL10n,_that.icon,_that.embeddedResourceId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class FavoritesTabScheme extends BottomMenuTabScheme {
  const FavoritesTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, final  String? $type}): $type = $type ?? 'favorites',super._();
  factory FavoritesTabScheme.fromJson(Map<String, dynamic> json) => _$FavoritesTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesTabSchemeCopyWith<FavoritesTabScheme> get copyWith => _$FavoritesTabSchemeCopyWithImpl<FavoritesTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoritesTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon);

@override
String toString() {
  return 'BottomMenuTabScheme.favorites(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $FavoritesTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $FavoritesTabSchemeCopyWith(FavoritesTabScheme value, $Res Function(FavoritesTabScheme) _then) = _$FavoritesTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon
});




}
/// @nodoc
class _$FavoritesTabSchemeCopyWithImpl<$Res>
    implements $FavoritesTabSchemeCopyWith<$Res> {
  _$FavoritesTabSchemeCopyWithImpl(this._self, this._then);

  final FavoritesTabScheme _self;
  final $Res Function(FavoritesTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,}) {
  return _then(FavoritesTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class RecentsTabScheme extends BottomMenuTabScheme {
  const RecentsTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, this.useCdrs = false, final  String? $type}): $type = $type ?? 'recents',super._();
  factory RecentsTabScheme.fromJson(Map<String, dynamic> json) => _$RecentsTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;
@JsonKey() final  bool useCdrs;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentsTabSchemeCopyWith<RecentsTabScheme> get copyWith => _$RecentsTabSchemeCopyWithImpl<RecentsTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentsTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentsTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.useCdrs, useCdrs) || other.useCdrs == useCdrs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon,useCdrs);

@override
String toString() {
  return 'BottomMenuTabScheme.recents(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon, useCdrs: $useCdrs)';
}


}

/// @nodoc
abstract mixin class $RecentsTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $RecentsTabSchemeCopyWith(RecentsTabScheme value, $Res Function(RecentsTabScheme) _then) = _$RecentsTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon, bool useCdrs
});




}
/// @nodoc
class _$RecentsTabSchemeCopyWithImpl<$Res>
    implements $RecentsTabSchemeCopyWith<$Res> {
  _$RecentsTabSchemeCopyWithImpl(this._self, this._then);

  final RecentsTabScheme _self;
  final $Res Function(RecentsTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,Object? useCdrs = null,}) {
  return _then(RecentsTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,useCdrs: null == useCdrs ? _self.useCdrs : useCdrs // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class ContactsTabScheme extends BottomMenuTabScheme {
  const ContactsTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, final  List<String> contactSourceTypes = const <String>[], final  String? $type}): _contactSourceTypes = contactSourceTypes,$type = $type ?? 'contacts',super._();
  factory ContactsTabScheme.fromJson(Map<String, dynamic> json) => _$ContactsTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;
 final  List<String> _contactSourceTypes;
@JsonKey() List<String> get contactSourceTypes {
  if (_contactSourceTypes is EqualUnmodifiableListView) return _contactSourceTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contactSourceTypes);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactsTabSchemeCopyWith<ContactsTabScheme> get copyWith => _$ContactsTabSchemeCopyWithImpl<ContactsTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactsTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactsTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._contactSourceTypes, _contactSourceTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon,const DeepCollectionEquality().hash(_contactSourceTypes));

@override
String toString() {
  return 'BottomMenuTabScheme.contacts(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon, contactSourceTypes: $contactSourceTypes)';
}


}

/// @nodoc
abstract mixin class $ContactsTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $ContactsTabSchemeCopyWith(ContactsTabScheme value, $Res Function(ContactsTabScheme) _then) = _$ContactsTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon, List<String> contactSourceTypes
});




}
/// @nodoc
class _$ContactsTabSchemeCopyWithImpl<$Res>
    implements $ContactsTabSchemeCopyWith<$Res> {
  _$ContactsTabSchemeCopyWithImpl(this._self, this._then);

  final ContactsTabScheme _self;
  final $Res Function(ContactsTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,Object? contactSourceTypes = null,}) {
  return _then(ContactsTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,contactSourceTypes: null == contactSourceTypes ? _self._contactSourceTypes : contactSourceTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class KeypadTabScheme extends BottomMenuTabScheme {
  const KeypadTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, final  String? $type}): $type = $type ?? 'keypad',super._();
  factory KeypadTabScheme.fromJson(Map<String, dynamic> json) => _$KeypadTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeypadTabSchemeCopyWith<KeypadTabScheme> get copyWith => _$KeypadTabSchemeCopyWithImpl<KeypadTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeypadTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeypadTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon);

@override
String toString() {
  return 'BottomMenuTabScheme.keypad(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $KeypadTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $KeypadTabSchemeCopyWith(KeypadTabScheme value, $Res Function(KeypadTabScheme) _then) = _$KeypadTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon
});




}
/// @nodoc
class _$KeypadTabSchemeCopyWithImpl<$Res>
    implements $KeypadTabSchemeCopyWith<$Res> {
  _$KeypadTabSchemeCopyWithImpl(this._self, this._then);

  final KeypadTabScheme _self;
  final $Res Function(KeypadTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,}) {
  return _then(KeypadTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class MessagingTabScheme extends BottomMenuTabScheme {
  const MessagingTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, final  String? $type}): $type = $type ?? 'messaging',super._();
  factory MessagingTabScheme.fromJson(Map<String, dynamic> json) => _$MessagingTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagingTabSchemeCopyWith<MessagingTabScheme> get copyWith => _$MessagingTabSchemeCopyWithImpl<MessagingTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagingTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagingTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon);

@override
String toString() {
  return 'BottomMenuTabScheme.messaging(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $MessagingTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $MessagingTabSchemeCopyWith(MessagingTabScheme value, $Res Function(MessagingTabScheme) _then) = _$MessagingTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon
});




}
/// @nodoc
class _$MessagingTabSchemeCopyWithImpl<$Res>
    implements $MessagingTabSchemeCopyWith<$Res> {
  _$MessagingTabSchemeCopyWithImpl(this._self, this._then);

  final MessagingTabScheme _self;
  final $Res Function(MessagingTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,}) {
  return _then(MessagingTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class EmbeddedTabScheme extends BottomMenuTabScheme {
  const EmbeddedTabScheme({this.enabled = true, this.initial = false, required this.titleL10n, required this.icon, @IntToStringConverter() required this.embeddedResourceId, final  String? $type}): $type = $type ?? 'embedded',super._();
  factory EmbeddedTabScheme.fromJson(Map<String, dynamic> json) => _$EmbeddedTabSchemeFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool initial;
@override final  String titleL10n;
@override final  String icon;
@IntToStringConverter() final  String embeddedResourceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmbeddedTabSchemeCopyWith<EmbeddedTabScheme> get copyWith => _$EmbeddedTabSchemeCopyWithImpl<EmbeddedTabScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmbeddedTabSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmbeddedTabScheme&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.embeddedResourceId, embeddedResourceId) || other.embeddedResourceId == embeddedResourceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,initial,titleL10n,icon,embeddedResourceId);

@override
String toString() {
  return 'BottomMenuTabScheme.embedded(enabled: $enabled, initial: $initial, titleL10n: $titleL10n, icon: $icon, embeddedResourceId: $embeddedResourceId)';
}


}

/// @nodoc
abstract mixin class $EmbeddedTabSchemeCopyWith<$Res> implements $BottomMenuTabSchemeCopyWith<$Res> {
  factory $EmbeddedTabSchemeCopyWith(EmbeddedTabScheme value, $Res Function(EmbeddedTabScheme) _then) = _$EmbeddedTabSchemeCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool initial, String titleL10n, String icon,@IntToStringConverter() String embeddedResourceId
});




}
/// @nodoc
class _$EmbeddedTabSchemeCopyWithImpl<$Res>
    implements $EmbeddedTabSchemeCopyWith<$Res> {
  _$EmbeddedTabSchemeCopyWithImpl(this._self, this._then);

  final EmbeddedTabScheme _self;
  final $Res Function(EmbeddedTabScheme) _then;

/// Create a copy of BottomMenuTabScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? initial = null,Object? titleL10n = null,Object? icon = null,Object? embeddedResourceId = null,}) {
  return _then(EmbeddedTabScheme(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,embeddedResourceId: null == embeddedResourceId ? _self.embeddedResourceId : embeddedResourceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AppConfigSettings {

 List<AppConfigSettingsSection> get sections;
/// Create a copy of AppConfigSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigSettingsCopyWith<AppConfigSettings> get copyWith => _$AppConfigSettingsCopyWithImpl<AppConfigSettings>(this as AppConfigSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigSettings&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'AppConfigSettings(sections: $sections)';
}


}

/// @nodoc
abstract mixin class $AppConfigSettingsCopyWith<$Res>  {
  factory $AppConfigSettingsCopyWith(AppConfigSettings value, $Res Function(AppConfigSettings) _then) = _$AppConfigSettingsCopyWithImpl;
@useResult
$Res call({
 List<AppConfigSettingsSection> sections
});




}
/// @nodoc
class _$AppConfigSettingsCopyWithImpl<$Res>
    implements $AppConfigSettingsCopyWith<$Res> {
  _$AppConfigSettingsCopyWithImpl(this._self, this._then);

  final AppConfigSettings _self;
  final $Res Function(AppConfigSettings) _then;

/// Create a copy of AppConfigSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sections = null,}) {
  return _then(AppConfigSettings(
sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<AppConfigSettingsSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigSettings].
extension AppConfigSettingsPatterns on AppConfigSettings {
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


/// @nodoc
mixin _$AppConfigSettingsSection {

 String get titleL10n; bool get enabled; List<AppConfigSettingsItem> get items;
/// Create a copy of AppConfigSettingsSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigSettingsSectionCopyWith<AppConfigSettingsSection> get copyWith => _$AppConfigSettingsSectionCopyWithImpl<AppConfigSettingsSection>(this as AppConfigSettingsSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigSettingsSection&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleL10n,enabled,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'AppConfigSettingsSection(titleL10n: $titleL10n, enabled: $enabled, items: $items)';
}


}

/// @nodoc
abstract mixin class $AppConfigSettingsSectionCopyWith<$Res>  {
  factory $AppConfigSettingsSectionCopyWith(AppConfigSettingsSection value, $Res Function(AppConfigSettingsSection) _then) = _$AppConfigSettingsSectionCopyWithImpl;
@useResult
$Res call({
 String titleL10n, bool enabled, List<AppConfigSettingsItem> items
});




}
/// @nodoc
class _$AppConfigSettingsSectionCopyWithImpl<$Res>
    implements $AppConfigSettingsSectionCopyWith<$Res> {
  _$AppConfigSettingsSectionCopyWithImpl(this._self, this._then);

  final AppConfigSettingsSection _self;
  final $Res Function(AppConfigSettingsSection) _then;

/// Create a copy of AppConfigSettingsSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleL10n = null,Object? enabled = null,Object? items = null,}) {
  return _then(AppConfigSettingsSection(
titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AppConfigSettingsItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigSettingsSection].
extension AppConfigSettingsSectionPatterns on AppConfigSettingsSection {
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


/// @nodoc
mixin _$AppConfigSettingsItem {

 bool get enabled; String get titleL10n; String get type; String get icon; String? get embeddedResourceId;
/// Create a copy of AppConfigSettingsItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigSettingsItemCopyWith<AppConfigSettingsItem> get copyWith => _$AppConfigSettingsItemCopyWithImpl<AppConfigSettingsItem>(this as AppConfigSettingsItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigSettingsItem&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.titleL10n, titleL10n) || other.titleL10n == titleL10n)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.embeddedResourceId, embeddedResourceId) || other.embeddedResourceId == embeddedResourceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,titleL10n,type,icon,embeddedResourceId);

@override
String toString() {
  return 'AppConfigSettingsItem(enabled: $enabled, titleL10n: $titleL10n, type: $type, icon: $icon, embeddedResourceId: $embeddedResourceId)';
}


}

/// @nodoc
abstract mixin class $AppConfigSettingsItemCopyWith<$Res>  {
  factory $AppConfigSettingsItemCopyWith(AppConfigSettingsItem value, $Res Function(AppConfigSettingsItem) _then) = _$AppConfigSettingsItemCopyWithImpl;
@useResult
$Res call({
 bool enabled, String titleL10n, String type, String icon,@IntToStringOptionalConverter() String? embeddedResourceId
});




}
/// @nodoc
class _$AppConfigSettingsItemCopyWithImpl<$Res>
    implements $AppConfigSettingsItemCopyWith<$Res> {
  _$AppConfigSettingsItemCopyWithImpl(this._self, this._then);

  final AppConfigSettingsItem _self;
  final $Res Function(AppConfigSettingsItem) _then;

/// Create a copy of AppConfigSettingsItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? titleL10n = null,Object? type = null,Object? icon = null,Object? embeddedResourceId = freezed,}) {
  return _then(AppConfigSettingsItem(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,titleL10n: null == titleL10n ? _self.titleL10n : titleL10n // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,embeddedResourceId: freezed == embeddedResourceId ? _self.embeddedResourceId : embeddedResourceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigSettingsItem].
extension AppConfigSettingsItemPatterns on AppConfigSettingsItem {
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
