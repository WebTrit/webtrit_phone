// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_local_tab_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactsLocalTabStarted {
  String get search => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ContactsLocalTabStartedImpl implements _ContactsLocalTabStarted {
  const _$ContactsLocalTabStartedImpl({required this.search});

  @override
  final String search;

  @override
  String toString() {
    return 'ContactsLocalTabStarted(search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsLocalTabStartedImpl &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search);
}

abstract class _ContactsLocalTabStarted implements ContactsLocalTabStarted {
  const factory _ContactsLocalTabStarted({required final String search}) =
      _$ContactsLocalTabStartedImpl;

  @override
  String get search;
}

/// @nodoc
mixin _$ContactsLocalTabRefreshed {}

/// @nodoc

class _$ContactsLocalTabRefreshedImpl implements _ContactsLocalTabRefreshed {
  const _$ContactsLocalTabRefreshedImpl();

  @override
  String toString() {
    return 'ContactsLocalTabRefreshed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsLocalTabRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _ContactsLocalTabRefreshed implements ContactsLocalTabRefreshed {
  const factory _ContactsLocalTabRefreshed() = _$ContactsLocalTabRefreshedImpl;
}
