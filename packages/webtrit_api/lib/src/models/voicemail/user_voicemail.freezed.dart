// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_voicemail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserVoicemail _$UserVoicemailFromJson(Map<String, dynamic> json) {
  return _UserVoicemail.fromJson(json);
}

/// @nodoc
mixin _$UserVoicemail {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get receiver => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<UserVoicemailAttachment> get attachments =>
      throw _privateConstructorUsedError;

  /// Serializes this UserVoicemail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoicemail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoicemailCopyWith<UserVoicemail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVoicemailCopyWith<$Res> {
  factory $UserVoicemailCopyWith(
    UserVoicemail value,
    $Res Function(UserVoicemail) then,
  ) = _$UserVoicemailCopyWithImpl<$Res, UserVoicemail>;
  @useResult
  $Res call({
    String id,
    String date,
    double duration,
    String sender,
    String receiver,
    bool seen,
    int size,
    String type,
    List<UserVoicemailAttachment> attachments,
  });
}

/// @nodoc
class _$UserVoicemailCopyWithImpl<$Res, $Val extends UserVoicemail>
    implements $UserVoicemailCopyWith<$Res> {
  _$UserVoicemailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVoicemail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? duration = null,
    Object? sender = null,
    Object? receiver = null,
    Object? seen = null,
    Object? size = null,
    Object? type = null,
    Object? attachments = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as double,
            sender: null == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as String,
            receiver: null == receiver
                ? _value.receiver
                : receiver // ignore: cast_nullable_to_non_nullable
                      as String,
            seen: null == seen
                ? _value.seen
                : seen // ignore: cast_nullable_to_non_nullable
                      as bool,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<UserVoicemailAttachment>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserVoicemailImplCopyWith<$Res>
    implements $UserVoicemailCopyWith<$Res> {
  factory _$$UserVoicemailImplCopyWith(
    _$UserVoicemailImpl value,
    $Res Function(_$UserVoicemailImpl) then,
  ) = __$$UserVoicemailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String date,
    double duration,
    String sender,
    String receiver,
    bool seen,
    int size,
    String type,
    List<UserVoicemailAttachment> attachments,
  });
}

