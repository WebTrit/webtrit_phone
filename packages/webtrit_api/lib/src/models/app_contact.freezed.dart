// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppContact _$AppContactFromJson(Map<String, dynamic> json) {
  return _AppContact.fromJson(json);
}

/// @nodoc
mixin _$AppContact {
  String get identifier => throw _privateConstructorUsedError;
  List<String> get phones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppContactCopyWith<AppContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppContactCopyWith<$Res> {
  factory $AppContactCopyWith(
          AppContact value, $Res Function(AppContact) then) =
      _$AppContactCopyWithImpl<$Res, AppContact>;
  @useResult
  $Res call({String identifier, List<String> phones});
}

/// @nodoc
class _$AppContactCopyWithImpl<$Res, $Val extends AppContact>
    implements $AppContactCopyWith<$Res> {
  _$AppContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? phones = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phones: null == phones
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppContactImplCopyWith<$Res>
    implements $AppContactCopyWith<$Res> {
  factory _$$AppContactImplCopyWith(
          _$AppContactImpl value, $Res Function(_$AppContactImpl) then) =
      __$$AppContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String identifier, List<String> phones});
}

/// @nodoc
class __$$AppContactImplCopyWithImpl<$Res>
    extends _$AppContactCopyWithImpl<$Res, _$AppContactImpl>
    implements _$$AppContactImplCopyWith<$Res> {
  __$$AppContactImplCopyWithImpl(
      _$AppContactImpl _value, $Res Function(_$AppContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? phones = null,
  }) {
    return _then(_$AppContactImpl(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phones: null == phones
          ? _value._phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$AppContactImpl implements _AppContact {
  const _$AppContactImpl(
      {required this.identifier, required final List<String> phones})
      : _phones = phones;

  factory _$AppContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppContactImplFromJson(json);

  @override
  final String identifier;
  final List<String> _phones;
  @override
  List<String> get phones {
    if (_phones is EqualUnmodifiableListView) return _phones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phones);
  }

  @override
  String toString() {
    return 'AppContact(identifier: $identifier, phones: $phones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppContactImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            const DeepCollectionEquality().equals(other._phones, _phones));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, identifier, const DeepCollectionEquality().hash(_phones));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppContactImplCopyWith<_$AppContactImpl> get copyWith =>
      __$$AppContactImplCopyWithImpl<_$AppContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppContactImplToJson(
      this,
    );
  }
}

abstract class _AppContact implements AppContact {
  const factory _AppContact(
      {required final String identifier,
      required final List<String> phones}) = _$AppContactImpl;

  factory _AppContact.fromJson(Map<String, dynamic> json) =
      _$AppContactImpl.fromJson;

  @override
  String get identifier;
  @override
  List<String> get phones;
  @override
  @JsonKey(ignore: true)
  _$$AppContactImplCopyWith<_$AppContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
