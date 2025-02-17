// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppLogined {
  String get coreUrl => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  WebtritSystemInfo get systemInfo => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppLoginedImpl implements _AppLogined {
  const _$AppLoginedImpl(
      {required this.coreUrl,
      required this.tenantId,
      required this.token,
      required this.userId,
      required this.systemInfo});

  @override
  final String coreUrl;
  @override
  final String tenantId;
  @override
  final String token;
  @override
  final String userId;
  @override
  final WebtritSystemInfo systemInfo;

  @override
  String toString() {
    return 'AppLogined(coreUrl: $coreUrl, tenantId: $tenantId, token: $token, userId: $userId, systemInfo: $systemInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLoginedImpl &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, coreUrl, tenantId, token, userId, systemInfo);
}

abstract class _AppLogined implements AppLogined {
  const factory _AppLogined(
      {required final String coreUrl,
      required final String tenantId,
      required final String token,
      required final String userId,
      required final WebtritSystemInfo systemInfo}) = _$AppLoginedImpl;

  @override
  String get coreUrl;
  @override
  String get tenantId;
  @override
  String get token;
  @override
  String get userId;
  @override
  WebtritSystemInfo get systemInfo;
}

/// @nodoc
mixin _$AppLogouted {
  bool get checkTokenForError => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppLogoutedImpl implements _AppLogouted {
  const _$AppLogoutedImpl({this.checkTokenForError = false});

  @override
  @JsonKey()
  final bool checkTokenForError;

  @override
  String toString() {
    return 'AppLogouted(checkTokenForError: $checkTokenForError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLogoutedImpl &&
            (identical(other.checkTokenForError, checkTokenForError) ||
                other.checkTokenForError == checkTokenForError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, checkTokenForError);
}

abstract class _AppLogouted implements AppLogouted {
  const factory _AppLogouted({final bool checkTokenForError}) =
      _$AppLogoutedImpl;

  @override
  bool get checkTokenForError;
}

/// @nodoc
mixin _$AppLogoutedTeardown {}

/// @nodoc

class _$AppLogoutTeardownImpl implements _AppLogoutTeardown {
  const _$AppLogoutTeardownImpl();

  @override
  String toString() {
    return 'AppLogoutedTeardown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppLogoutTeardownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _AppLogoutTeardown implements AppLogoutedTeardown {
  const factory _AppLogoutTeardown() = _$AppLogoutTeardownImpl;
}

/// @nodoc
mixin _$AppThemeSettingsChanged {
  ThemeSettings get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppThemeSettingsChangedImpl implements _AppThemeSettingsChanged {
  const _$AppThemeSettingsChangedImpl(this.value);

  @override
  final ThemeSettings value;

  @override
  String toString() {
    return 'AppThemeSettingsChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeSettingsChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppThemeSettingsChanged implements AppThemeSettingsChanged {
  const factory _AppThemeSettingsChanged(final ThemeSettings value) =
      _$AppThemeSettingsChangedImpl;

  @override
  ThemeSettings get value;
}

/// @nodoc
mixin _$AppThemeModeChanged {
  ThemeMode get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppThemeModeChangedImpl implements _AppThemeModeChanged {
  const _$AppThemeModeChangedImpl(this.value);

  @override
  final ThemeMode value;

  @override
  String toString() {
    return 'AppThemeModeChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeModeChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppThemeModeChanged implements AppThemeModeChanged {
  const factory _AppThemeModeChanged(final ThemeMode value) =
      _$AppThemeModeChangedImpl;

  @override
  ThemeMode get value;
}

/// @nodoc
mixin _$AppLocaleChanged {
  Locale get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppLocaleChangedImpl implements _AppLocaleChanged {
  const _$AppLocaleChangedImpl(this.value);

  @override
  final Locale value;

  @override
  String toString() {
    return 'AppLocaleChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLocaleChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppLocaleChanged implements AppLocaleChanged {
  const factory _AppLocaleChanged(final Locale value) = _$AppLocaleChangedImpl;

  @override
  Locale get value;
}

/// @nodoc
mixin _$AppAgreementAccepted {
  AgreementStatus get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AgreementStatus status) updateUserAgreement,
    required TResult Function(AgreementStatus status) updateContactsAgreement,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AgreementStatus status)? updateUserAgreement,
    TResult? Function(AgreementStatus status)? updateContactsAgreement,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AgreementStatus status)? updateUserAgreement,
    TResult Function(AgreementStatus status)? updateContactsAgreement,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UserAppAgreementUpdate value)
        updateUserAgreement,
    required TResult Function(_ContactsAppAgreementUpdate value)
        updateContactsAgreement,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult? Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$UserAppAgreementUpdateImpl implements _UserAppAgreementUpdate {
  const _$UserAppAgreementUpdateImpl(this.status);

  @override
  final AgreementStatus status;

  @override
  String toString() {
    return 'AppAgreementAccepted.updateUserAgreement(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAppAgreementUpdateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AgreementStatus status) updateUserAgreement,
    required TResult Function(AgreementStatus status) updateContactsAgreement,
  }) {
    return updateUserAgreement(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AgreementStatus status)? updateUserAgreement,
    TResult? Function(AgreementStatus status)? updateContactsAgreement,
  }) {
    return updateUserAgreement?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AgreementStatus status)? updateUserAgreement,
    TResult Function(AgreementStatus status)? updateContactsAgreement,
    required TResult orElse(),
  }) {
    if (updateUserAgreement != null) {
      return updateUserAgreement(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UserAppAgreementUpdate value)
        updateUserAgreement,
    required TResult Function(_ContactsAppAgreementUpdate value)
        updateContactsAgreement,
  }) {
    return updateUserAgreement(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult? Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
  }) {
    return updateUserAgreement?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
    required TResult orElse(),
  }) {
    if (updateUserAgreement != null) {
      return updateUserAgreement(this);
    }
    return orElse();
  }
}

abstract class _UserAppAgreementUpdate implements AppAgreementAccepted {
  const factory _UserAppAgreementUpdate(final AgreementStatus status) =
      _$UserAppAgreementUpdateImpl;

  @override
  AgreementStatus get status;
}

/// @nodoc

class _$ContactsAppAgreementUpdateImpl implements _ContactsAppAgreementUpdate {
  const _$ContactsAppAgreementUpdateImpl(this.status);

  @override
  final AgreementStatus status;

  @override
  String toString() {
    return 'AppAgreementAccepted.updateContactsAgreement(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsAppAgreementUpdateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AgreementStatus status) updateUserAgreement,
    required TResult Function(AgreementStatus status) updateContactsAgreement,
  }) {
    return updateContactsAgreement(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AgreementStatus status)? updateUserAgreement,
    TResult? Function(AgreementStatus status)? updateContactsAgreement,
  }) {
    return updateContactsAgreement?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AgreementStatus status)? updateUserAgreement,
    TResult Function(AgreementStatus status)? updateContactsAgreement,
    required TResult orElse(),
  }) {
    if (updateContactsAgreement != null) {
      return updateContactsAgreement(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UserAppAgreementUpdate value)
        updateUserAgreement,
    required TResult Function(_ContactsAppAgreementUpdate value)
        updateContactsAgreement,
  }) {
    return updateContactsAgreement(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult? Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
  }) {
    return updateContactsAgreement?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserAppAgreementUpdate value)? updateUserAgreement,
    TResult Function(_ContactsAppAgreementUpdate value)?
        updateContactsAgreement,
    required TResult orElse(),
  }) {
    if (updateContactsAgreement != null) {
      return updateContactsAgreement(this);
    }
    return orElse();
  }
}

