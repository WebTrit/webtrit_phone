// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supported_feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SupportedFeature _$SupportedFeatureFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'themeMode':
          return SupportedThemeMode.fromJson(
            json
          );
                case 'videoCall':
          return SupportedVideoCall.fromJson(
            json
          );
                case 'loggingConfig':
          return SupportedLoggingConfig.fromJson(
            json
          );
                case 'systemNotifications':
          return SupportedSystemNotifications.fromJson(
            json
          );
                case 'hybridPresence':
          return SupportedHybridPresence.fromJson(
            json
          );
                case 'callPull':
          return SupportedCallPull.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SupportedFeature',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SupportedFeature {

 String get type;
/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedFeatureCopyWith<SupportedFeature> get copyWith => _$SupportedFeatureCopyWithImpl<SupportedFeature>(this as SupportedFeature, _$identity);

  /// Serializes this SupportedFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedFeature&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'SupportedFeature(type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedFeatureCopyWith<$Res>  {
  factory $SupportedFeatureCopyWith(SupportedFeature value, $Res Function(SupportedFeature) _then) = _$SupportedFeatureCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$SupportedFeatureCopyWithImpl<$Res>
    implements $SupportedFeatureCopyWith<$Res> {
  _$SupportedFeatureCopyWithImpl(this._self, this._then);

  final SupportedFeature _self;
  final $Res Function(SupportedFeature) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportedFeature].
