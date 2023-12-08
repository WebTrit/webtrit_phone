// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactsSourceTypeChanged {
  ContactSourceType get sourceType => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ContactsSourceTypeChangedImpl implements _ContactsSourceTypeChanged {
  const _$ContactsSourceTypeChangedImpl(this.sourceType);

  @override
  final ContactSourceType sourceType;

  @override
  String toString() {
    return 'ContactsSourceTypeChanged(sourceType: $sourceType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsSourceTypeChangedImpl &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourceType);
}

abstract class _ContactsSourceTypeChanged implements ContactsSourceTypeChanged {
  const factory _ContactsSourceTypeChanged(final ContactSourceType sourceType) =
      _$ContactsSourceTypeChangedImpl;

  @override
  ContactSourceType get sourceType;
}

/// @nodoc
mixin _$ContactsSearchChanged {
  String get search => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ContactsSearchChangedImpl implements _ContactsSearchChanged {
  const _$ContactsSearchChangedImpl(this.search);

  @override
  final String search;

  @override
  String toString() {
    return 'ContactsSearchChanged(search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsSearchChangedImpl &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search);
}

abstract class _ContactsSearchChanged implements ContactsSearchChanged {
  const factory _ContactsSearchChanged(final String search) =
      _$ContactsSearchChangedImpl;

  @override
  String get search;
}

/// @nodoc
mixin _$ContactsSearchSubmitted {
  String get search => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ContactsSearchSubmittedImpl implements _ContactsSearchSubmitted {
  const _$ContactsSearchSubmittedImpl(this.search);

  @override
  final String search;

  @override
  String toString() {
    return 'ContactsSearchSubmitted(search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsSearchSubmittedImpl &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search);
}

abstract class _ContactsSearchSubmitted implements ContactsSearchSubmitted {
  const factory _ContactsSearchSubmitted(final String search) =
      _$ContactsSearchSubmittedImpl;

  @override
  String get search;
}

/// @nodoc
mixin _$ContactsState {
  String get search => throw _privateConstructorUsedError;
  ContactSourceType get sourceType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactsStateCopyWith<ContactsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactsStateCopyWith<$Res> {
  factory $ContactsStateCopyWith(
          ContactsState value, $Res Function(ContactsState) then) =
      _$ContactsStateCopyWithImpl<$Res, ContactsState>;
  @useResult
  $Res call({String search, ContactSourceType sourceType});
}

/// @nodoc
class _$ContactsStateCopyWithImpl<$Res, $Val extends ContactsState>
    implements $ContactsStateCopyWith<$Res> {
  _$ContactsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = null,
    Object? sourceType = null,
  }) {
    return _then(_value.copyWith(
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ContactSourceType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactsStateImplCopyWith<$Res>
    implements $ContactsStateCopyWith<$Res> {
  factory _$$ContactsStateImplCopyWith(
          _$ContactsStateImpl value, $Res Function(_$ContactsStateImpl) then) =
      __$$ContactsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String search, ContactSourceType sourceType});
}

/// @nodoc
class __$$ContactsStateImplCopyWithImpl<$Res>
    extends _$ContactsStateCopyWithImpl<$Res, _$ContactsStateImpl>
    implements _$$ContactsStateImplCopyWith<$Res> {
  __$$ContactsStateImplCopyWithImpl(
      _$ContactsStateImpl _value, $Res Function(_$ContactsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = null,
    Object? sourceType = null,
  }) {
    return _then(_$ContactsStateImpl(
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ContactSourceType,
    ));
  }
}

/// @nodoc

class _$ContactsStateImpl implements _ContactsState {
  const _$ContactsStateImpl({this.search = '', required this.sourceType});

  @override
  @JsonKey()
  final String search;
  @override
  final ContactSourceType sourceType;

  @override
  String toString() {
    return 'ContactsState(search: $search, sourceType: $sourceType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsStateImpl &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search, sourceType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactsStateImplCopyWith<_$ContactsStateImpl> get copyWith =>
      __$$ContactsStateImplCopyWithImpl<_$ContactsStateImpl>(this, _$identity);
}

abstract class _ContactsState implements ContactsState {
  const factory _ContactsState(
      {final String search,
      required final ContactSourceType sourceType}) = _$ContactsStateImpl;

  @override
  String get search;
  @override
  ContactSourceType get sourceType;
  @override
  @JsonKey(ignore: true)
  _$$ContactsStateImplCopyWith<_$ContactsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