abstract class _ContactsAppAgreementUpdate implements AppAgreementAccepted {
  const factory _ContactsAppAgreementUpdate(final AgreementStatus status) =
      _$ContactsAppAgreementUpdateImpl;

  @override
  AgreementStatus get status;
}

/// @nodoc
mixin _$AppState {
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  AccountErrorCode? get accountErrorCode => throw _privateConstructorUsedError;
  ThemeSettings get themeSettings => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Locale get locale => throw _privateConstructorUsedError;
  AgreementStatus get userAgreementStatus => throw _privateConstructorUsedError;
  AgreementStatus get contactsAgreementStatus =>
      throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {String? coreUrl,
      String? tenantId,
      String? token,
      String? userId,
      AccountErrorCode? accountErrorCode,
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale,
      AgreementStatus userAgreementStatus,
      AgreementStatus contactsAgreementStatus});

  $ThemeSettingsCopyWith<$Res> get themeSettings;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? accountErrorCode = freezed,
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementStatus = null,
    Object? contactsAgreementStatus = null,
  }) {
    return _then(_value.copyWith(
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountErrorCode: freezed == accountErrorCode
          ? _value.accountErrorCode
          : accountErrorCode // ignore: cast_nullable_to_non_nullable
              as AccountErrorCode?,
      themeSettings: null == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      userAgreementStatus: null == userAgreementStatus
          ? _value.userAgreementStatus
          : userAgreementStatus // ignore: cast_nullable_to_non_nullable
              as AgreementStatus,
      contactsAgreementStatus: null == contactsAgreementStatus
          ? _value.contactsAgreementStatus
          : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
              as AgreementStatus,
    ) as $Val);
  }

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeSettingsCopyWith<$Res> get themeSettings {
    return $ThemeSettingsCopyWith<$Res>(_value.themeSettings, (value) {
      return _then(_value.copyWith(themeSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? coreUrl,
      String? tenantId,
      String? token,
      String? userId,
      AccountErrorCode? accountErrorCode,
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale,
      AgreementStatus userAgreementStatus,
      AgreementStatus contactsAgreementStatus});

  @override
  $ThemeSettingsCopyWith<$Res> get themeSettings;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? accountErrorCode = freezed,
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementStatus = null,
    Object? contactsAgreementStatus = null,
  }) {
    return _then(_$AppStateImpl(
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountErrorCode: freezed == accountErrorCode
          ? _value.accountErrorCode
          : accountErrorCode // ignore: cast_nullable_to_non_nullable
              as AccountErrorCode?,
      themeSettings: null == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      userAgreementStatus: null == userAgreementStatus
          ? _value.userAgreementStatus
          : userAgreementStatus // ignore: cast_nullable_to_non_nullable
              as AgreementStatus,
      contactsAgreementStatus: null == contactsAgreementStatus
          ? _value.contactsAgreementStatus
          : contactsAgreementStatus // ignore: cast_nullable_to_non_nullable
              as AgreementStatus,
    ));
  }
}

