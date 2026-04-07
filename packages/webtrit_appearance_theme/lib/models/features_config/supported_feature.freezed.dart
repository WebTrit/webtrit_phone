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



  /// Serializes this SupportedFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedFeature);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SupportedFeature()';
}


}

/// @nodoc
class $SupportedFeatureCopyWith<$Res>  {
$SupportedFeatureCopyWith(SupportedFeature _, $Res Function(SupportedFeature) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SupportedThemeMode value)?  themeMode,TResult Function( SupportedVideoCall value)?  videoCall,TResult Function( SupportedLoggingConfig value)?  loggingConfig,TResult Function( SupportedSystemNotifications value)?  systemNotifications,TResult Function( SupportedHybridPresence value)?  hybridPresence,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that);case SupportedVideoCall() when videoCall != null:
return videoCall(_that);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SupportedThemeMode value)  themeMode,required TResult Function( SupportedVideoCall value)  videoCall,required TResult Function( SupportedLoggingConfig value)  loggingConfig,required TResult Function( SupportedSystemNotifications value)  systemNotifications,required TResult Function( SupportedHybridPresence value)  hybridPresence,}){
final _that = this;
switch (_that) {
case SupportedThemeMode():
return themeMode(_that);case SupportedVideoCall():
return videoCall(_that);case SupportedLoggingConfig():
return loggingConfig(_that);case SupportedSystemNotifications():
return systemNotifications(_that);case SupportedHybridPresence():
return hybridPresence(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SupportedThemeMode value)?  themeMode,TResult? Function( SupportedVideoCall value)?  videoCall,TResult? Function( SupportedLoggingConfig value)?  loggingConfig,TResult? Function( SupportedSystemNotifications value)?  systemNotifications,TResult? Function( SupportedHybridPresence value)?  hybridPresence,}){
final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that);case SupportedVideoCall() when videoCall != null:
return videoCall(_that);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ThemeModeConfig mode)?  themeMode,TResult Function( bool enabled)?  videoCall,TResult Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled)?  loggingConfig,TResult Function( bool enabled)?  systemNotifications,TResult Function( bool enabled)?  hybridPresence,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that.mode);case SupportedVideoCall() when videoCall != null:
return videoCall(_that.enabled);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that.enabled);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ThemeModeConfig mode)  themeMode,required TResult Function( bool enabled)  videoCall,required TResult Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled)  loggingConfig,required TResult Function( bool enabled)  systemNotifications,required TResult Function( bool enabled)  hybridPresence,}) {final _that = this;
switch (_that) {
case SupportedThemeMode():
return themeMode(_that.mode);case SupportedVideoCall():
return videoCall(_that.enabled);case SupportedLoggingConfig():
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled);case SupportedSystemNotifications():
return systemNotifications(_that.enabled);case SupportedHybridPresence():
return hybridPresence(_that.enabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ThemeModeConfig mode)?  themeMode,TResult? Function( bool enabled)?  videoCall,TResult? Function( String logLevel,  int checkIntervalSec,  bool anonymizationEnabled)?  loggingConfig,TResult? Function( bool enabled)?  systemNotifications,TResult? Function( bool enabled)?  hybridPresence,}) {final _that = this;
switch (_that) {
case SupportedThemeMode() when themeMode != null:
return themeMode(_that.mode);case SupportedVideoCall() when videoCall != null:
return videoCall(_that.enabled);case SupportedLoggingConfig() when loggingConfig != null:
return loggingConfig(_that.logLevel,_that.checkIntervalSec,_that.anonymizationEnabled);case SupportedSystemNotifications() when systemNotifications != null:
return systemNotifications(_that.enabled);case SupportedHybridPresence() when hybridPresence != null:
return hybridPresence(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SupportedThemeMode implements SupportedFeature {
  const SupportedThemeMode({this.mode = ThemeModeConfig.system, final  String? $type}): $type = $type ?? 'themeMode';
  factory SupportedThemeMode.fromJson(Map<String, dynamic> json) => _$SupportedThemeModeFromJson(json);

@JsonKey() final  ThemeModeConfig mode;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedThemeModeCopyWith<SupportedThemeMode> get copyWith => _$SupportedThemeModeCopyWithImpl<SupportedThemeMode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedThemeModeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedThemeMode&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'SupportedFeature.themeMode(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $SupportedThemeModeCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedThemeModeCopyWith(SupportedThemeMode value, $Res Function(SupportedThemeMode) _then) = _$SupportedThemeModeCopyWithImpl;
@useResult
$Res call({
 ThemeModeConfig mode
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
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(SupportedThemeMode(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeModeConfig,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedVideoCall implements SupportedFeature {
  const SupportedVideoCall({this.enabled = true, final  String? $type}): $type = $type ?? 'videoCall';
  factory SupportedVideoCall.fromJson(Map<String, dynamic> json) => _$SupportedVideoCallFromJson(json);

@JsonKey() final  bool enabled;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedVideoCallCopyWith<SupportedVideoCall> get copyWith => _$SupportedVideoCallCopyWithImpl<SupportedVideoCall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedVideoCallToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedVideoCall&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SupportedFeature.videoCall(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SupportedVideoCallCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedVideoCallCopyWith(SupportedVideoCall value, $Res Function(SupportedVideoCall) _then) = _$SupportedVideoCallCopyWithImpl;
@useResult
$Res call({
 bool enabled
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
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(SupportedVideoCall(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedLoggingConfig implements SupportedFeature {
  const SupportedLoggingConfig({this.logLevel = 'INFO', this.checkIntervalSec = 15, this.anonymizationEnabled = true, final  String? $type}): $type = $type ?? 'loggingConfig';
  factory SupportedLoggingConfig.fromJson(Map<String, dynamic> json) => _$SupportedLoggingConfigFromJson(json);

@JsonKey() final  String logLevel;
@JsonKey() final  int checkIntervalSec;
@JsonKey() final  bool anonymizationEnabled;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedLoggingConfigCopyWith<SupportedLoggingConfig> get copyWith => _$SupportedLoggingConfigCopyWithImpl<SupportedLoggingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedLoggingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedLoggingConfig&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.checkIntervalSec, checkIntervalSec) || other.checkIntervalSec == checkIntervalSec)&&(identical(other.anonymizationEnabled, anonymizationEnabled) || other.anonymizationEnabled == anonymizationEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logLevel,checkIntervalSec,anonymizationEnabled);

@override
String toString() {
  return 'SupportedFeature.loggingConfig(logLevel: $logLevel, checkIntervalSec: $checkIntervalSec, anonymizationEnabled: $anonymizationEnabled)';
}


}

/// @nodoc
abstract mixin class $SupportedLoggingConfigCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedLoggingConfigCopyWith(SupportedLoggingConfig value, $Res Function(SupportedLoggingConfig) _then) = _$SupportedLoggingConfigCopyWithImpl;
@useResult
$Res call({
 String logLevel, int checkIntervalSec, bool anonymizationEnabled
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
@pragma('vm:prefer-inline') $Res call({Object? logLevel = null,Object? checkIntervalSec = null,Object? anonymizationEnabled = null,}) {
  return _then(SupportedLoggingConfig(
logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String,checkIntervalSec: null == checkIntervalSec ? _self.checkIntervalSec : checkIntervalSec // ignore: cast_nullable_to_non_nullable
as int,anonymizationEnabled: null == anonymizationEnabled ? _self.anonymizationEnabled : anonymizationEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedSystemNotifications implements SupportedFeature {
  const SupportedSystemNotifications({this.enabled = true, final  String? $type}): $type = $type ?? 'systemNotifications';
  factory SupportedSystemNotifications.fromJson(Map<String, dynamic> json) => _$SupportedSystemNotificationsFromJson(json);

@JsonKey() final  bool enabled;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedSystemNotificationsCopyWith<SupportedSystemNotifications> get copyWith => _$SupportedSystemNotificationsCopyWithImpl<SupportedSystemNotifications>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedSystemNotificationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedSystemNotifications&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SupportedFeature.systemNotifications(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SupportedSystemNotificationsCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedSystemNotificationsCopyWith(SupportedSystemNotifications value, $Res Function(SupportedSystemNotifications) _then) = _$SupportedSystemNotificationsCopyWithImpl;
@useResult
$Res call({
 bool enabled
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
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(SupportedSystemNotifications(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SupportedHybridPresence implements SupportedFeature {
  const SupportedHybridPresence({this.enabled = true, final  String? $type}): $type = $type ?? 'hybridPresence';
  factory SupportedHybridPresence.fromJson(Map<String, dynamic> json) => _$SupportedHybridPresenceFromJson(json);

@JsonKey() final  bool enabled;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SupportedFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedHybridPresenceCopyWith<SupportedHybridPresence> get copyWith => _$SupportedHybridPresenceCopyWithImpl<SupportedHybridPresence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedHybridPresenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedHybridPresence&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SupportedFeature.hybridPresence(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SupportedHybridPresenceCopyWith<$Res> implements $SupportedFeatureCopyWith<$Res> {
  factory $SupportedHybridPresenceCopyWith(SupportedHybridPresence value, $Res Function(SupportedHybridPresence) _then) = _$SupportedHybridPresenceCopyWithImpl;
@useResult
$Res call({
 bool enabled
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
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(SupportedHybridPresence(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
