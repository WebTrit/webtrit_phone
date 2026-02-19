// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'caller_id_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrefixMatcher {

 String get prefix; String get number;
/// Create a copy of PrefixMatcher
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrefixMatcherCopyWith<PrefixMatcher> get copyWith => _$PrefixMatcherCopyWithImpl<PrefixMatcher>(this as PrefixMatcher, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrefixMatcher&&(identical(other.prefix, prefix) || other.prefix == prefix)&&(identical(other.number, number) || other.number == number));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefix,number);

@override
String toString() {
  return 'PrefixMatcher(prefix: $prefix, number: $number)';
}


}

/// @nodoc
abstract mixin class $PrefixMatcherCopyWith<$Res>  {
  factory $PrefixMatcherCopyWith(PrefixMatcher value, $Res Function(PrefixMatcher) _then) = _$PrefixMatcherCopyWithImpl;
@useResult
$Res call({
 String prefix, String number
});




}
/// @nodoc
class _$PrefixMatcherCopyWithImpl<$Res>
    implements $PrefixMatcherCopyWith<$Res> {
  _$PrefixMatcherCopyWithImpl(this._self, this._then);

  final PrefixMatcher _self;
  final $Res Function(PrefixMatcher) _then;

/// Create a copy of PrefixMatcher
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefix = null,Object? number = null,}) {
  return _then(PrefixMatcher(
prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PrefixMatcher].
extension PrefixMatcherPatterns on PrefixMatcher {
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
mixin _$CallerIdSettings {

 String? get defaultNumber; List<PrefixMatcher> get prefixMatchers; int get version; DateTime get modifiedAt;
/// Create a copy of CallerIdSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallerIdSettingsCopyWith<CallerIdSettings> get copyWith => _$CallerIdSettingsCopyWithImpl<CallerIdSettings>(this as CallerIdSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallerIdSettings&&(identical(other.defaultNumber, defaultNumber) || other.defaultNumber == defaultNumber)&&const DeepCollectionEquality().equals(other.prefixMatchers, prefixMatchers)&&(identical(other.version, version) || other.version == version)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultNumber,const DeepCollectionEquality().hash(prefixMatchers),version,modifiedAt);

@override
String toString() {
  return 'CallerIdSettings(defaultNumber: $defaultNumber, prefixMatchers: $prefixMatchers, version: $version, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class $CallerIdSettingsCopyWith<$Res>  {
  factory $CallerIdSettingsCopyWith(CallerIdSettings value, $Res Function(CallerIdSettings) _then) = _$CallerIdSettingsCopyWithImpl;
@useResult
$Res call({
 String? defaultNumber, List<PrefixMatcher> prefixMatchers, int version, DateTime modifiedAt
});




}
/// @nodoc
class _$CallerIdSettingsCopyWithImpl<$Res>
    implements $CallerIdSettingsCopyWith<$Res> {
  _$CallerIdSettingsCopyWithImpl(this._self, this._then);

  final CallerIdSettings _self;
  final $Res Function(CallerIdSettings) _then;

/// Create a copy of CallerIdSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultNumber = freezed,Object? prefixMatchers = null,Object? version = null,Object? modifiedAt = null,}) {
  return _then(CallerIdSettings(
defaultNumber: freezed == defaultNumber ? _self.defaultNumber : defaultNumber // ignore: cast_nullable_to_non_nullable
as String?,prefixMatchers: null == prefixMatchers ? _self.prefixMatchers : prefixMatchers // ignore: cast_nullable_to_non_nullable
as List<PrefixMatcher>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CallerIdSettings].
extension CallerIdSettingsPatterns on CallerIdSettings {
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
