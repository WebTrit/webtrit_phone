// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ContactsTableTable extends ContactsTable
    with TableInfo<$ContactsTableTable, ContactData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumnWithTypeConverter<ContactSourceTypeEnum, int>
      sourceType = GeneratedColumn<int>('source_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ContactSourceTypeEnum>(
              $ContactsTableTable.$convertersourceType);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aliasNameMeta =
      const VerificationMeta('aliasName');
  @override
  late final GeneratedColumn<String> aliasName = GeneratedColumn<String>(
      'alias_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<Uint8List> thumbnail = GeneratedColumn<Uint8List>(
      'thumbnail', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _registeredMeta =
      const VerificationMeta('registered');
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
      'registered', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("registered" IN (0, 1))'));
  static const VerificationMeta _userRegisteredMeta =
      const VerificationMeta('userRegistered');
  @override
  late final GeneratedColumn<bool> userRegistered = GeneratedColumn<bool>(
      'user_registered', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("user_registered" IN (0, 1))'));
  static const VerificationMeta _isCurrentUserMeta =
      const VerificationMeta('isCurrentUser');
  @override
  late final GeneratedColumn<bool> isCurrentUser = GeneratedColumn<bool>(
      'is_current_user', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_current_user" IN (0, 1))'));
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceType,
        sourceId,
        firstName,
        lastName,
        aliasName,
        thumbnail,
        registered,
        userRegistered,
        isCurrentUser,
        insertedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<ContactData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_sourceTypeMeta, const VerificationResult.success());
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('alias_name')) {
      context.handle(_aliasNameMeta,
          aliasName.isAcceptableOrUnknown(data['alias_name']!, _aliasNameMeta));
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('registered')) {
      context.handle(
          _registeredMeta,
          registered.isAcceptableOrUnknown(
              data['registered']!, _registeredMeta));
    }
    if (data.containsKey('user_registered')) {
      context.handle(
          _userRegisteredMeta,
          userRegistered.isAcceptableOrUnknown(
              data['user_registered']!, _userRegisteredMeta));
    }
    if (data.containsKey('is_current_user')) {
      context.handle(
          _isCurrentUserMeta,
          isCurrentUser.isAcceptableOrUnknown(
              data['is_current_user']!, _isCurrentUserMeta));
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sourceType: $ContactsTableTable.$convertersourceType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}source_type'])!),
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name']),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      aliasName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alias_name']),
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}thumbnail']),
      registered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}registered']),
      userRegistered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}user_registered']),
      isCurrentUser: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_current_user']),
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ContactsTableTable createAlias(String alias) {
    return $ContactsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContactSourceTypeEnum, int, int>
      $convertersourceType = const EnumIndexConverter<ContactSourceTypeEnum>(
          ContactSourceTypeEnum.values);
}

