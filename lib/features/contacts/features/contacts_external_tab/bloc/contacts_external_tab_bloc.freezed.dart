// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_external_tab_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactsExternalTabStarted {
  String get search => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ContactsExternalTabStartedImpl implements _ContactsExternalTabStarted {
  const _$ContactsExternalTabStartedImpl({required this.search});

  @override
  final String search;

  @override
  String toString() {
    return 'ContactsExternalTabStarted(search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsExternalTabStartedImpl &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search);
}

abstract class _ContactsExternalTabStarted
    implements ContactsExternalTabStarted {
  const factory _ContactsExternalTabStarted({required final String search}) =
      _$ContactsExternalTabStartedImpl;

  @override
  String get search;
}

/// @nodoc
mixin _$ContactsExternalTabRefreshed {}

/// @nodoc

class _$ContactsExternalTabRefreshedImpl
    implements _ContactsExternalTabRefreshed {
  const _$ContactsExternalTabRefreshedImpl();

  @override
  String toString() {
    return 'ContactsExternalTabRefreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsExternalTabRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _ContactsExternalTabRefreshed
    implements ContactsExternalTabRefreshed {
  const factory _ContactsExternalTabRefreshed() =
      _$ContactsExternalTabRefreshedImpl;
}
