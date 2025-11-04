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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppState {
  Session get session => throw _privateConstructorUsedError;
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
  $Res call({
    Session session,
    ThemeSettings themeSettings,
    ThemeMode themeMode,
    Locale locale,
    AgreementStatus userAgreementStatus,
    AgreementStatus contactsAgreementStatus,
  });

  $SessionCopyWith<$Res> get session;
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
    Object? session = null,
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementStatus = null,
    Object? contactsAgreementStatus = null,
  }) {
    return _then(
      _value.copyWith(
            session: null == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as Session,
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
          )
          as $Val,
    );
  }

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionCopyWith<$Res> get session {
    return $SessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
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
    _$AppStateImpl value,
    $Res Function(_$AppStateImpl) then,
  ) = __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Session session,
    ThemeSettings themeSettings,
    ThemeMode themeMode,
    Locale locale,
    AgreementStatus userAgreementStatus,
    AgreementStatus contactsAgreementStatus,
  });

  @override
  $SessionCopyWith<$Res> get session;
  @override
  $ThemeSettingsCopyWith<$Res> get themeSettings;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
    _$AppStateImpl _value,
    $Res Function(_$AppStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementStatus = null,
    Object? contactsAgreementStatus = null,
  }) {
    return _then(
      _$AppStateImpl(
        session: null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as Session,
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
      ),
    );
  }
}

/// @nodoc

class _$AppStateImpl extends _AppState {
  const _$AppStateImpl({
    this.session = const Session(),
    required this.themeSettings,
    required this.themeMode,
    required this.locale,
    required this.userAgreementStatus,
    required this.contactsAgreementStatus,
  }) : super._();

  @override
  @JsonKey()
  final Session session;
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
    return 'AppState(session: $session, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale, userAgreementStatus: $userAgreementStatus, contactsAgreementStatus: $contactsAgreementStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.themeSettings, themeSettings) ||
                other.themeSettings == themeSettings) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.userAgreementStatus, userAgreementStatus) ||
                other.userAgreementStatus == userAgreementStatus) &&
            (identical(
                  other.contactsAgreementStatus,
                  contactsAgreementStatus,
                ) ||
                other.contactsAgreementStatus == contactsAgreementStatus));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    session,
    themeSettings,
    themeMode,
    locale,
    userAgreementStatus,
    contactsAgreementStatus,
  );

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState extends AppState {
  const factory _AppState({
    final Session session,
    required final ThemeSettings themeSettings,
    required final ThemeMode themeMode,
    required final Locale locale,
    required final AgreementStatus userAgreementStatus,
    required final AgreementStatus contactsAgreementStatus,
  }) = _$AppStateImpl;
  const _AppState._() : super._();

  @override
  Session get session;
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
