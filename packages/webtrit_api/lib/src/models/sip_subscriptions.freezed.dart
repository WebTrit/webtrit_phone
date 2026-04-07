// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sip_subscriptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SipSubscriptionsGetResult {

 bool get notModified; String get etag; SipSubscriptionsListResponse? get data;
/// Create a copy of SipSubscriptionsGetResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionsGetResultCopyWith<SipSubscriptionsGetResult> get copyWith => _$SipSubscriptionsGetResultCopyWithImpl<SipSubscriptionsGetResult>(this as SipSubscriptionsGetResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionsGetResult&&(identical(other.notModified, notModified) || other.notModified == notModified)&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,notModified,etag,data);

@override
String toString() {
  return 'SipSubscriptionsGetResult(notModified: $notModified, etag: $etag, data: $data)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionsGetResultCopyWith<$Res>  {
  factory $SipSubscriptionsGetResultCopyWith(SipSubscriptionsGetResult value, $Res Function(SipSubscriptionsGetResult) _then) = _$SipSubscriptionsGetResultCopyWithImpl;
@useResult
$Res call({
 bool notModified, String etag, SipSubscriptionsListResponse? data
});




}
/// @nodoc
class _$SipSubscriptionsGetResultCopyWithImpl<$Res>
    implements $SipSubscriptionsGetResultCopyWith<$Res> {
  _$SipSubscriptionsGetResultCopyWithImpl(this._self, this._then);

  final SipSubscriptionsGetResult _self;
  final $Res Function(SipSubscriptionsGetResult) _then;

/// Create a copy of SipSubscriptionsGetResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notModified = null,Object? etag = null,Object? data = freezed,}) {
  return _then(SipSubscriptionsGetResult(
notModified: null == notModified ? _self.notModified : notModified // ignore: cast_nullable_to_non_nullable
as bool,etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SipSubscriptionsListResponse?,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionsGetResult].
extension SipSubscriptionsGetResultPatterns on SipSubscriptionsGetResult {
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
mixin _$SipSubscriptionsListResponse {

 List<SipSubscriptionItem> get subscriptions;
/// Create a copy of SipSubscriptionsListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionsListResponseCopyWith<SipSubscriptionsListResponse> get copyWith => _$SipSubscriptionsListResponseCopyWithImpl<SipSubscriptionsListResponse>(this as SipSubscriptionsListResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionsListResponse&&const DeepCollectionEquality().equals(other.subscriptions, subscriptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(subscriptions));

@override
String toString() {
  return 'SipSubscriptionsListResponse(subscriptions: $subscriptions)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionsListResponseCopyWith<$Res>  {
  factory $SipSubscriptionsListResponseCopyWith(SipSubscriptionsListResponse value, $Res Function(SipSubscriptionsListResponse) _then) = _$SipSubscriptionsListResponseCopyWithImpl;
@useResult
$Res call({
 List<SipSubscriptionItem> subscriptions
});




}
/// @nodoc
class _$SipSubscriptionsListResponseCopyWithImpl<$Res>
    implements $SipSubscriptionsListResponseCopyWith<$Res> {
  _$SipSubscriptionsListResponseCopyWithImpl(this._self, this._then);

  final SipSubscriptionsListResponse _self;
  final $Res Function(SipSubscriptionsListResponse) _then;

/// Create a copy of SipSubscriptionsListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscriptions = null,}) {
  return _then(SipSubscriptionsListResponse(
subscriptions: null == subscriptions ? _self.subscriptions : subscriptions // ignore: cast_nullable_to_non_nullable
as List<SipSubscriptionItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionsListResponse].
extension SipSubscriptionsListResponsePatterns on SipSubscriptionsListResponse {
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
mixin _$SipSubscriptionItem {

 SipSubscriptionType get type; String get number; String get contactUserId; DateTime get subscribedAt;
/// Create a copy of SipSubscriptionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionItemCopyWith<SipSubscriptionItem> get copyWith => _$SipSubscriptionItemCopyWithImpl<SipSubscriptionItem>(this as SipSubscriptionItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionItem&&(identical(other.type, type) || other.type == type)&&(identical(other.number, number) || other.number == number)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.subscribedAt, subscribedAt) || other.subscribedAt == subscribedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,number,contactUserId,subscribedAt);

@override
String toString() {
  return 'SipSubscriptionItem(type: $type, number: $number, contactUserId: $contactUserId, subscribedAt: $subscribedAt)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionItemCopyWith<$Res>  {
  factory $SipSubscriptionItemCopyWith(SipSubscriptionItem value, $Res Function(SipSubscriptionItem) _then) = _$SipSubscriptionItemCopyWithImpl;
@useResult
$Res call({
 SipSubscriptionType type, String number, String contactUserId, DateTime subscribedAt
});




}
/// @nodoc
class _$SipSubscriptionItemCopyWithImpl<$Res>
    implements $SipSubscriptionItemCopyWith<$Res> {
  _$SipSubscriptionItemCopyWithImpl(this._self, this._then);

  final SipSubscriptionItem _self;
  final $Res Function(SipSubscriptionItem) _then;

/// Create a copy of SipSubscriptionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? number = null,Object? contactUserId = null,Object? subscribedAt = null,}) {
  return _then(SipSubscriptionItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SipSubscriptionType,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String,subscribedAt: null == subscribedAt ? _self.subscribedAt : subscribedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionItem].
extension SipSubscriptionItemPatterns on SipSubscriptionItem {
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
mixin _$SipSubscriptionBatchAction {

 SipSubscriptionBatchActionType get action; SipSubscriptionType get type; String get number; String get contactUserId; DateTime? get subscribedAt;
/// Create a copy of SipSubscriptionBatchAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionBatchActionCopyWith<SipSubscriptionBatchAction> get copyWith => _$SipSubscriptionBatchActionCopyWithImpl<SipSubscriptionBatchAction>(this as SipSubscriptionBatchAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionBatchAction&&(identical(other.action, action) || other.action == action)&&(identical(other.type, type) || other.type == type)&&(identical(other.number, number) || other.number == number)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.subscribedAt, subscribedAt) || other.subscribedAt == subscribedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,type,number,contactUserId,subscribedAt);

@override
String toString() {
  return 'SipSubscriptionBatchAction(action: $action, type: $type, number: $number, contactUserId: $contactUserId, subscribedAt: $subscribedAt)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionBatchActionCopyWith<$Res>  {
  factory $SipSubscriptionBatchActionCopyWith(SipSubscriptionBatchAction value, $Res Function(SipSubscriptionBatchAction) _then) = _$SipSubscriptionBatchActionCopyWithImpl;
@useResult
$Res call({
 SipSubscriptionBatchActionType action, SipSubscriptionType type, String number, String contactUserId, DateTime? subscribedAt
});




}
/// @nodoc
class _$SipSubscriptionBatchActionCopyWithImpl<$Res>
    implements $SipSubscriptionBatchActionCopyWith<$Res> {
  _$SipSubscriptionBatchActionCopyWithImpl(this._self, this._then);

  final SipSubscriptionBatchAction _self;
  final $Res Function(SipSubscriptionBatchAction) _then;

/// Create a copy of SipSubscriptionBatchAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? type = null,Object? number = null,Object? contactUserId = null,Object? subscribedAt = freezed,}) {
  return _then(SipSubscriptionBatchAction(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SipSubscriptionBatchActionType,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SipSubscriptionType,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String,subscribedAt: freezed == subscribedAt ? _self.subscribedAt : subscribedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionBatchAction].
extension SipSubscriptionBatchActionPatterns on SipSubscriptionBatchAction {
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
mixin _$SipSubscriptionBatchSyncResult {

 SipSubscriptionBatchSyncResponse get data; String get etag;
/// Create a copy of SipSubscriptionBatchSyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionBatchSyncResultCopyWith<SipSubscriptionBatchSyncResult> get copyWith => _$SipSubscriptionBatchSyncResultCopyWithImpl<SipSubscriptionBatchSyncResult>(this as SipSubscriptionBatchSyncResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionBatchSyncResult&&(identical(other.data, data) || other.data == data)&&(identical(other.etag, etag) || other.etag == etag));
}


@override
int get hashCode => Object.hash(runtimeType,data,etag);

@override
String toString() {
  return 'SipSubscriptionBatchSyncResult(data: $data, etag: $etag)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionBatchSyncResultCopyWith<$Res>  {
  factory $SipSubscriptionBatchSyncResultCopyWith(SipSubscriptionBatchSyncResult value, $Res Function(SipSubscriptionBatchSyncResult) _then) = _$SipSubscriptionBatchSyncResultCopyWithImpl;
@useResult
$Res call({
 SipSubscriptionBatchSyncResponse data, String etag
});




}
/// @nodoc
class _$SipSubscriptionBatchSyncResultCopyWithImpl<$Res>
    implements $SipSubscriptionBatchSyncResultCopyWith<$Res> {
  _$SipSubscriptionBatchSyncResultCopyWithImpl(this._self, this._then);

  final SipSubscriptionBatchSyncResult _self;
  final $Res Function(SipSubscriptionBatchSyncResult) _then;

/// Create a copy of SipSubscriptionBatchSyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? etag = null,}) {
  return _then(SipSubscriptionBatchSyncResult(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SipSubscriptionBatchSyncResponse,etag: null == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionBatchSyncResult].
extension SipSubscriptionBatchSyncResultPatterns on SipSubscriptionBatchSyncResult {
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
mixin _$SipSubscriptionBatchSyncResponse {

 List<SipSubscriptionItem> get subscriptions; List<SipSubscriptionBatchConflict> get conflicts;
/// Create a copy of SipSubscriptionBatchSyncResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionBatchSyncResponseCopyWith<SipSubscriptionBatchSyncResponse> get copyWith => _$SipSubscriptionBatchSyncResponseCopyWithImpl<SipSubscriptionBatchSyncResponse>(this as SipSubscriptionBatchSyncResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionBatchSyncResponse&&const DeepCollectionEquality().equals(other.subscriptions, subscriptions)&&const DeepCollectionEquality().equals(other.conflicts, conflicts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(subscriptions),const DeepCollectionEquality().hash(conflicts));

@override
String toString() {
  return 'SipSubscriptionBatchSyncResponse(subscriptions: $subscriptions, conflicts: $conflicts)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionBatchSyncResponseCopyWith<$Res>  {
  factory $SipSubscriptionBatchSyncResponseCopyWith(SipSubscriptionBatchSyncResponse value, $Res Function(SipSubscriptionBatchSyncResponse) _then) = _$SipSubscriptionBatchSyncResponseCopyWithImpl;
@useResult
$Res call({
 List<SipSubscriptionItem> subscriptions, List<SipSubscriptionBatchConflict> conflicts
});




}
/// @nodoc
class _$SipSubscriptionBatchSyncResponseCopyWithImpl<$Res>
    implements $SipSubscriptionBatchSyncResponseCopyWith<$Res> {
  _$SipSubscriptionBatchSyncResponseCopyWithImpl(this._self, this._then);

  final SipSubscriptionBatchSyncResponse _self;
  final $Res Function(SipSubscriptionBatchSyncResponse) _then;

/// Create a copy of SipSubscriptionBatchSyncResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscriptions = null,Object? conflicts = null,}) {
  return _then(SipSubscriptionBatchSyncResponse(
subscriptions: null == subscriptions ? _self.subscriptions : subscriptions // ignore: cast_nullable_to_non_nullable
as List<SipSubscriptionItem>,conflicts: null == conflicts ? _self.conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<SipSubscriptionBatchConflict>,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionBatchSyncResponse].
extension SipSubscriptionBatchSyncResponsePatterns on SipSubscriptionBatchSyncResponse {
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
mixin _$SipSubscriptionBatchConflict {

 SipSubscriptionBatchActionType get action; SipSubscriptionType get type; String get number; String? get contactUserId; SipSubscriptionBatchConflictReason get reason;
/// Create a copy of SipSubscriptionBatchConflict
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SipSubscriptionBatchConflictCopyWith<SipSubscriptionBatchConflict> get copyWith => _$SipSubscriptionBatchConflictCopyWithImpl<SipSubscriptionBatchConflict>(this as SipSubscriptionBatchConflict, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SipSubscriptionBatchConflict&&(identical(other.action, action) || other.action == action)&&(identical(other.type, type) || other.type == type)&&(identical(other.number, number) || other.number == number)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,type,number,contactUserId,reason);

@override
String toString() {
  return 'SipSubscriptionBatchConflict(action: $action, type: $type, number: $number, contactUserId: $contactUserId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $SipSubscriptionBatchConflictCopyWith<$Res>  {
  factory $SipSubscriptionBatchConflictCopyWith(SipSubscriptionBatchConflict value, $Res Function(SipSubscriptionBatchConflict) _then) = _$SipSubscriptionBatchConflictCopyWithImpl;
@useResult
$Res call({
 SipSubscriptionBatchActionType action, SipSubscriptionType type, String number, String? contactUserId, SipSubscriptionBatchConflictReason reason
});




}
/// @nodoc
class _$SipSubscriptionBatchConflictCopyWithImpl<$Res>
    implements $SipSubscriptionBatchConflictCopyWith<$Res> {
  _$SipSubscriptionBatchConflictCopyWithImpl(this._self, this._then);

  final SipSubscriptionBatchConflict _self;
  final $Res Function(SipSubscriptionBatchConflict) _then;

/// Create a copy of SipSubscriptionBatchConflict
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? type = null,Object? number = null,Object? contactUserId = freezed,Object? reason = null,}) {
  return _then(SipSubscriptionBatchConflict(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SipSubscriptionBatchActionType,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SipSubscriptionType,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,contactUserId: freezed == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SipSubscriptionBatchConflictReason,
  ));
}

}


/// Adds pattern-matching-related methods to [SipSubscriptionBatchConflict].
extension SipSubscriptionBatchConflictPatterns on SipSubscriptionBatchConflict {
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