class ContactData extends DataClass implements Insertable<ContactData> {
  final int id;
  final ContactSourceTypeEnum sourceType;
  final String sourceId;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final Uint8List? thumbnail;
  final bool? registered;
  final bool? userRegistered;
  final bool? isCurrentUser;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactData(
      {required this.id,
      required this.sourceType,
      required this.sourceId,
      this.firstName,
      this.lastName,
      this.aliasName,
      this.thumbnail,
      this.registered,
      this.userRegistered,
      this.isCurrentUser,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['source_type'] = Variable<int>(
          $ContactsTableTable.$convertersourceType.toSql(sourceType));
    }
    map['source_id'] = Variable<String>(sourceId);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || aliasName != null) {
      map['alias_name'] = Variable<String>(aliasName);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<Uint8List>(thumbnail);
    }
    if (!nullToAbsent || registered != null) {
      map['registered'] = Variable<bool>(registered);
    }
    if (!nullToAbsent || userRegistered != null) {
      map['user_registered'] = Variable<bool>(userRegistered);
    }
    if (!nullToAbsent || isCurrentUser != null) {
      map['is_current_user'] = Variable<bool>(isCurrentUser);
    }
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ContactDataCompanion toCompanion(bool nullToAbsent) {
    return ContactDataCompanion(
      id: Value(id),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      aliasName: aliasName == null && nullToAbsent
          ? const Value.absent()
          : Value(aliasName),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      registered: registered == null && nullToAbsent
          ? const Value.absent()
          : Value(registered),
      userRegistered: userRegistered == null && nullToAbsent
          ? const Value.absent()
          : Value(userRegistered),
      isCurrentUser: isCurrentUser == null && nullToAbsent
          ? const Value.absent()
          : Value(isCurrentUser),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ContactData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactData(
      id: serializer.fromJson<int>(json['id']),
      sourceType: $ContactsTableTable.$convertersourceType
          .fromJson(serializer.fromJson<int>(json['sourceType'])),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      aliasName: serializer.fromJson<String?>(json['aliasName']),
      thumbnail: serializer.fromJson<Uint8List?>(json['thumbnail']),
      registered: serializer.fromJson<bool?>(json['registered']),
      userRegistered: serializer.fromJson<bool?>(json['userRegistered']),
      isCurrentUser: serializer.fromJson<bool?>(json['isCurrentUser']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceType': serializer.toJson<int>(
          $ContactsTableTable.$convertersourceType.toJson(sourceType)),
      'sourceId': serializer.toJson<String>(sourceId),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'aliasName': serializer.toJson<String?>(aliasName),
      'thumbnail': serializer.toJson<Uint8List?>(thumbnail),
      'registered': serializer.toJson<bool?>(registered),
      'userRegistered': serializer.toJson<bool?>(userRegistered),
      'isCurrentUser': serializer.toJson<bool?>(isCurrentUser),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ContactData copyWith(
          {int? id,
          ContactSourceTypeEnum? sourceType,
          String? sourceId,
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<String?> aliasName = const Value.absent(),
          Value<Uint8List?> thumbnail = const Value.absent(),
          Value<bool?> registered = const Value.absent(),
          Value<bool?> userRegistered = const Value.absent(),
          Value<bool?> isCurrentUser = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactData(
        id: id ?? this.id,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        aliasName: aliasName.present ? aliasName.value : this.aliasName,
        thumbnail: thumbnail.present ? thumbnail.value : this.thumbnail,
        registered: registered.present ? registered.value : this.registered,
        userRegistered:
            userRegistered.present ? userRegistered.value : this.userRegistered,
        isCurrentUser:
            isCurrentUser.present ? isCurrentUser.value : this.isCurrentUser,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ContactData copyWithCompanion(ContactDataCompanion data) {
    return ContactData(
      id: data.id.present ? data.id.value : this.id,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      aliasName: data.aliasName.present ? data.aliasName.value : this.aliasName,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
      registered:
          data.registered.present ? data.registered.value : this.registered,
      userRegistered: data.userRegistered.present
          ? data.userRegistered.value
          : this.userRegistered,
      isCurrentUser: data.isCurrentUser.present
          ? data.isCurrentUser.value
          : this.isCurrentUser,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactData(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('aliasName: $aliasName, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('registered: $registered, ')
          ..write('userRegistered: $userRegistered, ')
          ..write('isCurrentUser: $isCurrentUser, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sourceType,
      sourceId,
      firstName,
      lastName,
      aliasName,
      $driftBlobEquality.hash(thumbnail),
      registered,
      userRegistered,
      isCurrentUser,
      insertedAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactData &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.aliasName == this.aliasName &&
          $driftBlobEquality.equals(other.thumbnail, this.thumbnail) &&
          other.registered == this.registered &&
          other.userRegistered == this.userRegistered &&
          other.isCurrentUser == this.isCurrentUser &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactDataCompanion extends UpdateCompanion<ContactData> {
  final Value<int> id;
  final Value<ContactSourceTypeEnum> sourceType;
  final Value<String> sourceId;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> aliasName;
  final Value<Uint8List?> thumbnail;
  final Value<bool?> registered;
  final Value<bool?> userRegistered;
  final Value<bool?> isCurrentUser;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactDataCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.aliasName = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.registered = const Value.absent(),
    this.userRegistered = const Value.absent(),
    this.isCurrentUser = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactDataCompanion.insert({
    this.id = const Value.absent(),
    required ContactSourceTypeEnum sourceType,
    required String sourceId,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.aliasName = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.registered = const Value.absent(),
    this.userRegistered = const Value.absent(),
    this.isCurrentUser = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sourceType = Value(sourceType),
        sourceId = Value(sourceId);
  static Insertable<ContactData> custom({
    Expression<int>? id,
    Expression<int>? sourceType,
    Expression<String>? sourceId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? aliasName,
    Expression<Uint8List>? thumbnail,
    Expression<bool>? registered,
    Expression<bool>? userRegistered,
    Expression<bool>? isCurrentUser,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (aliasName != null) 'alias_name': aliasName,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (registered != null) 'registered': registered,
      if (userRegistered != null) 'user_registered': userRegistered,
      if (isCurrentUser != null) 'is_current_user': isCurrentUser,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ContactDataCompanion copyWith(
      {Value<int>? id,
      Value<ContactSourceTypeEnum>? sourceType,
      Value<String>? sourceId,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? aliasName,
      Value<Uint8List?>? thumbnail,
      Value<bool?>? registered,
      Value<bool?>? userRegistered,
      Value<bool?>? isCurrentUser,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactDataCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aliasName: aliasName ?? this.aliasName,
      thumbnail: thumbnail ?? this.thumbnail,
      registered: registered ?? this.registered,
      userRegistered: userRegistered ?? this.userRegistered,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<int>(
          $ContactsTableTable.$convertersourceType.toSql(sourceType.value));
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (aliasName.present) {
      map['alias_name'] = Variable<String>(aliasName.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<Uint8List>(thumbnail.value);
    }
    if (registered.present) {
      map['registered'] = Variable<bool>(registered.value);
    }
    if (userRegistered.present) {
      map['user_registered'] = Variable<bool>(userRegistered.value);
    }
    if (isCurrentUser.present) {
      map['is_current_user'] = Variable<bool>(isCurrentUser.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactDataCompanion(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('aliasName: $aliasName, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('registered: $registered, ')
          ..write('userRegistered: $userRegistered, ')
          ..write('isCurrentUser: $isCurrentUser, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactPhonesTableTable extends ContactPhonesTable
    with TableInfo<$ContactPhonesTableTable, ContactPhoneData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactPhonesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES contacts(id) ON DELETE CASCADE');
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, label, contactId, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_phones';
  @override
  VerificationContext validateIntegrity(Insertable<ContactPhoneData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactPhoneData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactPhoneData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ContactPhonesTableTable createAlias(String alias) {
    return $ContactPhonesTableTable(attachedDatabase, alias);
  }
}

class ContactPhoneData extends DataClass
    implements Insertable<ContactPhoneData> {
  final int id;
  final String number;
  final String label;
  final int contactId;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactPhoneData(
      {required this.id,
      required this.number,
      required this.label,
      required this.contactId,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<String>(number);
    map['label'] = Variable<String>(label);
    map['contact_id'] = Variable<int>(contactId);
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ContactPhoneDataCompanion toCompanion(bool nullToAbsent) {
    return ContactPhoneDataCompanion(
      id: Value(id),
      number: Value(number),
      label: Value(label),
      contactId: Value(contactId),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ContactPhoneData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactPhoneData(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      label: serializer.fromJson<String>(json['label']),
      contactId: serializer.fromJson<int>(json['contactId']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<String>(number),
      'label': serializer.toJson<String>(label),
      'contactId': serializer.toJson<int>(contactId),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ContactPhoneData copyWith(
          {int? id,
          String? number,
          String? label,
          int? contactId,
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactPhoneData(
        id: id ?? this.id,
        number: number ?? this.number,
        label: label ?? this.label,
        contactId: contactId ?? this.contactId,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ContactPhoneData copyWithCompanion(ContactPhoneDataCompanion data) {
    return ContactPhoneData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      label: data.label.present ? data.label.value : this.label,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactPhoneData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('label: $label, ')
          ..write('contactId: $contactId, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, number, label, contactId, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactPhoneData &&
          other.id == this.id &&
          other.number == this.number &&
          other.label == this.label &&
          other.contactId == this.contactId &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactPhoneDataCompanion extends UpdateCompanion<ContactPhoneData> {
  final Value<int> id;
  final Value<String> number;
  final Value<String> label;
  final Value<int> contactId;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactPhoneDataCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.label = const Value.absent(),
    this.contactId = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactPhoneDataCompanion.insert({
    this.id = const Value.absent(),
    required String number,
    required String label,
    required int contactId,
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : number = Value(number),
        label = Value(label),
        contactId = Value(contactId);
  static Insertable<ContactPhoneData> custom({
    Expression<int>? id,
    Expression<String>? number,
    Expression<String>? label,
    Expression<int>? contactId,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (label != null) 'label': label,
      if (contactId != null) 'contact_id': contactId,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ContactPhoneDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? number,
      Value<String>? label,
      Value<int>? contactId,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactPhoneDataCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      label: label ?? this.label,
      contactId: contactId ?? this.contactId,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactPhoneDataCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('label: $label, ')
          ..write('contactId: $contactId, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactEmailsTableTable extends ContactEmailsTable
    with TableInfo<$ContactEmailsTableTable, ContactEmailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactEmailsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES contacts(id) ON DELETE CASCADE');
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, address, label, contactId, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_emails';
  @override
  VerificationContext validateIntegrity(Insertable<ContactEmailData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactEmailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactEmailData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ContactEmailsTableTable createAlias(String alias) {
    return $ContactEmailsTableTable(attachedDatabase, alias);
  }
}

class ContactEmailData extends DataClass
    implements Insertable<ContactEmailData> {
  final int id;
  final String address;
  final String label;
  final int contactId;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactEmailData(
      {required this.id,
      required this.address,
      required this.label,
      required this.contactId,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['address'] = Variable<String>(address);
    map['label'] = Variable<String>(label);
    map['contact_id'] = Variable<int>(contactId);
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ContactEmailDataCompanion toCompanion(bool nullToAbsent) {
    return ContactEmailDataCompanion(
      id: Value(id),
      address: Value(address),
      label: Value(label),
      contactId: Value(contactId),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ContactEmailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactEmailData(
      id: serializer.fromJson<int>(json['id']),
      address: serializer.fromJson<String>(json['address']),
      label: serializer.fromJson<String>(json['label']),
      contactId: serializer.fromJson<int>(json['contactId']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'address': serializer.toJson<String>(address),
      'label': serializer.toJson<String>(label),
      'contactId': serializer.toJson<int>(contactId),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ContactEmailData copyWith(
          {int? id,
          String? address,
          String? label,
          int? contactId,
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactEmailData(
        id: id ?? this.id,
        address: address ?? this.address,
        label: label ?? this.label,
        contactId: contactId ?? this.contactId,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ContactEmailData copyWithCompanion(ContactEmailDataCompanion data) {
    return ContactEmailData(
      id: data.id.present ? data.id.value : this.id,
      address: data.address.present ? data.address.value : this.address,
      label: data.label.present ? data.label.value : this.label,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactEmailData(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('label: $label, ')
          ..write('contactId: $contactId, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, address, label, contactId, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactEmailData &&
          other.id == this.id &&
          other.address == this.address &&
          other.label == this.label &&
          other.contactId == this.contactId &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactEmailDataCompanion extends UpdateCompanion<ContactEmailData> {
  final Value<int> id;
  final Value<String> address;
  final Value<String> label;
  final Value<int> contactId;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactEmailDataCompanion({
    this.id = const Value.absent(),
    this.address = const Value.absent(),
    this.label = const Value.absent(),
    this.contactId = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactEmailDataCompanion.insert({
    this.id = const Value.absent(),
    required String address,
    required String label,
    required int contactId,
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : address = Value(address),
        label = Value(label),
        contactId = Value(contactId);
  static Insertable<ContactEmailData> custom({
    Expression<int>? id,
    Expression<String>? address,
    Expression<String>? label,
    Expression<int>? contactId,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (address != null) 'address': address,
      if (label != null) 'label': label,
      if (contactId != null) 'contact_id': contactId,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ContactEmailDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? address,
      Value<String>? label,
      Value<int>? contactId,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactEmailDataCompanion(
      id: id ?? this.id,
      address: address ?? this.address,
      label: label ?? this.label,
      contactId: contactId ?? this.contactId,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactEmailDataCompanion(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('label: $label, ')
          ..write('contactId: $contactId, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CallLogsTableTable extends CallLogsTable
    with TableInfo<$CallLogsTableTable, CallLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumnWithTypeConverter<CallLogDirectionEnum, int>
      direction = GeneratedColumn<int>('direction', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CallLogDirectionEnum>(
              $CallLogsTableTable.$converterdirection);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)');
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
      'video', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("video" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _acceptedAtMeta =
      const VerificationMeta('acceptedAt');
  @override
  late final GeneratedColumn<DateTime> acceptedAt = GeneratedColumn<DateTime>(
      'accepted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _hungUpAtMeta =
      const VerificationMeta('hungUpAt');
  @override
  late final GeneratedColumn<DateTime> hungUpAt = GeneratedColumn<DateTime>(
      'hung_up_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, direction, number, video, createdAt, acceptedAt, hungUpAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_logs';
  @override
  VerificationContext validateIntegrity(Insertable<CallLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_directionMeta, const VerificationResult.success());
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video']!, _videoMeta));
    } else if (isInserting) {
      context.missing(_videoMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('accepted_at')) {
      context.handle(
          _acceptedAtMeta,
          acceptedAt.isAcceptableOrUnknown(
              data['accepted_at']!, _acceptedAtMeta));
    }
    if (data.containsKey('hung_up_at')) {
      context.handle(_hungUpAtMeta,
          hungUpAt.isAcceptableOrUnknown(data['hung_up_at']!, _hungUpAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallLogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      direction: $CallLogsTableTable.$converterdirection.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}direction'])!),
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      video: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}video'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      acceptedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}accepted_at']),
      hungUpAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}hung_up_at']),
    );
  }

  @override
  $CallLogsTableTable createAlias(String alias) {
    return $CallLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CallLogDirectionEnum, int, int>
      $converterdirection = const EnumIndexConverter<CallLogDirectionEnum>(
          CallLogDirectionEnum.values);
}

class CallLogData extends DataClass implements Insertable<CallLogData> {
  final int id;
  final CallLogDirectionEnum direction;
  final String number;
  final bool video;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? hungUpAt;
  const CallLogData(
      {required this.id,
      required this.direction,
      required this.number,
      required this.video,
      required this.createdAt,
      this.acceptedAt,
      this.hungUpAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['direction'] = Variable<int>(
          $CallLogsTableTable.$converterdirection.toSql(direction));
    }
    map['number'] = Variable<String>(number);
    map['video'] = Variable<bool>(video);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || acceptedAt != null) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt);
    }
    if (!nullToAbsent || hungUpAt != null) {
      map['hung_up_at'] = Variable<DateTime>(hungUpAt);
    }
    return map;
  }

  CallLogDataCompanion toCompanion(bool nullToAbsent) {
    return CallLogDataCompanion(
      id: Value(id),
      direction: Value(direction),
      number: Value(number),
      video: Value(video),
      createdAt: Value(createdAt),
      acceptedAt: acceptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acceptedAt),
      hungUpAt: hungUpAt == null && nullToAbsent
          ? const Value.absent()
          : Value(hungUpAt),
    );
  }

  factory CallLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallLogData(
      id: serializer.fromJson<int>(json['id']),
      direction: $CallLogsTableTable.$converterdirection
          .fromJson(serializer.fromJson<int>(json['direction'])),
      number: serializer.fromJson<String>(json['number']),
      video: serializer.fromJson<bool>(json['video']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      acceptedAt: serializer.fromJson<DateTime?>(json['acceptedAt']),
      hungUpAt: serializer.fromJson<DateTime?>(json['hungUpAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'direction': serializer.toJson<int>(
          $CallLogsTableTable.$converterdirection.toJson(direction)),
      'number': serializer.toJson<String>(number),
      'video': serializer.toJson<bool>(video),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'acceptedAt': serializer.toJson<DateTime?>(acceptedAt),
      'hungUpAt': serializer.toJson<DateTime?>(hungUpAt),
    };
  }

  CallLogData copyWith(
          {int? id,
          CallLogDirectionEnum? direction,
          String? number,
          bool? video,
          DateTime? createdAt,
          Value<DateTime?> acceptedAt = const Value.absent(),
          Value<DateTime?> hungUpAt = const Value.absent()}) =>
      CallLogData(
        id: id ?? this.id,
        direction: direction ?? this.direction,
        number: number ?? this.number,
        video: video ?? this.video,
        createdAt: createdAt ?? this.createdAt,
        acceptedAt: acceptedAt.present ? acceptedAt.value : this.acceptedAt,
        hungUpAt: hungUpAt.present ? hungUpAt.value : this.hungUpAt,
      );
  CallLogData copyWithCompanion(CallLogDataCompanion data) {
    return CallLogData(
      id: data.id.present ? data.id.value : this.id,
      direction: data.direction.present ? data.direction.value : this.direction,
      number: data.number.present ? data.number.value : this.number,
      video: data.video.present ? data.video.value : this.video,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      acceptedAt:
          data.acceptedAt.present ? data.acceptedAt.value : this.acceptedAt,
      hungUpAt: data.hungUpAt.present ? data.hungUpAt.value : this.hungUpAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CallLogData(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('number: $number, ')
          ..write('video: $video, ')
          ..write('createdAt: $createdAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('hungUpAt: $hungUpAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, direction, number, video, createdAt, acceptedAt, hungUpAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLogData &&
          other.id == this.id &&
          other.direction == this.direction &&
          other.number == this.number &&
          other.video == this.video &&
          other.createdAt == this.createdAt &&
          other.acceptedAt == this.acceptedAt &&
          other.hungUpAt == this.hungUpAt);
}

class CallLogDataCompanion extends UpdateCompanion<CallLogData> {
  final Value<int> id;
  final Value<CallLogDirectionEnum> direction;
  final Value<String> number;
  final Value<bool> video;
  final Value<DateTime> createdAt;
  final Value<DateTime?> acceptedAt;
  final Value<DateTime?> hungUpAt;
  const CallLogDataCompanion({
    this.id = const Value.absent(),
    this.direction = const Value.absent(),
    this.number = const Value.absent(),
    this.video = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.hungUpAt = const Value.absent(),
  });
  CallLogDataCompanion.insert({
    this.id = const Value.absent(),
    required CallLogDirectionEnum direction,
    required String number,
    required bool video,
    required DateTime createdAt,
    this.acceptedAt = const Value.absent(),
    this.hungUpAt = const Value.absent(),
  })  : direction = Value(direction),
        number = Value(number),
        video = Value(video),
        createdAt = Value(createdAt);
  static Insertable<CallLogData> custom({
    Expression<int>? id,
    Expression<int>? direction,
    Expression<String>? number,
    Expression<bool>? video,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? acceptedAt,
    Expression<DateTime>? hungUpAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (direction != null) 'direction': direction,
      if (number != null) 'number': number,
      if (video != null) 'video': video,
      if (createdAt != null) 'created_at': createdAt,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (hungUpAt != null) 'hung_up_at': hungUpAt,
    });
  }

  CallLogDataCompanion copyWith(
      {Value<int>? id,
      Value<CallLogDirectionEnum>? direction,
      Value<String>? number,
      Value<bool>? video,
      Value<DateTime>? createdAt,
      Value<DateTime?>? acceptedAt,
      Value<DateTime?>? hungUpAt}) {
    return CallLogDataCompanion(
      id: id ?? this.id,
      direction: direction ?? this.direction,
      number: number ?? this.number,
      video: video ?? this.video,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      hungUpAt: hungUpAt ?? this.hungUpAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(
          $CallLogsTableTable.$converterdirection.toSql(direction.value));
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (acceptedAt.present) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt.value);
    }
    if (hungUpAt.present) {
      map['hung_up_at'] = Variable<DateTime>(hungUpAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallLogDataCompanion(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('number: $number, ')
          ..write('video: $video, ')
          ..write('createdAt: $createdAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('hungUpAt: $hungUpAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contactPhoneIdMeta =
      const VerificationMeta('contactPhoneId');
  @override
  late final GeneratedColumn<int> contactPhoneId = GeneratedColumn<int>(
      'contact_phone_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES contact_phones(id) ON DELETE CASCADE');
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, contactPhoneId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('contact_phone_id')) {
      context.handle(
          _contactPhoneIdMeta,
          contactPhoneId.isAcceptableOrUnknown(
              data['contact_phone_id']!, _contactPhoneIdMeta));
    } else if (isInserting) {
      context.missing(_contactPhoneIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      contactPhoneId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_phone_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final int contactPhoneId;
  final int position;
  const FavoriteData(
      {required this.id, required this.contactPhoneId, required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['contact_phone_id'] = Variable<int>(contactPhoneId);
    map['position'] = Variable<int>(position);
    return map;
  }

  FavoriteDataCompanion toCompanion(bool nullToAbsent) {
    return FavoriteDataCompanion(
      id: Value(id),
      contactPhoneId: Value(contactPhoneId),
      position: Value(position),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      contactPhoneId: serializer.fromJson<int>(json['contactPhoneId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contactPhoneId': serializer.toJson<int>(contactPhoneId),
      'position': serializer.toJson<int>(position),
    };
  }

  FavoriteData copyWith({int? id, int? contactPhoneId, int? position}) =>
      FavoriteData(
        id: id ?? this.id,
        contactPhoneId: contactPhoneId ?? this.contactPhoneId,
        position: position ?? this.position,
      );
  FavoriteData copyWithCompanion(FavoriteDataCompanion data) {
    return FavoriteData(
      id: data.id.present ? data.id.value : this.id,
      contactPhoneId: data.contactPhoneId.present
          ? data.contactPhoneId.value
          : this.contactPhoneId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('contactPhoneId: $contactPhoneId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contactPhoneId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.contactPhoneId == this.contactPhoneId &&
          other.position == this.position);
}

class FavoriteDataCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<int> contactPhoneId;
  final Value<int> position;
  const FavoriteDataCompanion({
    this.id = const Value.absent(),
    this.contactPhoneId = const Value.absent(),
    this.position = const Value.absent(),
  });
  FavoriteDataCompanion.insert({
    this.id = const Value.absent(),
    required int contactPhoneId,
    required int position,
  })  : contactPhoneId = Value(contactPhoneId),
        position = Value(position);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<int>? contactPhoneId,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contactPhoneId != null) 'contact_phone_id': contactPhoneId,
      if (position != null) 'position': position,
    });
  }

  FavoriteDataCompanion copyWith(
      {Value<int>? id, Value<int>? contactPhoneId, Value<int>? position}) {
    return FavoriteDataCompanion(
      id: id ?? this.id,
      contactPhoneId: contactPhoneId ?? this.contactPhoneId,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contactPhoneId.present) {
      map['contact_phone_id'] = Variable<int>(contactPhoneId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteDataCompanion(')
          ..write('id: $id, ')
          ..write('contactPhoneId: $contactPhoneId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $ChatsTableTable extends ChatsTable
    with TableInfo<$ChatsTableTable, ChatData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ChatTypeEnum, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ChatTypeEnum>($ChatsTableTable.$convertertype);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _insertedAtRemoteMeta =
      const VerificationMeta('insertedAtRemote');
  @override
  late final GeneratedColumn<DateTime> insertedAtRemote =
      GeneratedColumn<DateTime>('inserted_at_remote', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtRemoteMeta =
      const VerificationMeta('updatedAtRemote');
  @override
  late final GeneratedColumn<DateTime> updatedAtRemote =
      GeneratedColumn<DateTime>('updated_at_remote', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        name,
        insertedAtRemote,
        updatedAtRemote,
        insertedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<ChatData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('inserted_at_remote')) {
      context.handle(
          _insertedAtRemoteMeta,
          insertedAtRemote.isAcceptableOrUnknown(
              data['inserted_at_remote']!, _insertedAtRemoteMeta));
    } else if (isInserting) {
      context.missing(_insertedAtRemoteMeta);
    }
    if (data.containsKey('updated_at_remote')) {
      context.handle(
          _updatedAtRemoteMeta,
          updatedAtRemote.isAcceptableOrUnknown(
              data['updated_at_remote']!, _updatedAtRemoteMeta));
    } else if (isInserting) {
      context.missing(_updatedAtRemoteMeta);
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $ChatsTableTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      insertedAtRemote: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}inserted_at_remote'])!,
      updatedAtRemote: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}updated_at_remote'])!,
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ChatsTableTable createAlias(String alias) {
    return $ChatsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ChatTypeEnum, String, String> $convertertype =
      const EnumNameConverter<ChatTypeEnum>(ChatTypeEnum.values);
}

class ChatData extends DataClass implements Insertable<ChatData> {
  final int id;
  final ChatTypeEnum type;
  final String? name;
  final DateTime insertedAtRemote;
  final DateTime updatedAtRemote;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ChatData(
      {required this.id,
      required this.type,
      this.name,
      required this.insertedAtRemote,
      required this.updatedAtRemote,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] =
          Variable<String>($ChatsTableTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['inserted_at_remote'] = Variable<DateTime>(insertedAtRemote);
    map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote);
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ChatDataCompanion toCompanion(bool nullToAbsent) {
    return ChatDataCompanion(
      id: Value(id),
      type: Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      insertedAtRemote: Value(insertedAtRemote),
      updatedAtRemote: Value(updatedAtRemote),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ChatData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatData(
      id: serializer.fromJson<int>(json['id']),
      type: $ChatsTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      name: serializer.fromJson<String?>(json['name']),
      insertedAtRemote: serializer.fromJson<DateTime>(json['insertedAtRemote']),
      updatedAtRemote: serializer.fromJson<DateTime>(json['updatedAtRemote']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer
          .toJson<String>($ChatsTableTable.$convertertype.toJson(type)),
      'name': serializer.toJson<String?>(name),
      'insertedAtRemote': serializer.toJson<DateTime>(insertedAtRemote),
      'updatedAtRemote': serializer.toJson<DateTime>(updatedAtRemote),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ChatData copyWith(
          {int? id,
          ChatTypeEnum? type,
          Value<String?> name = const Value.absent(),
          DateTime? insertedAtRemote,
          DateTime? updatedAtRemote,
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ChatData(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name.present ? name.value : this.name,
        insertedAtRemote: insertedAtRemote ?? this.insertedAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ChatData copyWithCompanion(ChatDataCompanion data) {
    return ChatData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      insertedAtRemote: data.insertedAtRemote.present
          ? data.insertedAtRemote.value
          : this.insertedAtRemote,
      updatedAtRemote: data.updatedAtRemote.present
          ? data.updatedAtRemote.value
          : this.updatedAtRemote,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('insertedAtRemote: $insertedAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, name, insertedAtRemote, updatedAtRemote, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatData &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.insertedAtRemote == this.insertedAtRemote &&
          other.updatedAtRemote == this.updatedAtRemote &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ChatDataCompanion extends UpdateCompanion<ChatData> {
  final Value<int> id;
  final Value<ChatTypeEnum> type;
  final Value<String?> name;
  final Value<DateTime> insertedAtRemote;
  final Value<DateTime> updatedAtRemote;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ChatDataCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.insertedAtRemote = const Value.absent(),
    this.updatedAtRemote = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatDataCompanion.insert({
    this.id = const Value.absent(),
    required ChatTypeEnum type,
    this.name = const Value.absent(),
    required DateTime insertedAtRemote,
    required DateTime updatedAtRemote,
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : type = Value(type),
        insertedAtRemote = Value(insertedAtRemote),
        updatedAtRemote = Value(updatedAtRemote);
  static Insertable<ChatData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<DateTime>? insertedAtRemote,
    Expression<DateTime>? updatedAtRemote,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (insertedAtRemote != null) 'inserted_at_remote': insertedAtRemote,
      if (updatedAtRemote != null) 'updated_at_remote': updatedAtRemote,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatDataCompanion copyWith(
      {Value<int>? id,
      Value<ChatTypeEnum>? type,
      Value<String?>? name,
      Value<DateTime>? insertedAtRemote,
      Value<DateTime>? updatedAtRemote,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ChatDataCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      insertedAtRemote: insertedAtRemote ?? this.insertedAtRemote,
      updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($ChatsTableTable.$convertertype.toSql(type.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (insertedAtRemote.present) {
      map['inserted_at_remote'] = Variable<DateTime>(insertedAtRemote.value);
    }
    if (updatedAtRemote.present) {
      map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatDataCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('insertedAtRemote: $insertedAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMembersTableTable extends ChatMembersTable
    with TableInfo<$ChatMembersTableTable, ChatMemberData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupAuthoritiesMeta =
      const VerificationMeta('groupAuthorities');
  @override
  late final GeneratedColumnWithTypeConverter<GroupAuthoritiesEnum?, String>
      groupAuthorities = GeneratedColumn<String>(
              'group_authorities', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<GroupAuthoritiesEnum?>(
              $ChatMembersTableTable.$convertergroupAuthoritiesn);
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, chatId, userId, groupAuthorities, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_members';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMemberData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    context.handle(_groupAuthoritiesMeta, const VerificationResult.success());
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMemberData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMemberData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      groupAuthorities: $ChatMembersTableTable.$convertergroupAuthoritiesn
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}group_authorities'])),
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ChatMembersTableTable createAlias(String alias) {
    return $ChatMembersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GroupAuthoritiesEnum, String, String>
      $convertergroupAuthorities =
      const EnumNameConverter<GroupAuthoritiesEnum>(
          GroupAuthoritiesEnum.values);
  static JsonTypeConverter2<GroupAuthoritiesEnum?, String?, String?>
      $convertergroupAuthoritiesn =
      JsonTypeConverter2.asNullable($convertergroupAuthorities);
}

class ChatMemberData extends DataClass implements Insertable<ChatMemberData> {
  final int id;
  final int chatId;
  final String userId;
  final GroupAuthoritiesEnum? groupAuthorities;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ChatMemberData(
      {required this.id,
      required this.chatId,
      required this.userId,
      this.groupAuthorities,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || groupAuthorities != null) {
      map['group_authorities'] = Variable<String>($ChatMembersTableTable
          .$convertergroupAuthoritiesn
          .toSql(groupAuthorities));
    }
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ChatMemberDataCompanion toCompanion(bool nullToAbsent) {
    return ChatMemberDataCompanion(
      id: Value(id),
      chatId: Value(chatId),
      userId: Value(userId),
      groupAuthorities: groupAuthorities == null && nullToAbsent
          ? const Value.absent()
          : Value(groupAuthorities),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ChatMemberData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMemberData(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      userId: serializer.fromJson<String>(json['userId']),
      groupAuthorities: $ChatMembersTableTable.$convertergroupAuthoritiesn
          .fromJson(serializer.fromJson<String?>(json['groupAuthorities'])),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'userId': serializer.toJson<String>(userId),
      'groupAuthorities': serializer.toJson<String?>($ChatMembersTableTable
          .$convertergroupAuthoritiesn
          .toJson(groupAuthorities)),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ChatMemberData copyWith(
          {int? id,
          int? chatId,
          String? userId,
          Value<GroupAuthoritiesEnum?> groupAuthorities = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ChatMemberData(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        groupAuthorities: groupAuthorities.present
            ? groupAuthorities.value
            : this.groupAuthorities,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ChatMemberData copyWithCompanion(ChatMemberDataCompanion data) {
    return ChatMemberData(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      userId: data.userId.present ? data.userId.value : this.userId,
      groupAuthorities: data.groupAuthorities.present
          ? data.groupAuthorities.value
          : this.groupAuthorities,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMemberData(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('groupAuthorities: $groupAuthorities, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chatId, userId, groupAuthorities, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMemberData &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.userId == this.userId &&
          other.groupAuthorities == this.groupAuthorities &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ChatMemberDataCompanion extends UpdateCompanion<ChatMemberData> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> userId;
  final Value<GroupAuthoritiesEnum?> groupAuthorities;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ChatMemberDataCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.groupAuthorities = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatMemberDataCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String userId,
    this.groupAuthorities = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : chatId = Value(chatId),
        userId = Value(userId);
  static Insertable<ChatMemberData> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? userId,
    Expression<String>? groupAuthorities,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (userId != null) 'user_id': userId,
      if (groupAuthorities != null) 'group_authorities': groupAuthorities,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatMemberDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? chatId,
      Value<String>? userId,
      Value<GroupAuthoritiesEnum?>? groupAuthorities,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ChatMemberDataCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      groupAuthorities: groupAuthorities ?? this.groupAuthorities,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (groupAuthorities.present) {
      map['group_authorities'] = Variable<String>($ChatMembersTableTable
          .$convertergroupAuthoritiesn
          .toSql(groupAuthorities.value));
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMemberDataCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('groupAuthorities: $groupAuthorities, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTableTable extends ChatMessagesTable
    with TableInfo<$ChatMessagesTableTable, ChatMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
      'id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderIdMeta =
      const VerificationMeta('senderId');
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
      'sender_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _replyToIdMeta =
      const VerificationMeta('replyToId');
  @override
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
      'reply_to_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _forwardFromIdMeta =
      const VerificationMeta('forwardFromId');
  @override
  late final GeneratedColumn<int> forwardFromId = GeneratedColumn<int>(
      'forward_from_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _viaSmsMeta = const VerificationMeta('viaSms');
  @override
  late final GeneratedColumn<bool> viaSms = GeneratedColumn<bool>(
      'via_sms', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("via_sms" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _smsOutStateMeta =
      const VerificationMeta('smsOutState');
  @override
  late final GeneratedColumnWithTypeConverter<SmsOutStateEnum?, String>
      smsOutState = GeneratedColumn<String>('sms_out_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SmsOutStateEnum?>(
              $ChatMessagesTableTable.$convertersmsOutStaten);
  static const VerificationMeta _smsNumberMeta =
      const VerificationMeta('smsNumber');
  @override
  late final GeneratedColumn<String> smsNumber = GeneratedColumn<String>(
      'sms_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _viewedAtMeta =
      const VerificationMeta('viewedAt');
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
      'viewed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _editedAtMeta =
      const VerificationMeta('editedAt');
  @override
  late final GeneratedColumn<DateTime> editedAt = GeneratedColumn<DateTime>(
      'edited_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtRemoteMeta =
      const VerificationMeta('createdAtRemote');
  @override
  late final GeneratedColumn<DateTime> createdAtRemote =
      GeneratedColumn<DateTime>('created_at_remote', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtRemoteMeta =
      const VerificationMeta('updatedAtRemote');
  @override
  late final GeneratedColumn<DateTime> updatedAtRemote =
      GeneratedColumn<DateTime>('updated_at_remote', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtRemoteMeta =
      const VerificationMeta('deletedAtRemote');
  @override
  late final GeneratedColumn<DateTime> deletedAtRemote =
      GeneratedColumn<DateTime>('deleted_at_remote', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _insertedAtMeta =
      const VerificationMeta('insertedAt');
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idKey,
        senderId,
        chatId,
        replyToId,
        forwardFromId,
        authorId,
        viaSms,
        smsOutState,
        smsNumber,
        content,
        viewedAt,
        editedAt,
        createdAtRemote,
        updatedAtRemote,
        deletedAtRemote,
        insertedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
          _idKeyMeta, idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta));
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(_senderIdMeta,
          senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta));
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
          _replyToIdMeta,
          replyToId.isAcceptableOrUnknown(
              data['reply_to_id']!, _replyToIdMeta));
    }
    if (data.containsKey('forward_from_id')) {
      context.handle(
          _forwardFromIdMeta,
          forwardFromId.isAcceptableOrUnknown(
              data['forward_from_id']!, _forwardFromIdMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    if (data.containsKey('via_sms')) {
      context.handle(_viaSmsMeta,
          viaSms.isAcceptableOrUnknown(data['via_sms']!, _viaSmsMeta));
    }
    context.handle(_smsOutStateMeta, const VerificationResult.success());
    if (data.containsKey('sms_number')) {
      context.handle(_smsNumberMeta,
          smsNumber.isAcceptableOrUnknown(data['sms_number']!, _smsNumberMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('viewed_at')) {
      context.handle(_viewedAtMeta,
          viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta));
    }
    if (data.containsKey('edited_at')) {
      context.handle(_editedAtMeta,
          editedAt.isAcceptableOrUnknown(data['edited_at']!, _editedAtMeta));
    }
    if (data.containsKey('created_at_remote')) {
      context.handle(
          _createdAtRemoteMeta,
          createdAtRemote.isAcceptableOrUnknown(
              data['created_at_remote']!, _createdAtRemoteMeta));
    } else if (isInserting) {
      context.missing(_createdAtRemoteMeta);
    }
    if (data.containsKey('updated_at_remote')) {
      context.handle(
          _updatedAtRemoteMeta,
          updatedAtRemote.isAcceptableOrUnknown(
              data['updated_at_remote']!, _updatedAtRemoteMeta));
    } else if (isInserting) {
      context.missing(_updatedAtRemoteMeta);
    }
    if (data.containsKey('deleted_at_remote')) {
      context.handle(
          _deletedAtRemoteMeta,
          deletedAtRemote.isAcceptableOrUnknown(
              data['deleted_at_remote']!, _deletedAtRemoteMeta));
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
          _insertedAtMeta,
          insertedAt.isAcceptableOrUnknown(
              data['inserted_at']!, _insertedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_key'])!,
      senderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      replyToId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reply_to_id']),
      forwardFromId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}forward_from_id']),
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_id']),
      viaSms: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}via_sms'])!,
      smsOutState: $ChatMessagesTableTable.$convertersmsOutStaten.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}sms_out_state'])),
      smsNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sms_number']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      viewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}viewed_at']),
      editedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}edited_at']),
      createdAtRemote: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}created_at_remote'])!,
      updatedAtRemote: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}updated_at_remote'])!,
      deletedAtRemote: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}deleted_at_remote']),
      insertedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}inserted_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ChatMessagesTableTable createAlias(String alias) {
    return $ChatMessagesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsOutStateEnum, String, String>
      $convertersmsOutState =
      const EnumNameConverter<SmsOutStateEnum>(SmsOutStateEnum.values);
  static JsonTypeConverter2<SmsOutStateEnum?, String?, String?>
      $convertersmsOutStaten =
      JsonTypeConverter2.asNullable($convertersmsOutState);
}

class ChatMessageData extends DataClass implements Insertable<ChatMessageData> {
  final int id;
  final String idKey;
  final String senderId;
  final int chatId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final bool viaSms;
  final SmsOutStateEnum? smsOutState;
  final String? smsNumber;
  final String content;
  final DateTime? viewedAt;
  final DateTime? editedAt;
  final DateTime createdAtRemote;
  final DateTime updatedAtRemote;
  final DateTime? deletedAtRemote;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ChatMessageData(
      {required this.id,
      required this.idKey,
      required this.senderId,
      required this.chatId,
      this.replyToId,
      this.forwardFromId,
      this.authorId,
      required this.viaSms,
      this.smsOutState,
      this.smsNumber,
      required this.content,
      this.viewedAt,
      this.editedAt,
      required this.createdAtRemote,
      required this.updatedAtRemote,
      this.deletedAtRemote,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['sender_id'] = Variable<String>(senderId);
    map['chat_id'] = Variable<int>(chatId);
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<int>(replyToId);
    }
    if (!nullToAbsent || forwardFromId != null) {
      map['forward_from_id'] = Variable<int>(forwardFromId);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    map['via_sms'] = Variable<bool>(viaSms);
    if (!nullToAbsent || smsOutState != null) {
      map['sms_out_state'] = Variable<String>(
          $ChatMessagesTableTable.$convertersmsOutStaten.toSql(smsOutState));
    }
    if (!nullToAbsent || smsNumber != null) {
      map['sms_number'] = Variable<String>(smsNumber);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || viewedAt != null) {
      map['viewed_at'] = Variable<DateTime>(viewedAt);
    }
    if (!nullToAbsent || editedAt != null) {
      map['edited_at'] = Variable<DateTime>(editedAt);
    }
    map['created_at_remote'] = Variable<DateTime>(createdAtRemote);
    map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote);
    if (!nullToAbsent || deletedAtRemote != null) {
      map['deleted_at_remote'] = Variable<DateTime>(deletedAtRemote);
    }
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ChatMessageDataCompanion toCompanion(bool nullToAbsent) {
    return ChatMessageDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      senderId: Value(senderId),
      chatId: Value(chatId),
      replyToId: replyToId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToId),
      forwardFromId: forwardFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(forwardFromId),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      viaSms: Value(viaSms),
      smsOutState: smsOutState == null && nullToAbsent
          ? const Value.absent()
          : Value(smsOutState),
      smsNumber: smsNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(smsNumber),
      content: Value(content),
      viewedAt: viewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(viewedAt),
      editedAt: editedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(editedAt),
      createdAtRemote: Value(createdAtRemote),
      updatedAtRemote: Value(updatedAtRemote),
      deletedAtRemote: deletedAtRemote == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtRemote),
      insertedAt: insertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insertedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ChatMessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      senderId: serializer.fromJson<String>(json['senderId']),
      chatId: serializer.fromJson<int>(json['chatId']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
      forwardFromId: serializer.fromJson<int?>(json['forwardFromId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      viaSms: serializer.fromJson<bool>(json['viaSms']),
      smsOutState: $ChatMessagesTableTable.$convertersmsOutStaten
          .fromJson(serializer.fromJson<String?>(json['smsOutState'])),
      smsNumber: serializer.fromJson<String?>(json['smsNumber']),
      content: serializer.fromJson<String>(json['content']),
      viewedAt: serializer.fromJson<DateTime?>(json['viewedAt']),
      editedAt: serializer.fromJson<DateTime?>(json['editedAt']),
      createdAtRemote: serializer.fromJson<DateTime>(json['createdAtRemote']),
      updatedAtRemote: serializer.fromJson<DateTime>(json['updatedAtRemote']),
      deletedAtRemote: serializer.fromJson<DateTime?>(json['deletedAtRemote']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'senderId': serializer.toJson<String>(senderId),
      'chatId': serializer.toJson<int>(chatId),
      'replyToId': serializer.toJson<int?>(replyToId),
      'forwardFromId': serializer.toJson<int?>(forwardFromId),
      'authorId': serializer.toJson<String?>(authorId),
      'viaSms': serializer.toJson<bool>(viaSms),
      'smsOutState': serializer.toJson<String?>(
          $ChatMessagesTableTable.$convertersmsOutStaten.toJson(smsOutState)),
      'smsNumber': serializer.toJson<String?>(smsNumber),
      'content': serializer.toJson<String>(content),
      'viewedAt': serializer.toJson<DateTime?>(viewedAt),
      'editedAt': serializer.toJson<DateTime?>(editedAt),
      'createdAtRemote': serializer.toJson<DateTime>(createdAtRemote),
      'updatedAtRemote': serializer.toJson<DateTime>(updatedAtRemote),
      'deletedAtRemote': serializer.toJson<DateTime?>(deletedAtRemote),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ChatMessageData copyWith(
          {int? id,
          String? idKey,
          String? senderId,
          int? chatId,
          Value<int?> replyToId = const Value.absent(),
          Value<int?> forwardFromId = const Value.absent(),
          Value<String?> authorId = const Value.absent(),
          bool? viaSms,
          Value<SmsOutStateEnum?> smsOutState = const Value.absent(),
          Value<String?> smsNumber = const Value.absent(),
          String? content,
          Value<DateTime?> viewedAt = const Value.absent(),
          Value<DateTime?> editedAt = const Value.absent(),
          DateTime? createdAtRemote,
          DateTime? updatedAtRemote,
          Value<DateTime?> deletedAtRemote = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ChatMessageData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        senderId: senderId ?? this.senderId,
        chatId: chatId ?? this.chatId,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
        forwardFromId:
            forwardFromId.present ? forwardFromId.value : this.forwardFromId,
        authorId: authorId.present ? authorId.value : this.authorId,
        viaSms: viaSms ?? this.viaSms,
        smsOutState: smsOutState.present ? smsOutState.value : this.smsOutState,
        smsNumber: smsNumber.present ? smsNumber.value : this.smsNumber,
        content: content ?? this.content,
        viewedAt: viewedAt.present ? viewedAt.value : this.viewedAt,
        editedAt: editedAt.present ? editedAt.value : this.editedAt,
        createdAtRemote: createdAtRemote ?? this.createdAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
        deletedAtRemote: deletedAtRemote.present
            ? deletedAtRemote.value
            : this.deletedAtRemote,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ChatMessageData copyWithCompanion(ChatMessageDataCompanion data) {
    return ChatMessageData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
      forwardFromId: data.forwardFromId.present
          ? data.forwardFromId.value
          : this.forwardFromId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      viaSms: data.viaSms.present ? data.viaSms.value : this.viaSms,
      smsOutState:
          data.smsOutState.present ? data.smsOutState.value : this.smsOutState,
      smsNumber: data.smsNumber.present ? data.smsNumber.value : this.smsNumber,
      content: data.content.present ? data.content.value : this.content,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
      editedAt: data.editedAt.present ? data.editedAt.value : this.editedAt,
      createdAtRemote: data.createdAtRemote.present
          ? data.createdAtRemote.value
          : this.createdAtRemote,
      updatedAtRemote: data.updatedAtRemote.present
          ? data.updatedAtRemote.value
          : this.updatedAtRemote,
      deletedAtRemote: data.deletedAtRemote.present
          ? data.deletedAtRemote.value
          : this.deletedAtRemote,
      insertedAt:
          data.insertedAt.present ? data.insertedAt.value : this.insertedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('senderId: $senderId, ')
          ..write('chatId: $chatId, ')
          ..write('replyToId: $replyToId, ')
          ..write('forwardFromId: $forwardFromId, ')
          ..write('authorId: $authorId, ')
          ..write('viaSms: $viaSms, ')
          ..write('smsOutState: $smsOutState, ')
          ..write('smsNumber: $smsNumber, ')
          ..write('content: $content, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('editedAt: $editedAt, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('deletedAtRemote: $deletedAtRemote, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      idKey,
      senderId,
      chatId,
      replyToId,
      forwardFromId,
      authorId,
      viaSms,
      smsOutState,
      smsNumber,
      content,
      viewedAt,
      editedAt,
      createdAtRemote,
      updatedAtRemote,
      deletedAtRemote,
      insertedAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.senderId == this.senderId &&
          other.chatId == this.chatId &&
          other.replyToId == this.replyToId &&
          other.forwardFromId == this.forwardFromId &&
          other.authorId == this.authorId &&
          other.viaSms == this.viaSms &&
          other.smsOutState == this.smsOutState &&
          other.smsNumber == this.smsNumber &&
          other.content == this.content &&
          other.viewedAt == this.viewedAt &&
          other.editedAt == this.editedAt &&
          other.createdAtRemote == this.createdAtRemote &&
          other.updatedAtRemote == this.updatedAtRemote &&
          other.deletedAtRemote == this.deletedAtRemote &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ChatMessageDataCompanion extends UpdateCompanion<ChatMessageData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<String> senderId;
  final Value<int> chatId;
  final Value<int?> replyToId;
  final Value<int?> forwardFromId;
  final Value<String?> authorId;
  final Value<bool> viaSms;
  final Value<SmsOutStateEnum?> smsOutState;
  final Value<String?> smsNumber;
  final Value<String> content;
  final Value<DateTime?> viewedAt;
  final Value<DateTime?> editedAt;
  final Value<DateTime> createdAtRemote;
  final Value<DateTime> updatedAtRemote;
  final Value<DateTime?> deletedAtRemote;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ChatMessageDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.senderId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.viaSms = const Value.absent(),
    this.smsOutState = const Value.absent(),
    this.smsNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.viewedAt = const Value.absent(),
    this.editedAt = const Value.absent(),
    this.createdAtRemote = const Value.absent(),
    this.updatedAtRemote = const Value.absent(),
    this.deletedAtRemote = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatMessageDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required String senderId,
    required int chatId,
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.viaSms = const Value.absent(),
    this.smsOutState = const Value.absent(),
    this.smsNumber = const Value.absent(),
    required String content,
    this.viewedAt = const Value.absent(),
    this.editedAt = const Value.absent(),
    required DateTime createdAtRemote,
    required DateTime updatedAtRemote,
    this.deletedAtRemote = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : idKey = Value(idKey),
        senderId = Value(senderId),
        chatId = Value(chatId),
        content = Value(content),
        createdAtRemote = Value(createdAtRemote),
        updatedAtRemote = Value(updatedAtRemote);
  static Insertable<ChatMessageData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<String>? senderId,
    Expression<int>? chatId,
    Expression<int>? replyToId,
    Expression<int>? forwardFromId,
    Expression<String>? authorId,
    Expression<bool>? viaSms,
    Expression<String>? smsOutState,
    Expression<String>? smsNumber,
    Expression<String>? content,
    Expression<DateTime>? viewedAt,
    Expression<DateTime>? editedAt,
    Expression<DateTime>? createdAtRemote,
    Expression<DateTime>? updatedAtRemote,
    Expression<DateTime>? deletedAtRemote,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (senderId != null) 'sender_id': senderId,
      if (chatId != null) 'chat_id': chatId,
      if (replyToId != null) 'reply_to_id': replyToId,
      if (forwardFromId != null) 'forward_from_id': forwardFromId,
      if (authorId != null) 'author_id': authorId,
      if (viaSms != null) 'via_sms': viaSms,
      if (smsOutState != null) 'sms_out_state': smsOutState,
      if (smsNumber != null) 'sms_number': smsNumber,
      if (content != null) 'content': content,
      if (viewedAt != null) 'viewed_at': viewedAt,
      if (editedAt != null) 'edited_at': editedAt,
      if (createdAtRemote != null) 'created_at_remote': createdAtRemote,
      if (updatedAtRemote != null) 'updated_at_remote': updatedAtRemote,
      if (deletedAtRemote != null) 'deleted_at_remote': deletedAtRemote,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatMessageDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? idKey,
      Value<String>? senderId,
      Value<int>? chatId,
      Value<int?>? replyToId,
      Value<int?>? forwardFromId,
      Value<String?>? authorId,
      Value<bool>? viaSms,
      Value<SmsOutStateEnum?>? smsOutState,
      Value<String?>? smsNumber,
      Value<String>? content,
      Value<DateTime?>? viewedAt,
      Value<DateTime?>? editedAt,
      Value<DateTime>? createdAtRemote,
      Value<DateTime>? updatedAtRemote,
      Value<DateTime?>? deletedAtRemote,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ChatMessageDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      senderId: senderId ?? this.senderId,
      chatId: chatId ?? this.chatId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      viaSms: viaSms ?? this.viaSms,
      smsOutState: smsOutState ?? this.smsOutState,
      smsNumber: smsNumber ?? this.smsNumber,
      content: content ?? this.content,
      viewedAt: viewedAt ?? this.viewedAt,
      editedAt: editedAt ?? this.editedAt,
      createdAtRemote: createdAtRemote ?? this.createdAtRemote,
      updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
      deletedAtRemote: deletedAtRemote ?? this.deletedAtRemote,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (replyToId.present) {
      map['reply_to_id'] = Variable<int>(replyToId.value);
    }
    if (forwardFromId.present) {
      map['forward_from_id'] = Variable<int>(forwardFromId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (viaSms.present) {
      map['via_sms'] = Variable<bool>(viaSms.value);
    }
    if (smsOutState.present) {
      map['sms_out_state'] = Variable<String>($ChatMessagesTableTable
          .$convertersmsOutStaten
          .toSql(smsOutState.value));
    }
    if (smsNumber.present) {
      map['sms_number'] = Variable<String>(smsNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    if (editedAt.present) {
      map['edited_at'] = Variable<DateTime>(editedAt.value);
    }
    if (createdAtRemote.present) {
      map['created_at_remote'] = Variable<DateTime>(createdAtRemote.value);
    }
    if (updatedAtRemote.present) {
      map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote.value);
    }
    if (deletedAtRemote.present) {
      map['deleted_at_remote'] = Variable<DateTime>(deletedAtRemote.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('senderId: $senderId, ')
          ..write('chatId: $chatId, ')
          ..write('replyToId: $replyToId, ')
          ..write('forwardFromId: $forwardFromId, ')
          ..write('authorId: $authorId, ')
          ..write('viaSms: $viaSms, ')
          ..write('smsOutState: $smsOutState, ')
          ..write('smsNumber: $smsNumber, ')
          ..write('content: $content, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('editedAt: $editedAt, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('deletedAtRemote: $deletedAtRemote, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMessageSyncCursorTableTable extends ChatMessageSyncCursorTable
    with
        TableInfo<$ChatMessageSyncCursorTableTable, ChatMessageSyncCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessageSyncCursorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _cursorTypeMeta =
      const VerificationMeta('cursorType');
  @override
  late final GeneratedColumnWithTypeConverter<MessageSyncCursorTypeEnum, String>
      cursorType = GeneratedColumn<String>('cursor_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MessageSyncCursorTypeEnum>(
              $ChatMessageSyncCursorTableTable.$convertercursorType);
  static const VerificationMeta _timestampUsecMeta =
      const VerificationMeta('timestampUsec');
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
      'timestamp_usec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [chatId, cursorType, timestampUsec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_message_sync_cursors';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatMessageSyncCursorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    context.handle(_cursorTypeMeta, const VerificationResult.success());
    if (data.containsKey('timestamp_usec')) {
      context.handle(
          _timestampUsecMeta,
          timestampUsec.isAcceptableOrUnknown(
              data['timestamp_usec']!, _timestampUsecMeta));
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId, cursorType};
  @override
  ChatMessageSyncCursorData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageSyncCursorData(
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      cursorType: $ChatMessageSyncCursorTableTable.$convertercursorType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}cursor_type'])!),
      timestampUsec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp_usec'])!,
    );
  }

  @override
  $ChatMessageSyncCursorTableTable createAlias(String alias) {
    return $ChatMessageSyncCursorTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MessageSyncCursorTypeEnum, String, String>
      $convertercursorType = const EnumNameConverter<MessageSyncCursorTypeEnum>(
          MessageSyncCursorTypeEnum.values);
}

class ChatMessageSyncCursorData extends DataClass
    implements Insertable<ChatMessageSyncCursorData> {
  final int chatId;
  final MessageSyncCursorTypeEnum cursorType;
  final int timestampUsec;
  const ChatMessageSyncCursorData(
      {required this.chatId,
      required this.cursorType,
      required this.timestampUsec});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    {
      map['cursor_type'] = Variable<String>($ChatMessageSyncCursorTableTable
          .$convertercursorType
          .toSql(cursorType));
    }
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    return map;
  }

  ChatMessageSyncCursorDataCompanion toCompanion(bool nullToAbsent) {
    return ChatMessageSyncCursorDataCompanion(
      chatId: Value(chatId),
      cursorType: Value(cursorType),
      timestampUsec: Value(timestampUsec),
    );
  }

  factory ChatMessageSyncCursorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageSyncCursorData(
      chatId: serializer.fromJson<int>(json['chatId']),
      cursorType: $ChatMessageSyncCursorTableTable.$convertercursorType
          .fromJson(serializer.fromJson<String>(json['cursorType'])),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'cursorType': serializer.toJson<String>($ChatMessageSyncCursorTableTable
          .$convertercursorType
          .toJson(cursorType)),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
    };
  }

  ChatMessageSyncCursorData copyWith(
          {int? chatId,
          MessageSyncCursorTypeEnum? cursorType,
          int? timestampUsec}) =>
      ChatMessageSyncCursorData(
        chatId: chatId ?? this.chatId,
        cursorType: cursorType ?? this.cursorType,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  ChatMessageSyncCursorData copyWithCompanion(
      ChatMessageSyncCursorDataCompanion data) {
    return ChatMessageSyncCursorData(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      cursorType:
          data.cursorType.present ? data.cursorType.value : this.cursorType,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageSyncCursorData(')
          ..write('chatId: $chatId, ')
          ..write('cursorType: $cursorType, ')
          ..write('timestampUsec: $timestampUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(chatId, cursorType, timestampUsec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageSyncCursorData &&
          other.chatId == this.chatId &&
          other.cursorType == this.cursorType &&
          other.timestampUsec == this.timestampUsec);
}

class ChatMessageSyncCursorDataCompanion
    extends UpdateCompanion<ChatMessageSyncCursorData> {
  final Value<int> chatId;
  final Value<MessageSyncCursorTypeEnum> cursorType;
  final Value<int> timestampUsec;
  final Value<int> rowid;
  const ChatMessageSyncCursorDataCompanion({
    this.chatId = const Value.absent(),
    this.cursorType = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessageSyncCursorDataCompanion.insert({
    required int chatId,
    required MessageSyncCursorTypeEnum cursorType,
    required int timestampUsec,
    this.rowid = const Value.absent(),
  })  : chatId = Value(chatId),
        cursorType = Value(cursorType),
        timestampUsec = Value(timestampUsec);
  static Insertable<ChatMessageSyncCursorData> custom({
    Expression<int>? chatId,
    Expression<String>? cursorType,
    Expression<int>? timestampUsec,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (cursorType != null) 'cursor_type': cursorType,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessageSyncCursorDataCompanion copyWith(
      {Value<int>? chatId,
      Value<MessageSyncCursorTypeEnum>? cursorType,
      Value<int>? timestampUsec,
      Value<int>? rowid}) {
    return ChatMessageSyncCursorDataCompanion(
      chatId: chatId ?? this.chatId,
      cursorType: cursorType ?? this.cursorType,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (cursorType.present) {
      map['cursor_type'] = Variable<String>($ChatMessageSyncCursorTableTable
          .$convertercursorType
          .toSql(cursorType.value));
    }
    if (timestampUsec.present) {
      map['timestamp_usec'] = Variable<int>(timestampUsec.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageSyncCursorDataCompanion(')
          ..write('chatId: $chatId, ')
          ..write('cursorType: $cursorType, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessageReadCursorTableTable extends ChatMessageReadCursorTable
    with
        TableInfo<$ChatMessageReadCursorTableTable, ChatMessageReadCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessageReadCursorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampUsecMeta =
      const VerificationMeta('timestampUsec');
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
      'timestamp_usec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [chatId, userId, timestampUsec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_message_read_cursors';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatMessageReadCursorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
          _timestampUsecMeta,
          timestampUsec.isAcceptableOrUnknown(
              data['timestamp_usec']!, _timestampUsecMeta));
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId, userId};
  @override
  ChatMessageReadCursorData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageReadCursorData(
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      timestampUsec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp_usec'])!,
    );
  }

  @override
  $ChatMessageReadCursorTableTable createAlias(String alias) {
    return $ChatMessageReadCursorTableTable(attachedDatabase, alias);
  }
}

class ChatMessageReadCursorData extends DataClass
    implements Insertable<ChatMessageReadCursorData> {
  final int chatId;
  final String userId;
  final int timestampUsec;
  const ChatMessageReadCursorData(
      {required this.chatId,
      required this.userId,
      required this.timestampUsec});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['user_id'] = Variable<String>(userId);
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    return map;
  }

  ChatMessageReadCursorDataCompanion toCompanion(bool nullToAbsent) {
    return ChatMessageReadCursorDataCompanion(
      chatId: Value(chatId),
      userId: Value(userId),
      timestampUsec: Value(timestampUsec),
    );
  }

  factory ChatMessageReadCursorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageReadCursorData(
      chatId: serializer.fromJson<int>(json['chatId']),
      userId: serializer.fromJson<String>(json['userId']),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'userId': serializer.toJson<String>(userId),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
    };
  }

  ChatMessageReadCursorData copyWith(
          {int? chatId, String? userId, int? timestampUsec}) =>
      ChatMessageReadCursorData(
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  ChatMessageReadCursorData copyWithCompanion(
      ChatMessageReadCursorDataCompanion data) {
    return ChatMessageReadCursorData(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageReadCursorData(')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('timestampUsec: $timestampUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(chatId, userId, timestampUsec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageReadCursorData &&
          other.chatId == this.chatId &&
          other.userId == this.userId &&
          other.timestampUsec == this.timestampUsec);
}

class ChatMessageReadCursorDataCompanion
    extends UpdateCompanion<ChatMessageReadCursorData> {
  final Value<int> chatId;
  final Value<String> userId;
  final Value<int> timestampUsec;
  final Value<int> rowid;
  const ChatMessageReadCursorDataCompanion({
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessageReadCursorDataCompanion.insert({
    required int chatId,
    required String userId,
    required int timestampUsec,
    this.rowid = const Value.absent(),
  })  : chatId = Value(chatId),
        userId = Value(userId),
        timestampUsec = Value(timestampUsec);
  static Insertable<ChatMessageReadCursorData> custom({
    Expression<int>? chatId,
    Expression<String>? userId,
    Expression<int>? timestampUsec,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (userId != null) 'user_id': userId,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessageReadCursorDataCompanion copyWith(
      {Value<int>? chatId,
      Value<String>? userId,
      Value<int>? timestampUsec,
      Value<int>? rowid}) {
    return ChatMessageReadCursorDataCompanion(
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (timestampUsec.present) {
      map['timestamp_usec'] = Variable<int>(timestampUsec.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageReadCursorDataCompanion(')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatOutboxMessageTableTable extends ChatOutboxMessageTable
    with TableInfo<$ChatOutboxMessageTableTable, ChatOutboxMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxMessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
      'id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _participantIdMeta =
      const VerificationMeta('participantId');
  @override
  late final GeneratedColumn<String> participantId = GeneratedColumn<String>(
      'participant_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _replyToIdMeta =
      const VerificationMeta('replyToId');
  @override
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
      'reply_to_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _forwardFromIdMeta =
      const VerificationMeta('forwardFromId');
  @override
  late final GeneratedColumn<int> forwardFromId = GeneratedColumn<int>(
      'forward_from_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _viaSmsMeta = const VerificationMeta('viaSms');
  @override
  late final GeneratedColumn<bool> viaSms = GeneratedColumn<bool>(
      'via_sms', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("via_sms" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _smsNumberMeta =
      const VerificationMeta('smsNumber');
  @override
  late final GeneratedColumn<String> smsNumber = GeneratedColumn<String>(
      'sms_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sendAttemptsMeta =
      const VerificationMeta('sendAttempts');
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
      'send_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        idKey,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        viaSms,
        smsNumber,
        content,
        sendAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_messages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatOutboxMessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_key')) {
      context.handle(
          _idKeyMeta, idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta));
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    }
    if (data.containsKey('participant_id')) {
      context.handle(
          _participantIdMeta,
          participantId.isAcceptableOrUnknown(
              data['participant_id']!, _participantIdMeta));
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
          _replyToIdMeta,
          replyToId.isAcceptableOrUnknown(
              data['reply_to_id']!, _replyToIdMeta));
    }
    if (data.containsKey('forward_from_id')) {
      context.handle(
          _forwardFromIdMeta,
          forwardFromId.isAcceptableOrUnknown(
              data['forward_from_id']!, _forwardFromIdMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    if (data.containsKey('via_sms')) {
      context.handle(_viaSmsMeta,
          viaSms.isAcceptableOrUnknown(data['via_sms']!, _viaSmsMeta));
    }
    if (data.containsKey('sms_number')) {
      context.handle(_smsNumberMeta,
          smsNumber.isAcceptableOrUnknown(data['sms_number']!, _smsNumberMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
          _sendAttemptsMeta,
          sendAttempts.isAcceptableOrUnknown(
              data['send_attempts']!, _sendAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idKey};
  @override
  ChatOutboxMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageData(
      idKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_key'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id']),
      participantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}participant_id']),
      replyToId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reply_to_id']),
      forwardFromId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}forward_from_id']),
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_id']),
      viaSms: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}via_sms'])!,
      smsNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sms_number']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      sendAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_attempts'])!,
    );
  }

  @override
  $ChatOutboxMessageTableTable createAlias(String alias) {
    return $ChatOutboxMessageTableTable(attachedDatabase, alias);
  }
}

class ChatOutboxMessageData extends DataClass
    implements Insertable<ChatOutboxMessageData> {
  final String idKey;
  final int? chatId;
  final String? participantId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final bool viaSms;
  final String? smsNumber;
  final String content;
  final int sendAttempts;
  const ChatOutboxMessageData(
      {required this.idKey,
      this.chatId,
      this.participantId,
      this.replyToId,
      this.forwardFromId,
      this.authorId,
      required this.viaSms,
      this.smsNumber,
      required this.content,
      required this.sendAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_key'] = Variable<String>(idKey);
    if (!nullToAbsent || chatId != null) {
      map['chat_id'] = Variable<int>(chatId);
    }
    if (!nullToAbsent || participantId != null) {
      map['participant_id'] = Variable<String>(participantId);
    }
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<int>(replyToId);
    }
    if (!nullToAbsent || forwardFromId != null) {
      map['forward_from_id'] = Variable<int>(forwardFromId);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    map['via_sms'] = Variable<bool>(viaSms);
    if (!nullToAbsent || smsNumber != null) {
      map['sms_number'] = Variable<String>(smsNumber);
    }
    map['content'] = Variable<String>(content);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  ChatOutboxMessageDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageDataCompanion(
      idKey: Value(idKey),
      chatId:
          chatId == null && nullToAbsent ? const Value.absent() : Value(chatId),
      participantId: participantId == null && nullToAbsent
          ? const Value.absent()
          : Value(participantId),
      replyToId: replyToId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToId),
      forwardFromId: forwardFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(forwardFromId),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      viaSms: Value(viaSms),
      smsNumber: smsNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(smsNumber),
      content: Value(content),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxMessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageData(
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int?>(json['chatId']),
      participantId: serializer.fromJson<String?>(json['participantId']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
      forwardFromId: serializer.fromJson<int?>(json['forwardFromId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      viaSms: serializer.fromJson<bool>(json['viaSms']),
      smsNumber: serializer.fromJson<String?>(json['smsNumber']),
      content: serializer.fromJson<String>(json['content']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idKey': serializer.toJson<String>(idKey),
      'chatId': serializer.toJson<int?>(chatId),
      'participantId': serializer.toJson<String?>(participantId),
      'replyToId': serializer.toJson<int?>(replyToId),
      'forwardFromId': serializer.toJson<int?>(forwardFromId),
      'authorId': serializer.toJson<String?>(authorId),
      'viaSms': serializer.toJson<bool>(viaSms),
      'smsNumber': serializer.toJson<String?>(smsNumber),
      'content': serializer.toJson<String>(content),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxMessageData copyWith(
          {String? idKey,
          Value<int?> chatId = const Value.absent(),
          Value<String?> participantId = const Value.absent(),
          Value<int?> replyToId = const Value.absent(),
          Value<int?> forwardFromId = const Value.absent(),
          Value<String?> authorId = const Value.absent(),
          bool? viaSms,
          Value<String?> smsNumber = const Value.absent(),
          String? content,
          int? sendAttempts}) =>
      ChatOutboxMessageData(
        idKey: idKey ?? this.idKey,
        chatId: chatId.present ? chatId.value : this.chatId,
        participantId:
            participantId.present ? participantId.value : this.participantId,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
        forwardFromId:
            forwardFromId.present ? forwardFromId.value : this.forwardFromId,
        authorId: authorId.present ? authorId.value : this.authorId,
        viaSms: viaSms ?? this.viaSms,
        smsNumber: smsNumber.present ? smsNumber.value : this.smsNumber,
        content: content ?? this.content,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageData copyWithCompanion(ChatOutboxMessageDataCompanion data) {
    return ChatOutboxMessageData(
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      participantId: data.participantId.present
          ? data.participantId.value
          : this.participantId,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
      forwardFromId: data.forwardFromId.present
          ? data.forwardFromId.value
          : this.forwardFromId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      viaSms: data.viaSms.present ? data.viaSms.value : this.viaSms,
      smsNumber: data.smsNumber.present ? data.smsNumber.value : this.smsNumber,
      content: data.content.present ? data.content.value : this.content,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageData(')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('participantId: $participantId, ')
          ..write('replyToId: $replyToId, ')
          ..write('forwardFromId: $forwardFromId, ')
          ..write('authorId: $authorId, ')
          ..write('viaSms: $viaSms, ')
          ..write('smsNumber: $smsNumber, ')
          ..write('content: $content, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idKey, chatId, participantId, replyToId,
      forwardFromId, authorId, viaSms, smsNumber, content, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageData &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId &&
          other.participantId == this.participantId &&
          other.replyToId == this.replyToId &&
          other.forwardFromId == this.forwardFromId &&
          other.authorId == this.authorId &&
          other.viaSms == this.viaSms &&
          other.smsNumber == this.smsNumber &&
          other.content == this.content &&
          other.sendAttempts == this.sendAttempts);
}

class ChatOutboxMessageDataCompanion
    extends UpdateCompanion<ChatOutboxMessageData> {
  final Value<String> idKey;
  final Value<int?> chatId;
  final Value<String?> participantId;
  final Value<int?> replyToId;
  final Value<int?> forwardFromId;
  final Value<String?> authorId;
  final Value<bool> viaSms;
  final Value<String?> smsNumber;
  final Value<String> content;
  final Value<int> sendAttempts;
  final Value<int> rowid;
  const ChatOutboxMessageDataCompanion({
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
    this.participantId = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.viaSms = const Value.absent(),
    this.smsNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatOutboxMessageDataCompanion.insert({
    required String idKey,
    this.chatId = const Value.absent(),
    this.participantId = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.viaSms = const Value.absent(),
    this.smsNumber = const Value.absent(),
    required String content,
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : idKey = Value(idKey),
        content = Value(content);
  static Insertable<ChatOutboxMessageData> custom({
    Expression<String>? idKey,
    Expression<int>? chatId,
    Expression<String>? participantId,
    Expression<int>? replyToId,
    Expression<int>? forwardFromId,
    Expression<String>? authorId,
    Expression<bool>? viaSms,
    Expression<String>? smsNumber,
    Expression<String>? content,
    Expression<int>? sendAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
      if (participantId != null) 'participant_id': participantId,
      if (replyToId != null) 'reply_to_id': replyToId,
      if (forwardFromId != null) 'forward_from_id': forwardFromId,
      if (authorId != null) 'author_id': authorId,
      if (viaSms != null) 'via_sms': viaSms,
      if (smsNumber != null) 'sms_number': smsNumber,
      if (content != null) 'content': content,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatOutboxMessageDataCompanion copyWith(
      {Value<String>? idKey,
      Value<int?>? chatId,
      Value<String?>? participantId,
      Value<int?>? replyToId,
      Value<int?>? forwardFromId,
      Value<String?>? authorId,
      Value<bool>? viaSms,
      Value<String?>? smsNumber,
      Value<String>? content,
      Value<int>? sendAttempts,
      Value<int>? rowid}) {
    return ChatOutboxMessageDataCompanion(
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      viaSms: viaSms ?? this.viaSms,
      smsNumber: smsNumber ?? this.smsNumber,
      content: content ?? this.content,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (participantId.present) {
      map['participant_id'] = Variable<String>(participantId.value);
    }
    if (replyToId.present) {
      map['reply_to_id'] = Variable<int>(replyToId.value);
    }
    if (forwardFromId.present) {
      map['forward_from_id'] = Variable<int>(forwardFromId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (viaSms.present) {
      map['via_sms'] = Variable<bool>(viaSms.value);
    }
    if (smsNumber.present) {
      map['sms_number'] = Variable<String>(smsNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageDataCompanion(')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('participantId: $participantId, ')
          ..write('replyToId: $replyToId, ')
          ..write('forwardFromId: $forwardFromId, ')
          ..write('authorId: $authorId, ')
          ..write('viaSms: $viaSms, ')
          ..write('smsNumber: $smsNumber, ')
          ..write('content: $content, ')
          ..write('sendAttempts: $sendAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatOutboxMessageEditTableTable extends ChatOutboxMessageEditTable
    with
        TableInfo<$ChatOutboxMessageEditTableTable, ChatOutboxMessageEditData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxMessageEditTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
      'id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _newContentMeta =
      const VerificationMeta('newContent');
  @override
  late final GeneratedColumn<String> newContent = GeneratedColumn<String>(
      'new_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sendAttemptsMeta =
      const VerificationMeta('sendAttempts');
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
      'send_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, idKey, chatId, newContent, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_message_edits';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatOutboxMessageEditData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
          _idKeyMeta, idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta));
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('new_content')) {
      context.handle(
          _newContentMeta,
          newContent.isAcceptableOrUnknown(
              data['new_content']!, _newContentMeta));
    } else if (isInserting) {
      context.missing(_newContentMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
          _sendAttemptsMeta,
          sendAttempts.isAcceptableOrUnknown(
              data['send_attempts']!, _sendAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatOutboxMessageEditData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageEditData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_key'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      newContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}new_content'])!,
      sendAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_attempts'])!,
    );
  }

  @override
  $ChatOutboxMessageEditTableTable createAlias(String alias) {
    return $ChatOutboxMessageEditTableTable(attachedDatabase, alias);
  }
}

class ChatOutboxMessageEditData extends DataClass
    implements Insertable<ChatOutboxMessageEditData> {
  final int id;
  final String idKey;
  final int chatId;
  final String newContent;
  final int sendAttempts;
  const ChatOutboxMessageEditData(
      {required this.id,
      required this.idKey,
      required this.chatId,
      required this.newContent,
      required this.sendAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['chat_id'] = Variable<int>(chatId);
    map['new_content'] = Variable<String>(newContent);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  ChatOutboxMessageEditDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageEditDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      chatId: Value(chatId),
      newContent: Value(newContent),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxMessageEditData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageEditData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int>(json['chatId']),
      newContent: serializer.fromJson<String>(json['newContent']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'chatId': serializer.toJson<int>(chatId),
      'newContent': serializer.toJson<String>(newContent),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxMessageEditData copyWith(
          {int? id,
          String? idKey,
          int? chatId,
          String? newContent,
          int? sendAttempts}) =>
      ChatOutboxMessageEditData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        newContent: newContent ?? this.newContent,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageEditData copyWithCompanion(
      ChatOutboxMessageEditDataCompanion data) {
    return ChatOutboxMessageEditData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      newContent:
          data.newContent.present ? data.newContent.value : this.newContent,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageEditData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('newContent: $newContent, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, chatId, newContent, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageEditData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId &&
          other.newContent == this.newContent &&
          other.sendAttempts == this.sendAttempts);
}

class ChatOutboxMessageEditDataCompanion
    extends UpdateCompanion<ChatOutboxMessageEditData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> chatId;
  final Value<String> newContent;
  final Value<int> sendAttempts;
  const ChatOutboxMessageEditDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
    this.newContent = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  ChatOutboxMessageEditDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int chatId,
    required String newContent,
    this.sendAttempts = const Value.absent(),
  })  : idKey = Value(idKey),
        chatId = Value(chatId),
        newContent = Value(newContent);
  static Insertable<ChatOutboxMessageEditData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? chatId,
    Expression<String>? newContent,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
      if (newContent != null) 'new_content': newContent,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  ChatOutboxMessageEditDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? idKey,
      Value<int>? chatId,
      Value<String>? newContent,
      Value<int>? sendAttempts}) {
    return ChatOutboxMessageEditDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      newContent: newContent ?? this.newContent,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (newContent.present) {
      map['new_content'] = Variable<String>(newContent.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageEditDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('newContent: $newContent, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

class $ChatOutboxMessageDeleteTableTable extends ChatOutboxMessageDeleteTable
    with
        TableInfo<$ChatOutboxMessageDeleteTableTable,
            ChatOutboxMessageDeleteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxMessageDeleteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
      'id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _sendAttemptsMeta =
      const VerificationMeta('sendAttempts');
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
      'send_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, idKey, chatId, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_message_deletes';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatOutboxMessageDeleteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
          _idKeyMeta, idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta));
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
          _sendAttemptsMeta,
          sendAttempts.isAcceptableOrUnknown(
              data['send_attempts']!, _sendAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatOutboxMessageDeleteData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageDeleteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_key'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      sendAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_attempts'])!,
    );
  }

  @override
  $ChatOutboxMessageDeleteTableTable createAlias(String alias) {
    return $ChatOutboxMessageDeleteTableTable(attachedDatabase, alias);
  }
}

class ChatOutboxMessageDeleteData extends DataClass
    implements Insertable<ChatOutboxMessageDeleteData> {
  final int id;
  final String idKey;
  final int chatId;
  final int sendAttempts;
  const ChatOutboxMessageDeleteData(
      {required this.id,
      required this.idKey,
      required this.chatId,
      required this.sendAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['chat_id'] = Variable<int>(chatId);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  ChatOutboxMessageDeleteDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageDeleteDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      chatId: Value(chatId),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxMessageDeleteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageDeleteData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int>(json['chatId']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'chatId': serializer.toJson<int>(chatId),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxMessageDeleteData copyWith(
          {int? id, String? idKey, int? chatId, int? sendAttempts}) =>
      ChatOutboxMessageDeleteData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageDeleteData copyWithCompanion(
      ChatOutboxMessageDeleteDataCompanion data) {
    return ChatOutboxMessageDeleteData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageDeleteData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, chatId, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageDeleteData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId &&
          other.sendAttempts == this.sendAttempts);
}

class ChatOutboxMessageDeleteDataCompanion
    extends UpdateCompanion<ChatOutboxMessageDeleteData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> chatId;
  final Value<int> sendAttempts;
  const ChatOutboxMessageDeleteDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  ChatOutboxMessageDeleteDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int chatId,
    this.sendAttempts = const Value.absent(),
  })  : idKey = Value(idKey),
        chatId = Value(chatId);
  static Insertable<ChatOutboxMessageDeleteData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? chatId,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  ChatOutboxMessageDeleteDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? idKey,
      Value<int>? chatId,
      Value<int>? sendAttempts}) {
    return ChatOutboxMessageDeleteDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageDeleteDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

class $ChatOutboxMessageViewsTableTable extends ChatOutboxMessageViewsTable
    with
        TableInfo<$ChatOutboxMessageViewsTableTable,
            ChatOutboxMessageViewData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxMessageViewsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
      'id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _sendAttemptsMeta =
      const VerificationMeta('sendAttempts');
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
      'send_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, idKey, chatId, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_message_views';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatOutboxMessageViewData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
          _idKeyMeta, idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta));
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
          _sendAttemptsMeta,
          sendAttempts.isAcceptableOrUnknown(
              data['send_attempts']!, _sendAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatOutboxMessageViewData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_key'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      sendAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_attempts'])!,
    );
  }

  @override
  $ChatOutboxMessageViewsTableTable createAlias(String alias) {
    return $ChatOutboxMessageViewsTableTable(attachedDatabase, alias);
  }
}

class ChatOutboxMessageViewData extends DataClass
    implements Insertable<ChatOutboxMessageViewData> {
  final int id;
  final String idKey;
  final int chatId;
  final int sendAttempts;
  const ChatOutboxMessageViewData(
      {required this.id,
      required this.idKey,
      required this.chatId,
      required this.sendAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['chat_id'] = Variable<int>(chatId);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  ChatOutboxMessageViewDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageViewDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      chatId: Value(chatId),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxMessageViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageViewData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int>(json['chatId']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'chatId': serializer.toJson<int>(chatId),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxMessageViewData copyWith(
          {int? id, String? idKey, int? chatId, int? sendAttempts}) =>
      ChatOutboxMessageViewData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageViewData copyWithCompanion(
      ChatOutboxMessageViewDataCompanion data) {
    return ChatOutboxMessageViewData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageViewData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, chatId, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageViewData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId &&
          other.sendAttempts == this.sendAttempts);
}

class ChatOutboxMessageViewDataCompanion
    extends UpdateCompanion<ChatOutboxMessageViewData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> chatId;
  final Value<int> sendAttempts;
  const ChatOutboxMessageViewDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  ChatOutboxMessageViewDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int chatId,
    this.sendAttempts = const Value.absent(),
  })  : idKey = Value(idKey),
        chatId = Value(chatId);
  static Insertable<ChatOutboxMessageViewData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? chatId,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  ChatOutboxMessageViewDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? idKey,
      Value<int>? chatId,
      Value<int>? sendAttempts}) {
    return ChatOutboxMessageViewDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageViewDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

class $ChatOutboxReadCursorsTableTable extends ChatOutboxReadCursorsTable
    with TableInfo<$ChatOutboxReadCursorsTableTable, ChatOutboxReadCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxReadCursorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES chats (id) ON DELETE CASCADE'));
  static const VerificationMeta _timestampUsecMeta =
      const VerificationMeta('timestampUsec');
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
      'timestamp_usec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sendAttemptsMeta =
      const VerificationMeta('sendAttempts');
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
      'send_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [chatId, timestampUsec, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_read_cursors';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatOutboxReadCursorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
          _timestampUsecMeta,
          timestampUsec.isAcceptableOrUnknown(
              data['timestamp_usec']!, _timestampUsecMeta));
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
          _sendAttemptsMeta,
          sendAttempts.isAcceptableOrUnknown(
              data['send_attempts']!, _sendAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId};
  @override
  ChatOutboxReadCursorData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxReadCursorData(
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      timestampUsec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp_usec'])!,
      sendAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_attempts'])!,
    );
  }

  @override
  $ChatOutboxReadCursorsTableTable createAlias(String alias) {
    return $ChatOutboxReadCursorsTableTable(attachedDatabase, alias);
  }
}

class ChatOutboxReadCursorData extends DataClass
    implements Insertable<ChatOutboxReadCursorData> {
  final int chatId;
  final int timestampUsec;
  final int sendAttempts;
  const ChatOutboxReadCursorData(
      {required this.chatId,
      required this.timestampUsec,
      required this.sendAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  ChatOutboxReadCursorDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxReadCursorDataCompanion(
      chatId: Value(chatId),
      timestampUsec: Value(timestampUsec),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxReadCursorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxReadCursorData(
      chatId: serializer.fromJson<int>(json['chatId']),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxReadCursorData copyWith(
          {int? chatId, int? timestampUsec, int? sendAttempts}) =>
      ChatOutboxReadCursorData(
        chatId: chatId ?? this.chatId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxReadCursorData copyWithCompanion(
      ChatOutboxReadCursorDataCompanion data) {
    return ChatOutboxReadCursorData(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxReadCursorData(')
          ..write('chatId: $chatId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(chatId, timestampUsec, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxReadCursorData &&
          other.chatId == this.chatId &&
          other.timestampUsec == this.timestampUsec &&
          other.sendAttempts == this.sendAttempts);
}

class ChatOutboxReadCursorDataCompanion
    extends UpdateCompanion<ChatOutboxReadCursorData> {
  final Value<int> chatId;
  final Value<int> timestampUsec;
  final Value<int> sendAttempts;
  const ChatOutboxReadCursorDataCompanion({
    this.chatId = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  ChatOutboxReadCursorDataCompanion.insert({
    this.chatId = const Value.absent(),
    required int timestampUsec,
    this.sendAttempts = const Value.absent(),
  }) : timestampUsec = Value(timestampUsec);
  static Insertable<ChatOutboxReadCursorData> custom({
    Expression<int>? chatId,
    Expression<int>? timestampUsec,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  ChatOutboxReadCursorDataCompanion copyWith(
      {Value<int>? chatId,
      Value<int>? timestampUsec,
      Value<int>? sendAttempts}) {
    return ChatOutboxReadCursorDataCompanion(
      chatId: chatId ?? this.chatId,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (timestampUsec.present) {
      map['timestamp_usec'] = Variable<int>(timestampUsec.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxReadCursorDataCompanion(')
          ..write('chatId: $chatId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ContactsTableTable contactsTable = $ContactsTableTable(this);
  late final $ContactPhonesTableTable contactPhonesTable =
      $ContactPhonesTableTable(this);
  late final $ContactEmailsTableTable contactEmailsTable =
      $ContactEmailsTableTable(this);
  late final $CallLogsTableTable callLogsTable = $CallLogsTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $ChatsTableTable chatsTable = $ChatsTableTable(this);
  late final $ChatMembersTableTable chatMembersTable =
      $ChatMembersTableTable(this);
  late final $ChatMessagesTableTable chatMessagesTable =
      $ChatMessagesTableTable(this);
  late final $ChatMessageSyncCursorTableTable chatMessageSyncCursorTable =
      $ChatMessageSyncCursorTableTable(this);
  late final $ChatMessageReadCursorTableTable chatMessageReadCursorTable =
      $ChatMessageReadCursorTableTable(this);
  late final $ChatOutboxMessageTableTable chatOutboxMessageTable =
      $ChatOutboxMessageTableTable(this);
  late final $ChatOutboxMessageEditTableTable chatOutboxMessageEditTable =
      $ChatOutboxMessageEditTableTable(this);
  late final $ChatOutboxMessageDeleteTableTable chatOutboxMessageDeleteTable =
      $ChatOutboxMessageDeleteTableTable(this);
  late final $ChatOutboxMessageViewsTableTable chatOutboxMessageViewsTable =
      $ChatOutboxMessageViewsTableTable(this);
  late final $ChatOutboxReadCursorsTableTable chatOutboxReadCursorsTable =
      $ChatOutboxReadCursorsTableTable(this);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ContactPhonesDao contactPhonesDao =
      ContactPhonesDao(this as AppDatabase);
  late final ContactEmailsDao contactEmailsDao =
      ContactEmailsDao(this as AppDatabase);
  late final CallLogsDao callLogsDao = CallLogsDao(this as AppDatabase);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  late final ChatsDao chatsDao = ChatsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contactsTable,
        contactPhonesTable,
        contactEmailsTable,
        callLogsTable,
        favoritesTable,
        chatsTable,
        chatMembersTable,
        chatMessagesTable,
        chatMessageSyncCursorTable,
        chatMessageReadCursorTable,
        chatOutboxMessageTable,
        chatOutboxMessageEditTable,
        chatOutboxMessageDeleteTable,
        chatOutboxMessageViewsTable,
        chatOutboxReadCursorsTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('contact_phones', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('contact_emails', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contact_phones',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('favorites', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_members', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_messages', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_message_sync_cursors', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_message_read_cursors', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_outbox_messages', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_outbox_message_edits', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_outbox_message_deletes',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_outbox_message_views', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chat_outbox_read_cursors', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ContactsTableTableCreateCompanionBuilder = ContactDataCompanion
    Function({
  Value<int> id,
  required ContactSourceTypeEnum sourceType,
  required String sourceId,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> aliasName,
  Value<Uint8List?> thumbnail,
  Value<bool?> registered,
  Value<bool?> userRegistered,
  Value<bool?> isCurrentUser,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ContactsTableTableUpdateCompanionBuilder = ContactDataCompanion
    Function({
  Value<int> id,
  Value<ContactSourceTypeEnum> sourceType,
  Value<String> sourceId,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> aliasName,
  Value<Uint8List?> thumbnail,
  Value<bool?> registered,
  Value<bool?> userRegistered,
  Value<bool?> isCurrentUser,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ContactsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTableTable,
    ContactData,
    $$ContactsTableTableFilterComposer,
    $$ContactsTableTableOrderingComposer,
    $$ContactsTableTableCreateCompanionBuilder,
    $$ContactsTableTableUpdateCompanionBuilder> {
  $$ContactsTableTableTableManager(_$AppDatabase db, $ContactsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContactsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContactsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ContactSourceTypeEnum> sourceType = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> aliasName = const Value.absent(),
            Value<Uint8List?> thumbnail = const Value.absent(),
            Value<bool?> registered = const Value.absent(),
            Value<bool?> userRegistered = const Value.absent(),
            Value<bool?> isCurrentUser = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactDataCompanion(
            id: id,
            sourceType: sourceType,
            sourceId: sourceId,
            firstName: firstName,
            lastName: lastName,
            aliasName: aliasName,
            thumbnail: thumbnail,
            registered: registered,
            userRegistered: userRegistered,
            isCurrentUser: isCurrentUser,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ContactSourceTypeEnum sourceType,
            required String sourceId,
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> aliasName = const Value.absent(),
            Value<Uint8List?> thumbnail = const Value.absent(),
            Value<bool?> registered = const Value.absent(),
            Value<bool?> userRegistered = const Value.absent(),
            Value<bool?> isCurrentUser = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactDataCompanion.insert(
            id: id,
            sourceType: sourceType,
            sourceId: sourceId,
            firstName: firstName,
            lastName: lastName,
            aliasName: aliasName,
            thumbnail: thumbnail,
            registered: registered,
            userRegistered: userRegistered,
            isCurrentUser: isCurrentUser,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ContactsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContactsTableTable> {
  $$ContactsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ContactSourceTypeEnum, ContactSourceTypeEnum,
          int>
      get sourceType => $state.composableBuilder(
          column: $state.table.sourceType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get aliasName => $state.composableBuilder(
      column: $state.table.aliasName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get thumbnail => $state.composableBuilder(
      column: $state.table.thumbnail,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get registered => $state.composableBuilder(
      column: $state.table.registered,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get userRegistered => $state.composableBuilder(
      column: $state.table.userRegistered,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCurrentUser => $state.composableBuilder(
      column: $state.table.isCurrentUser,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter contactPhonesTableRefs(
      ComposableFilter Function($$ContactPhonesTableTableFilterComposer f) f) {
    final $$ContactPhonesTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.contactPhonesTable,
            getReferencedColumn: (t) => t.contactId,
            builder: (joinBuilder, parentComposers) =>
                $$ContactPhonesTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.contactPhonesTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter contactEmailsTableRefs(
      ComposableFilter Function($$ContactEmailsTableTableFilterComposer f) f) {
    final $$ContactEmailsTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.contactEmailsTable,
            getReferencedColumn: (t) => t.contactId,
            builder: (joinBuilder, parentComposers) =>
                $$ContactEmailsTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.contactEmailsTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ContactsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContactsTableTable> {
  $$ContactsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sourceType => $state.composableBuilder(
      column: $state.table.sourceType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get aliasName => $state.composableBuilder(
      column: $state.table.aliasName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get thumbnail => $state.composableBuilder(
      column: $state.table.thumbnail,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get registered => $state.composableBuilder(
      column: $state.table.registered,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get userRegistered => $state.composableBuilder(
      column: $state.table.userRegistered,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCurrentUser => $state.composableBuilder(
      column: $state.table.isCurrentUser,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ContactPhonesTableTableCreateCompanionBuilder
    = ContactPhoneDataCompanion Function({
  Value<int> id,
  required String number,
  required String label,
  required int contactId,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ContactPhonesTableTableUpdateCompanionBuilder
    = ContactPhoneDataCompanion Function({
  Value<int> id,
  Value<String> number,
  Value<String> label,
  Value<int> contactId,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ContactPhonesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactPhonesTableTable,
    ContactPhoneData,
    $$ContactPhonesTableTableFilterComposer,
    $$ContactPhonesTableTableOrderingComposer,
    $$ContactPhonesTableTableCreateCompanionBuilder,
    $$ContactPhonesTableTableUpdateCompanionBuilder> {
  $$ContactPhonesTableTableTableManager(
      _$AppDatabase db, $ContactPhonesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContactPhonesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ContactPhonesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> contactId = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactPhoneDataCompanion(
            id: id,
            number: number,
            label: label,
            contactId: contactId,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String number,
            required String label,
            required int contactId,
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactPhoneDataCompanion.insert(
            id: id,
            number: number,
            label: label,
            contactId: contactId,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ContactPhonesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContactPhonesTableTable> {
  $$ContactPhonesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ContactsTableTableFilterComposer get contactId {
    final $$ContactsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $state.db.contactsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ContactsTableTableFilterComposer(ComposerState($state.db,
                $state.db.contactsTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter favoritesTableRefs(
      ComposableFilter Function($$FavoritesTableTableFilterComposer f) f) {
    final $$FavoritesTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.favoritesTable,
        getReferencedColumn: (t) => t.contactPhoneId,
        builder: (joinBuilder, parentComposers) =>
            $$FavoritesTableTableFilterComposer(ComposerState($state.db,
                $state.db.favoritesTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ContactPhonesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContactPhonesTableTable> {
  $$ContactPhonesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ContactsTableTableOrderingComposer get contactId {
    final $$ContactsTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.contactId,
            referencedTable: $state.db.contactsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ContactsTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.contactsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ContactEmailsTableTableCreateCompanionBuilder
    = ContactEmailDataCompanion Function({
  Value<int> id,
  required String address,
  required String label,
  required int contactId,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ContactEmailsTableTableUpdateCompanionBuilder
    = ContactEmailDataCompanion Function({
  Value<int> id,
  Value<String> address,
  Value<String> label,
  Value<int> contactId,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ContactEmailsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactEmailsTableTable,
    ContactEmailData,
    $$ContactEmailsTableTableFilterComposer,
    $$ContactEmailsTableTableOrderingComposer,
    $$ContactEmailsTableTableCreateCompanionBuilder,
    $$ContactEmailsTableTableUpdateCompanionBuilder> {
  $$ContactEmailsTableTableTableManager(
      _$AppDatabase db, $ContactEmailsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContactEmailsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ContactEmailsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> contactId = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactEmailDataCompanion(
            id: id,
            address: address,
            label: label,
            contactId: contactId,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String address,
            required String label,
            required int contactId,
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ContactEmailDataCompanion.insert(
            id: id,
            address: address,
            label: label,
            contactId: contactId,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ContactEmailsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContactEmailsTableTable> {
  $$ContactEmailsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ContactsTableTableFilterComposer get contactId {
    final $$ContactsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $state.db.contactsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ContactsTableTableFilterComposer(ComposerState($state.db,
                $state.db.contactsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ContactEmailsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContactEmailsTableTable> {
  $$ContactEmailsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ContactsTableTableOrderingComposer get contactId {
    final $$ContactsTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.contactId,
            referencedTable: $state.db.contactsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ContactsTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.contactsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CallLogsTableTableCreateCompanionBuilder = CallLogDataCompanion
    Function({
  Value<int> id,
  required CallLogDirectionEnum direction,
  required String number,
  required bool video,
  required DateTime createdAt,
  Value<DateTime?> acceptedAt,
  Value<DateTime?> hungUpAt,
});
typedef $$CallLogsTableTableUpdateCompanionBuilder = CallLogDataCompanion
    Function({
  Value<int> id,
  Value<CallLogDirectionEnum> direction,
  Value<String> number,
  Value<bool> video,
  Value<DateTime> createdAt,
  Value<DateTime?> acceptedAt,
  Value<DateTime?> hungUpAt,
});

class $$CallLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CallLogsTableTable,
    CallLogData,
    $$CallLogsTableTableFilterComposer,
    $$CallLogsTableTableOrderingComposer,
    $$CallLogsTableTableCreateCompanionBuilder,
    $$CallLogsTableTableUpdateCompanionBuilder> {
  $$CallLogsTableTableTableManager(_$AppDatabase db, $CallLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CallLogsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CallLogsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<CallLogDirectionEnum> direction = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<bool> video = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> acceptedAt = const Value.absent(),
            Value<DateTime?> hungUpAt = const Value.absent(),
          }) =>
              CallLogDataCompanion(
            id: id,
            direction: direction,
            number: number,
            video: video,
            createdAt: createdAt,
            acceptedAt: acceptedAt,
            hungUpAt: hungUpAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required CallLogDirectionEnum direction,
            required String number,
            required bool video,
            required DateTime createdAt,
            Value<DateTime?> acceptedAt = const Value.absent(),
            Value<DateTime?> hungUpAt = const Value.absent(),
          }) =>
              CallLogDataCompanion.insert(
            id: id,
            direction: direction,
            number: number,
            video: video,
            createdAt: createdAt,
            acceptedAt: acceptedAt,
            hungUpAt: hungUpAt,
          ),
        ));
}

class $$CallLogsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CallLogsTableTable> {
  $$CallLogsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<CallLogDirectionEnum, CallLogDirectionEnum,
          int>
      get direction => $state.composableBuilder(
          column: $state.table.direction,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get video => $state.composableBuilder(
      column: $state.table.video,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get acceptedAt => $state.composableBuilder(
      column: $state.table.acceptedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get hungUpAt => $state.composableBuilder(
      column: $state.table.hungUpAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CallLogsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CallLogsTableTable> {
  $$CallLogsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get direction => $state.composableBuilder(
      column: $state.table.direction,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get video => $state.composableBuilder(
      column: $state.table.video,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get acceptedAt => $state.composableBuilder(
      column: $state.table.acceptedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get hungUpAt => $state.composableBuilder(
      column: $state.table.hungUpAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$FavoritesTableTableCreateCompanionBuilder = FavoriteDataCompanion
    Function({
  Value<int> id,
  required int contactPhoneId,
  required int position,
});
typedef $$FavoritesTableTableUpdateCompanionBuilder = FavoriteDataCompanion
    Function({
  Value<int> id,
  Value<int> contactPhoneId,
  Value<int> position,
});

class $$FavoritesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoritesTableTable,
    FavoriteData,
    $$FavoritesTableTableFilterComposer,
    $$FavoritesTableTableOrderingComposer,
    $$FavoritesTableTableCreateCompanionBuilder,
    $$FavoritesTableTableUpdateCompanionBuilder> {
  $$FavoritesTableTableTableManager(
      _$AppDatabase db, $FavoritesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FavoritesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FavoritesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> contactPhoneId = const Value.absent(),
            Value<int> position = const Value.absent(),
          }) =>
              FavoriteDataCompanion(
            id: id,
            contactPhoneId: contactPhoneId,
            position: position,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int contactPhoneId,
            required int position,
          }) =>
              FavoriteDataCompanion.insert(
            id: id,
            contactPhoneId: contactPhoneId,
            position: position,
          ),
        ));
}

class $$FavoritesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ContactPhonesTableTableFilterComposer get contactPhoneId {
    final $$ContactPhonesTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.contactPhoneId,
            referencedTable: $state.db.contactPhonesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ContactPhonesTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.contactPhonesTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$FavoritesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ContactPhonesTableTableOrderingComposer get contactPhoneId {
    final $$ContactPhonesTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.contactPhoneId,
            referencedTable: $state.db.contactPhonesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ContactPhonesTableTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.contactPhonesTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

typedef $$ChatsTableTableCreateCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  required ChatTypeEnum type,
  Value<String?> name,
  required DateTime insertedAtRemote,
  required DateTime updatedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ChatsTableTableUpdateCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  Value<ChatTypeEnum> type,
  Value<String?> name,
  Value<DateTime> insertedAtRemote,
  Value<DateTime> updatedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ChatsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatsTableTable,
    ChatData,
    $$ChatsTableTableFilterComposer,
    $$ChatsTableTableOrderingComposer,
    $$ChatsTableTableCreateCompanionBuilder,
    $$ChatsTableTableUpdateCompanionBuilder> {
  $$ChatsTableTableTableManager(_$AppDatabase db, $ChatsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChatsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChatsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ChatTypeEnum> type = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<DateTime> insertedAtRemote = const Value.absent(),
            Value<DateTime> updatedAtRemote = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatDataCompanion(
            id: id,
            type: type,
            name: name,
            insertedAtRemote: insertedAtRemote,
            updatedAtRemote: updatedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ChatTypeEnum type,
            Value<String?> name = const Value.absent(),
            required DateTime insertedAtRemote,
            required DateTime updatedAtRemote,
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatDataCompanion.insert(
            id: id,
            type: type,
            name: name,
            insertedAtRemote: insertedAtRemote,
            updatedAtRemote: updatedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ChatTypeEnum, ChatTypeEnum, String> get type =>
      $state.composableBuilder(
          column: $state.table.type,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAtRemote => $state.composableBuilder(
      column: $state.table.insertedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAtRemote => $state.composableBuilder(
      column: $state.table.updatedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter chatMembersTableRefs(
      ComposableFilter Function($$ChatMembersTableTableFilterComposer f) f) {
    final $$ChatMembersTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatMembersTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatMembersTableTableFilterComposer(ComposerState($state.db,
                    $state.db.chatMembersTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter chatMessagesTableRefs(
      ComposableFilter Function($$ChatMessagesTableTableFilterComposer f) f) {
    final $$ChatMessagesTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatMessagesTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatMessagesTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatMessagesTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatMessageSyncCursorTableRefs(
      ComposableFilter Function(
              $$ChatMessageSyncCursorTableTableFilterComposer f)
          f) {
    final $$ChatMessageSyncCursorTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatMessageSyncCursorTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatMessageSyncCursorTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatMessageSyncCursorTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatMessageReadCursorTableRefs(
      ComposableFilter Function(
              $$ChatMessageReadCursorTableTableFilterComposer f)
          f) {
    final $$ChatMessageReadCursorTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatMessageReadCursorTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatMessageReadCursorTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatMessageReadCursorTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatOutboxMessageTableRefs(
      ComposableFilter Function($$ChatOutboxMessageTableTableFilterComposer f)
          f) {
    final $$ChatOutboxMessageTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatOutboxMessageTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatOutboxMessageTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatOutboxMessageTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatOutboxMessageEditTableRefs(
      ComposableFilter Function(
              $$ChatOutboxMessageEditTableTableFilterComposer f)
          f) {
    final $$ChatOutboxMessageEditTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatOutboxMessageEditTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatOutboxMessageEditTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatOutboxMessageEditTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatOutboxMessageDeleteTableRefs(
      ComposableFilter Function(
              $$ChatOutboxMessageDeleteTableTableFilterComposer f)
          f) {
    final $$ChatOutboxMessageDeleteTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatOutboxMessageDeleteTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatOutboxMessageDeleteTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatOutboxMessageDeleteTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatOutboxMessageViewsTableRefs(
      ComposableFilter Function(
              $$ChatOutboxMessageViewsTableTableFilterComposer f)
          f) {
    final $$ChatOutboxMessageViewsTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatOutboxMessageViewsTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatOutboxMessageViewsTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatOutboxMessageViewsTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter chatOutboxReadCursorsTableRefs(
      ComposableFilter Function(
              $$ChatOutboxReadCursorsTableTableFilterComposer f)
          f) {
    final $$ChatOutboxReadCursorsTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.chatOutboxReadCursorsTable,
            getReferencedColumn: (t) => t.chatId,
            builder: (joinBuilder, parentComposers) =>
                $$ChatOutboxReadCursorsTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.chatOutboxReadCursorsTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ChatsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAtRemote => $state.composableBuilder(
      column: $state.table.insertedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAtRemote => $state.composableBuilder(
      column: $state.table.updatedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ChatMembersTableTableCreateCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  required int chatId,
  required String userId,
  Value<GroupAuthoritiesEnum?> groupAuthorities,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ChatMembersTableTableUpdateCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  Value<int> chatId,
  Value<String> userId,
  Value<GroupAuthoritiesEnum?> groupAuthorities,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ChatMembersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMembersTableTable,
    ChatMemberData,
    $$ChatMembersTableTableFilterComposer,
    $$ChatMembersTableTableOrderingComposer,
    $$ChatMembersTableTableCreateCompanionBuilder,
    $$ChatMembersTableTableUpdateCompanionBuilder> {
  $$ChatMembersTableTableTableManager(
      _$AppDatabase db, $ChatMembersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChatMembersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChatMembersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<GroupAuthoritiesEnum?> groupAuthorities =
                const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMemberDataCompanion(
            id: id,
            chatId: chatId,
            userId: userId,
            groupAuthorities: groupAuthorities,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int chatId,
            required String userId,
            Value<GroupAuthoritiesEnum?> groupAuthorities =
                const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMemberDataCompanion.insert(
            id: id,
            chatId: chatId,
            userId: userId,
            groupAuthorities: groupAuthorities,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatMembersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatMembersTableTable> {
  $$ChatMembersTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<GroupAuthoritiesEnum?, GroupAuthoritiesEnum,
          String>
      get groupAuthorities => $state.composableBuilder(
          column: $state.table.groupAuthorities,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatMembersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatMembersTableTable> {
  $$ChatMembersTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get groupAuthorities => $state.composableBuilder(
      column: $state.table.groupAuthorities,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatMessagesTableTableCreateCompanionBuilder
    = ChatMessageDataCompanion Function({
  Value<int> id,
  required String idKey,
  required String senderId,
  required int chatId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
  Value<bool> viaSms,
  Value<SmsOutStateEnum?> smsOutState,
  Value<String?> smsNumber,
  required String content,
  Value<DateTime?> viewedAt,
  Value<DateTime?> editedAt,
  required DateTime createdAtRemote,
  required DateTime updatedAtRemote,
  Value<DateTime?> deletedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ChatMessagesTableTableUpdateCompanionBuilder
    = ChatMessageDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<String> senderId,
  Value<int> chatId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
  Value<bool> viaSms,
  Value<SmsOutStateEnum?> smsOutState,
  Value<String?> smsNumber,
  Value<String> content,
  Value<DateTime?> viewedAt,
  Value<DateTime?> editedAt,
  Value<DateTime> createdAtRemote,
  Value<DateTime> updatedAtRemote,
  Value<DateTime?> deletedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ChatMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTableTable,
    ChatMessageData,
    $$ChatMessagesTableTableFilterComposer,
    $$ChatMessagesTableTableOrderingComposer,
    $$ChatMessagesTableTableCreateCompanionBuilder,
    $$ChatMessagesTableTableUpdateCompanionBuilder> {
  $$ChatMessagesTableTableTableManager(
      _$AppDatabase db, $ChatMessagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChatMessagesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ChatMessagesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<String> senderId = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<SmsOutStateEnum?> smsOutState = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime?> viewedAt = const Value.absent(),
            Value<DateTime?> editedAt = const Value.absent(),
            Value<DateTime> createdAtRemote = const Value.absent(),
            Value<DateTime> updatedAtRemote = const Value.absent(),
            Value<DateTime?> deletedAtRemote = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMessageDataCompanion(
            id: id,
            idKey: idKey,
            senderId: senderId,
            chatId: chatId,
            replyToId: replyToId,
            forwardFromId: forwardFromId,
            authorId: authorId,
            viaSms: viaSms,
            smsOutState: smsOutState,
            smsNumber: smsNumber,
            content: content,
            viewedAt: viewedAt,
            editedAt: editedAt,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required String senderId,
            required int chatId,
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<SmsOutStateEnum?> smsOutState = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            required String content,
            Value<DateTime?> viewedAt = const Value.absent(),
            Value<DateTime?> editedAt = const Value.absent(),
            required DateTime createdAtRemote,
            required DateTime updatedAtRemote,
            Value<DateTime?> deletedAtRemote = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMessageDataCompanion.insert(
            id: id,
            idKey: idKey,
            senderId: senderId,
            chatId: chatId,
            replyToId: replyToId,
            forwardFromId: forwardFromId,
            authorId: authorId,
            viaSms: viaSms,
            smsOutState: smsOutState,
            smsNumber: smsNumber,
            content: content,
            viewedAt: viewedAt,
            editedAt: editedAt,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatMessagesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get senderId => $state.composableBuilder(
      column: $state.table.senderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get replyToId => $state.composableBuilder(
      column: $state.table.replyToId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get forwardFromId => $state.composableBuilder(
      column: $state.table.forwardFromId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get viaSms => $state.composableBuilder(
      column: $state.table.viaSms,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<SmsOutStateEnum?, SmsOutStateEnum, String>
      get smsOutState => $state.composableBuilder(
          column: $state.table.smsOutState,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get smsNumber => $state.composableBuilder(
      column: $state.table.smsNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get viewedAt => $state.composableBuilder(
      column: $state.table.viewedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get editedAt => $state.composableBuilder(
      column: $state.table.editedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAtRemote => $state.composableBuilder(
      column: $state.table.createdAtRemote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAtRemote => $state.composableBuilder(
      column: $state.table.updatedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAtRemote => $state.composableBuilder(
      column: $state.table.deletedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatMessagesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get senderId => $state.composableBuilder(
      column: $state.table.senderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get replyToId => $state.composableBuilder(
      column: $state.table.replyToId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get forwardFromId => $state.composableBuilder(
      column: $state.table.forwardFromId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get viaSms => $state.composableBuilder(
      column: $state.table.viaSms,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get smsOutState => $state.composableBuilder(
      column: $state.table.smsOutState,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get smsNumber => $state.composableBuilder(
      column: $state.table.smsNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get viewedAt => $state.composableBuilder(
      column: $state.table.viewedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get editedAt => $state.composableBuilder(
      column: $state.table.editedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAtRemote => $state.composableBuilder(
      column: $state.table.createdAtRemote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAtRemote => $state.composableBuilder(
      column: $state.table.updatedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAtRemote => $state.composableBuilder(
      column: $state.table.deletedAtRemote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get insertedAt => $state.composableBuilder(
      column: $state.table.insertedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatMessageSyncCursorTableTableCreateCompanionBuilder
    = ChatMessageSyncCursorDataCompanion Function({
  required int chatId,
  required MessageSyncCursorTypeEnum cursorType,
  required int timestampUsec,
  Value<int> rowid,
});
typedef $$ChatMessageSyncCursorTableTableUpdateCompanionBuilder
    = ChatMessageSyncCursorDataCompanion Function({
  Value<int> chatId,
  Value<MessageSyncCursorTypeEnum> cursorType,
  Value<int> timestampUsec,
  Value<int> rowid,
});

class $$ChatMessageSyncCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessageSyncCursorTableTable,
    ChatMessageSyncCursorData,
    $$ChatMessageSyncCursorTableTableFilterComposer,
    $$ChatMessageSyncCursorTableTableOrderingComposer,
    $$ChatMessageSyncCursorTableTableCreateCompanionBuilder,
    $$ChatMessageSyncCursorTableTableUpdateCompanionBuilder> {
  $$ChatMessageSyncCursorTableTableTableManager(
      _$AppDatabase db, $ChatMessageSyncCursorTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatMessageSyncCursorTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatMessageSyncCursorTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> chatId = const Value.absent(),
            Value<MessageSyncCursorTypeEnum> cursorType = const Value.absent(),
            Value<int> timestampUsec = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageSyncCursorDataCompanion(
            chatId: chatId,
            cursorType: cursorType,
            timestampUsec: timestampUsec,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int chatId,
            required MessageSyncCursorTypeEnum cursorType,
            required int timestampUsec,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageSyncCursorDataCompanion.insert(
            chatId: chatId,
            cursorType: cursorType,
            timestampUsec: timestampUsec,
            rowid: rowid,
          ),
        ));
}

class $$ChatMessageSyncCursorTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatMessageSyncCursorTableTable> {
  $$ChatMessageSyncCursorTableTableFilterComposer(super.$state);
  ColumnWithTypeConverterFilters<MessageSyncCursorTypeEnum,
          MessageSyncCursorTypeEnum, String>
      get cursorType => $state.composableBuilder(
          column: $state.table.cursorType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatMessageSyncCursorTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatMessageSyncCursorTableTable> {
  $$ChatMessageSyncCursorTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get cursorType => $state.composableBuilder(
      column: $state.table.cursorType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatMessageReadCursorTableTableCreateCompanionBuilder
    = ChatMessageReadCursorDataCompanion Function({
  required int chatId,
  required String userId,
  required int timestampUsec,
  Value<int> rowid,
});
typedef $$ChatMessageReadCursorTableTableUpdateCompanionBuilder
    = ChatMessageReadCursorDataCompanion Function({
  Value<int> chatId,
  Value<String> userId,
  Value<int> timestampUsec,
  Value<int> rowid,
});

class $$ChatMessageReadCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessageReadCursorTableTable,
    ChatMessageReadCursorData,
    $$ChatMessageReadCursorTableTableFilterComposer,
    $$ChatMessageReadCursorTableTableOrderingComposer,
    $$ChatMessageReadCursorTableTableCreateCompanionBuilder,
    $$ChatMessageReadCursorTableTableUpdateCompanionBuilder> {
  $$ChatMessageReadCursorTableTableTableManager(
      _$AppDatabase db, $ChatMessageReadCursorTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatMessageReadCursorTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatMessageReadCursorTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> chatId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> timestampUsec = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageReadCursorDataCompanion(
            chatId: chatId,
            userId: userId,
            timestampUsec: timestampUsec,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int chatId,
            required String userId,
            required int timestampUsec,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageReadCursorDataCompanion.insert(
            chatId: chatId,
            userId: userId,
            timestampUsec: timestampUsec,
            rowid: rowid,
          ),
        ));
}

class $$ChatMessageReadCursorTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatMessageReadCursorTableTable> {
  $$ChatMessageReadCursorTableTableFilterComposer(super.$state);
  ColumnFilters<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatMessageReadCursorTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatMessageReadCursorTableTable> {
  $$ChatMessageReadCursorTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatOutboxMessageTableTableCreateCompanionBuilder
    = ChatOutboxMessageDataCompanion Function({
  required String idKey,
  Value<int?> chatId,
  Value<String?> participantId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
  Value<bool> viaSms,
  Value<String?> smsNumber,
  required String content,
  Value<int> sendAttempts,
  Value<int> rowid,
});
typedef $$ChatOutboxMessageTableTableUpdateCompanionBuilder
    = ChatOutboxMessageDataCompanion Function({
  Value<String> idKey,
  Value<int?> chatId,
  Value<String?> participantId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
  Value<bool> viaSms,
  Value<String?> smsNumber,
  Value<String> content,
  Value<int> sendAttempts,
  Value<int> rowid,
});

class $$ChatOutboxMessageTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageTableTable,
    ChatOutboxMessageData,
    $$ChatOutboxMessageTableTableFilterComposer,
    $$ChatOutboxMessageTableTableOrderingComposer,
    $$ChatOutboxMessageTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageTableTableTableManager(
      _$AppDatabase db, $ChatOutboxMessageTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatOutboxMessageTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatOutboxMessageTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> idKey = const Value.absent(),
            Value<int?> chatId = const Value.absent(),
            Value<String?> participantId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> sendAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatOutboxMessageDataCompanion(
            idKey: idKey,
            chatId: chatId,
            participantId: participantId,
            replyToId: replyToId,
            forwardFromId: forwardFromId,
            authorId: authorId,
            viaSms: viaSms,
            smsNumber: smsNumber,
            content: content,
            sendAttempts: sendAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String idKey,
            Value<int?> chatId = const Value.absent(),
            Value<String?> participantId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            required String content,
            Value<int> sendAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatOutboxMessageDataCompanion.insert(
            idKey: idKey,
            chatId: chatId,
            participantId: participantId,
            replyToId: replyToId,
            forwardFromId: forwardFromId,
            authorId: authorId,
            viaSms: viaSms,
            smsNumber: smsNumber,
            content: content,
            sendAttempts: sendAttempts,
            rowid: rowid,
          ),
        ));
}

class $$ChatOutboxMessageTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatOutboxMessageTableTable> {
  $$ChatOutboxMessageTableTableFilterComposer(super.$state);
  ColumnFilters<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get participantId => $state.composableBuilder(
      column: $state.table.participantId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get replyToId => $state.composableBuilder(
      column: $state.table.replyToId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get forwardFromId => $state.composableBuilder(
      column: $state.table.forwardFromId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get viaSms => $state.composableBuilder(
      column: $state.table.viaSms,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get smsNumber => $state.composableBuilder(
      column: $state.table.smsNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatOutboxMessageTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatOutboxMessageTableTable> {
  $$ChatOutboxMessageTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get participantId => $state.composableBuilder(
      column: $state.table.participantId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get replyToId => $state.composableBuilder(
      column: $state.table.replyToId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get forwardFromId => $state.composableBuilder(
      column: $state.table.forwardFromId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get viaSms => $state.composableBuilder(
      column: $state.table.viaSms,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get smsNumber => $state.composableBuilder(
      column: $state.table.smsNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatOutboxMessageEditTableTableCreateCompanionBuilder
    = ChatOutboxMessageEditDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int chatId,
  required String newContent,
  Value<int> sendAttempts,
});
typedef $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder
    = ChatOutboxMessageEditDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> chatId,
  Value<String> newContent,
  Value<int> sendAttempts,
});

class $$ChatOutboxMessageEditTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageEditTableTable,
    ChatOutboxMessageEditData,
    $$ChatOutboxMessageEditTableTableFilterComposer,
    $$ChatOutboxMessageEditTableTableOrderingComposer,
    $$ChatOutboxMessageEditTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageEditTableTableTableManager(
      _$AppDatabase db, $ChatOutboxMessageEditTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatOutboxMessageEditTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatOutboxMessageEditTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> newContent = const Value.absent(),
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageEditDataCompanion(
            id: id,
            idKey: idKey,
            chatId: chatId,
            newContent: newContent,
            sendAttempts: sendAttempts,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required int chatId,
            required String newContent,
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageEditDataCompanion.insert(
            id: id,
            idKey: idKey,
            chatId: chatId,
            newContent: newContent,
            sendAttempts: sendAttempts,
          ),
        ));
}

class $$ChatOutboxMessageEditTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatOutboxMessageEditTableTable> {
  $$ChatOutboxMessageEditTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get newContent => $state.composableBuilder(
      column: $state.table.newContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatOutboxMessageEditTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatOutboxMessageEditTableTable> {
  $$ChatOutboxMessageEditTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get newContent => $state.composableBuilder(
      column: $state.table.newContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatOutboxMessageDeleteTableTableCreateCompanionBuilder
    = ChatOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int chatId,
  Value<int> sendAttempts,
});
typedef $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder
    = ChatOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> chatId,
  Value<int> sendAttempts,
});

class $$ChatOutboxMessageDeleteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageDeleteTableTable,
    ChatOutboxMessageDeleteData,
    $$ChatOutboxMessageDeleteTableTableFilterComposer,
    $$ChatOutboxMessageDeleteTableTableOrderingComposer,
    $$ChatOutboxMessageDeleteTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageDeleteTableTableTableManager(
      _$AppDatabase db, $ChatOutboxMessageDeleteTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatOutboxMessageDeleteTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatOutboxMessageDeleteTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageDeleteDataCompanion(
            id: id,
            idKey: idKey,
            chatId: chatId,
            sendAttempts: sendAttempts,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required int chatId,
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageDeleteDataCompanion.insert(
            id: id,
            idKey: idKey,
            chatId: chatId,
            sendAttempts: sendAttempts,
          ),
        ));
}

class $$ChatOutboxMessageDeleteTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatOutboxMessageDeleteTableTable> {
  $$ChatOutboxMessageDeleteTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatOutboxMessageDeleteTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase,
        $ChatOutboxMessageDeleteTableTable> {
  $$ChatOutboxMessageDeleteTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatOutboxMessageViewsTableTableCreateCompanionBuilder
    = ChatOutboxMessageViewDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int chatId,
  Value<int> sendAttempts,
});
typedef $$ChatOutboxMessageViewsTableTableUpdateCompanionBuilder
    = ChatOutboxMessageViewDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> chatId,
  Value<int> sendAttempts,
});

class $$ChatOutboxMessageViewsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageViewsTableTable,
    ChatOutboxMessageViewData,
    $$ChatOutboxMessageViewsTableTableFilterComposer,
    $$ChatOutboxMessageViewsTableTableOrderingComposer,
    $$ChatOutboxMessageViewsTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageViewsTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageViewsTableTableTableManager(
      _$AppDatabase db, $ChatOutboxMessageViewsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatOutboxMessageViewsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatOutboxMessageViewsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageViewDataCompanion(
            id: id,
            idKey: idKey,
            chatId: chatId,
            sendAttempts: sendAttempts,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required int chatId,
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxMessageViewDataCompanion.insert(
            id: id,
            idKey: idKey,
            chatId: chatId,
            sendAttempts: sendAttempts,
          ),
        ));
}

class $$ChatOutboxMessageViewsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatOutboxMessageViewsTableTable> {
  $$ChatOutboxMessageViewsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatOutboxMessageViewsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatOutboxMessageViewsTableTable> {
  $$ChatOutboxMessageViewsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get idKey => $state.composableBuilder(
      column: $state.table.idKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ChatOutboxReadCursorsTableTableCreateCompanionBuilder
    = ChatOutboxReadCursorDataCompanion Function({
  Value<int> chatId,
  required int timestampUsec,
  Value<int> sendAttempts,
});
typedef $$ChatOutboxReadCursorsTableTableUpdateCompanionBuilder
    = ChatOutboxReadCursorDataCompanion Function({
  Value<int> chatId,
  Value<int> timestampUsec,
  Value<int> sendAttempts,
});

class $$ChatOutboxReadCursorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxReadCursorsTableTable,
    ChatOutboxReadCursorData,
    $$ChatOutboxReadCursorsTableTableFilterComposer,
    $$ChatOutboxReadCursorsTableTableOrderingComposer,
    $$ChatOutboxReadCursorsTableTableCreateCompanionBuilder,
    $$ChatOutboxReadCursorsTableTableUpdateCompanionBuilder> {
  $$ChatOutboxReadCursorsTableTableTableManager(
      _$AppDatabase db, $ChatOutboxReadCursorsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ChatOutboxReadCursorsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ChatOutboxReadCursorsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> chatId = const Value.absent(),
            Value<int> timestampUsec = const Value.absent(),
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxReadCursorDataCompanion(
            chatId: chatId,
            timestampUsec: timestampUsec,
            sendAttempts: sendAttempts,
          ),
          createCompanionCallback: ({
            Value<int> chatId = const Value.absent(),
            required int timestampUsec,
            Value<int> sendAttempts = const Value.absent(),
          }) =>
              ChatOutboxReadCursorDataCompanion.insert(
            chatId: chatId,
            timestampUsec: timestampUsec,
            sendAttempts: sendAttempts,
          ),
        ));
}

class $$ChatOutboxReadCursorsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ChatOutboxReadCursorsTableTable> {
  $$ChatOutboxReadCursorsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableFilterComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ChatOutboxReadCursorsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ChatOutboxReadCursorsTableTable> {
  $$ChatOutboxReadCursorsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get timestampUsec => $state.composableBuilder(
      column: $state.table.timestampUsec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sendAttempts => $state.composableBuilder(
      column: $state.table.sendAttempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.chatsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ChatsTableTableOrderingComposer(ComposerState($state.db,
                $state.db.chatsTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ContactsTableTableTableManager get contactsTable =>
      $$ContactsTableTableTableManager(_db, _db.contactsTable);
  $$ContactPhonesTableTableTableManager get contactPhonesTable =>
      $$ContactPhonesTableTableTableManager(_db, _db.contactPhonesTable);
  $$ContactEmailsTableTableTableManager get contactEmailsTable =>
      $$ContactEmailsTableTableTableManager(_db, _db.contactEmailsTable);
  $$CallLogsTableTableTableManager get callLogsTable =>
      $$CallLogsTableTableTableManager(_db, _db.callLogsTable);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$ChatsTableTableTableManager get chatsTable =>
      $$ChatsTableTableTableManager(_db, _db.chatsTable);
  $$ChatMembersTableTableTableManager get chatMembersTable =>
      $$ChatMembersTableTableTableManager(_db, _db.chatMembersTable);
  $$ChatMessagesTableTableTableManager get chatMessagesTable =>
      $$ChatMessagesTableTableTableManager(_db, _db.chatMessagesTable);
  $$ChatMessageSyncCursorTableTableTableManager
      get chatMessageSyncCursorTable =>
          $$ChatMessageSyncCursorTableTableTableManager(
              _db, _db.chatMessageSyncCursorTable);
  $$ChatMessageReadCursorTableTableTableManager
      get chatMessageReadCursorTable =>
          $$ChatMessageReadCursorTableTableTableManager(
              _db, _db.chatMessageReadCursorTable);
  $$ChatOutboxMessageTableTableTableManager get chatOutboxMessageTable =>
      $$ChatOutboxMessageTableTableTableManager(
          _db, _db.chatOutboxMessageTable);
  $$ChatOutboxMessageEditTableTableTableManager
      get chatOutboxMessageEditTable =>
          $$ChatOutboxMessageEditTableTableTableManager(
              _db, _db.chatOutboxMessageEditTable);
  $$ChatOutboxMessageDeleteTableTableTableManager
      get chatOutboxMessageDeleteTable =>
          $$ChatOutboxMessageDeleteTableTableTableManager(
              _db, _db.chatOutboxMessageDeleteTable);
  $$ChatOutboxMessageViewsTableTableTableManager
      get chatOutboxMessageViewsTable =>
          $$ChatOutboxMessageViewsTableTableTableManager(
              _db, _db.chatOutboxMessageViewsTable);
  $$ChatOutboxReadCursorsTableTableTableManager
      get chatOutboxReadCursorsTable =>
          $$ChatOutboxReadCursorsTableTableTableManager(
              _db, _db.chatOutboxReadCursorsTable);
}

mixin _$ContactsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
}
mixin _$ContactPhonesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
}
mixin _$ContactEmailsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactEmailsTableTable get contactEmailsTable =>
      attachedDatabase.contactEmailsTable;
}
mixin _$CallLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CallLogsTableTable get callLogsTable => attachedDatabase.callLogsTable;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
}
mixin _$FavoritesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
}
mixin _$ChatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ChatsTableTable get chatsTable => attachedDatabase.chatsTable;
  $ChatMembersTableTable get chatMembersTable =>
      attachedDatabase.chatMembersTable;
  $ChatMessagesTableTable get chatMessagesTable =>
      attachedDatabase.chatMessagesTable;
  $ChatMessageSyncCursorTableTable get chatMessageSyncCursorTable =>
      attachedDatabase.chatMessageSyncCursorTable;
  $ChatMessageReadCursorTableTable get chatMessageReadCursorTable =>
      attachedDatabase.chatMessageReadCursorTable;
  $ChatOutboxMessageTableTable get chatOutboxMessageTable =>
      attachedDatabase.chatOutboxMessageTable;
  $ChatOutboxMessageEditTableTable get chatOutboxMessageEditTable =>
      attachedDatabase.chatOutboxMessageEditTable;
  $ChatOutboxMessageDeleteTableTable get chatOutboxMessageDeleteTable =>
      attachedDatabase.chatOutboxMessageDeleteTable;
  $ChatOutboxMessageViewsTableTable get chatOutboxMessageViewsTable =>
      attachedDatabase.chatOutboxMessageViewsTable;
  $ChatOutboxReadCursorsTableTable get chatOutboxReadCursorsTable =>
      attachedDatabase.chatOutboxReadCursorsTable;
}