/// @nodoc
class __$$UserVoicemailImplCopyWithImpl<$Res>
    extends _$UserVoicemailCopyWithImpl<$Res, _$UserVoicemailImpl>
    implements _$$UserVoicemailImplCopyWith<$Res> {
  __$$UserVoicemailImplCopyWithImpl(
    _$UserVoicemailImpl _value,
    $Res Function(_$UserVoicemailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserVoicemail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? duration = null,
    Object? sender = null,
    Object? receiver = null,
    Object? seen = null,
    Object? size = null,
    Object? type = null,
    Object? attachments = null,
  }) {
    return _then(
      _$UserVoicemailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        sender: null == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as String,
        receiver: null == receiver
            ? _value.receiver
            : receiver // ignore: cast_nullable_to_non_nullable
                  as String,
        seen: null == seen
            ? _value.seen
            : seen // ignore: cast_nullable_to_non_nullable
                  as bool,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<UserVoicemailAttachment>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoicemailImpl implements _UserVoicemail {
  const _$UserVoicemailImpl({
    required this.id,
    required this.date,
    required this.duration,
    required this.sender,
    required this.receiver,
    required this.seen,
    required this.size,
    required this.type,
    required final List<UserVoicemailAttachment> attachments,
  }) : _attachments = attachments;

  factory _$UserVoicemailImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoicemailImplFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final double duration;
  @override
  final String sender;
  @override
  final String receiver;
  @override
  final bool seen;
  @override
  final int size;
  @override
  final String type;
  final List<UserVoicemailAttachment> _attachments;
  @override
  List<UserVoicemailAttachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'UserVoicemail(id: $id, date: $date, duration: $duration, sender: $sender, receiver: $receiver, seen: $seen, size: $size, type: $type, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoicemailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    duration,
    sender,
    receiver,
    seen,
    size,
    type,
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of UserVoicemail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoicemailImplCopyWith<_$UserVoicemailImpl> get copyWith =>
      __$$UserVoicemailImplCopyWithImpl<_$UserVoicemailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoicemailImplToJson(this);
  }
}

abstract class _UserVoicemail implements UserVoicemail {
  const factory _UserVoicemail({
    required final String id,
    required final String date,
    required final double duration,
    required final String sender,
    required final String receiver,
    required final bool seen,
    required final int size,
    required final String type,
    required final List<UserVoicemailAttachment> attachments,
  }) = _$UserVoicemailImpl;

  factory _UserVoicemail.fromJson(Map<String, dynamic> json) =
      _$UserVoicemailImpl.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  double get duration;
  @override
  String get sender;
  @override
  String get receiver;
  @override
  bool get seen;
  @override
  int get size;
  @override
  String get type;
  @override
  List<UserVoicemailAttachment> get attachments;

  /// Create a copy of UserVoicemail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoicemailImplCopyWith<_$UserVoicemailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserVoicemailAttachment _$UserVoicemailAttachmentFromJson(
  Map<String, dynamic> json,
) {
  return _UserVoicemailAttachment.fromJson(json);
}

/// @nodoc
mixin _$UserVoicemailAttachment {
  String get filename => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get subtype => throw _privateConstructorUsedError;

  /// Serializes this UserVoicemailAttachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoicemailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoicemailAttachmentCopyWith<UserVoicemailAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVoicemailAttachmentCopyWith<$Res> {
  factory $UserVoicemailAttachmentCopyWith(
    UserVoicemailAttachment value,
    $Res Function(UserVoicemailAttachment) then,
  ) = _$UserVoicemailAttachmentCopyWithImpl<$Res, UserVoicemailAttachment>;
  @useResult
  $Res call({String filename, int size, String type, String subtype});
}

/// @nodoc
class _$UserVoicemailAttachmentCopyWithImpl<
  $Res,
  $Val extends UserVoicemailAttachment
>
    implements $UserVoicemailAttachmentCopyWith<$Res> {
  _$UserVoicemailAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVoicemailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? size = null,
    Object? type = null,
    Object? subtype = null,
  }) {
    return _then(
      _value.copyWith(
            filename: null == filename
                ? _value.filename
                : filename // ignore: cast_nullable_to_non_nullable
                      as String,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            subtype: null == subtype
                ? _value.subtype
                : subtype // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserVoicemailAttachmentImplCopyWith<$Res>
    implements $UserVoicemailAttachmentCopyWith<$Res> {
  factory _$$UserVoicemailAttachmentImplCopyWith(
    _$UserVoicemailAttachmentImpl value,
    $Res Function(_$UserVoicemailAttachmentImpl) then,
  ) = __$$UserVoicemailAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String filename, int size, String type, String subtype});
}

/// @nodoc
class __$$UserVoicemailAttachmentImplCopyWithImpl<$Res>
    extends
        _$UserVoicemailAttachmentCopyWithImpl<
          $Res,
          _$UserVoicemailAttachmentImpl
        >
    implements _$$UserVoicemailAttachmentImplCopyWith<$Res> {
  __$$UserVoicemailAttachmentImplCopyWithImpl(
    _$UserVoicemailAttachmentImpl _value,
    $Res Function(_$UserVoicemailAttachmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserVoicemailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? size = null,
    Object? type = null,
    Object? subtype = null,
  }) {
    return _then(
      _$UserVoicemailAttachmentImpl(
        filename: null == filename
            ? _value.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        subtype: null == subtype
            ? _value.subtype
            : subtype // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoicemailAttachmentImpl implements _UserVoicemailAttachment {
  const _$UserVoicemailAttachmentImpl({
    required this.filename,
    required this.size,
    required this.type,
    required this.subtype,
  });

  factory _$UserVoicemailAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoicemailAttachmentImplFromJson(json);

  @override
  final String filename;
  @override
  final int size;
  @override
  final String type;
  @override
  final String subtype;

  @override
  String toString() {
    return 'UserVoicemailAttachment(filename: $filename, size: $size, type: $type, subtype: $subtype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoicemailAttachmentImpl &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subtype, subtype) || other.subtype == subtype));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filename, size, type, subtype);

  /// Create a copy of UserVoicemailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoicemailAttachmentImplCopyWith<_$UserVoicemailAttachmentImpl>
  get copyWith =>
      __$$UserVoicemailAttachmentImplCopyWithImpl<
        _$UserVoicemailAttachmentImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoicemailAttachmentImplToJson(this);
  }
}

abstract class _UserVoicemailAttachment implements UserVoicemailAttachment {
  const factory _UserVoicemailAttachment({
    required final String filename,
    required final int size,
    required final String type,
    required final String subtype,
  }) = _$UserVoicemailAttachmentImpl;

  factory _UserVoicemailAttachment.fromJson(Map<String, dynamic> json) =
      _$UserVoicemailAttachmentImpl.fromJson;

  @override
  String get filename;
  @override
  int get size;
  @override
  String get type;
  @override
  String get subtype;

  /// Create a copy of UserVoicemailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoicemailAttachmentImplCopyWith<_$UserVoicemailAttachmentImpl>
  get copyWith => throw _privateConstructorUsedError;
}
