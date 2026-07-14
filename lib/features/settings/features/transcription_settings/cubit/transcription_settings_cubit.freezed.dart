// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcription_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranscriptionSettingsState {

 String get defaultModel; String get selectedModel; Set<String> get downloadedModels; ModelDownloadState get downloadState;
/// Create a copy of TranscriptionSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptionSettingsStateCopyWith<TranscriptionSettingsState> get copyWith => _$TranscriptionSettingsStateCopyWithImpl<TranscriptionSettingsState>(this as TranscriptionSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptionSettingsState&&(identical(other.defaultModel, defaultModel) || other.defaultModel == defaultModel)&&(identical(other.selectedModel, selectedModel) || other.selectedModel == selectedModel)&&const DeepCollectionEquality().equals(other.downloadedModels, downloadedModels)&&(identical(other.downloadState, downloadState) || other.downloadState == downloadState));
}


@override
int get hashCode => Object.hash(runtimeType,defaultModel,selectedModel,const DeepCollectionEquality().hash(downloadedModels),downloadState);

@override
String toString() {
  return 'TranscriptionSettingsState(defaultModel: $defaultModel, selectedModel: $selectedModel, downloadedModels: $downloadedModels, downloadState: $downloadState)';
}


}

/// @nodoc
abstract mixin class $TranscriptionSettingsStateCopyWith<$Res>  {
  factory $TranscriptionSettingsStateCopyWith(TranscriptionSettingsState value, $Res Function(TranscriptionSettingsState) _then) = _$TranscriptionSettingsStateCopyWithImpl;
@useResult
$Res call({
 String defaultModel, String selectedModel, Set<String> downloadedModels, ModelDownloadState downloadState
});




}
/// @nodoc
class _$TranscriptionSettingsStateCopyWithImpl<$Res>
    implements $TranscriptionSettingsStateCopyWith<$Res> {
  _$TranscriptionSettingsStateCopyWithImpl(this._self, this._then);

  final TranscriptionSettingsState _self;
  final $Res Function(TranscriptionSettingsState) _then;

/// Create a copy of TranscriptionSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultModel = null,Object? selectedModel = null,Object? downloadedModels = null,Object? downloadState = null,}) {
  return _then(TranscriptionSettingsState(
defaultModel: null == defaultModel ? _self.defaultModel : defaultModel // ignore: cast_nullable_to_non_nullable
as String,selectedModel: null == selectedModel ? _self.selectedModel : selectedModel // ignore: cast_nullable_to_non_nullable
as String,downloadedModels: null == downloadedModels ? _self.downloadedModels : downloadedModels // ignore: cast_nullable_to_non_nullable
as Set<String>,downloadState: null == downloadState ? _self.downloadState : downloadState // ignore: cast_nullable_to_non_nullable
as ModelDownloadState,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptionSettingsState].
extension TranscriptionSettingsStatePatterns on TranscriptionSettingsState {
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
