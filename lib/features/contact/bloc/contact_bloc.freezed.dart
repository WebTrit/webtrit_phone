// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactAddedByToFavorites {
  ContactPhone get contactPhone => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_ContactAddedByToFavorites implements _ContactAddedByToFavorites {
  const _$_ContactAddedByToFavorites(this.contactPhone);

  @override
  final ContactPhone contactPhone;

  @override
  String toString() {
    return 'ContactAddedByToFavorites(contactPhone: $contactPhone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactAddedByToFavorites &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactPhone);
}

abstract class _ContactAddedByToFavorites implements ContactAddedByToFavorites {
  const factory _ContactAddedByToFavorites(final ContactPhone contactPhone) =
      _$_ContactAddedByToFavorites;

  @override
  ContactPhone get contactPhone;
}

/// @nodoc
mixin _$ContactRemovedFromFavorites {
  ContactPhone get contactPhone => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_ContactRemovedFromFavorites implements _ContactRemovedFromFavorites {
  const _$_ContactRemovedFromFavorites(this.contactPhone);

  @override
  final ContactPhone contactPhone;

  @override
  String toString() {
    return 'ContactRemovedFromFavorites(contactPhone: $contactPhone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactRemovedFromFavorites &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactPhone);
}

abstract class _ContactRemovedFromFavorites
    implements ContactRemovedFromFavorites {
  const factory _ContactRemovedFromFavorites(final ContactPhone contactPhone) =
      _$_ContactRemovedFromFavorites;

  @override
  ContactPhone get contactPhone;
}

/// @nodoc
mixin _$ContactEmailSend {
  ContactEmail get contactEmail => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_ContactEmailSend implements _ContactEmailSend {
  const _$_ContactEmailSend(this.contactEmail);

  @override
  final ContactEmail contactEmail;

  @override
  String toString() {
    return 'ContactEmailSend(contactEmail: $contactEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactEmailSend &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactEmail);
}

abstract class _ContactEmailSend implements ContactEmailSend {
  const factory _ContactEmailSend(final ContactEmail contactEmail) =
      _$_ContactEmailSend;

  @override
  ContactEmail get contactEmail;
}

/// @nodoc
mixin _$ContactState {
  Contact? get contact => throw _privateConstructorUsedError;
  List<ContactPhone>? get contactPhones => throw _privateConstructorUsedError;
  List<ContactEmail>? get contactEmails => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactStateCopyWith<ContactState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStateCopyWith<$Res> {
  factory $ContactStateCopyWith(
          ContactState value, $Res Function(ContactState) then) =
      _$ContactStateCopyWithImpl<$Res, ContactState>;
  @useResult
  $Res call(
      {Contact? contact,
      List<ContactPhone>? contactPhones,
      List<ContactEmail>? contactEmails});
}

/// @nodoc
class _$ContactStateCopyWithImpl<$Res, $Val extends ContactState>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? contactPhones = freezed,
    Object? contactEmails = freezed,
  }) {
    return _then(_value.copyWith(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      contactPhones: freezed == contactPhones
          ? _value.contactPhones
          : contactPhones // ignore: cast_nullable_to_non_nullable
              as List<ContactPhone>?,
      contactEmails: freezed == contactEmails
          ? _value.contactEmails
          : contactEmails // ignore: cast_nullable_to_non_nullable
              as List<ContactEmail>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContactStateCopyWith<$Res>
    implements $ContactStateCopyWith<$Res> {
  factory _$$_ContactStateCopyWith(
          _$_ContactState value, $Res Function(_$_ContactState) then) =
      __$$_ContactStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Contact? contact,
      List<ContactPhone>? contactPhones,
      List<ContactEmail>? contactEmails});
}

/// @nodoc
class __$$_ContactStateCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$_ContactState>
    implements _$$_ContactStateCopyWith<$Res> {
  __$$_ContactStateCopyWithImpl(
      _$_ContactState _value, $Res Function(_$_ContactState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? contactPhones = freezed,
    Object? contactEmails = freezed,
  }) {
    return _then(_$_ContactState(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      contactPhones: freezed == contactPhones
          ? _value._contactPhones
          : contactPhones // ignore: cast_nullable_to_non_nullable
              as List<ContactPhone>?,
      contactEmails: freezed == contactEmails
          ? _value._contactEmails
          : contactEmails // ignore: cast_nullable_to_non_nullable
              as List<ContactEmail>?,
    ));
  }
}

/// @nodoc

class _$_ContactState implements _ContactState {
  const _$_ContactState(
      {this.contact,
      final List<ContactPhone>? contactPhones,
      final List<ContactEmail>? contactEmails})
      : _contactPhones = contactPhones,
        _contactEmails = contactEmails;

  @override
  final Contact? contact;
  final List<ContactPhone>? _contactPhones;
  @override
  List<ContactPhone>? get contactPhones {
    final value = _contactPhones;
    if (value == null) return null;
    if (_contactPhones is EqualUnmodifiableListView) return _contactPhones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ContactEmail>? _contactEmails;
  @override
  List<ContactEmail>? get contactEmails {
    final value = _contactEmails;
    if (value == null) return null;
    if (_contactEmails is EqualUnmodifiableListView) return _contactEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ContactState(contact: $contact, contactPhones: $contactPhones, contactEmails: $contactEmails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactState &&
            (identical(other.contact, contact) || other.contact == contact) &&
            const DeepCollectionEquality()
                .equals(other._contactPhones, _contactPhones) &&
            const DeepCollectionEquality()
                .equals(other._contactEmails, _contactEmails));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      contact,
      const DeepCollectionEquality().hash(_contactPhones),
      const DeepCollectionEquality().hash(_contactEmails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContactStateCopyWith<_$_ContactState> get copyWith =>
      __$$_ContactStateCopyWithImpl<_$_ContactState>(this, _$identity);
}

abstract class _ContactState implements ContactState {
  const factory _ContactState(
      {final Contact? contact,
      final List<ContactPhone>? contactPhones,
      final List<ContactEmail>? contactEmails}) = _$_ContactState;

  @override
  Contact? get contact;
  @override
  List<ContactPhone>? get contactPhones;
  @override
  List<ContactEmail>? get contactEmails;
  @override
  @JsonKey(ignore: true)
  _$$_ContactStateCopyWith<_$_ContactState> get copyWith =>
      throw _privateConstructorUsedError;
}
