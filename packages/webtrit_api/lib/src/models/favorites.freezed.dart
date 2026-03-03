// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesGetResult {

 bool get notModified; String get etag; FavoritesListResponse? get data;
/// Create a copy of FavoritesGetResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesGetResultCopyWith<FavoritesGetResult> get copyWith => _$FavoritesGetResultCopyWithImpl<FavoritesGetResult>(this as FavoritesGetResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesGetResult&&(identical(other.notModified, notModified) || other.notModified == notModified)&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,notModified,etag,data);

@override
String toString() {
  return 'FavoritesGetResult(notModified: $notModified, etag: $etag, data: $data)';
}


}

/// @nodoc
abstract mixin class $FavoritesGetResultCopyWith<$Res>  {
  factory $FavoritesGetResultCopyWith(FavoritesGetResult value, $Res Function(FavoritesGetResult) _then) = _$FavoritesGetResultCopyWithImpl;
@useResult
$Res call({
 bool notModified, String etag, FavoritesListResponse? data
});




}
/// @nodoc
class _$FavoritesGetResultCopyWithImpl<$Res>
    implements $FavoritesGetResultCopyWith<$Res> {
  _$FavoritesGetResultCopyWithImpl(this._self, this._then);

  final FavoritesGetResult _self;
  final $Res Function(FavoritesGetResult) _then;

/// Create a copy of FavoritesGetResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notModified = null,Object? etag = null,Object? data = freezed,}) {
  return _then(FavoritesGetResult(
notModified: null == notModified ? _self.notModified : notModified // ignore: cast_nullable_to_non_nullable
as bool,etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FavoritesListResponse?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesGetResult].
extension FavoritesGetResultPatterns on FavoritesGetResult {
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
mixin _$FavoritesListResponse {

 List<FavoriteItem> get items;
/// Create a copy of FavoritesListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesListResponseCopyWith<FavoritesListResponse> get copyWith => _$FavoritesListResponseCopyWithImpl<FavoritesListResponse>(this as FavoritesListResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesListResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FavoritesListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $FavoritesListResponseCopyWith<$Res>  {
  factory $FavoritesListResponseCopyWith(FavoritesListResponse value, $Res Function(FavoritesListResponse) _then) = _$FavoritesListResponseCopyWithImpl;
@useResult
$Res call({
 List<FavoriteItem> items
});




}
/// @nodoc
class _$FavoritesListResponseCopyWithImpl<$Res>
    implements $FavoritesListResponseCopyWith<$Res> {
  _$FavoritesListResponseCopyWithImpl(this._self, this._then);

  final FavoritesListResponse _self;
  final $Res Function(FavoritesListResponse) _then;

/// Create a copy of FavoritesListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(FavoritesListResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FavoriteItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesListResponse].
extension FavoritesListResponsePatterns on FavoritesListResponse {
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
mixin _$FavoriteItem {

 String get number; FavoriteSourceType get sourceType; String get sourceId; String get label; int get position;
/// Create a copy of FavoriteItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteItemCopyWith<FavoriteItem> get copyWith => _$FavoriteItemCopyWithImpl<FavoriteItem>(this as FavoriteItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteItem&&(identical(other.number, number) || other.number == number)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,sourceType,sourceId,label,position);

@override
String toString() {
  return 'FavoriteItem(number: $number, sourceType: $sourceType, sourceId: $sourceId, label: $label, position: $position)';
}


}

/// @nodoc
abstract mixin class $FavoriteItemCopyWith<$Res>  {
  factory $FavoriteItemCopyWith(FavoriteItem value, $Res Function(FavoriteItem) _then) = _$FavoriteItemCopyWithImpl;
@useResult
$Res call({
 String number, FavoriteSourceType sourceType, String sourceId, String label, int position
});




}
/// @nodoc
class _$FavoriteItemCopyWithImpl<$Res>
    implements $FavoriteItemCopyWith<$Res> {
  _$FavoriteItemCopyWithImpl(this._self, this._then);

  final FavoriteItem _self;
  final $Res Function(FavoriteItem) _then;

/// Create a copy of FavoriteItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? sourceType = null,Object? sourceId = null,Object? label = null,Object? position = null,}) {
  return _then(FavoriteItem(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as FavoriteSourceType,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteItem].
extension FavoriteItemPatterns on FavoriteItem {
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
mixin _$FavoriteBatchAction {

 FavoriteBatchActionType get action; String get number; FavoriteSourceType get sourceType; String? get sourceId; String? get label; int? get position;
/// Create a copy of FavoriteBatchAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteBatchActionCopyWith<FavoriteBatchAction> get copyWith => _$FavoriteBatchActionCopyWithImpl<FavoriteBatchAction>(this as FavoriteBatchAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteBatchAction&&(identical(other.action, action) || other.action == action)&&(identical(other.number, number) || other.number == number)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,number,sourceType,sourceId,label,position);

@override
String toString() {
  return 'FavoriteBatchAction(action: $action, number: $number, sourceType: $sourceType, sourceId: $sourceId, label: $label, position: $position)';
}


}

/// @nodoc
abstract mixin class $FavoriteBatchActionCopyWith<$Res>  {
  factory $FavoriteBatchActionCopyWith(FavoriteBatchAction value, $Res Function(FavoriteBatchAction) _then) = _$FavoriteBatchActionCopyWithImpl;
@useResult
$Res call({
 FavoriteBatchActionType action, String number, FavoriteSourceType sourceType, String? sourceId, String? label, int? position
});




}
/// @nodoc
class _$FavoriteBatchActionCopyWithImpl<$Res>
    implements $FavoriteBatchActionCopyWith<$Res> {
  _$FavoriteBatchActionCopyWithImpl(this._self, this._then);

  final FavoriteBatchAction _self;
  final $Res Function(FavoriteBatchAction) _then;

/// Create a copy of FavoriteBatchAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? number = null,Object? sourceType = null,Object? sourceId = freezed,Object? label = freezed,Object? position = freezed,}) {
  return _then(FavoriteBatchAction(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FavoriteBatchActionType,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as FavoriteSourceType,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteBatchAction].
extension FavoriteBatchActionPatterns on FavoriteBatchAction {
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
mixin _$FavoriteBatchSyncResult {

 FavoriteBatchSyncResponse get data; String get etag;
/// Create a copy of FavoriteBatchSyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteBatchSyncResultCopyWith<FavoriteBatchSyncResult> get copyWith => _$FavoriteBatchSyncResultCopyWithImpl<FavoriteBatchSyncResult>(this as FavoriteBatchSyncResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteBatchSyncResult&&(identical(other.data, data) || other.data == data)&&(identical(other.etag, etag) || other.etag == etag));
}


@override
int get hashCode => Object.hash(runtimeType,data,etag);

@override
String toString() {
  return 'FavoriteBatchSyncResult(data: $data, etag: $etag)';
}


}

/// @nodoc
abstract mixin class $FavoriteBatchSyncResultCopyWith<$Res>  {
  factory $FavoriteBatchSyncResultCopyWith(FavoriteBatchSyncResult value, $Res Function(FavoriteBatchSyncResult) _then) = _$FavoriteBatchSyncResultCopyWithImpl;
@useResult
$Res call({
 FavoriteBatchSyncResponse data, String etag
});




}
/// @nodoc
class _$FavoriteBatchSyncResultCopyWithImpl<$Res>
    implements $FavoriteBatchSyncResultCopyWith<$Res> {
  _$FavoriteBatchSyncResultCopyWithImpl(this._self, this._then);

  final FavoriteBatchSyncResult _self;
  final $Res Function(FavoriteBatchSyncResult) _then;

/// Create a copy of FavoriteBatchSyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? etag = null,}) {
  return _then(FavoriteBatchSyncResult(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FavoriteBatchSyncResponse,etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteBatchSyncResult].
extension FavoriteBatchSyncResultPatterns on FavoriteBatchSyncResult {
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
mixin _$FavoriteBatchSyncResponse {

 List<FavoriteItem> get items; List<FavoriteBatchConflict> get conflicts;
/// Create a copy of FavoriteBatchSyncResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteBatchSyncResponseCopyWith<FavoriteBatchSyncResponse> get copyWith => _$FavoriteBatchSyncResponseCopyWithImpl<FavoriteBatchSyncResponse>(this as FavoriteBatchSyncResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteBatchSyncResponse&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.conflicts, conflicts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(conflicts));

@override
String toString() {
  return 'FavoriteBatchSyncResponse(items: $items, conflicts: $conflicts)';
}


}

/// @nodoc
abstract mixin class $FavoriteBatchSyncResponseCopyWith<$Res>  {
  factory $FavoriteBatchSyncResponseCopyWith(FavoriteBatchSyncResponse value, $Res Function(FavoriteBatchSyncResponse) _then) = _$FavoriteBatchSyncResponseCopyWithImpl;
@useResult
$Res call({
 List<FavoriteItem> items, List<FavoriteBatchConflict> conflicts
});




}
/// @nodoc
class _$FavoriteBatchSyncResponseCopyWithImpl<$Res>
    implements $FavoriteBatchSyncResponseCopyWith<$Res> {
  _$FavoriteBatchSyncResponseCopyWithImpl(this._self, this._then);

  final FavoriteBatchSyncResponse _self;
  final $Res Function(FavoriteBatchSyncResponse) _then;

/// Create a copy of FavoriteBatchSyncResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? conflicts = null,}) {
  return _then(FavoriteBatchSyncResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FavoriteItem>,conflicts: null == conflicts ? _self.conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<FavoriteBatchConflict>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteBatchSyncResponse].
extension FavoriteBatchSyncResponsePatterns on FavoriteBatchSyncResponse {
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
mixin _$FavoriteBatchConflict {

 FavoriteBatchActionType get action; String get number; FavoriteSourceType get sourceType; FavoriteBatchConflictReason get reason;
/// Create a copy of FavoriteBatchConflict
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteBatchConflictCopyWith<FavoriteBatchConflict> get copyWith => _$FavoriteBatchConflictCopyWithImpl<FavoriteBatchConflict>(this as FavoriteBatchConflict, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteBatchConflict&&(identical(other.action, action) || other.action == action)&&(identical(other.number, number) || other.number == number)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,number,sourceType,reason);

@override
String toString() {
  return 'FavoriteBatchConflict(action: $action, number: $number, sourceType: $sourceType, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FavoriteBatchConflictCopyWith<$Res>  {
  factory $FavoriteBatchConflictCopyWith(FavoriteBatchConflict value, $Res Function(FavoriteBatchConflict) _then) = _$FavoriteBatchConflictCopyWithImpl;
@useResult
$Res call({
 FavoriteBatchActionType action, String number, FavoriteSourceType sourceType, FavoriteBatchConflictReason reason
});




}
/// @nodoc
class _$FavoriteBatchConflictCopyWithImpl<$Res>
    implements $FavoriteBatchConflictCopyWith<$Res> {
  _$FavoriteBatchConflictCopyWithImpl(this._self, this._then);

  final FavoriteBatchConflict _self;
  final $Res Function(FavoriteBatchConflict) _then;

/// Create a copy of FavoriteBatchConflict
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? number = null,Object? sourceType = null,Object? reason = null,}) {
  return _then(FavoriteBatchConflict(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FavoriteBatchActionType,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as FavoriteSourceType,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as FavoriteBatchConflictReason,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteBatchConflict].
extension FavoriteBatchConflictPatterns on FavoriteBatchConflict {
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
