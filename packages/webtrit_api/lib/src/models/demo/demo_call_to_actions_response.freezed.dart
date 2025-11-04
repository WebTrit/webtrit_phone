// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_call_to_actions_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemoCallToActionsResponse {

 List<DemoCallToActionsResponseActions> get actions;
/// Create a copy of DemoCallToActionsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemoCallToActionsResponseCopyWith<DemoCallToActionsResponse> get copyWith => _$DemoCallToActionsResponseCopyWithImpl<DemoCallToActionsResponse>(this as DemoCallToActionsResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemoCallToActionsResponse&&const DeepCollectionEquality().equals(other.actions, actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(actions));

@override
String toString() {
  return 'DemoCallToActionsResponse(actions: $actions)';
}


}

/// @nodoc
abstract mixin class $DemoCallToActionsResponseCopyWith<$Res>  {
  factory $DemoCallToActionsResponseCopyWith(DemoCallToActionsResponse value, $Res Function(DemoCallToActionsResponse) _then) = _$DemoCallToActionsResponseCopyWithImpl;
@useResult
$Res call({
 List<DemoCallToActionsResponseActions> actions
});




}
/// @nodoc
class _$DemoCallToActionsResponseCopyWithImpl<$Res>
    implements $DemoCallToActionsResponseCopyWith<$Res> {
  _$DemoCallToActionsResponseCopyWithImpl(this._self, this._then);

  final DemoCallToActionsResponse _self;
  final $Res Function(DemoCallToActionsResponse) _then;

/// Create a copy of DemoCallToActionsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actions = null,}) {
  return _then(DemoCallToActionsResponse(
actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<DemoCallToActionsResponseActions>,
  ));
}

}


/// Adds pattern-matching-related methods to [DemoCallToActionsResponse].
extension DemoCallToActionsResponsePatterns on DemoCallToActionsResponse {
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
mixin _$DemoCallToActionsResponseActions {

 String? get title; String? get description; String get url; DemoCallToActionsResponseActionsExtraData get extraData;
/// Create a copy of DemoCallToActionsResponseActions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemoCallToActionsResponseActionsCopyWith<DemoCallToActionsResponseActions> get copyWith => _$DemoCallToActionsResponseActionsCopyWithImpl<DemoCallToActionsResponseActions>(this as DemoCallToActionsResponseActions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemoCallToActionsResponseActions&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.extraData, extraData) || other.extraData == extraData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,url,extraData);

@override
String toString() {
  return 'DemoCallToActionsResponseActions(title: $title, description: $description, url: $url, extraData: $extraData)';
}


}

/// @nodoc
abstract mixin class $DemoCallToActionsResponseActionsCopyWith<$Res>  {
  factory $DemoCallToActionsResponseActionsCopyWith(DemoCallToActionsResponseActions value, $Res Function(DemoCallToActionsResponseActions) _then) = _$DemoCallToActionsResponseActionsCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, String url,@JsonKey(name: 'extra_data') DemoCallToActionsResponseActionsExtraData extraData
});




}
/// @nodoc
class _$DemoCallToActionsResponseActionsCopyWithImpl<$Res>
    implements $DemoCallToActionsResponseActionsCopyWith<$Res> {
  _$DemoCallToActionsResponseActionsCopyWithImpl(this._self, this._then);

  final DemoCallToActionsResponseActions _self;
  final $Res Function(DemoCallToActionsResponseActions) _then;

/// Create a copy of DemoCallToActionsResponseActions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? url = null,Object? extraData = null,}) {
  return _then(DemoCallToActionsResponseActions(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,extraData: null == extraData ? _self.extraData : extraData // ignore: cast_nullable_to_non_nullable
as DemoCallToActionsResponseActionsExtraData,
  ));
}

}


/// Adds pattern-matching-related methods to [DemoCallToActionsResponseActions].
extension DemoCallToActionsResponseActionsPatterns on DemoCallToActionsResponseActions {
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
mixin _$DemoCallToActionsResponseActionsExtraData {

 String get apiToken; String get tokenExpires;
/// Create a copy of DemoCallToActionsResponseActionsExtraData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemoCallToActionsResponseActionsExtraDataCopyWith<DemoCallToActionsResponseActionsExtraData> get copyWith => _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl<DemoCallToActionsResponseActionsExtraData>(this as DemoCallToActionsResponseActionsExtraData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemoCallToActionsResponseActionsExtraData&&(identical(other.apiToken, apiToken) || other.apiToken == apiToken)&&(identical(other.tokenExpires, tokenExpires) || other.tokenExpires == tokenExpires));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiToken,tokenExpires);

@override
String toString() {
  return 'DemoCallToActionsResponseActionsExtraData(apiToken: $apiToken, tokenExpires: $tokenExpires)';
}


}

/// @nodoc
abstract mixin class $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res>  {
  factory $DemoCallToActionsResponseActionsExtraDataCopyWith(DemoCallToActionsResponseActionsExtraData value, $Res Function(DemoCallToActionsResponseActionsExtraData) _then) = _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'api_token') String apiToken,@JsonKey(name: 'token_expires') String tokenExpires
});




}
/// @nodoc
class _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl<$Res>
    implements $DemoCallToActionsResponseActionsExtraDataCopyWith<$Res> {
  _$DemoCallToActionsResponseActionsExtraDataCopyWithImpl(this._self, this._then);

  final DemoCallToActionsResponseActionsExtraData _self;
  final $Res Function(DemoCallToActionsResponseActionsExtraData) _then;

/// Create a copy of DemoCallToActionsResponseActionsExtraData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiToken = null,Object? tokenExpires = null,}) {
  return _then(DemoCallToActionsResponseActionsExtraData(
apiToken: null == apiToken ? _self.apiToken : apiToken // ignore: cast_nullable_to_non_nullable
as String,tokenExpires: null == tokenExpires ? _self.tokenExpires : tokenExpires // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DemoCallToActionsResponseActionsExtraData].
extension DemoCallToActionsResponseActionsExtraDataPatterns on DemoCallToActionsResponseActionsExtraData {
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
