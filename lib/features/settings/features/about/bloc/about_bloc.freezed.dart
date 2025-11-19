// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AboutState {

 bool get progress; List<String> get embeddedLinks; String get packageName; String get appIdentifier; Uri get coreUrl; String get userAgent; String? get fcmPushToken; Version? get coreVersion;
/// Create a copy of AboutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AboutStateCopyWith<AboutState> get copyWith => _$AboutStateCopyWithImpl<AboutState>(this as AboutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AboutState&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.embeddedLinks, embeddedLinks)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.appIdentifier, appIdentifier) || other.appIdentifier == appIdentifier)&&(identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.fcmPushToken, fcmPushToken) || other.fcmPushToken == fcmPushToken)&&(identical(other.coreVersion, coreVersion) || other.coreVersion == coreVersion));
}


@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(embeddedLinks),packageName,appIdentifier,coreUrl,userAgent,fcmPushToken,coreVersion);

@override
String toString() {
  return 'AboutState(progress: $progress, embeddedLinks: $embeddedLinks, packageName: $packageName, appIdentifier: $appIdentifier, coreUrl: $coreUrl, userAgent: $userAgent, fcmPushToken: $fcmPushToken, coreVersion: $coreVersion)';
}


}

/// @nodoc
abstract mixin class $AboutStateCopyWith<$Res>  {
  factory $AboutStateCopyWith(AboutState value, $Res Function(AboutState) _then) = _$AboutStateCopyWithImpl;
@useResult
$Res call({
 bool progress, List<String> embeddedLinks, String packageName, String appIdentifier, Uri coreUrl, String userAgent, String? fcmPushToken, Version? coreVersion
});




}
/// @nodoc
class _$AboutStateCopyWithImpl<$Res>
    implements $AboutStateCopyWith<$Res> {
  _$AboutStateCopyWithImpl(this._self, this._then);

  final AboutState _self;
  final $Res Function(AboutState) _then;

/// Create a copy of AboutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? embeddedLinks = null,Object? packageName = null,Object? appIdentifier = null,Object? coreUrl = null,Object? userAgent = null,Object? fcmPushToken = freezed,Object? coreVersion = freezed,}) {
  return _then(AboutState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as bool,embeddedLinks: null == embeddedLinks ? _self.embeddedLinks : embeddedLinks // ignore: cast_nullable_to_non_nullable
as List<String>,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,appIdentifier: null == appIdentifier ? _self.appIdentifier : appIdentifier // ignore: cast_nullable_to_non_nullable
as String,coreUrl: null == coreUrl ? _self.coreUrl : coreUrl // ignore: cast_nullable_to_non_nullable
as Uri,userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,fcmPushToken: freezed == fcmPushToken ? _self.fcmPushToken : fcmPushToken // ignore: cast_nullable_to_non_nullable
as String?,coreVersion: freezed == coreVersion ? _self.coreVersion : coreVersion // ignore: cast_nullable_to_non_nullable
as Version?,
  ));
}

}


/// Adds pattern-matching-related methods to [AboutState].
extension AboutStatePatterns on AboutState {
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