/// @nodoc

class _$AppStateImpl extends _AppState {
  const _$AppStateImpl(
      {this.coreUrl,
      this.tenantId,
      this.token,
      this.userId,
      this.accountErrorCode,
      required this.themeSettings,
      required this.themeMode,
      required this.locale,
      required this.userAgreementStatus,
      required this.contactsAgreementStatus})
      : super._();

  @override
  final String? coreUrl;
  @override
  final String? tenantId;
  @override
  final String? token;
  @override
  final String? userId;
  @override
  final AccountErrorCode? accountErrorCode;
  @override
  final ThemeSettings themeSettings;
  @override
  final ThemeMode themeMode;
  @override
  final Locale locale;
  @override
  final AgreementStatus userAgreementStatus;
  @override
  final AgreementStatus contactsAgreementStatus;

  @override
  String toString() {
    return 'AppState(coreUrl: $coreUrl, tenantId: $tenantId, token: $token, userId: $userId, accountErrorCode: $accountErrorCode, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other.accountErrorCode, accountErrorCode) &&
            (identical(other.themeSettings, themeSettings) ||
                other.themeSettings == themeSettings) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.userAgreementStatus, userAgreementStatus) ||
                other.userAgreementStatus == userAgreementStatus) &&
            (identical(
                    other.contactsAgreementStatus, contactsAgreementStatus) ||
                other.contactsAgreementStatus == contactsAgreementStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      coreUrl,
      tenantId,
      token,
      userId,
      const DeepCollectionEquality().hash(accountErrorCode),
      themeSettings,
      themeMode,
      locale,
      userAgreementStatus,
      contactsAgreementStatus);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState extends AppState {
  const factory _AppState(
      {final String? coreUrl,
      final String? tenantId,
      final String? token,
      final String? userId,
      final AccountErrorCode? accountErrorCode,
      required final ThemeSettings themeSettings,
      required final ThemeMode themeMode,
      required final Locale locale,
      required final AgreementStatus userAgreementStatus,
      required final AgreementStatus contactsAgreementStatus}) = _$AppStateImpl;
  const _AppState._() : super._();

  @override
  String? get coreUrl;
  @override
  String? get tenantId;
  @override
  String? get token;
  @override
  String? get userId;
  @override
  AccountErrorCode? get accountErrorCode;
  @override
  ThemeSettings get themeSettings;
  @override
  ThemeMode get themeMode;
  @override
  Locale get locale;
  @override
  AgreementStatus get userAgreementStatus;
  @override
  AgreementStatus get contactsAgreementStatus;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