extension SupportedFeaturePatterns on SupportedFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SupportedThemeMode value)?  themeMode,TResult Function( SupportedVideoCall value)?  videoCall,TResult Function( SupportedLoggingConfig value)?  loggingConfig,TResult Function( SupportedSystemNotifications value)?  systemNotifications,TResult Function( SupportedHybridPresence value)?  hybridPresence,TResult Function( SupportedCallPull value)?  callPull,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that);case SupportedVideoCall() when videoCall != null:
return videoCall(_that);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that);case SupportedCallPull() when callPull != null:
return callPull(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SupportedThemeMode value)  themeMode,required TResult Function( SupportedVideoCall value)  videoCall,required TResult Function( SupportedLoggingConfig value)  loggingConfig,required TResult Function( SupportedSystemNotifications value)  systemNotifications,required TResult Function( SupportedHybridPresence value)  hybridPresence,required TResult Function( SupportedCallPull value)  callPull,}){
final _that = this;
switch (_that) {
case SupportedThemeMode():
return themeMode(_that);case SupportedVideoCall():
return videoCall(_that);case SupportedLoggingConfig():
return loggingConfig(_that);case SupportedSystemNotifications():
return systemNotifications(_that);case SupportedHybridPresence():
return hybridPresence(_that);case SupportedCallPull():
return callPull(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SupportedThemeMode value)?  themeMode,TResult? Function( SupportedVideoCall value)?  videoCall,TResult? Function( SupportedLoggingConfig value)?  loggingConfig,TResult? Function( SupportedSystemNotifications value)?  systemNotifications,TResult? Function( SupportedHybridPresence value)?  hybridPresence,TResult? Function( SupportedCallPull value)?  callPull,}){
final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that);case SupportedVideoCall() when videoCall != null:
return videoCall(_that);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that);case SupportedCallPull() when callPull != null:
return callPull(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ThemeModeConfig mode,  String type)?  themeMode,TResult Function( bool enabled,  String type)?  videoCall,TResult Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled,  String type)?  loggingConfig,TResult Function( bool enabled,  String type)?  systemNotifications,TResult Function( bool enabled,  String type)?  hybridPresence,TResult Function( String videoStrategy,  String type)?  callPull,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that.mode,_that.type);case SupportedVideoCall() when videoCall != null:
return videoCall(_that.enabled,_that.type);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled,_that.type);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that.enabled,_that.type);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that.enabled,_that.type);case SupportedCallPull() when callPull != null:
return callPull(_that.videoStrategy,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ThemeModeConfig mode,  String type)  themeMode,required TResult Function( bool enabled,  String type)  videoCall,required TResult Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled,  String type)  loggingConfig,required TResult Function( bool enabled,  String type)  systemNotifications,required TResult Function( bool enabled,  String type)  hybridPresence,required TResult Function( String videoStrategy,  String type)  callPull,}) {final _that = this;
switch (_that) {
case SupportedThemeMode():
return themeMode(_that.mode,_that.type);case SupportedVideoCall():
return videoCall(_that.enabled,_that.type);case SupportedLoggingConfig():
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled,_that.type);case SupportedSystemNotifications():
return systemNotifications(_that.enabled,_that.type);case SupportedHybridPresence():
return hybridPresence(_that.enabled,_that.type);case SupportedCallPull():
return callPull(_that.videoStrategy,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ThemeModeConfig mode,  String type)?  themeMode,TResult? Function( bool enabled,  String type)?  videoCall,TResult? Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled,  String type)?  loggingConfig,TResult? Function( bool enabled,  String type)?  systemNotifications,TResult? Function( bool enabled,  String type)?  hybridPresence,TResult? Function( String videoStrategy,  String type)?  callPull,}) {final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that.mode,_that.type);case SupportedVideoCall() when videoCall != null:
return videoCall(_that.enabled,_that.type);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled,_that.type);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that.enabled,_that.type);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that.enabled,_that.type);case SupportedCallPull() when callPull != null:
return callPull(_that.videoStrategy,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SupportedThemeMode implements SupportedFeature {
  const SupportedThemeMode({this.mode = ThemeModeConfig.system, this.type = 'themeMode'});
  factory SupportedThemeMode.fromJson(Map<String, dynamic> json) => _$SupportedThemeModeFromJson(json);

@JsonKey() final  ThemeModeConfig mode;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedThemeModeCopyWith<SupportedThemeMode> get copyWith => _$SupportedThemeModeCopyWithImpl<SupportedThemeMode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedThemeModeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedThemeMode&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,type);

@override
String toString() {
  return 'SupportedFeature.themeMode(mode: $mode, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedThemeModeCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedThemeModeCopyWith(SupportedThemeMode value, $Res Function(SupportedThemeMode) _then) = _$SupportedThemeModeCopyWithImpl;
@override @useResult
$Res call({
 ThemeModeConfig mode, String type
});




}
/// @nodoc
class _$SupportedThemeModeCopyWithImpl<$Res>
    implements $SupportedThemeModeCopyWith<$Res> {
  _$SupportedThemeModeCopyWithImpl(this._self, this._then);

  final SupportedThemeMode _self;
  final $Res Function(SupportedThemeMode) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? type = null,}) {
  return _then(SupportedThemeMode(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeModeConfig,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedVideoCall implements SupportedFeature {
  const SupportedVideoCall({this.enabled = true, this.type = 'videoCall'});
  factory SupportedVideoCall.fromJson(Map<String, dynamic> json) => _$SupportedVideoCallFromJson(json);

@JsonKey() final  bool enabled;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedVideoCallCopyWith<SupportedVideoCall> get copyWith => _$SupportedVideoCallCopyWithImpl<SupportedVideoCall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedVideoCallToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedVideoCall&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,type);

@override
String toString() {
  return 'SupportedFeature.videoCall(enabled: $enabled, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedVideoCallCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedVideoCallCopyWith(SupportedVideoCall value, $Res Function(SupportedVideoCall) _then) = _$SupportedVideoCallCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String type
});




}
/// @nodoc
class _$SupportedVideoCallCopyWithImpl<$Res>
    implements $SupportedVideoCallCopyWith<$Res> {
  _$SupportedVideoCallCopyWithImpl(this._self, this._then);

  final SupportedVideoCall _self;
  final $Res Function(SupportedVideoCall) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? type = null,}) {
  return _then(SupportedVideoCall(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedLoggingConfig implements SupportedFeature {
  const SupportedLoggingConfig({this.logLevel = 'INFO', this.checkIntervalSec = 15, this.anonymizationEnabled = true, this.type = 'loggingConfig'});
  factory SupportedLoggingConfig.fromJson(Map<String, dynamic> json) => _$SupportedLoggingConfigFromJson(json);

@JsonKey() final  String logLevel;
@JsonKey() final  int checkIntervalSec;
@JsonKey() final  bool anonymizationEnabled;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedLoggingConfigCopyWith<SupportedLoggingConfig> get copyWith => _$SupportedLoggingConfigCopyWithImpl<SupportedLoggingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedLoggingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedLoggingConfig&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.checkIntervalSec, checkIntervalSec) || other.checkIntervalSec == checkIntervalSec)&&(identical(other.anonymizationEnabled, anonymizationEnabled) || other.anonymizationEnabled == anonymizationEnabled)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logLevel,checkIntervalSec,anonymizationEnabled,type);

@override
String toString() {
  return 'SupportedFeature.loggingConfig(logLevel: $logLevel, checkIntervalSec: $checkIntervalSec, anonymizationEnabled: $anonymizationEnabled, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedLoggingConfigCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedLoggingConfigCopyWith(SupportedLoggingConfig value, $Res Function(SupportedLoggingConfig) _then) = _$SupportedLoggingConfigCopyWithImpl;
@override @useResult
$Res call({
 String logLevel, int checkIntervalSec, bool anonymizationEnabled, String type
});




}
/// @nodoc
class _$SupportedLoggingConfigCopyWithImpl<$Res>
    implements $SupportedLoggingConfigCopyWith<$Res> {
  _$SupportedLoggingConfigCopyWithImpl(this._self, this._then);

  final SupportedLoggingConfig _self;
  final $Res Function(SupportedLoggingConfig) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logLevel = null,Object? checkIntervalSec = null,Object? anonymizationEnabled = null,Object? type = null,}) {
  return _then(SupportedLoggingConfig(
logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String,checkIntervalSec: null == checkIntervalSec ? _self.checkIntervalSec : checkIntervalSec // ignore: cast_nullable_to_non_nullable
as int,anonymizationEnabled: null == anonymizationEnabled ? _self.anonymizationEnabled : anonymizationEnabled // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedSystemNotifications implements SupportedFeature {
  const SupportedSystemNotifications({this.enabled = true, this.type = 'systemNotifications'});
  factory SupportedSystemNotifications.fromJson(Map<String, dynamic> json) => _$SupportedSystemNotificationsFromJson(json);

@JsonKey() final  bool enabled;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedSystemNotificationsCopyWith<SupportedSystemNotifications> get copyWith => _$SupportedSystemNotificationsCopyWithImpl<SupportedSystemNotifications>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedSystemNotificationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedSystemNotifications&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,type);

@override
String toString() {
  return 'SupportedFeature.systemNotifications(enabled: $enabled, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedSystemNotificationsCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedSystemNotificationsCopyWith(SupportedSystemNotifications value, $Res Function(SupportedSystemNotifications) _then) = _$SupportedSystemNotificationsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String type
});




}
/// @nodoc
class _$SupportedSystemNotificationsCopyWithImpl<$Res>
    implements $SupportedSystemNotificationsCopyWith<$Res> {
  _$SupportedSystemNotificationsCopyWithImpl(this._self, this._then);

  final SupportedSystemNotifications _self;
  final $Res Function(SupportedSystemNotifications) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? type = null,}) {
  return _then(SupportedSystemNotifications(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedHybridPresence implements SupportedFeature {
  const SupportedHybridPresence({this.enabled = true, this.type = 'hybridPresence'});
  factory SupportedHybridPresence.fromJson(Map<String, dynamic> json) => _$SupportedHybridPresenceFromJson(json);

@JsonKey() final  bool enabled;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedHybridPresenceCopyWith<SupportedHybridPresence> get copyWith => _$SupportedHybridPresenceCopyWithImpl<SupportedHybridPresence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedHybridPresenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedHybridPresence&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,type);

@override
String toString() {
  return 'SupportedFeature.hybridPresence(enabled: $enabled, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedHybridPresenceCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedHybridPresenceCopyWith(SupportedHybridPresence value, $Res Function(SupportedHybridPresence) _then) = _$SupportedHybridPresenceCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String type
});




}
/// @nodoc
class _$SupportedHybridPresenceCopyWithImpl<$Res>
    implements $SupportedHybridPresenceCopyWith<$Res> {
  _$SupportedHybridPresenceCopyWithImpl(this._self, this._then);

  final SupportedHybridPresence _self;
  final $Res Function(SupportedHybridPresence) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? type = null,}) {
  return _then(SupportedHybridPresence(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedCallPull implements SupportedFeature {
  const SupportedCallPull({this.videoStrategy = 'softMute', this.type = 'callPull'});
  factory SupportedCallPull.fromJson(Map<String, dynamic> json) => _$SupportedCallPullFromJson(json);

@JsonKey() final  String videoStrategy;
@override@JsonKey() final  String type;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedCallPullCopyWith<SupportedCallPull> get copyWith => _$SupportedCallPullCopyWithImpl<SupportedCallPull>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedCallPullToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedCallPull&&(identical(other.videoStrategy, videoStrategy) || other.videoStrategy == videoStrategy)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,videoStrategy,type);

@override
String toString() {
  return 'SupportedFeature.callPull(videoStrategy: $videoStrategy, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportedCallPullCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedCallPullCopyWith(SupportedCallPull value, $Res Function(SupportedCallPull) _then) = _$SupportedCallPullCopyWithImpl;
@override @useResult
$Res call({
 String videoStrategy, String type
});




}
/// @nodoc
class _$SupportedCallPullCopyWithImpl<$Res>
    implements $SupportedCallPullCopyWith<$Res> {
  _$SupportedCallPullCopyWithImpl(this._self, this._then);

  final SupportedCallPull _self;
  final $Res Function(SupportedCallPull) _then;

/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? videoStrategy = null,Object? type = null,}) {
  return _then(SupportedCallPull(
videoStrategy: null == videoStrategy ? _self.videoStrategy : videoStrategy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
