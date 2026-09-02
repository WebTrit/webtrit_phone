// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_widget_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeWidgetConfig {

 FontsConfig get fonts; ButtonWidgetConfig get button; GroupWidgetConfig? get group; BarWidgetConfig get bar; ImageAssetsConfig get imageAssets; InputWidgetConfig get input; TextWidgetConfig get text; DialogWidgetConfig get dialog; StatusesWidgetConfig get statuses;
/// Create a copy of ThemeWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeWidgetConfigCopyWith<ThemeWidgetConfig> get copyWith => _$ThemeWidgetConfigCopyWithImpl<ThemeWidgetConfig>(this as ThemeWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeWidgetConfig&&(identical(other.fonts, fonts) || other.fonts == fonts)&&(identical(other.button, button) || other.button == button)&&(identical(other.group, group) || other.group == group)&&(identical(other.bar, bar) || other.bar == bar)&&(identical(other.imageAssets, imageAssets) || other.imageAssets == imageAssets)&&(identical(other.input, input) || other.input == input)&&(identical(other.text, text) || other.text == text)&&(identical(other.dialog, dialog) || other.dialog == dialog)&&(identical(other.statuses, statuses) || other.statuses == statuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fonts,button,group,bar,imageAssets,input,text,dialog,statuses);

@override
String toString() {
  return 'ThemeWidgetConfig(fonts: $fonts, button: $button, group: $group, bar: $bar, imageAssets: $imageAssets, input: $input, text: $text, dialog: $dialog, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class $ThemeWidgetConfigCopyWith<$Res>  {
  factory $ThemeWidgetConfigCopyWith(ThemeWidgetConfig value, $Res Function(ThemeWidgetConfig) _then) = _$ThemeWidgetConfigCopyWithImpl;
@useResult
$Res call({
 FontsConfig fonts, ButtonWidgetConfig button, GroupWidgetConfig? group, BarWidgetConfig bar, ImageAssetsConfig imageAssets, InputWidgetConfig input, TextWidgetConfig text, DialogWidgetConfig dialog, StatusesWidgetConfig statuses
});




}
/// @nodoc
class _$ThemeWidgetConfigCopyWithImpl<$Res>
    implements $ThemeWidgetConfigCopyWith<$Res> {
  _$ThemeWidgetConfigCopyWithImpl(this._self, this._then);

  final ThemeWidgetConfig _self;
  final $Res Function(ThemeWidgetConfig) _then;

/// Create a copy of ThemeWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fonts = null,Object? button = null,Object? group = freezed,Object? bar = null,Object? imageAssets = null,Object? input = null,Object? text = null,Object? dialog = null,Object? statuses = null,}) {
  return _then(ThemeWidgetConfig(
fonts: null == fonts ? _self.fonts : fonts // ignore: cast_nullable_to_non_nullable
as FontsConfig,button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonWidgetConfig,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GroupWidgetConfig?,bar: null == bar ? _self.bar : bar // ignore: cast_nullable_to_non_nullable
as BarWidgetConfig,imageAssets: null == imageAssets ? _self.imageAssets : imageAssets // ignore: cast_nullable_to_non_nullable
as ImageAssetsConfig,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as InputWidgetConfig,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as TextWidgetConfig,dialog: null == dialog ? _self.dialog : dialog // ignore: cast_nullable_to_non_nullable
as DialogWidgetConfig,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as StatusesWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeWidgetConfig].
extension ThemeWidgetConfigPatterns on ThemeWidgetConfig {
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
mixin _$FontsConfig {

 String? get fontFamily;
/// Create a copy of FontsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FontsConfigCopyWith<FontsConfig> get copyWith => _$FontsConfigCopyWithImpl<FontsConfig>(this as FontsConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FontsConfig&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fontFamily);

@override
String toString() {
  return 'FontsConfig(fontFamily: $fontFamily)';
}


}

/// @nodoc
abstract mixin class $FontsConfigCopyWith<$Res>  {
  factory $FontsConfigCopyWith(FontsConfig value, $Res Function(FontsConfig) _then) = _$FontsConfigCopyWithImpl;
@useResult
$Res call({
 String? fontFamily
});




}
/// @nodoc
class _$FontsConfigCopyWithImpl<$Res>
    implements $FontsConfigCopyWith<$Res> {
  _$FontsConfigCopyWithImpl(this._self, this._then);

  final FontsConfig _self;
  final $Res Function(FontsConfig) _then;

/// Create a copy of FontsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fontFamily = freezed,}) {
  return _then(FontsConfig(
fontFamily: freezed == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FontsConfig].
extension FontsConfigPatterns on FontsConfig {
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
mixin _$ButtonWidgetConfig {

 ButtonStyleConfig? get primaryElevatedButton;
/// Create a copy of ButtonWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonWidgetConfigCopyWith<ButtonWidgetConfig> get copyWith => _$ButtonWidgetConfigCopyWithImpl<ButtonWidgetConfig>(this as ButtonWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonWidgetConfig&&(identical(other.primaryElevatedButton, primaryElevatedButton) || other.primaryElevatedButton == primaryElevatedButton));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primaryElevatedButton);

@override
String toString() {
  return 'ButtonWidgetConfig(primaryElevatedButton: $primaryElevatedButton)';
}


}

/// @nodoc
abstract mixin class $ButtonWidgetConfigCopyWith<$Res>  {
  factory $ButtonWidgetConfigCopyWith(ButtonWidgetConfig value, $Res Function(ButtonWidgetConfig) _then) = _$ButtonWidgetConfigCopyWithImpl;
@useResult
$Res call({
 ButtonStyleConfig? primaryElevatedButton
});




}
/// @nodoc
class _$ButtonWidgetConfigCopyWithImpl<$Res>
    implements $ButtonWidgetConfigCopyWith<$Res> {
  _$ButtonWidgetConfigCopyWithImpl(this._self, this._then);

  final ButtonWidgetConfig _self;
  final $Res Function(ButtonWidgetConfig) _then;

/// Create a copy of ButtonWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primaryElevatedButton = freezed,}) {
  return _then(ButtonWidgetConfig(
primaryElevatedButton: freezed == primaryElevatedButton ? _self.primaryElevatedButton : primaryElevatedButton // ignore: cast_nullable_to_non_nullable
as ButtonStyleConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonWidgetConfig].
extension ButtonWidgetConfigPatterns on ButtonWidgetConfig {
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
mixin _$GroupWidgetConfig {

 GroupTitleListTileWidgetConfig get groupTitleListTile;
/// Create a copy of GroupWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupWidgetConfigCopyWith<GroupWidgetConfig> get copyWith => _$GroupWidgetConfigCopyWithImpl<GroupWidgetConfig>(this as GroupWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupWidgetConfig&&(identical(other.groupTitleListTile, groupTitleListTile) || other.groupTitleListTile == groupTitleListTile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupTitleListTile);

@override
String toString() {
  return 'GroupWidgetConfig(groupTitleListTile: $groupTitleListTile)';
}


}

/// @nodoc
abstract mixin class $GroupWidgetConfigCopyWith<$Res>  {
  factory $GroupWidgetConfigCopyWith(GroupWidgetConfig value, $Res Function(GroupWidgetConfig) _then) = _$GroupWidgetConfigCopyWithImpl;
@useResult
$Res call({
 GroupTitleListTileWidgetConfig groupTitleListTile
});




}
/// @nodoc
class _$GroupWidgetConfigCopyWithImpl<$Res>
    implements $GroupWidgetConfigCopyWith<$Res> {
  _$GroupWidgetConfigCopyWithImpl(this._self, this._then);

  final GroupWidgetConfig _self;
  final $Res Function(GroupWidgetConfig) _then;

/// Create a copy of GroupWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupTitleListTile = null,}) {
  return _then(GroupWidgetConfig(
groupTitleListTile: null == groupTitleListTile ? _self.groupTitleListTile : groupTitleListTile // ignore: cast_nullable_to_non_nullable
as GroupTitleListTileWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupWidgetConfig].
extension GroupWidgetConfigPatterns on GroupWidgetConfig {
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
mixin _$BarWidgetConfig {

 BottomNavigationBarWidgetConfig get bottomNavigationBar; AppBarConfig get appBarConfig; TabBarConfig get tabBarConfig;
/// Create a copy of BarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarWidgetConfigCopyWith<BarWidgetConfig> get copyWith => _$BarWidgetConfigCopyWithImpl<BarWidgetConfig>(this as BarWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarWidgetConfig&&(identical(other.bottomNavigationBar, bottomNavigationBar) || other.bottomNavigationBar == bottomNavigationBar)&&(identical(other.appBarConfig, appBarConfig) || other.appBarConfig == appBarConfig)&&(identical(other.tabBarConfig, tabBarConfig) || other.tabBarConfig == tabBarConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bottomNavigationBar,appBarConfig,tabBarConfig);

@override
String toString() {
  return 'BarWidgetConfig(bottomNavigationBar: $bottomNavigationBar, appBarConfig: $appBarConfig, tabBarConfig: $tabBarConfig)';
}


}

/// @nodoc
abstract mixin class $BarWidgetConfigCopyWith<$Res>  {
  factory $BarWidgetConfigCopyWith(BarWidgetConfig value, $Res Function(BarWidgetConfig) _then) = _$BarWidgetConfigCopyWithImpl;
@useResult
$Res call({
 BottomNavigationBarWidgetConfig bottomNavigationBar, AppBarConfig appBarConfig, TabBarConfig tabBarConfig
});




}
/// @nodoc
class _$BarWidgetConfigCopyWithImpl<$Res>
    implements $BarWidgetConfigCopyWith<$Res> {
  _$BarWidgetConfigCopyWithImpl(this._self, this._then);

  final BarWidgetConfig _self;
  final $Res Function(BarWidgetConfig) _then;

/// Create a copy of BarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bottomNavigationBar = null,Object? appBarConfig = null,Object? tabBarConfig = null,}) {
  return _then(BarWidgetConfig(
bottomNavigationBar: null == bottomNavigationBar ? _self.bottomNavigationBar : bottomNavigationBar // ignore: cast_nullable_to_non_nullable
as BottomNavigationBarWidgetConfig,appBarConfig: null == appBarConfig ? _self.appBarConfig : appBarConfig // ignore: cast_nullable_to_non_nullable
as AppBarConfig,tabBarConfig: null == tabBarConfig ? _self.tabBarConfig : tabBarConfig // ignore: cast_nullable_to_non_nullable
as TabBarConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [BarWidgetConfig].
extension BarWidgetConfigPatterns on BarWidgetConfig {
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
mixin _$BottomNavigationBarWidgetConfig {

 String? get backgroundColor; String? get selectedItemColor; String? get unSelectedItemColor;
/// Create a copy of BottomNavigationBarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomNavigationBarWidgetConfigCopyWith<BottomNavigationBarWidgetConfig> get copyWith => _$BottomNavigationBarWidgetConfigCopyWithImpl<BottomNavigationBarWidgetConfig>(this as BottomNavigationBarWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomNavigationBarWidgetConfig&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.selectedItemColor, selectedItemColor) || other.selectedItemColor == selectedItemColor)&&(identical(other.unSelectedItemColor, unSelectedItemColor) || other.unSelectedItemColor == unSelectedItemColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,selectedItemColor,unSelectedItemColor);

@override
String toString() {
  return 'BottomNavigationBarWidgetConfig(backgroundColor: $backgroundColor, selectedItemColor: $selectedItemColor, unSelectedItemColor: $unSelectedItemColor)';
}


}

/// @nodoc
abstract mixin class $BottomNavigationBarWidgetConfigCopyWith<$Res>  {
  factory $BottomNavigationBarWidgetConfigCopyWith(BottomNavigationBarWidgetConfig value, $Res Function(BottomNavigationBarWidgetConfig) _then) = _$BottomNavigationBarWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? backgroundColor, String? selectedItemColor, String? unSelectedItemColor
});




}
/// @nodoc
class _$BottomNavigationBarWidgetConfigCopyWithImpl<$Res>
    implements $BottomNavigationBarWidgetConfigCopyWith<$Res> {
  _$BottomNavigationBarWidgetConfigCopyWithImpl(this._self, this._then);

  final BottomNavigationBarWidgetConfig _self;
  final $Res Function(BottomNavigationBarWidgetConfig) _then;

/// Create a copy of BottomNavigationBarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? selectedItemColor = freezed,Object? unSelectedItemColor = freezed,}) {
  return _then(BottomNavigationBarWidgetConfig(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,selectedItemColor: freezed == selectedItemColor ? _self.selectedItemColor : selectedItemColor // ignore: cast_nullable_to_non_nullable
as String?,unSelectedItemColor: freezed == unSelectedItemColor ? _self.unSelectedItemColor : unSelectedItemColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomNavigationBarWidgetConfig].
extension BottomNavigationBarWidgetConfigPatterns on BottomNavigationBarWidgetConfig {
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
mixin _$GroupTitleListTileWidgetConfig {

 String? get backgroundColor; TextStyleConfig? get textStyle;
/// Create a copy of GroupTitleListTileWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupTitleListTileWidgetConfigCopyWith<GroupTitleListTileWidgetConfig> get copyWith => _$GroupTitleListTileWidgetConfigCopyWithImpl<GroupTitleListTileWidgetConfig>(this as GroupTitleListTileWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupTitleListTileWidgetConfig&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.textStyle, textStyle) || other.textStyle == textStyle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,textStyle);

@override
String toString() {
  return 'GroupTitleListTileWidgetConfig(backgroundColor: $backgroundColor, textStyle: $textStyle)';
}


}

/// @nodoc
abstract mixin class $GroupTitleListTileWidgetConfigCopyWith<$Res>  {
  factory $GroupTitleListTileWidgetConfigCopyWith(GroupTitleListTileWidgetConfig value, $Res Function(GroupTitleListTileWidgetConfig) _then) = _$GroupTitleListTileWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? backgroundColor, TextStyleConfig? textStyle
});




}
/// @nodoc
class _$GroupTitleListTileWidgetConfigCopyWithImpl<$Res>
    implements $GroupTitleListTileWidgetConfigCopyWith<$Res> {
  _$GroupTitleListTileWidgetConfigCopyWithImpl(this._self, this._then);

  final GroupTitleListTileWidgetConfig _self;
  final $Res Function(GroupTitleListTileWidgetConfig) _then;

/// Create a copy of GroupTitleListTileWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? textStyle = freezed,}) {
  return _then(GroupTitleListTileWidgetConfig(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,textStyle: freezed == textStyle ? _self.textStyle : textStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupTitleListTileWidgetConfig].
extension GroupTitleListTileWidgetConfigPatterns on GroupTitleListTileWidgetConfig {
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
mixin _$ImageAssetsConfig {

 ImageSource? get defaultPlaceholderImage; AppIconWidgetConfig get appIcon; LeadingAvatarStyleConfig get leadingAvatarStyle;
/// Create a copy of ImageAssetsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageAssetsConfigCopyWith<ImageAssetsConfig> get copyWith => _$ImageAssetsConfigCopyWithImpl<ImageAssetsConfig>(this as ImageAssetsConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageAssetsConfig&&(identical(other.defaultPlaceholderImage, defaultPlaceholderImage) || other.defaultPlaceholderImage == defaultPlaceholderImage)&&(identical(other.appIcon, appIcon) || other.appIcon == appIcon)&&(identical(other.leadingAvatarStyle, leadingAvatarStyle) || other.leadingAvatarStyle == leadingAvatarStyle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultPlaceholderImage,appIcon,leadingAvatarStyle);

@override
String toString() {
  return 'ImageAssetsConfig(defaultPlaceholderImage: $defaultPlaceholderImage, appIcon: $appIcon, leadingAvatarStyle: $leadingAvatarStyle)';
}


}

/// @nodoc
abstract mixin class $ImageAssetsConfigCopyWith<$Res>  {
  factory $ImageAssetsConfigCopyWith(ImageAssetsConfig value, $Res Function(ImageAssetsConfig) _then) = _$ImageAssetsConfigCopyWithImpl;
@useResult
$Res call({
 ImageSource? defaultPlaceholderImage, AppIconWidgetConfig appIcon, LeadingAvatarStyleConfig leadingAvatarStyle
});




}
/// @nodoc
class _$ImageAssetsConfigCopyWithImpl<$Res>
    implements $ImageAssetsConfigCopyWith<$Res> {
  _$ImageAssetsConfigCopyWithImpl(this._self, this._then);

  final ImageAssetsConfig _self;
  final $Res Function(ImageAssetsConfig) _then;

/// Create a copy of ImageAssetsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultPlaceholderImage = freezed,Object? appIcon = null,Object? leadingAvatarStyle = null,}) {
  return _then(ImageAssetsConfig(
defaultPlaceholderImage: freezed == defaultPlaceholderImage ? _self.defaultPlaceholderImage : defaultPlaceholderImage // ignore: cast_nullable_to_non_nullable
as ImageSource?,appIcon: null == appIcon ? _self.appIcon : appIcon // ignore: cast_nullable_to_non_nullable
as AppIconWidgetConfig,leadingAvatarStyle: null == leadingAvatarStyle ? _self.leadingAvatarStyle : leadingAvatarStyle // ignore: cast_nullable_to_non_nullable
as LeadingAvatarStyleConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageAssetsConfig].
extension ImageAssetsConfigPatterns on ImageAssetsConfig {
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
mixin _$AppIconWidgetConfig {

 String? get color;
/// Create a copy of AppIconWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppIconWidgetConfigCopyWith<AppIconWidgetConfig> get copyWith => _$AppIconWidgetConfigCopyWithImpl<AppIconWidgetConfig>(this as AppIconWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppIconWidgetConfig&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color);

@override
String toString() {
  return 'AppIconWidgetConfig(color: $color)';
}


}

/// @nodoc
abstract mixin class $AppIconWidgetConfigCopyWith<$Res>  {
  factory $AppIconWidgetConfigCopyWith(AppIconWidgetConfig value, $Res Function(AppIconWidgetConfig) _then) = _$AppIconWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? color
});




}
/// @nodoc
class _$AppIconWidgetConfigCopyWithImpl<$Res>
    implements $AppIconWidgetConfigCopyWith<$Res> {
  _$AppIconWidgetConfigCopyWithImpl(this._self, this._then);

  final AppIconWidgetConfig _self;
  final $Res Function(AppIconWidgetConfig) _then;

/// Create a copy of AppIconWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = freezed,}) {
  return _then(AppIconWidgetConfig(
color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppIconWidgetConfig].
extension AppIconWidgetConfigPatterns on AppIconWidgetConfig {
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
mixin _$InputWidgetConfig {

 TextFormFieldWidgetConfig get primary;
/// Create a copy of InputWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputWidgetConfigCopyWith<InputWidgetConfig> get copyWith => _$InputWidgetConfigCopyWithImpl<InputWidgetConfig>(this as InputWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputWidgetConfig&&(identical(other.primary, primary) || other.primary == primary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary);

@override
String toString() {
  return 'InputWidgetConfig(primary: $primary)';
}


}

/// @nodoc
abstract mixin class $InputWidgetConfigCopyWith<$Res>  {
  factory $InputWidgetConfigCopyWith(InputWidgetConfig value, $Res Function(InputWidgetConfig) _then) = _$InputWidgetConfigCopyWithImpl;
@useResult
$Res call({
 TextFormFieldWidgetConfig primary
});




}
/// @nodoc
class _$InputWidgetConfigCopyWithImpl<$Res>
    implements $InputWidgetConfigCopyWith<$Res> {
  _$InputWidgetConfigCopyWithImpl(this._self, this._then);

  final InputWidgetConfig _self;
  final $Res Function(InputWidgetConfig) _then;

/// Create a copy of InputWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,}) {
  return _then(InputWidgetConfig(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as TextFormFieldWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [InputWidgetConfig].
extension InputWidgetConfigPatterns on InputWidgetConfig {
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
mixin _$TextFormFieldWidgetConfig {

 String? get labelColor; InputBorderWidgetConfig get border;
/// Create a copy of TextFormFieldWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextFormFieldWidgetConfigCopyWith<TextFormFieldWidgetConfig> get copyWith => _$TextFormFieldWidgetConfigCopyWithImpl<TextFormFieldWidgetConfig>(this as TextFormFieldWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextFormFieldWidgetConfig&&(identical(other.labelColor, labelColor) || other.labelColor == labelColor)&&(identical(other.border, border) || other.border == border));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelColor,border);

@override
String toString() {
  return 'TextFormFieldWidgetConfig(labelColor: $labelColor, border: $border)';
}


}

/// @nodoc
abstract mixin class $TextFormFieldWidgetConfigCopyWith<$Res>  {
  factory $TextFormFieldWidgetConfigCopyWith(TextFormFieldWidgetConfig value, $Res Function(TextFormFieldWidgetConfig) _then) = _$TextFormFieldWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? labelColor, InputBorderWidgetConfig border
});




}
/// @nodoc
class _$TextFormFieldWidgetConfigCopyWithImpl<$Res>
    implements $TextFormFieldWidgetConfigCopyWith<$Res> {
  _$TextFormFieldWidgetConfigCopyWithImpl(this._self, this._then);

  final TextFormFieldWidgetConfig _self;
  final $Res Function(TextFormFieldWidgetConfig) _then;

/// Create a copy of TextFormFieldWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labelColor = freezed,Object? border = null,}) {
  return _then(TextFormFieldWidgetConfig(
labelColor: freezed == labelColor ? _self.labelColor : labelColor // ignore: cast_nullable_to_non_nullable
as String?,border: null == border ? _self.border : border // ignore: cast_nullable_to_non_nullable
as InputBorderWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [TextFormFieldWidgetConfig].
extension TextFormFieldWidgetConfigPatterns on TextFormFieldWidgetConfig {
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
mixin _$InputBorderWidgetConfig {

 BorderWidgetConfig get disabled; BorderWidgetConfig get focused; BorderWidgetConfig get any;
/// Create a copy of InputBorderWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputBorderWidgetConfigCopyWith<InputBorderWidgetConfig> get copyWith => _$InputBorderWidgetConfigCopyWithImpl<InputBorderWidgetConfig>(this as InputBorderWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputBorderWidgetConfig&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.focused, focused) || other.focused == focused)&&(identical(other.any, any) || other.any == any));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,disabled,focused,any);

@override
String toString() {
  return 'InputBorderWidgetConfig(disabled: $disabled, focused: $focused, any: $any)';
}


}

/// @nodoc
abstract mixin class $InputBorderWidgetConfigCopyWith<$Res>  {
  factory $InputBorderWidgetConfigCopyWith(InputBorderWidgetConfig value, $Res Function(InputBorderWidgetConfig) _then) = _$InputBorderWidgetConfigCopyWithImpl;
@useResult
$Res call({
 BorderWidgetConfig disabled, BorderWidgetConfig focused, BorderWidgetConfig any
});




}
/// @nodoc
class _$InputBorderWidgetConfigCopyWithImpl<$Res>
    implements $InputBorderWidgetConfigCopyWith<$Res> {
  _$InputBorderWidgetConfigCopyWithImpl(this._self, this._then);

  final InputBorderWidgetConfig _self;
  final $Res Function(InputBorderWidgetConfig) _then;

/// Create a copy of InputBorderWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? disabled = null,Object? focused = null,Object? any = null,}) {
  return _then(InputBorderWidgetConfig(
disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as BorderWidgetConfig,focused: null == focused ? _self.focused : focused // ignore: cast_nullable_to_non_nullable
as BorderWidgetConfig,any: null == any ? _self.any : any // ignore: cast_nullable_to_non_nullable
as BorderWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [InputBorderWidgetConfig].
extension InputBorderWidgetConfigPatterns on InputBorderWidgetConfig {
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
mixin _$BorderWidgetConfig {

 String? get typicalColor; String? get errorColor;
/// Create a copy of BorderWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BorderWidgetConfigCopyWith<BorderWidgetConfig> get copyWith => _$BorderWidgetConfigCopyWithImpl<BorderWidgetConfig>(this as BorderWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BorderWidgetConfig&&(identical(other.typicalColor, typicalColor) || other.typicalColor == typicalColor)&&(identical(other.errorColor, errorColor) || other.errorColor == errorColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,typicalColor,errorColor);

@override
String toString() {
  return 'BorderWidgetConfig(typicalColor: $typicalColor, errorColor: $errorColor)';
}


}

/// @nodoc
abstract mixin class $BorderWidgetConfigCopyWith<$Res>  {
  factory $BorderWidgetConfigCopyWith(BorderWidgetConfig value, $Res Function(BorderWidgetConfig) _then) = _$BorderWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? typicalColor, String? errorColor
});




}
/// @nodoc
class _$BorderWidgetConfigCopyWithImpl<$Res>
    implements $BorderWidgetConfigCopyWith<$Res> {
  _$BorderWidgetConfigCopyWithImpl(this._self, this._then);

  final BorderWidgetConfig _self;
  final $Res Function(BorderWidgetConfig) _then;

/// Create a copy of BorderWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? typicalColor = freezed,Object? errorColor = freezed,}) {
  return _then(BorderWidgetConfig(
typicalColor: freezed == typicalColor ? _self.typicalColor : typicalColor // ignore: cast_nullable_to_non_nullable
as String?,errorColor: freezed == errorColor ? _self.errorColor : errorColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BorderWidgetConfig].
extension BorderWidgetConfigPatterns on BorderWidgetConfig {
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
mixin _$TextWidgetConfig {

 TextSelectionWidgetConfig get selection; LinkifyWidgetConfig get linkify;
/// Create a copy of TextWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextWidgetConfigCopyWith<TextWidgetConfig> get copyWith => _$TextWidgetConfigCopyWithImpl<TextWidgetConfig>(this as TextWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextWidgetConfig&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.linkify, linkify) || other.linkify == linkify));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,linkify);

@override
String toString() {
  return 'TextWidgetConfig(selection: $selection, linkify: $linkify)';
}


}

/// @nodoc
abstract mixin class $TextWidgetConfigCopyWith<$Res>  {
  factory $TextWidgetConfigCopyWith(TextWidgetConfig value, $Res Function(TextWidgetConfig) _then) = _$TextWidgetConfigCopyWithImpl;
@useResult
$Res call({
 TextSelectionWidgetConfig selection, LinkifyWidgetConfig linkify
});




}
/// @nodoc
class _$TextWidgetConfigCopyWithImpl<$Res>
    implements $TextWidgetConfigCopyWith<$Res> {
  _$TextWidgetConfigCopyWithImpl(this._self, this._then);

  final TextWidgetConfig _self;
  final $Res Function(TextWidgetConfig) _then;

/// Create a copy of TextWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selection = null,Object? linkify = null,}) {
  return _then(TextWidgetConfig(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as TextSelectionWidgetConfig,linkify: null == linkify ? _self.linkify : linkify // ignore: cast_nullable_to_non_nullable
as LinkifyWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [TextWidgetConfig].
extension TextWidgetConfigPatterns on TextWidgetConfig {
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
mixin _$TextSelectionWidgetConfig {

 String? get cursorColor; String? get selectionColor; String? get selectionHandleColor;
/// Create a copy of TextSelectionWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextSelectionWidgetConfigCopyWith<TextSelectionWidgetConfig> get copyWith => _$TextSelectionWidgetConfigCopyWithImpl<TextSelectionWidgetConfig>(this as TextSelectionWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextSelectionWidgetConfig&&(identical(other.cursorColor, cursorColor) || other.cursorColor == cursorColor)&&(identical(other.selectionColor, selectionColor) || other.selectionColor == selectionColor)&&(identical(other.selectionHandleColor, selectionHandleColor) || other.selectionHandleColor == selectionHandleColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursorColor,selectionColor,selectionHandleColor);

@override
String toString() {
  return 'TextSelectionWidgetConfig(cursorColor: $cursorColor, selectionColor: $selectionColor, selectionHandleColor: $selectionHandleColor)';
}


}

/// @nodoc
abstract mixin class $TextSelectionWidgetConfigCopyWith<$Res>  {
  factory $TextSelectionWidgetConfigCopyWith(TextSelectionWidgetConfig value, $Res Function(TextSelectionWidgetConfig) _then) = _$TextSelectionWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? cursorColor, String? selectionColor, String? selectionHandleColor
});




}
/// @nodoc
class _$TextSelectionWidgetConfigCopyWithImpl<$Res>
    implements $TextSelectionWidgetConfigCopyWith<$Res> {
  _$TextSelectionWidgetConfigCopyWithImpl(this._self, this._then);

  final TextSelectionWidgetConfig _self;
  final $Res Function(TextSelectionWidgetConfig) _then;

/// Create a copy of TextSelectionWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursorColor = freezed,Object? selectionColor = freezed,Object? selectionHandleColor = freezed,}) {
  return _then(TextSelectionWidgetConfig(
cursorColor: freezed == cursorColor ? _self.cursorColor : cursorColor // ignore: cast_nullable_to_non_nullable
as String?,selectionColor: freezed == selectionColor ? _self.selectionColor : selectionColor // ignore: cast_nullable_to_non_nullable
as String?,selectionHandleColor: freezed == selectionHandleColor ? _self.selectionHandleColor : selectionHandleColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TextSelectionWidgetConfig].
extension TextSelectionWidgetConfigPatterns on TextSelectionWidgetConfig {
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
mixin _$LinkifyWidgetConfig {

 String? get styleColor; String? get linkifyStyleColor;
/// Create a copy of LinkifyWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkifyWidgetConfigCopyWith<LinkifyWidgetConfig> get copyWith => _$LinkifyWidgetConfigCopyWithImpl<LinkifyWidgetConfig>(this as LinkifyWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkifyWidgetConfig&&(identical(other.styleColor, styleColor) || other.styleColor == styleColor)&&(identical(other.linkifyStyleColor, linkifyStyleColor) || other.linkifyStyleColor == linkifyStyleColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,styleColor,linkifyStyleColor);

@override
String toString() {
  return 'LinkifyWidgetConfig(styleColor: $styleColor, linkifyStyleColor: $linkifyStyleColor)';
}


}

/// @nodoc
abstract mixin class $LinkifyWidgetConfigCopyWith<$Res>  {
  factory $LinkifyWidgetConfigCopyWith(LinkifyWidgetConfig value, $Res Function(LinkifyWidgetConfig) _then) = _$LinkifyWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? styleColor, String? linkifyStyleColor
});




}
/// @nodoc
class _$LinkifyWidgetConfigCopyWithImpl<$Res>
    implements $LinkifyWidgetConfigCopyWith<$Res> {
  _$LinkifyWidgetConfigCopyWithImpl(this._self, this._then);

  final LinkifyWidgetConfig _self;
  final $Res Function(LinkifyWidgetConfig) _then;

/// Create a copy of LinkifyWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? styleColor = freezed,Object? linkifyStyleColor = freezed,}) {
  return _then(LinkifyWidgetConfig(
styleColor: freezed == styleColor ? _self.styleColor : styleColor // ignore: cast_nullable_to_non_nullable
as String?,linkifyStyleColor: freezed == linkifyStyleColor ? _self.linkifyStyleColor : linkifyStyleColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkifyWidgetConfig].
extension LinkifyWidgetConfigPatterns on LinkifyWidgetConfig {
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
mixin _$DialogWidgetConfig {

 DialogThemeConfig get theme; ConfirmDialogWidgetConfig get confirmDialog; SnackBarWidgetConfig get snackBar;
/// Create a copy of DialogWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DialogWidgetConfigCopyWith<DialogWidgetConfig> get copyWith => _$DialogWidgetConfigCopyWithImpl<DialogWidgetConfig>(this as DialogWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DialogWidgetConfig&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.confirmDialog, confirmDialog) || other.confirmDialog == confirmDialog)&&(identical(other.snackBar, snackBar) || other.snackBar == snackBar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,confirmDialog,snackBar);

@override
String toString() {
  return 'DialogWidgetConfig(theme: $theme, confirmDialog: $confirmDialog, snackBar: $snackBar)';
}


}

/// @nodoc
abstract mixin class $DialogWidgetConfigCopyWith<$Res>  {
  factory $DialogWidgetConfigCopyWith(DialogWidgetConfig value, $Res Function(DialogWidgetConfig) _then) = _$DialogWidgetConfigCopyWithImpl;
@useResult
$Res call({
 DialogThemeConfig theme, ConfirmDialogWidgetConfig confirmDialog, SnackBarWidgetConfig snackBar
});




}
/// @nodoc
class _$DialogWidgetConfigCopyWithImpl<$Res>
    implements $DialogWidgetConfigCopyWith<$Res> {
  _$DialogWidgetConfigCopyWithImpl(this._self, this._then);

  final DialogWidgetConfig _self;
  final $Res Function(DialogWidgetConfig) _then;

/// Create a copy of DialogWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? confirmDialog = null,Object? snackBar = null,}) {
  return _then(DialogWidgetConfig(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as DialogThemeConfig,confirmDialog: null == confirmDialog ? _self.confirmDialog : confirmDialog // ignore: cast_nullable_to_non_nullable
as ConfirmDialogWidgetConfig,snackBar: null == snackBar ? _self.snackBar : snackBar // ignore: cast_nullable_to_non_nullable
as SnackBarWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [DialogWidgetConfig].
extension DialogWidgetConfigPatterns on DialogWidgetConfig {
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
mixin _$DialogThemeConfig {

 String? get backgroundColor; String? get surfaceTintColor; String? get shadowColor; String? get barrierColor; double? get elevation; double? get borderRadius; TextStyleConfig? get titleTextStyle; TextStyleConfig? get contentTextStyle;
/// Create a copy of DialogThemeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DialogThemeConfigCopyWith<DialogThemeConfig> get copyWith => _$DialogThemeConfigCopyWithImpl<DialogThemeConfig>(this as DialogThemeConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DialogThemeConfig&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.surfaceTintColor, surfaceTintColor) || other.surfaceTintColor == surfaceTintColor)&&(identical(other.shadowColor, shadowColor) || other.shadowColor == shadowColor)&&(identical(other.barrierColor, barrierColor) || other.barrierColor == barrierColor)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.titleTextStyle, titleTextStyle) || other.titleTextStyle == titleTextStyle)&&(identical(other.contentTextStyle, contentTextStyle) || other.contentTextStyle == contentTextStyle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,surfaceTintColor,shadowColor,barrierColor,elevation,borderRadius,titleTextStyle,contentTextStyle);

@override
String toString() {
  return 'DialogThemeConfig(backgroundColor: $backgroundColor, surfaceTintColor: $surfaceTintColor, shadowColor: $shadowColor, barrierColor: $barrierColor, elevation: $elevation, borderRadius: $borderRadius, titleTextStyle: $titleTextStyle, contentTextStyle: $contentTextStyle)';
}


}

/// @nodoc
abstract mixin class $DialogThemeConfigCopyWith<$Res>  {
  factory $DialogThemeConfigCopyWith(DialogThemeConfig value, $Res Function(DialogThemeConfig) _then) = _$DialogThemeConfigCopyWithImpl;
@useResult
$Res call({
 String? backgroundColor, String? surfaceTintColor, String? shadowColor, String? barrierColor, double? elevation, double? borderRadius, TextStyleConfig? titleTextStyle, TextStyleConfig? contentTextStyle
});




}
/// @nodoc
class _$DialogThemeConfigCopyWithImpl<$Res>
    implements $DialogThemeConfigCopyWith<$Res> {
  _$DialogThemeConfigCopyWithImpl(this._self, this._then);

  final DialogThemeConfig _self;
  final $Res Function(DialogThemeConfig) _then;

/// Create a copy of DialogThemeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? surfaceTintColor = freezed,Object? shadowColor = freezed,Object? barrierColor = freezed,Object? elevation = freezed,Object? borderRadius = freezed,Object? titleTextStyle = freezed,Object? contentTextStyle = freezed,}) {
  return _then(DialogThemeConfig(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,surfaceTintColor: freezed == surfaceTintColor ? _self.surfaceTintColor : surfaceTintColor // ignore: cast_nullable_to_non_nullable
as String?,shadowColor: freezed == shadowColor ? _self.shadowColor : shadowColor // ignore: cast_nullable_to_non_nullable
as String?,barrierColor: freezed == barrierColor ? _self.barrierColor : barrierColor // ignore: cast_nullable_to_non_nullable
as String?,elevation: freezed == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double?,borderRadius: freezed == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double?,titleTextStyle: freezed == titleTextStyle ? _self.titleTextStyle : titleTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,contentTextStyle: freezed == contentTextStyle ? _self.contentTextStyle : contentTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [DialogThemeConfig].
extension DialogThemeConfigPatterns on DialogThemeConfig {
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
mixin _$ConfirmDialogWidgetConfig {

 String? get activeButtonColor1; String? get activeButtonColor2; String? get defaultButtonColor; String? get backgroundColor; String? get surfaceTintColor; double? get elevation; double? get borderRadius; TextStyleConfig? get titleTextStyle; TextStyleConfig? get contentTextStyle;
/// Create a copy of ConfirmDialogWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmDialogWidgetConfigCopyWith<ConfirmDialogWidgetConfig> get copyWith => _$ConfirmDialogWidgetConfigCopyWithImpl<ConfirmDialogWidgetConfig>(this as ConfirmDialogWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmDialogWidgetConfig&&(identical(other.activeButtonColor1, activeButtonColor1) || other.activeButtonColor1 == activeButtonColor1)&&(identical(other.activeButtonColor2, activeButtonColor2) || other.activeButtonColor2 == activeButtonColor2)&&(identical(other.defaultButtonColor, defaultButtonColor) || other.defaultButtonColor == defaultButtonColor)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.surfaceTintColor, surfaceTintColor) || other.surfaceTintColor == surfaceTintColor)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.titleTextStyle, titleTextStyle) || other.titleTextStyle == titleTextStyle)&&(identical(other.contentTextStyle, contentTextStyle) || other.contentTextStyle == contentTextStyle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeButtonColor1,activeButtonColor2,defaultButtonColor,backgroundColor,surfaceTintColor,elevation,borderRadius,titleTextStyle,contentTextStyle);

@override
String toString() {
  return 'ConfirmDialogWidgetConfig(activeButtonColor1: $activeButtonColor1, activeButtonColor2: $activeButtonColor2, defaultButtonColor: $defaultButtonColor, backgroundColor: $backgroundColor, surfaceTintColor: $surfaceTintColor, elevation: $elevation, borderRadius: $borderRadius, titleTextStyle: $titleTextStyle, contentTextStyle: $contentTextStyle)';
}


}

/// @nodoc
abstract mixin class $ConfirmDialogWidgetConfigCopyWith<$Res>  {
  factory $ConfirmDialogWidgetConfigCopyWith(ConfirmDialogWidgetConfig value, $Res Function(ConfirmDialogWidgetConfig) _then) = _$ConfirmDialogWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String? activeButtonColor1, String? activeButtonColor2, String? defaultButtonColor, String? backgroundColor, String? surfaceTintColor, double? elevation, double? borderRadius, TextStyleConfig? titleTextStyle, TextStyleConfig? contentTextStyle
});




}
/// @nodoc
class _$ConfirmDialogWidgetConfigCopyWithImpl<$Res>
    implements $ConfirmDialogWidgetConfigCopyWith<$Res> {
  _$ConfirmDialogWidgetConfigCopyWithImpl(this._self, this._then);

  final ConfirmDialogWidgetConfig _self;
  final $Res Function(ConfirmDialogWidgetConfig) _then;

/// Create a copy of ConfirmDialogWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeButtonColor1 = freezed,Object? activeButtonColor2 = freezed,Object? defaultButtonColor = freezed,Object? backgroundColor = freezed,Object? surfaceTintColor = freezed,Object? elevation = freezed,Object? borderRadius = freezed,Object? titleTextStyle = freezed,Object? contentTextStyle = freezed,}) {
  return _then(ConfirmDialogWidgetConfig(
activeButtonColor1: freezed == activeButtonColor1 ? _self.activeButtonColor1 : activeButtonColor1 // ignore: cast_nullable_to_non_nullable
as String?,activeButtonColor2: freezed == activeButtonColor2 ? _self.activeButtonColor2 : activeButtonColor2 // ignore: cast_nullable_to_non_nullable
as String?,defaultButtonColor: freezed == defaultButtonColor ? _self.defaultButtonColor : defaultButtonColor // ignore: cast_nullable_to_non_nullable
as String?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,surfaceTintColor: freezed == surfaceTintColor ? _self.surfaceTintColor : surfaceTintColor // ignore: cast_nullable_to_non_nullable
as String?,elevation: freezed == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double?,borderRadius: freezed == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double?,titleTextStyle: freezed == titleTextStyle ? _self.titleTextStyle : titleTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,contentTextStyle: freezed == contentTextStyle ? _self.contentTextStyle : contentTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmDialogWidgetConfig].
extension ConfirmDialogWidgetConfigPatterns on ConfirmDialogWidgetConfig {
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
mixin _$SnackBarWidgetConfig {

 String get successBackgroundColor; String get errorBackgroundColor; String get infoBackgroundColor; String get warningBackgroundColor;
/// Create a copy of SnackBarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackBarWidgetConfigCopyWith<SnackBarWidgetConfig> get copyWith => _$SnackBarWidgetConfigCopyWithImpl<SnackBarWidgetConfig>(this as SnackBarWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackBarWidgetConfig&&(identical(other.successBackgroundColor, successBackgroundColor) || other.successBackgroundColor == successBackgroundColor)&&(identical(other.errorBackgroundColor, errorBackgroundColor) || other.errorBackgroundColor == errorBackgroundColor)&&(identical(other.infoBackgroundColor, infoBackgroundColor) || other.infoBackgroundColor == infoBackgroundColor)&&(identical(other.warningBackgroundColor, warningBackgroundColor) || other.warningBackgroundColor == warningBackgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,successBackgroundColor,errorBackgroundColor,infoBackgroundColor,warningBackgroundColor);

@override
String toString() {
  return 'SnackBarWidgetConfig(successBackgroundColor: $successBackgroundColor, errorBackgroundColor: $errorBackgroundColor, infoBackgroundColor: $infoBackgroundColor, warningBackgroundColor: $warningBackgroundColor)';
}


}

/// @nodoc
abstract mixin class $SnackBarWidgetConfigCopyWith<$Res>  {
  factory $SnackBarWidgetConfigCopyWith(SnackBarWidgetConfig value, $Res Function(SnackBarWidgetConfig) _then) = _$SnackBarWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String successBackgroundColor, String errorBackgroundColor, String infoBackgroundColor, String warningBackgroundColor
});




}
/// @nodoc
class _$SnackBarWidgetConfigCopyWithImpl<$Res>
    implements $SnackBarWidgetConfigCopyWith<$Res> {
  _$SnackBarWidgetConfigCopyWithImpl(this._self, this._then);

  final SnackBarWidgetConfig _self;
  final $Res Function(SnackBarWidgetConfig) _then;

/// Create a copy of SnackBarWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? successBackgroundColor = null,Object? errorBackgroundColor = null,Object? infoBackgroundColor = null,Object? warningBackgroundColor = null,}) {
  return _then(SnackBarWidgetConfig(
successBackgroundColor: null == successBackgroundColor ? _self.successBackgroundColor : successBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,errorBackgroundColor: null == errorBackgroundColor ? _self.errorBackgroundColor : errorBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,infoBackgroundColor: null == infoBackgroundColor ? _self.infoBackgroundColor : infoBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,warningBackgroundColor: null == warningBackgroundColor ? _self.warningBackgroundColor : warningBackgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SnackBarWidgetConfig].
extension SnackBarWidgetConfigPatterns on SnackBarWidgetConfig {
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
mixin _$StatusesWidgetConfig {

 RegistrationStatusesWidgetConfig get registrationStatuses; CallStatusesWidgetConfig get callStatuses;
/// Create a copy of StatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusesWidgetConfigCopyWith<StatusesWidgetConfig> get copyWith => _$StatusesWidgetConfigCopyWithImpl<StatusesWidgetConfig>(this as StatusesWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusesWidgetConfig&&(identical(other.registrationStatuses, registrationStatuses) || other.registrationStatuses == registrationStatuses)&&(identical(other.callStatuses, callStatuses) || other.callStatuses == callStatuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationStatuses,callStatuses);

@override
String toString() {
  return 'StatusesWidgetConfig(registrationStatuses: $registrationStatuses, callStatuses: $callStatuses)';
}


}

/// @nodoc
abstract mixin class $StatusesWidgetConfigCopyWith<$Res>  {
  factory $StatusesWidgetConfigCopyWith(StatusesWidgetConfig value, $Res Function(StatusesWidgetConfig) _then) = _$StatusesWidgetConfigCopyWithImpl;
@useResult
$Res call({
 RegistrationStatusesWidgetConfig registrationStatuses, CallStatusesWidgetConfig callStatuses
});




}
/// @nodoc
class _$StatusesWidgetConfigCopyWithImpl<$Res>
    implements $StatusesWidgetConfigCopyWith<$Res> {
  _$StatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final StatusesWidgetConfig _self;
  final $Res Function(StatusesWidgetConfig) _then;

/// Create a copy of StatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationStatuses = null,Object? callStatuses = null,}) {
  return _then(StatusesWidgetConfig(
registrationStatuses: null == registrationStatuses ? _self.registrationStatuses : registrationStatuses // ignore: cast_nullable_to_non_nullable
as RegistrationStatusesWidgetConfig,callStatuses: null == callStatuses ? _self.callStatuses : callStatuses // ignore: cast_nullable_to_non_nullable
as CallStatusesWidgetConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusesWidgetConfig].
extension StatusesWidgetConfigPatterns on StatusesWidgetConfig {
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
mixin _$RegistrationStatusesWidgetConfig {

 String get online; String get offline;
/// Create a copy of RegistrationStatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationStatusesWidgetConfigCopyWith<RegistrationStatusesWidgetConfig> get copyWith => _$RegistrationStatusesWidgetConfigCopyWithImpl<RegistrationStatusesWidgetConfig>(this as RegistrationStatusesWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationStatusesWidgetConfig&&(identical(other.online, online) || other.online == online)&&(identical(other.offline, offline) || other.offline == offline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,online,offline);

@override
String toString() {
  return 'RegistrationStatusesWidgetConfig(online: $online, offline: $offline)';
}


}

/// @nodoc
abstract mixin class $RegistrationStatusesWidgetConfigCopyWith<$Res>  {
  factory $RegistrationStatusesWidgetConfigCopyWith(RegistrationStatusesWidgetConfig value, $Res Function(RegistrationStatusesWidgetConfig) _then) = _$RegistrationStatusesWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String online, String offline
});




}
/// @nodoc
class _$RegistrationStatusesWidgetConfigCopyWithImpl<$Res>
    implements $RegistrationStatusesWidgetConfigCopyWith<$Res> {
  _$RegistrationStatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final RegistrationStatusesWidgetConfig _self;
  final $Res Function(RegistrationStatusesWidgetConfig) _then;

/// Create a copy of RegistrationStatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? online = null,Object? offline = null,}) {
  return _then(RegistrationStatusesWidgetConfig(
online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as String,offline: null == offline ? _self.offline : offline // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationStatusesWidgetConfig].
extension RegistrationStatusesWidgetConfigPatterns on RegistrationStatusesWidgetConfig {
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
mixin _$CallStatusesWidgetConfig {

 String get connectivityNone; String get connectError; String get appUnregistered; String get connectIssue; String get inProgress; String get ready;
/// Create a copy of CallStatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallStatusesWidgetConfigCopyWith<CallStatusesWidgetConfig> get copyWith => _$CallStatusesWidgetConfigCopyWithImpl<CallStatusesWidgetConfig>(this as CallStatusesWidgetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallStatusesWidgetConfig&&(identical(other.connectivityNone, connectivityNone) || other.connectivityNone == connectivityNone)&&(identical(other.connectError, connectError) || other.connectError == connectError)&&(identical(other.appUnregistered, appUnregistered) || other.appUnregistered == appUnregistered)&&(identical(other.connectIssue, connectIssue) || other.connectIssue == connectIssue)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.ready, ready) || other.ready == ready));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,connectivityNone,connectError,appUnregistered,connectIssue,inProgress,ready);

@override
String toString() {
  return 'CallStatusesWidgetConfig(connectivityNone: $connectivityNone, connectError: $connectError, appUnregistered: $appUnregistered, connectIssue: $connectIssue, inProgress: $inProgress, ready: $ready)';
}


}

/// @nodoc
abstract mixin class $CallStatusesWidgetConfigCopyWith<$Res>  {
  factory $CallStatusesWidgetConfigCopyWith(CallStatusesWidgetConfig value, $Res Function(CallStatusesWidgetConfig) _then) = _$CallStatusesWidgetConfigCopyWithImpl;
@useResult
$Res call({
 String connectivityNone, String connectError, String appUnregistered, String connectIssue, String inProgress, String ready
});




}
/// @nodoc
class _$CallStatusesWidgetConfigCopyWithImpl<$Res>
    implements $CallStatusesWidgetConfigCopyWith<$Res> {
  _$CallStatusesWidgetConfigCopyWithImpl(this._self, this._then);

  final CallStatusesWidgetConfig _self;
  final $Res Function(CallStatusesWidgetConfig) _then;

/// Create a copy of CallStatusesWidgetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectivityNone = null,Object? connectError = null,Object? appUnregistered = null,Object? connectIssue = null,Object? inProgress = null,Object? ready = null,}) {
  return _then(CallStatusesWidgetConfig(
connectivityNone: null == connectivityNone ? _self.connectivityNone : connectivityNone // ignore: cast_nullable_to_non_nullable
as String,connectError: null == connectError ? _self.connectError : connectError // ignore: cast_nullable_to_non_nullable
as String,appUnregistered: null == appUnregistered ? _self.appUnregistered : appUnregistered // ignore: cast_nullable_to_non_nullable
as String,connectIssue: null == connectIssue ? _self.connectIssue : connectIssue // ignore: cast_nullable_to_non_nullable
as String,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as String,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallStatusesWidgetConfig].
extension CallStatusesWidgetConfigPatterns on CallStatusesWidgetConfig {
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
mixin _$TabBarConfig {

 String? get indicatorColor; String? get dividerColor; String? get labelColor; String? get unselectedLabelColor; String? get overlayColor; double? get dividerHeight; PaddingConfig? get labelPadding; TextStyleConfig? get labelStyle; TextStyleConfig? get unselectedLabelStyle; TabBarIndicatorSizeConfig? get indicatorSize; TabAlignmentConfig? get tabAlignment; TabIndicatorAnimationConfig? get indicatorAnimation; TabSplashFactoryConfig? get splashFactory; BorderConfig? get indicatorBorder;
/// Create a copy of TabBarConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabBarConfigCopyWith<TabBarConfig> get copyWith => _$TabBarConfigCopyWithImpl<TabBarConfig>(this as TabBarConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabBarConfig&&(identical(other.indicatorColor, indicatorColor) || other.indicatorColor == indicatorColor)&&(identical(other.dividerColor, dividerColor) || other.dividerColor == dividerColor)&&(identical(other.labelColor, labelColor) || other.labelColor == labelColor)&&(identical(other.unselectedLabelColor, unselectedLabelColor) || other.unselectedLabelColor == unselectedLabelColor)&&(identical(other.overlayColor, overlayColor) || other.overlayColor == overlayColor)&&(identical(other.dividerHeight, dividerHeight) || other.dividerHeight == dividerHeight)&&(identical(other.labelPadding, labelPadding) || other.labelPadding == labelPadding)&&(identical(other.labelStyle, labelStyle) || other.labelStyle == labelStyle)&&(identical(other.unselectedLabelStyle, unselectedLabelStyle) || other.unselectedLabelStyle == unselectedLabelStyle)&&(identical(other.indicatorSize, indicatorSize) || other.indicatorSize == indicatorSize)&&(identical(other.tabAlignment, tabAlignment) || other.tabAlignment == tabAlignment)&&(identical(other.indicatorAnimation, indicatorAnimation) || other.indicatorAnimation == indicatorAnimation)&&(identical(other.splashFactory, splashFactory) || other.splashFactory == splashFactory)&&(identical(other.indicatorBorder, indicatorBorder) || other.indicatorBorder == indicatorBorder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,indicatorColor,dividerColor,labelColor,unselectedLabelColor,overlayColor,dividerHeight,labelPadding,labelStyle,unselectedLabelStyle,indicatorSize,tabAlignment,indicatorAnimation,splashFactory,indicatorBorder);

@override
String toString() {
  return 'TabBarConfig(indicatorColor: $indicatorColor, dividerColor: $dividerColor, labelColor: $labelColor, unselectedLabelColor: $unselectedLabelColor, overlayColor: $overlayColor, dividerHeight: $dividerHeight, labelPadding: $labelPadding, labelStyle: $labelStyle, unselectedLabelStyle: $unselectedLabelStyle, indicatorSize: $indicatorSize, tabAlignment: $tabAlignment, indicatorAnimation: $indicatorAnimation, splashFactory: $splashFactory, indicatorBorder: $indicatorBorder)';
}


}

/// @nodoc
abstract mixin class $TabBarConfigCopyWith<$Res>  {
  factory $TabBarConfigCopyWith(TabBarConfig value, $Res Function(TabBarConfig) _then) = _$TabBarConfigCopyWithImpl;
@useResult
$Res call({
 String? indicatorColor, String? dividerColor, String? labelColor, String? unselectedLabelColor, String? overlayColor, double? dividerHeight, PaddingConfig? labelPadding, TextStyleConfig? labelStyle, TextStyleConfig? unselectedLabelStyle, TabBarIndicatorSizeConfig? indicatorSize, TabAlignmentConfig? tabAlignment, TabIndicatorAnimationConfig? indicatorAnimation, TabSplashFactoryConfig? splashFactory, BorderConfig? indicatorBorder
});




}
/// @nodoc
class _$TabBarConfigCopyWithImpl<$Res>
    implements $TabBarConfigCopyWith<$Res> {
  _$TabBarConfigCopyWithImpl(this._self, this._then);

  final TabBarConfig _self;
  final $Res Function(TabBarConfig) _then;

/// Create a copy of TabBarConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? indicatorColor = freezed,Object? dividerColor = freezed,Object? labelColor = freezed,Object? unselectedLabelColor = freezed,Object? overlayColor = freezed,Object? dividerHeight = freezed,Object? labelPadding = freezed,Object? labelStyle = freezed,Object? unselectedLabelStyle = freezed,Object? indicatorSize = freezed,Object? tabAlignment = freezed,Object? indicatorAnimation = freezed,Object? splashFactory = freezed,Object? indicatorBorder = freezed,}) {
  return _then(TabBarConfig(
indicatorColor: freezed == indicatorColor ? _self.indicatorColor : indicatorColor // ignore: cast_nullable_to_non_nullable
as String?,dividerColor: freezed == dividerColor ? _self.dividerColor : dividerColor // ignore: cast_nullable_to_non_nullable
as String?,labelColor: freezed == labelColor ? _self.labelColor : labelColor // ignore: cast_nullable_to_non_nullable
as String?,unselectedLabelColor: freezed == unselectedLabelColor ? _self.unselectedLabelColor : unselectedLabelColor // ignore: cast_nullable_to_non_nullable
as String?,overlayColor: freezed == overlayColor ? _self.overlayColor : overlayColor // ignore: cast_nullable_to_non_nullable
as String?,dividerHeight: freezed == dividerHeight ? _self.dividerHeight : dividerHeight // ignore: cast_nullable_to_non_nullable
as double?,labelPadding: freezed == labelPadding ? _self.labelPadding : labelPadding // ignore: cast_nullable_to_non_nullable
as PaddingConfig?,labelStyle: freezed == labelStyle ? _self.labelStyle : labelStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,unselectedLabelStyle: freezed == unselectedLabelStyle ? _self.unselectedLabelStyle : unselectedLabelStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,indicatorSize: freezed == indicatorSize ? _self.indicatorSize : indicatorSize // ignore: cast_nullable_to_non_nullable
as TabBarIndicatorSizeConfig?,tabAlignment: freezed == tabAlignment ? _self.tabAlignment : tabAlignment // ignore: cast_nullable_to_non_nullable
as TabAlignmentConfig?,indicatorAnimation: freezed == indicatorAnimation ? _self.indicatorAnimation : indicatorAnimation // ignore: cast_nullable_to_non_nullable
as TabIndicatorAnimationConfig?,splashFactory: freezed == splashFactory ? _self.splashFactory : splashFactory // ignore: cast_nullable_to_non_nullable
as TabSplashFactoryConfig?,indicatorBorder: freezed == indicatorBorder ? _self.indicatorBorder : indicatorBorder // ignore: cast_nullable_to_non_nullable
as BorderConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [TabBarConfig].
extension TabBarConfigPatterns on TabBarConfig {
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
mixin _$AppBarConfig {

 bool get primary; bool get showBackButton; String? get backgroundColor; String? get foregroundColor; String? get shadowColor; String? get surfaceTintColor; double? get elevation; double? get scrolledUnderElevation; double? get titleSpacing; double? get leadingWidth; double? get toolbarHeight; bool? get centerTitle; IconThemeDataConfig? get iconTheme; IconThemeDataConfig? get actionsIconTheme; TextStyleConfig? get titleTextStyle; TextStyleConfig? get toolbarTextStyle; OverlayStyleModel? get systemOverlayStyle;
/// Create a copy of AppBarConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBarConfigCopyWith<AppBarConfig> get copyWith => _$AppBarConfigCopyWithImpl<AppBarConfig>(this as AppBarConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBarConfig&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.showBackButton, showBackButton) || other.showBackButton == showBackButton)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.foregroundColor, foregroundColor) || other.foregroundColor == foregroundColor)&&(identical(other.shadowColor, shadowColor) || other.shadowColor == shadowColor)&&(identical(other.surfaceTintColor, surfaceTintColor) || other.surfaceTintColor == surfaceTintColor)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.scrolledUnderElevation, scrolledUnderElevation) || other.scrolledUnderElevation == scrolledUnderElevation)&&(identical(other.titleSpacing, titleSpacing) || other.titleSpacing == titleSpacing)&&(identical(other.leadingWidth, leadingWidth) || other.leadingWidth == leadingWidth)&&(identical(other.toolbarHeight, toolbarHeight) || other.toolbarHeight == toolbarHeight)&&(identical(other.centerTitle, centerTitle) || other.centerTitle == centerTitle)&&(identical(other.iconTheme, iconTheme) || other.iconTheme == iconTheme)&&(identical(other.actionsIconTheme, actionsIconTheme) || other.actionsIconTheme == actionsIconTheme)&&(identical(other.titleTextStyle, titleTextStyle) || other.titleTextStyle == titleTextStyle)&&(identical(other.toolbarTextStyle, toolbarTextStyle) || other.toolbarTextStyle == toolbarTextStyle)&&(identical(other.systemOverlayStyle, systemOverlayStyle) || other.systemOverlayStyle == systemOverlayStyle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary,showBackButton,backgroundColor,foregroundColor,shadowColor,surfaceTintColor,elevation,scrolledUnderElevation,titleSpacing,leadingWidth,toolbarHeight,centerTitle,iconTheme,actionsIconTheme,titleTextStyle,toolbarTextStyle,systemOverlayStyle);

@override
String toString() {
  return 'AppBarConfig(primary: $primary, showBackButton: $showBackButton, backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, shadowColor: $shadowColor, surfaceTintColor: $surfaceTintColor, elevation: $elevation, scrolledUnderElevation: $scrolledUnderElevation, titleSpacing: $titleSpacing, leadingWidth: $leadingWidth, toolbarHeight: $toolbarHeight, centerTitle: $centerTitle, iconTheme: $iconTheme, actionsIconTheme: $actionsIconTheme, titleTextStyle: $titleTextStyle, toolbarTextStyle: $toolbarTextStyle, systemOverlayStyle: $systemOverlayStyle)';
}


}

/// @nodoc
abstract mixin class $AppBarConfigCopyWith<$Res>  {
  factory $AppBarConfigCopyWith(AppBarConfig value, $Res Function(AppBarConfig) _then) = _$AppBarConfigCopyWithImpl;
@useResult
$Res call({
 bool primary, bool showBackButton, String? backgroundColor, String? foregroundColor, String? shadowColor, String? surfaceTintColor, double? elevation, double? scrolledUnderElevation, double? titleSpacing, double? leadingWidth, double? toolbarHeight, bool? centerTitle, IconThemeDataConfig? iconTheme, IconThemeDataConfig? actionsIconTheme, TextStyleConfig? titleTextStyle, TextStyleConfig? toolbarTextStyle, OverlayStyleModel? systemOverlayStyle
});




}
/// @nodoc
class _$AppBarConfigCopyWithImpl<$Res>
    implements $AppBarConfigCopyWith<$Res> {
  _$AppBarConfigCopyWithImpl(this._self, this._then);

  final AppBarConfig _self;
  final $Res Function(AppBarConfig) _then;

/// Create a copy of AppBarConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? showBackButton = null,Object? backgroundColor = freezed,Object? foregroundColor = freezed,Object? shadowColor = freezed,Object? surfaceTintColor = freezed,Object? elevation = freezed,Object? scrolledUnderElevation = freezed,Object? titleSpacing = freezed,Object? leadingWidth = freezed,Object? toolbarHeight = freezed,Object? centerTitle = freezed,Object? iconTheme = freezed,Object? actionsIconTheme = freezed,Object? titleTextStyle = freezed,Object? toolbarTextStyle = freezed,Object? systemOverlayStyle = freezed,}) {
  return _then(AppBarConfig(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as bool,showBackButton: null == showBackButton ? _self.showBackButton : showBackButton // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,foregroundColor: freezed == foregroundColor ? _self.foregroundColor : foregroundColor // ignore: cast_nullable_to_non_nullable
as String?,shadowColor: freezed == shadowColor ? _self.shadowColor : shadowColor // ignore: cast_nullable_to_non_nullable
as String?,surfaceTintColor: freezed == surfaceTintColor ? _self.surfaceTintColor : surfaceTintColor // ignore: cast_nullable_to_non_nullable
as String?,elevation: freezed == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double?,scrolledUnderElevation: freezed == scrolledUnderElevation ? _self.scrolledUnderElevation : scrolledUnderElevation // ignore: cast_nullable_to_non_nullable
as double?,titleSpacing: freezed == titleSpacing ? _self.titleSpacing : titleSpacing // ignore: cast_nullable_to_non_nullable
as double?,leadingWidth: freezed == leadingWidth ? _self.leadingWidth : leadingWidth // ignore: cast_nullable_to_non_nullable
as double?,toolbarHeight: freezed == toolbarHeight ? _self.toolbarHeight : toolbarHeight // ignore: cast_nullable_to_non_nullable
as double?,centerTitle: freezed == centerTitle ? _self.centerTitle : centerTitle // ignore: cast_nullable_to_non_nullable
as bool?,iconTheme: freezed == iconTheme ? _self.iconTheme : iconTheme // ignore: cast_nullable_to_non_nullable
as IconThemeDataConfig?,actionsIconTheme: freezed == actionsIconTheme ? _self.actionsIconTheme : actionsIconTheme // ignore: cast_nullable_to_non_nullable
as IconThemeDataConfig?,titleTextStyle: freezed == titleTextStyle ? _self.titleTextStyle : titleTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,toolbarTextStyle: freezed == toolbarTextStyle ? _self.toolbarTextStyle : toolbarTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,systemOverlayStyle: freezed == systemOverlayStyle ? _self.systemOverlayStyle : systemOverlayStyle // ignore: cast_nullable_to_non_nullable
as OverlayStyleModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppBarConfig].
extension AppBarConfigPatterns on AppBarConfig {
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
