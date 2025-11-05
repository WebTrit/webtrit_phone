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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContactSourceTypeEnum, int>
      sourceType = GeneratedColumn<int>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<ContactSourceTypeEnum>(
    $ContactsTableTable.$convertersourceType,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aliasNameMeta = const VerificationMeta(
    'aliasName',
  );
  @override
  late final GeneratedColumn<String> aliasName = GeneratedColumn<String>(
    'alias_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<Uint8List> thumbnail = GeneratedColumn<Uint8List>(
    'thumbnail',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _registeredMeta = const VerificationMeta(
    'registered',
  );
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
    'registered',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("registered" IN (0, 1))',
    ),
  );
  static const VerificationMeta _userRegisteredMeta = const VerificationMeta(
    'userRegistered',
  );
  @override
  late final GeneratedColumn<bool> userRegistered = GeneratedColumn<bool>(
    'user_registered',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("user_registered" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isCurrentUserMeta = const VerificationMeta(
    'isCurrentUser',
  );
  @override
  late final GeneratedColumn<bool> isCurrentUser = GeneratedColumn<bool>(
    'is_current_user',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current_user" IN (0, 1))',
    ),
  );
  static const VerificationMeta _insertedAtMeta = const VerificationMeta(
    'insertedAt',
  );
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
    'inserted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
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
        updatedAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('alias_name')) {
      context.handle(
        _aliasNameMeta,
        aliasName.isAcceptableOrUnknown(data['alias_name']!, _aliasNameMeta),
      );
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    }
    if (data.containsKey('registered')) {
      context.handle(
        _registeredMeta,
        registered.isAcceptableOrUnknown(data['registered']!, _registeredMeta),
      );
    }
    if (data.containsKey('user_registered')) {
      context.handle(
        _userRegisteredMeta,
        userRegistered.isAcceptableOrUnknown(
          data['user_registered']!,
          _userRegisteredMeta,
        ),
      );
    }
    if (data.containsKey('is_current_user')) {
      context.handle(
        _isCurrentUserMeta,
        isCurrentUser.isAcceptableOrUnknown(
          data['is_current_user']!,
          _isCurrentUserMeta,
        ),
      );
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
        _insertedAtMeta,
        insertedAt.isAcceptableOrUnknown(data['inserted_at']!, _insertedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceType: $ContactsTableTable.$convertersourceType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source_type'],
        )!,
      ),
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      aliasName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias_name'],
      ),
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}thumbnail'],
      ),
      registered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}registered'],
      ),
      userRegistered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}user_registered'],
      ),
      isCurrentUser: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current_user'],
      ),
      insertedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inserted_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ContactsTableTable createAlias(String alias) {
    return $ContactsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContactSourceTypeEnum, int, int>
      $convertersourceType = const EnumIndexConverter<ContactSourceTypeEnum>(
    ContactSourceTypeEnum.values,
  );
}

class ContactData extends DataClass implements Insertable<ContactData> {
  final int id;
  final ContactSourceTypeEnum sourceType;
  final String? sourceId;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final Uint8List? thumbnail;
  final bool? registered;
  final bool? userRegistered;
  final bool? isCurrentUser;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactData({
    required this.id,
    required this.sourceType,
    this.sourceId,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.thumbnail,
    this.registered,
    this.userRegistered,
    this.isCurrentUser,
    this.insertedAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['source_type'] = Variable<int>(
        $ContactsTableTable.$convertersourceType.toSql(sourceType),
      );
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
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
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
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

  factory ContactData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactData(
      id: serializer.fromJson<int>(json['id']),
      sourceType: $ContactsTableTable.$convertersourceType.fromJson(
        serializer.fromJson<int>(json['sourceType']),
      ),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
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
        $ContactsTableTable.$convertersourceType.toJson(sourceType),
      ),
      'sourceId': serializer.toJson<String?>(sourceId),
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

  ContactData copyWith({
    int? id,
    ContactSourceTypeEnum? sourceType,
    Value<String?> sourceId = const Value.absent(),
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
      ContactData(
        id: id ?? this.id,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
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
        updatedAt,
      );
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
  final Value<String?> sourceId;
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
  }) : sourceType = Value(sourceType);
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

  ContactDataCompanion copyWith({
    Value<int>? id,
    Value<ContactSourceTypeEnum>? sourceType,
    Value<String?>? sourceId,
    Value<String?>? firstName,
    Value<String?>? lastName,
    Value<String?>? aliasName,
    Value<Uint8List?>? thumbnail,
    Value<bool?>? registered,
    Value<bool?>? userRegistered,
    Value<bool?>? isCurrentUser,
    Value<DateTime?>? insertedAt,
    Value<DateTime?>? updatedAt,
  }) {
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
        $ContactsTableTable.$convertersourceType.toSql(sourceType.value),
      );
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES contacts(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _insertedAtMeta = const VerificationMeta(
    'insertedAt',
  );
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
    'inserted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        number,
        label,
        contactId,
        insertedAt,
        updatedAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_phones';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactPhoneData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
        _insertedAtMeta,
        insertedAt.isAcceptableOrUnknown(data['inserted_at']!, _insertedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactPhoneData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactPhoneData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contact_id'],
      )!,
      insertedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inserted_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
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
  const ContactPhoneData({
    required this.id,
    required this.number,
    required this.label,
    required this.contactId,
    this.insertedAt,
    this.updatedAt,
  });
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

  factory ContactPhoneData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ContactPhoneData copyWith({
    int? id,
    String? number,
    String? label,
    int? contactId,
    Value<DateTime?> insertedAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) =>
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

  ContactPhoneDataCompanion copyWith({
    Value<int>? id,
    Value<String>? number,
    Value<String>? label,
    Value<int>? contactId,
    Value<DateTime?>? insertedAt,
    Value<DateTime?>? updatedAt,
  }) {
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES contacts(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _insertedAtMeta = const VerificationMeta(
    'insertedAt',
  );
  @override
  late final GeneratedColumn<DateTime> insertedAt = GeneratedColumn<DateTime>(
    'inserted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        address,
        label,
        contactId,
        insertedAt,
        updatedAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_emails';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactEmailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('inserted_at')) {
      context.handle(
        _insertedAtMeta,
        insertedAt.isAcceptableOrUnknown(data['inserted_at']!, _insertedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactEmailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactEmailData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contact_id'],
      )!,
      insertedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inserted_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
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
  const ContactEmailData({
    required this.id,
    required this.address,
    required this.label,
    required this.contactId,
    this.insertedAt,
    this.updatedAt,
  });
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

  factory ContactEmailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ContactEmailData copyWith({
    int? id,
    String? address,
    String? label,
    int? contactId,
    Value<DateTime?> insertedAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) =>
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

  ContactEmailDataCompanion copyWith({
    Value<int>? id,
    Value<String>? address,
    Value<String>? label,
    Value<int>? contactId,
    Value<DateTime?>? insertedAt,
    Value<DateTime?>? updatedAt,
  }) {
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CallLogDirectionEnum, int>
      direction = GeneratedColumn<int>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<CallLogDirectionEnum>(
    $CallLogsTableTable.$converterdirection,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)',
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
    'video',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("video" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acceptedAtMeta = const VerificationMeta(
    'acceptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acceptedAt = GeneratedColumn<DateTime>(
    'accepted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hungUpAtMeta = const VerificationMeta(
    'hungUpAt',
  );
  @override
  late final GeneratedColumn<DateTime> hungUpAt = GeneratedColumn<DateTime>(
    'hung_up_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        direction,
        number,
        username,
        video,
        createdAt,
        acceptedAt,
        hungUpAt,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CallLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('video')) {
      context.handle(
        _videoMeta,
        video.isAcceptableOrUnknown(data['video']!, _videoMeta),
      );
    } else if (isInserting) {
      context.missing(_videoMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('accepted_at')) {
      context.handle(
        _acceptedAtMeta,
        acceptedAt.isAcceptableOrUnknown(data['accepted_at']!, _acceptedAtMeta),
      );
    }
    if (data.containsKey('hung_up_at')) {
      context.handle(
        _hungUpAtMeta,
        hungUpAt.isAcceptableOrUnknown(data['hung_up_at']!, _hungUpAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      direction: $CallLogsTableTable.$converterdirection.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}direction'],
        )!,
      ),
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      video: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}video'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      acceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accepted_at'],
      ),
      hungUpAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hung_up_at'],
      ),
    );
  }

  @override
  $CallLogsTableTable createAlias(String alias) {
    return $CallLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CallLogDirectionEnum, int, int>
      $converterdirection = const EnumIndexConverter<CallLogDirectionEnum>(
    CallLogDirectionEnum.values,
  );
}

class CallLogData extends DataClass implements Insertable<CallLogData> {
  final int id;
  final CallLogDirectionEnum direction;
  final String number;
  final String? username;
  final bool video;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? hungUpAt;
  const CallLogData({
    required this.id,
    required this.direction,
    required this.number,
    this.username,
    required this.video,
    required this.createdAt,
    this.acceptedAt,
    this.hungUpAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['direction'] = Variable<int>(
        $CallLogsTableTable.$converterdirection.toSql(direction),
      );
    }
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
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
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
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

  factory CallLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallLogData(
      id: serializer.fromJson<int>(json['id']),
      direction: $CallLogsTableTable.$converterdirection.fromJson(
        serializer.fromJson<int>(json['direction']),
      ),
      number: serializer.fromJson<String>(json['number']),
      username: serializer.fromJson<String?>(json['username']),
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
        $CallLogsTableTable.$converterdirection.toJson(direction),
      ),
      'number': serializer.toJson<String>(number),
      'username': serializer.toJson<String?>(username),
      'video': serializer.toJson<bool>(video),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'acceptedAt': serializer.toJson<DateTime?>(acceptedAt),
      'hungUpAt': serializer.toJson<DateTime?>(hungUpAt),
    };
  }

  CallLogData copyWith({
    int? id,
    CallLogDirectionEnum? direction,
    String? number,
    Value<String?> username = const Value.absent(),
    bool? video,
    DateTime? createdAt,
    Value<DateTime?> acceptedAt = const Value.absent(),
    Value<DateTime?> hungUpAt = const Value.absent(),
  }) =>
      CallLogData(
        id: id ?? this.id,
        direction: direction ?? this.direction,
        number: number ?? this.number,
        username: username.present ? username.value : this.username,
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
      username: data.username.present ? data.username.value : this.username,
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
          ..write('username: $username, ')
          ..write('video: $video, ')
          ..write('createdAt: $createdAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('hungUpAt: $hungUpAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        direction,
        number,
        username,
        video,
        createdAt,
        acceptedAt,
        hungUpAt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLogData &&
          other.id == this.id &&
          other.direction == this.direction &&
          other.number == this.number &&
          other.username == this.username &&
          other.video == this.video &&
          other.createdAt == this.createdAt &&
          other.acceptedAt == this.acceptedAt &&
          other.hungUpAt == this.hungUpAt);
}

class CallLogDataCompanion extends UpdateCompanion<CallLogData> {
  final Value<int> id;
  final Value<CallLogDirectionEnum> direction;
  final Value<String> number;
  final Value<String?> username;
  final Value<bool> video;
  final Value<DateTime> createdAt;
  final Value<DateTime?> acceptedAt;
  final Value<DateTime?> hungUpAt;
  const CallLogDataCompanion({
    this.id = const Value.absent(),
    this.direction = const Value.absent(),
    this.number = const Value.absent(),
    this.username = const Value.absent(),
    this.video = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.hungUpAt = const Value.absent(),
  });
  CallLogDataCompanion.insert({
    this.id = const Value.absent(),
    required CallLogDirectionEnum direction,
    required String number,
    this.username = const Value.absent(),
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
    Expression<String>? username,
    Expression<bool>? video,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? acceptedAt,
    Expression<DateTime>? hungUpAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (direction != null) 'direction': direction,
      if (number != null) 'number': number,
      if (username != null) 'username': username,
      if (video != null) 'video': video,
      if (createdAt != null) 'created_at': createdAt,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (hungUpAt != null) 'hung_up_at': hungUpAt,
    });
  }

  CallLogDataCompanion copyWith({
    Value<int>? id,
    Value<CallLogDirectionEnum>? direction,
    Value<String>? number,
    Value<String?>? username,
    Value<bool>? video,
    Value<DateTime>? createdAt,
    Value<DateTime?>? acceptedAt,
    Value<DateTime?>? hungUpAt,
  }) {
    return CallLogDataCompanion(
      id: id ?? this.id,
      direction: direction ?? this.direction,
      number: number ?? this.number,
      username: username ?? this.username,
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
        $CallLogsTableTable.$converterdirection.toSql(direction.value),
      );
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
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
          ..write('username: $username, ')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contactPhoneIdMeta = const VerificationMeta(
    'contactPhoneId',
  );
  @override
  late final GeneratedColumn<int> contactPhoneId = GeneratedColumn<int>(
    'contact_phone_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES contact_phones(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, contactPhoneId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('contact_phone_id')) {
      context.handle(
        _contactPhoneIdMeta,
        contactPhoneId.isAcceptableOrUnknown(
          data['contact_phone_id']!,
          _contactPhoneIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactPhoneIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
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
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contactPhoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contact_phone_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
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
  const FavoriteData({
    required this.id,
    required this.contactPhoneId,
    required this.position,
  });
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

  factory FavoriteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  FavoriteDataCompanion copyWith({
    Value<int>? id,
    Value<int>? contactPhoneId,
    Value<int>? position,
  }) {
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ChatTypeEnum, String> type =
      GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ChatTypeEnum>($ChatsTableTable.$convertertype);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtRemoteMeta = const VerificationMeta(
    'createdAtRemote',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtRemote =
      GeneratedColumn<DateTime>(
    'created_at_remote',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtRemoteMeta = const VerificationMeta(
    'updatedAtRemote',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtRemote =
      GeneratedColumn<DateTime>(
    'updated_at_remote',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        name,
        createdAtRemote,
        updatedAtRemote,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('created_at_remote')) {
      context.handle(
        _createdAtRemoteMeta,
        createdAtRemote.isAcceptableOrUnknown(
          data['created_at_remote']!,
          _createdAtRemoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtRemoteMeta);
    }
    if (data.containsKey('updated_at_remote')) {
      context.handle(
        _updatedAtRemoteMeta,
        updatedAtRemote.isAcceptableOrUnknown(
          data['updated_at_remote']!,
          _updatedAtRemoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtRemoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $ChatsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      createdAtRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_remote'],
      )!,
      updatedAtRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_remote'],
      )!,
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
  final DateTime createdAtRemote;
  final DateTime updatedAtRemote;
  const ChatData({
    required this.id,
    required this.type,
    this.name,
    required this.createdAtRemote,
    required this.updatedAtRemote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $ChatsTableTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['created_at_remote'] = Variable<DateTime>(createdAtRemote);
    map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote);
    return map;
  }

  ChatDataCompanion toCompanion(bool nullToAbsent) {
    return ChatDataCompanion(
      id: Value(id),
      type: Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAtRemote: Value(createdAtRemote),
      updatedAtRemote: Value(updatedAtRemote),
    );
  }

  factory ChatData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatData(
      id: serializer.fromJson<int>(json['id']),
      type: $ChatsTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      name: serializer.fromJson<String?>(json['name']),
      createdAtRemote: serializer.fromJson<DateTime>(json['createdAtRemote']),
      updatedAtRemote: serializer.fromJson<DateTime>(json['updatedAtRemote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $ChatsTableTable.$convertertype.toJson(type),
      ),
      'name': serializer.toJson<String?>(name),
      'createdAtRemote': serializer.toJson<DateTime>(createdAtRemote),
      'updatedAtRemote': serializer.toJson<DateTime>(updatedAtRemote),
    };
  }

  ChatData copyWith({
    int? id,
    ChatTypeEnum? type,
    Value<String?> name = const Value.absent(),
    DateTime? createdAtRemote,
    DateTime? updatedAtRemote,
  }) =>
      ChatData(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name.present ? name.value : this.name,
        createdAtRemote: createdAtRemote ?? this.createdAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
      );
  ChatData copyWithCompanion(ChatDataCompanion data) {
    return ChatData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      createdAtRemote: data.createdAtRemote.present
          ? data.createdAtRemote.value
          : this.createdAtRemote,
      updatedAtRemote: data.updatedAtRemote.present
          ? data.updatedAtRemote.value
          : this.updatedAtRemote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, name, createdAtRemote, updatedAtRemote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatData &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.createdAtRemote == this.createdAtRemote &&
          other.updatedAtRemote == this.updatedAtRemote);
}

class ChatDataCompanion extends UpdateCompanion<ChatData> {
  final Value<int> id;
  final Value<ChatTypeEnum> type;
  final Value<String?> name;
  final Value<DateTime> createdAtRemote;
  final Value<DateTime> updatedAtRemote;
  const ChatDataCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAtRemote = const Value.absent(),
    this.updatedAtRemote = const Value.absent(),
  });
  ChatDataCompanion.insert({
    this.id = const Value.absent(),
    required ChatTypeEnum type,
    this.name = const Value.absent(),
    required DateTime createdAtRemote,
    required DateTime updatedAtRemote,
  })  : type = Value(type),
        createdAtRemote = Value(createdAtRemote),
        updatedAtRemote = Value(updatedAtRemote);
  static Insertable<ChatData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<DateTime>? createdAtRemote,
    Expression<DateTime>? updatedAtRemote,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (createdAtRemote != null) 'created_at_remote': createdAtRemote,
      if (updatedAtRemote != null) 'updated_at_remote': updatedAtRemote,
    });
  }

  ChatDataCompanion copyWith({
    Value<int>? id,
    Value<ChatTypeEnum>? type,
    Value<String?>? name,
    Value<DateTime>? createdAtRemote,
    Value<DateTime>? updatedAtRemote,
  }) {
    return ChatDataCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      createdAtRemote: createdAtRemote ?? this.createdAtRemote,
      updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ChatsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAtRemote.present) {
      map['created_at_remote'] = Variable<DateTime>(createdAtRemote.value);
    }
    if (updatedAtRemote.present) {
      map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatDataCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GroupAuthoritiesEnum?, String>
      groupAuthorities = GeneratedColumn<String>(
    'group_authorities',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<GroupAuthoritiesEnum?>(
    $ChatMembersTableTable.$convertergroupAuthoritiesn,
  );
  @override
  List<GeneratedColumn> get $columns => [id, chatId, userId, groupAuthorities];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMemberData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMemberData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMemberData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      groupAuthorities:
          $ChatMembersTableTable.$convertergroupAuthoritiesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}group_authorities'],
        ),
      ),
    );
  }

  @override
  $ChatMembersTableTable createAlias(String alias) {
    return $ChatMembersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GroupAuthoritiesEnum, String, String>
      $convertergroupAuthorities =
      const EnumNameConverter<GroupAuthoritiesEnum>(
    GroupAuthoritiesEnum.values,
  );
  static JsonTypeConverter2<GroupAuthoritiesEnum?, String?, String?>
      $convertergroupAuthoritiesn = JsonTypeConverter2.asNullable(
    $convertergroupAuthorities,
  );
}

class ChatMemberData extends DataClass implements Insertable<ChatMemberData> {
  final int id;
  final int chatId;
  final String userId;
  final GroupAuthoritiesEnum? groupAuthorities;
  const ChatMemberData({
    required this.id,
    required this.chatId,
    required this.userId,
    this.groupAuthorities,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || groupAuthorities != null) {
      map['group_authorities'] = Variable<String>(
        $ChatMembersTableTable.$convertergroupAuthoritiesn.toSql(
          groupAuthorities,
        ),
      );
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
    );
  }

  factory ChatMemberData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMemberData(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      userId: serializer.fromJson<String>(json['userId']),
      groupAuthorities: $ChatMembersTableTable.$convertergroupAuthoritiesn
          .fromJson(serializer.fromJson<String?>(json['groupAuthorities'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'userId': serializer.toJson<String>(userId),
      'groupAuthorities': serializer.toJson<String?>(
        $ChatMembersTableTable.$convertergroupAuthoritiesn.toJson(
          groupAuthorities,
        ),
      ),
    };
  }

  ChatMemberData copyWith({
    int? id,
    int? chatId,
    String? userId,
    Value<GroupAuthoritiesEnum?> groupAuthorities = const Value.absent(),
  }) =>
      ChatMemberData(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        groupAuthorities: groupAuthorities.present
            ? groupAuthorities.value
            : this.groupAuthorities,
      );
  ChatMemberData copyWithCompanion(ChatMemberDataCompanion data) {
    return ChatMemberData(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      userId: data.userId.present ? data.userId.value : this.userId,
      groupAuthorities: data.groupAuthorities.present
          ? data.groupAuthorities.value
          : this.groupAuthorities,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMemberData(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('groupAuthorities: $groupAuthorities')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chatId, userId, groupAuthorities);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMemberData &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.userId == this.userId &&
          other.groupAuthorities == this.groupAuthorities);
}

class ChatMemberDataCompanion extends UpdateCompanion<ChatMemberData> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> userId;
  final Value<GroupAuthoritiesEnum?> groupAuthorities;
  const ChatMemberDataCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.groupAuthorities = const Value.absent(),
  });
  ChatMemberDataCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String userId,
    this.groupAuthorities = const Value.absent(),
  })  : chatId = Value(chatId),
        userId = Value(userId);
  static Insertable<ChatMemberData> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? userId,
    Expression<String>? groupAuthorities,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (userId != null) 'user_id': userId,
      if (groupAuthorities != null) 'group_authorities': groupAuthorities,
    });
  }

  ChatMemberDataCompanion copyWith({
    Value<int>? id,
    Value<int>? chatId,
    Value<String>? userId,
    Value<GroupAuthoritiesEnum?>? groupAuthorities,
  }) {
    return ChatMemberDataCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      groupAuthorities: groupAuthorities ?? this.groupAuthorities,
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
      map['group_authorities'] = Variable<String>(
        $ChatMembersTableTable.$convertergroupAuthoritiesn.toSql(
          groupAuthorities.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMemberDataCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('groupAuthorities: $groupAuthorities')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _replyToIdMeta = const VerificationMeta(
    'replyToId',
  );
  @override
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
    'reply_to_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forwardFromIdMeta = const VerificationMeta(
    'forwardFromId',
  );
  @override
  late final GeneratedColumn<int> forwardFromId = GeneratedColumn<int>(
    'forward_from_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtRemoteUsecMeta =
      const VerificationMeta('createdAtRemoteUsec');
  @override
  late final GeneratedColumn<int> createdAtRemoteUsec = GeneratedColumn<int>(
    'created_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtRemoteUsecMeta =
      const VerificationMeta('updatedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> updatedAtRemoteUsec = GeneratedColumn<int>(
    'updated_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _editedAtRemoteUsecMeta =
      const VerificationMeta('editedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> editedAtRemoteUsec = GeneratedColumn<int>(
    'edited_at_remote_usec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtRemoteUsecMeta =
      const VerificationMeta('deletedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> deletedAtRemoteUsec = GeneratedColumn<int>(
    'deleted_at_remote_usec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idKey,
        senderId,
        chatId,
        replyToId,
        forwardFromId,
        authorId,
        content,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
        editedAtRemoteUsec,
        deletedAtRemoteUsec,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
        _replyToIdMeta,
        replyToId.isAcceptableOrUnknown(data['reply_to_id']!, _replyToIdMeta),
      );
    }
    if (data.containsKey('forward_from_id')) {
      context.handle(
        _forwardFromIdMeta,
        forwardFromId.isAcceptableOrUnknown(
          data['forward_from_id']!,
          _forwardFromIdMeta,
        ),
      );
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at_remote_usec')) {
      context.handle(
        _createdAtRemoteUsecMeta,
        createdAtRemoteUsec.isAcceptableOrUnknown(
          data['created_at_remote_usec']!,
          _createdAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtRemoteUsecMeta);
    }
    if (data.containsKey('updated_at_remote_usec')) {
      context.handle(
        _updatedAtRemoteUsecMeta,
        updatedAtRemoteUsec.isAcceptableOrUnknown(
          data['updated_at_remote_usec']!,
          _updatedAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtRemoteUsecMeta);
    }
    if (data.containsKey('edited_at_remote_usec')) {
      context.handle(
        _editedAtRemoteUsecMeta,
        editedAtRemoteUsec.isAcceptableOrUnknown(
          data['edited_at_remote_usec']!,
          _editedAtRemoteUsecMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at_remote_usec')) {
      context.handle(
        _deletedAtRemoteUsecMeta,
        deletedAtRemoteUsec.isAcceptableOrUnknown(
          data['deleted_at_remote_usec']!,
          _deletedAtRemoteUsecMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      replyToId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reply_to_id'],
      ),
      forwardFromId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}forward_from_id'],
      ),
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_remote_usec'],
      )!,
      updatedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_remote_usec'],
      )!,
      editedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edited_at_remote_usec'],
      ),
      deletedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_remote_usec'],
      ),
    );
  }

  @override
  $ChatMessagesTableTable createAlias(String alias) {
    return $ChatMessagesTableTable(attachedDatabase, alias);
  }
}

class ChatMessageData extends DataClass implements Insertable<ChatMessageData> {
  final int id;
  final String idKey;
  final String senderId;
  final int chatId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final String content;
  final int createdAtRemoteUsec;
  final int updatedAtRemoteUsec;
  final int? editedAtRemoteUsec;
  final int? deletedAtRemoteUsec;
  const ChatMessageData({
    required this.id,
    required this.idKey,
    required this.senderId,
    required this.chatId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    required this.content,
    required this.createdAtRemoteUsec,
    required this.updatedAtRemoteUsec,
    this.editedAtRemoteUsec,
    this.deletedAtRemoteUsec,
  });
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
    map['content'] = Variable<String>(content);
    map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec);
    map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec);
    if (!nullToAbsent || editedAtRemoteUsec != null) {
      map['edited_at_remote_usec'] = Variable<int>(editedAtRemoteUsec);
    }
    if (!nullToAbsent || deletedAtRemoteUsec != null) {
      map['deleted_at_remote_usec'] = Variable<int>(deletedAtRemoteUsec);
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
      content: Value(content),
      createdAtRemoteUsec: Value(createdAtRemoteUsec),
      updatedAtRemoteUsec: Value(updatedAtRemoteUsec),
      editedAtRemoteUsec: editedAtRemoteUsec == null && nullToAbsent
          ? const Value.absent()
          : Value(editedAtRemoteUsec),
      deletedAtRemoteUsec: deletedAtRemoteUsec == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtRemoteUsec),
    );
  }

  factory ChatMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      senderId: serializer.fromJson<String>(json['senderId']),
      chatId: serializer.fromJson<int>(json['chatId']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
      forwardFromId: serializer.fromJson<int?>(json['forwardFromId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      content: serializer.fromJson<String>(json['content']),
      createdAtRemoteUsec: serializer.fromJson<int>(
        json['createdAtRemoteUsec'],
      ),
      updatedAtRemoteUsec: serializer.fromJson<int>(
        json['updatedAtRemoteUsec'],
      ),
      editedAtRemoteUsec: serializer.fromJson<int?>(json['editedAtRemoteUsec']),
      deletedAtRemoteUsec: serializer.fromJson<int?>(
        json['deletedAtRemoteUsec'],
      ),
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
      'content': serializer.toJson<String>(content),
      'createdAtRemoteUsec': serializer.toJson<int>(createdAtRemoteUsec),
      'updatedAtRemoteUsec': serializer.toJson<int>(updatedAtRemoteUsec),
      'editedAtRemoteUsec': serializer.toJson<int?>(editedAtRemoteUsec),
      'deletedAtRemoteUsec': serializer.toJson<int?>(deletedAtRemoteUsec),
    };
  }

  ChatMessageData copyWith({
    int? id,
    String? idKey,
    String? senderId,
    int? chatId,
    Value<int?> replyToId = const Value.absent(),
    Value<int?> forwardFromId = const Value.absent(),
    Value<String?> authorId = const Value.absent(),
    String? content,
    int? createdAtRemoteUsec,
    int? updatedAtRemoteUsec,
    Value<int?> editedAtRemoteUsec = const Value.absent(),
    Value<int?> deletedAtRemoteUsec = const Value.absent(),
  }) =>
      ChatMessageData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        senderId: senderId ?? this.senderId,
        chatId: chatId ?? this.chatId,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
        forwardFromId:
            forwardFromId.present ? forwardFromId.value : this.forwardFromId,
        authorId: authorId.present ? authorId.value : this.authorId,
        content: content ?? this.content,
        createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
        updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
        editedAtRemoteUsec: editedAtRemoteUsec.present
            ? editedAtRemoteUsec.value
            : this.editedAtRemoteUsec,
        deletedAtRemoteUsec: deletedAtRemoteUsec.present
            ? deletedAtRemoteUsec.value
            : this.deletedAtRemoteUsec,
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
      content: data.content.present ? data.content.value : this.content,
      createdAtRemoteUsec: data.createdAtRemoteUsec.present
          ? data.createdAtRemoteUsec.value
          : this.createdAtRemoteUsec,
      updatedAtRemoteUsec: data.updatedAtRemoteUsec.present
          ? data.updatedAtRemoteUsec.value
          : this.updatedAtRemoteUsec,
      editedAtRemoteUsec: data.editedAtRemoteUsec.present
          ? data.editedAtRemoteUsec.value
          : this.editedAtRemoteUsec,
      deletedAtRemoteUsec: data.deletedAtRemoteUsec.present
          ? data.deletedAtRemoteUsec.value
          : this.deletedAtRemoteUsec,
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
          ..write('content: $content, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec, ')
          ..write('editedAtRemoteUsec: $editedAtRemoteUsec, ')
          ..write('deletedAtRemoteUsec: $deletedAtRemoteUsec')
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
        content,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
        editedAtRemoteUsec,
        deletedAtRemoteUsec,
      );
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
          other.content == this.content &&
          other.createdAtRemoteUsec == this.createdAtRemoteUsec &&
          other.updatedAtRemoteUsec == this.updatedAtRemoteUsec &&
          other.editedAtRemoteUsec == this.editedAtRemoteUsec &&
          other.deletedAtRemoteUsec == this.deletedAtRemoteUsec);
}

class ChatMessageDataCompanion extends UpdateCompanion<ChatMessageData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<String> senderId;
  final Value<int> chatId;
  final Value<int?> replyToId;
  final Value<int?> forwardFromId;
  final Value<String?> authorId;
  final Value<String> content;
  final Value<int> createdAtRemoteUsec;
  final Value<int> updatedAtRemoteUsec;
  final Value<int?> editedAtRemoteUsec;
  final Value<int?> deletedAtRemoteUsec;
  const ChatMessageDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.senderId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAtRemoteUsec = const Value.absent(),
    this.updatedAtRemoteUsec = const Value.absent(),
    this.editedAtRemoteUsec = const Value.absent(),
    this.deletedAtRemoteUsec = const Value.absent(),
  });
  ChatMessageDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required String senderId,
    required int chatId,
    this.replyToId = const Value.absent(),
    this.forwardFromId = const Value.absent(),
    this.authorId = const Value.absent(),
    required String content,
    required int createdAtRemoteUsec,
    required int updatedAtRemoteUsec,
    this.editedAtRemoteUsec = const Value.absent(),
    this.deletedAtRemoteUsec = const Value.absent(),
  })  : idKey = Value(idKey),
        senderId = Value(senderId),
        chatId = Value(chatId),
        content = Value(content),
        createdAtRemoteUsec = Value(createdAtRemoteUsec),
        updatedAtRemoteUsec = Value(updatedAtRemoteUsec);
  static Insertable<ChatMessageData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<String>? senderId,
    Expression<int>? chatId,
    Expression<int>? replyToId,
    Expression<int>? forwardFromId,
    Expression<String>? authorId,
    Expression<String>? content,
    Expression<int>? createdAtRemoteUsec,
    Expression<int>? updatedAtRemoteUsec,
    Expression<int>? editedAtRemoteUsec,
    Expression<int>? deletedAtRemoteUsec,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (senderId != null) 'sender_id': senderId,
      if (chatId != null) 'chat_id': chatId,
      if (replyToId != null) 'reply_to_id': replyToId,
      if (forwardFromId != null) 'forward_from_id': forwardFromId,
      if (authorId != null) 'author_id': authorId,
      if (content != null) 'content': content,
      if (createdAtRemoteUsec != null)
        'created_at_remote_usec': createdAtRemoteUsec,
      if (updatedAtRemoteUsec != null)
        'updated_at_remote_usec': updatedAtRemoteUsec,
      if (editedAtRemoteUsec != null)
        'edited_at_remote_usec': editedAtRemoteUsec,
      if (deletedAtRemoteUsec != null)
        'deleted_at_remote_usec': deletedAtRemoteUsec,
    });
  }

  ChatMessageDataCompanion copyWith({
    Value<int>? id,
    Value<String>? idKey,
    Value<String>? senderId,
    Value<int>? chatId,
    Value<int?>? replyToId,
    Value<int?>? forwardFromId,
    Value<String?>? authorId,
    Value<String>? content,
    Value<int>? createdAtRemoteUsec,
    Value<int>? updatedAtRemoteUsec,
    Value<int?>? editedAtRemoteUsec,
    Value<int?>? deletedAtRemoteUsec,
  }) {
    return ChatMessageDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      senderId: senderId ?? this.senderId,
      chatId: chatId ?? this.chatId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
      updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
      editedAtRemoteUsec: editedAtRemoteUsec ?? this.editedAtRemoteUsec,
      deletedAtRemoteUsec: deletedAtRemoteUsec ?? this.deletedAtRemoteUsec,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAtRemoteUsec.present) {
      map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec.value);
    }
    if (updatedAtRemoteUsec.present) {
      map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec.value);
    }
    if (editedAtRemoteUsec.present) {
      map['edited_at_remote_usec'] = Variable<int>(editedAtRemoteUsec.value);
    }
    if (deletedAtRemoteUsec.present) {
      map['deleted_at_remote_usec'] = Variable<int>(deletedAtRemoteUsec.value);
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
          ..write('content: $content, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec, ')
          ..write('editedAtRemoteUsec: $editedAtRemoteUsec, ')
          ..write('deletedAtRemoteUsec: $deletedAtRemoteUsec')
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
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageSyncCursorTypeEnum, String>
      cursorType = GeneratedColumn<String>(
    'cursor_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MessageSyncCursorTypeEnum>(
    $ChatMessageSyncCursorTableTable.$convertercursorType,
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [chatId, cursorType, timestampUsec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_message_sync_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageSyncCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId, cursorType};
  @override
  ChatMessageSyncCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageSyncCursorData(
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      cursorType: $ChatMessageSyncCursorTableTable.$convertercursorType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cursor_type'],
        )!,
      ),
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
    );
  }

  @override
  $ChatMessageSyncCursorTableTable createAlias(String alias) {
    return $ChatMessageSyncCursorTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MessageSyncCursorTypeEnum, String, String>
      $convertercursorType = const EnumNameConverter<MessageSyncCursorTypeEnum>(
    MessageSyncCursorTypeEnum.values,
  );
}

class ChatMessageSyncCursorData extends DataClass
    implements Insertable<ChatMessageSyncCursorData> {
  final int chatId;
  final MessageSyncCursorTypeEnum cursorType;
  final int timestampUsec;
  const ChatMessageSyncCursorData({
    required this.chatId,
    required this.cursorType,
    required this.timestampUsec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    {
      map['cursor_type'] = Variable<String>(
        $ChatMessageSyncCursorTableTable.$convertercursorType.toSql(cursorType),
      );
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

  factory ChatMessageSyncCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
      'cursorType': serializer.toJson<String>(
        $ChatMessageSyncCursorTableTable.$convertercursorType.toJson(
          cursorType,
        ),
      ),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
    };
  }

  ChatMessageSyncCursorData copyWith({
    int? chatId,
    MessageSyncCursorTypeEnum? cursorType,
    int? timestampUsec,
  }) =>
      ChatMessageSyncCursorData(
        chatId: chatId ?? this.chatId,
        cursorType: cursorType ?? this.cursorType,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  ChatMessageSyncCursorData copyWithCompanion(
    ChatMessageSyncCursorDataCompanion data,
  ) {
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

  ChatMessageSyncCursorDataCompanion copyWith({
    Value<int>? chatId,
    Value<MessageSyncCursorTypeEnum>? cursorType,
    Value<int>? timestampUsec,
    Value<int>? rowid,
  }) {
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
      map['cursor_type'] = Variable<String>(
        $ChatMessageSyncCursorTableTable.$convertercursorType.toSql(
          cursorType.value,
        ),
      );
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
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [chatId, userId, timestampUsec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_message_read_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageReadCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId, userId};
  @override
  ChatMessageReadCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageReadCursorData(
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
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
  const ChatMessageReadCursorData({
    required this.chatId,
    required this.userId,
    required this.timestampUsec,
  });
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

  factory ChatMessageReadCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ChatMessageReadCursorData copyWith({
    int? chatId,
    String? userId,
    int? timestampUsec,
  }) =>
      ChatMessageReadCursorData(
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  ChatMessageReadCursorData copyWithCompanion(
    ChatMessageReadCursorDataCompanion data,
  ) {
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

  ChatMessageReadCursorDataCompanion copyWith({
    Value<int>? chatId,
    Value<String>? userId,
    Value<int>? timestampUsec,
    Value<int>? rowid,
  }) {
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
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _participantIdMeta = const VerificationMeta(
    'participantId',
  );
  @override
  late final GeneratedColumn<String> participantId = GeneratedColumn<String>(
    'participant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyToIdMeta = const VerificationMeta(
    'replyToId',
  );
  @override
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
    'reply_to_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forwardFromIdMeta = const VerificationMeta(
    'forwardFromId',
  );
  @override
  late final GeneratedColumn<int> forwardFromId = GeneratedColumn<int>(
    'forward_from_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        idKey,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        content,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatOutboxMessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    }
    if (data.containsKey('participant_id')) {
      context.handle(
        _participantIdMeta,
        participantId.isAcceptableOrUnknown(
          data['participant_id']!,
          _participantIdMeta,
        ),
      );
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
        _replyToIdMeta,
        replyToId.isAcceptableOrUnknown(data['reply_to_id']!, _replyToIdMeta),
      );
    }
    if (data.containsKey('forward_from_id')) {
      context.handle(
        _forwardFromIdMeta,
        forwardFromId.isAcceptableOrUnknown(
          data['forward_from_id']!,
          _forwardFromIdMeta,
        ),
      );
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idKey};
  @override
  ChatOutboxMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageData(
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      ),
      participantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participant_id'],
      ),
      replyToId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reply_to_id'],
      ),
      forwardFromId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}forward_from_id'],
      ),
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
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
  final String content;
  final int sendAttempts;
  const ChatOutboxMessageData({
    required this.idKey,
    this.chatId,
    this.participantId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    required this.content,
    required this.sendAttempts,
  });
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
      content: Value(content),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory ChatOutboxMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageData(
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int?>(json['chatId']),
      participantId: serializer.fromJson<String?>(json['participantId']),
      replyToId: serializer.fromJson<int?>(json['replyToId']),
      forwardFromId: serializer.fromJson<int?>(json['forwardFromId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
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
      'content': serializer.toJson<String>(content),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  ChatOutboxMessageData copyWith({
    String? idKey,
    Value<int?> chatId = const Value.absent(),
    Value<String?> participantId = const Value.absent(),
    Value<int?> replyToId = const Value.absent(),
    Value<int?> forwardFromId = const Value.absent(),
    Value<String?> authorId = const Value.absent(),
    String? content,
    int? sendAttempts,
  }) =>
      ChatOutboxMessageData(
        idKey: idKey ?? this.idKey,
        chatId: chatId.present ? chatId.value : this.chatId,
        participantId:
            participantId.present ? participantId.value : this.participantId,
        replyToId: replyToId.present ? replyToId.value : this.replyToId,
        forwardFromId:
            forwardFromId.present ? forwardFromId.value : this.forwardFromId,
        authorId: authorId.present ? authorId.value : this.authorId,
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
          ..write('content: $content, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        idKey,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        content,
        sendAttempts,
      );
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
      if (content != null) 'content': content,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatOutboxMessageDataCompanion copyWith({
    Value<String>? idKey,
    Value<int?>? chatId,
    Value<String?>? participantId,
    Value<int?>? replyToId,
    Value<int?>? forwardFromId,
    Value<String?>? authorId,
    Value<String>? content,
    Value<int>? sendAttempts,
    Value<int>? rowid,
  }) {
    return ChatOutboxMessageDataCompanion(
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _newContentMeta = const VerificationMeta(
    'newContent',
  );
  @override
  late final GeneratedColumn<String> newContent = GeneratedColumn<String>(
    'new_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idKey,
        chatId,
        newContent,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_message_edits';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatOutboxMessageEditData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('new_content')) {
      context.handle(
        _newContentMeta,
        newContent.isAcceptableOrUnknown(data['new_content']!, _newContentMeta),
      );
    } else if (isInserting) {
      context.missing(_newContentMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatOutboxMessageEditData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageEditData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      newContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_content'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
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
  const ChatOutboxMessageEditData({
    required this.id,
    required this.idKey,
    required this.chatId,
    required this.newContent,
    required this.sendAttempts,
  });
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

  factory ChatOutboxMessageEditData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ChatOutboxMessageEditData copyWith({
    int? id,
    String? idKey,
    int? chatId,
    String? newContent,
    int? sendAttempts,
  }) =>
      ChatOutboxMessageEditData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        newContent: newContent ?? this.newContent,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageEditData copyWithCompanion(
    ChatOutboxMessageEditDataCompanion data,
  ) {
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

  ChatOutboxMessageEditDataCompanion copyWith({
    Value<int>? id,
    Value<String>? idKey,
    Value<int>? chatId,
    Value<String>? newContent,
    Value<int>? sendAttempts,
  }) {
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, idKey, chatId, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_message_deletes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatOutboxMessageDeleteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatOutboxMessageDeleteData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxMessageDeleteData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
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
  const ChatOutboxMessageDeleteData({
    required this.id,
    required this.idKey,
    required this.chatId,
    required this.sendAttempts,
  });
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

  factory ChatOutboxMessageDeleteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ChatOutboxMessageDeleteData copyWith({
    int? id,
    String? idKey,
    int? chatId,
    int? sendAttempts,
  }) =>
      ChatOutboxMessageDeleteData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxMessageDeleteData copyWithCompanion(
    ChatOutboxMessageDeleteDataCompanion data,
  ) {
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

  ChatOutboxMessageDeleteDataCompanion copyWith({
    Value<int>? id,
    Value<String>? idKey,
    Value<int>? chatId,
    Value<int>? sendAttempts,
  }) {
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

class $ChatOutboxReadCursorsTableTable extends ChatOutboxReadCursorsTable
    with TableInfo<$ChatOutboxReadCursorsTableTable, ChatOutboxReadCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatOutboxReadCursorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [chatId, timestampUsec, sendAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_outbox_read_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatOutboxReadCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId};
  @override
  ChatOutboxReadCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatOutboxReadCursorData(
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
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
  const ChatOutboxReadCursorData({
    required this.chatId,
    required this.timestampUsec,
    required this.sendAttempts,
  });
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

  factory ChatOutboxReadCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ChatOutboxReadCursorData copyWith({
    int? chatId,
    int? timestampUsec,
    int? sendAttempts,
  }) =>
      ChatOutboxReadCursorData(
        chatId: chatId ?? this.chatId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  ChatOutboxReadCursorData copyWithCompanion(
    ChatOutboxReadCursorDataCompanion data,
  ) {
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

  ChatOutboxReadCursorDataCompanion copyWith({
    Value<int>? chatId,
    Value<int>? timestampUsec,
    Value<int>? sendAttempts,
  }) {
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

class $SmsConversationsTableTable extends SmsConversationsTable
    with TableInfo<$SmsConversationsTableTable, SmsConversationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsConversationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstPhoneNumberMeta = const VerificationMeta(
    'firstPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> firstPhoneNumber = GeneratedColumn<String>(
    'first_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondPhoneNumberMeta = const VerificationMeta(
    'secondPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> secondPhoneNumber =
      GeneratedColumn<String>(
    'second_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtRemoteMeta = const VerificationMeta(
    'createdAtRemote',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtRemote =
      GeneratedColumn<DateTime>(
    'created_at_remote',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtRemoteMeta = const VerificationMeta(
    'updatedAtRemote',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtRemote =
      GeneratedColumn<DateTime>(
    'updated_at_remote',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstPhoneNumber,
        secondPhoneNumber,
        createdAtRemote,
        updatedAtRemote,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsConversationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_phone_number')) {
      context.handle(
        _firstPhoneNumberMeta,
        firstPhoneNumber.isAcceptableOrUnknown(
          data['first_phone_number']!,
          _firstPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstPhoneNumberMeta);
    }
    if (data.containsKey('second_phone_number')) {
      context.handle(
        _secondPhoneNumberMeta,
        secondPhoneNumber.isAcceptableOrUnknown(
          data['second_phone_number']!,
          _secondPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_secondPhoneNumberMeta);
    }
    if (data.containsKey('created_at_remote')) {
      context.handle(
        _createdAtRemoteMeta,
        createdAtRemote.isAcceptableOrUnknown(
          data['created_at_remote']!,
          _createdAtRemoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtRemoteMeta);
    }
    if (data.containsKey('updated_at_remote')) {
      context.handle(
        _updatedAtRemoteMeta,
        updatedAtRemote.isAcceptableOrUnknown(
          data['updated_at_remote']!,
          _updatedAtRemoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtRemoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsConversationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsConversationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_phone_number'],
      )!,
      secondPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}second_phone_number'],
      )!,
      createdAtRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_remote'],
      )!,
      updatedAtRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_remote'],
      )!,
    );
  }

  @override
  $SmsConversationsTableTable createAlias(String alias) {
    return $SmsConversationsTableTable(attachedDatabase, alias);
  }
}

class SmsConversationData extends DataClass
    implements Insertable<SmsConversationData> {
  final int id;
  final String firstPhoneNumber;
  final String secondPhoneNumber;
  final DateTime createdAtRemote;
  final DateTime updatedAtRemote;
  const SmsConversationData({
    required this.id,
    required this.firstPhoneNumber,
    required this.secondPhoneNumber,
    required this.createdAtRemote,
    required this.updatedAtRemote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_phone_number'] = Variable<String>(firstPhoneNumber);
    map['second_phone_number'] = Variable<String>(secondPhoneNumber);
    map['created_at_remote'] = Variable<DateTime>(createdAtRemote);
    map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote);
    return map;
  }

  SmsConversationDataCompanion toCompanion(bool nullToAbsent) {
    return SmsConversationDataCompanion(
      id: Value(id),
      firstPhoneNumber: Value(firstPhoneNumber),
      secondPhoneNumber: Value(secondPhoneNumber),
      createdAtRemote: Value(createdAtRemote),
      updatedAtRemote: Value(updatedAtRemote),
    );
  }

  factory SmsConversationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsConversationData(
      id: serializer.fromJson<int>(json['id']),
      firstPhoneNumber: serializer.fromJson<String>(json['firstPhoneNumber']),
      secondPhoneNumber: serializer.fromJson<String>(json['secondPhoneNumber']),
      createdAtRemote: serializer.fromJson<DateTime>(json['createdAtRemote']),
      updatedAtRemote: serializer.fromJson<DateTime>(json['updatedAtRemote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstPhoneNumber': serializer.toJson<String>(firstPhoneNumber),
      'secondPhoneNumber': serializer.toJson<String>(secondPhoneNumber),
      'createdAtRemote': serializer.toJson<DateTime>(createdAtRemote),
      'updatedAtRemote': serializer.toJson<DateTime>(updatedAtRemote),
    };
  }

  SmsConversationData copyWith({
    int? id,
    String? firstPhoneNumber,
    String? secondPhoneNumber,
    DateTime? createdAtRemote,
    DateTime? updatedAtRemote,
  }) =>
      SmsConversationData(
        id: id ?? this.id,
        firstPhoneNumber: firstPhoneNumber ?? this.firstPhoneNumber,
        secondPhoneNumber: secondPhoneNumber ?? this.secondPhoneNumber,
        createdAtRemote: createdAtRemote ?? this.createdAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
      );
  SmsConversationData copyWithCompanion(SmsConversationDataCompanion data) {
    return SmsConversationData(
      id: data.id.present ? data.id.value : this.id,
      firstPhoneNumber: data.firstPhoneNumber.present
          ? data.firstPhoneNumber.value
          : this.firstPhoneNumber,
      secondPhoneNumber: data.secondPhoneNumber.present
          ? data.secondPhoneNumber.value
          : this.secondPhoneNumber,
      createdAtRemote: data.createdAtRemote.present
          ? data.createdAtRemote.value
          : this.createdAtRemote,
      updatedAtRemote: data.updatedAtRemote.present
          ? data.updatedAtRemote.value
          : this.updatedAtRemote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsConversationData(')
          ..write('id: $id, ')
          ..write('firstPhoneNumber: $firstPhoneNumber, ')
          ..write('secondPhoneNumber: $secondPhoneNumber, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        firstPhoneNumber,
        secondPhoneNumber,
        createdAtRemote,
        updatedAtRemote,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsConversationData &&
          other.id == this.id &&
          other.firstPhoneNumber == this.firstPhoneNumber &&
          other.secondPhoneNumber == this.secondPhoneNumber &&
          other.createdAtRemote == this.createdAtRemote &&
          other.updatedAtRemote == this.updatedAtRemote);
}

class SmsConversationDataCompanion
    extends UpdateCompanion<SmsConversationData> {
  final Value<int> id;
  final Value<String> firstPhoneNumber;
  final Value<String> secondPhoneNumber;
  final Value<DateTime> createdAtRemote;
  final Value<DateTime> updatedAtRemote;
  const SmsConversationDataCompanion({
    this.id = const Value.absent(),
    this.firstPhoneNumber = const Value.absent(),
    this.secondPhoneNumber = const Value.absent(),
    this.createdAtRemote = const Value.absent(),
    this.updatedAtRemote = const Value.absent(),
  });
  SmsConversationDataCompanion.insert({
    this.id = const Value.absent(),
    required String firstPhoneNumber,
    required String secondPhoneNumber,
    required DateTime createdAtRemote,
    required DateTime updatedAtRemote,
  })  : firstPhoneNumber = Value(firstPhoneNumber),
        secondPhoneNumber = Value(secondPhoneNumber),
        createdAtRemote = Value(createdAtRemote),
        updatedAtRemote = Value(updatedAtRemote);
  static Insertable<SmsConversationData> custom({
    Expression<int>? id,
    Expression<String>? firstPhoneNumber,
    Expression<String>? secondPhoneNumber,
    Expression<DateTime>? createdAtRemote,
    Expression<DateTime>? updatedAtRemote,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstPhoneNumber != null) 'first_phone_number': firstPhoneNumber,
      if (secondPhoneNumber != null) 'second_phone_number': secondPhoneNumber,
      if (createdAtRemote != null) 'created_at_remote': createdAtRemote,
      if (updatedAtRemote != null) 'updated_at_remote': updatedAtRemote,
    });
  }

  SmsConversationDataCompanion copyWith({
    Value<int>? id,
    Value<String>? firstPhoneNumber,
    Value<String>? secondPhoneNumber,
    Value<DateTime>? createdAtRemote,
    Value<DateTime>? updatedAtRemote,
  }) {
    return SmsConversationDataCompanion(
      id: id ?? this.id,
      firstPhoneNumber: firstPhoneNumber ?? this.firstPhoneNumber,
      secondPhoneNumber: secondPhoneNumber ?? this.secondPhoneNumber,
      createdAtRemote: createdAtRemote ?? this.createdAtRemote,
      updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstPhoneNumber.present) {
      map['first_phone_number'] = Variable<String>(firstPhoneNumber.value);
    }
    if (secondPhoneNumber.present) {
      map['second_phone_number'] = Variable<String>(secondPhoneNumber.value);
    }
    if (createdAtRemote.present) {
      map['created_at_remote'] = Variable<DateTime>(createdAtRemote.value);
    }
    if (updatedAtRemote.present) {
      map['updated_at_remote'] = Variable<DateTime>(updatedAtRemote.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsConversationDataCompanion(')
          ..write('id: $id, ')
          ..write('firstPhoneNumber: $firstPhoneNumber, ')
          ..write('secondPhoneNumber: $secondPhoneNumber, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote')
          ..write(')'))
        .toString();
  }
}

class $SmsMessagesTableTable extends SmsMessagesTable
    with TableInfo<$SmsMessagesTableTable, SmsMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromPhoneNumberMeta = const VerificationMeta(
    'fromPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> fromPhoneNumber = GeneratedColumn<String>(
    'from_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toPhoneNumberMeta = const VerificationMeta(
    'toPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> toPhoneNumber = GeneratedColumn<String>(
    'to_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SmsSendingStatusEnum, String>
      sendingStatus = GeneratedColumn<String>(
    'sending_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SmsSendingStatusEnum>(
    $SmsMessagesTableTable.$convertersendingStatus,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtRemoteUsecMeta =
      const VerificationMeta('createdAtRemoteUsec');
  @override
  late final GeneratedColumn<int> createdAtRemoteUsec = GeneratedColumn<int>(
    'created_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtRemoteUsecMeta =
      const VerificationMeta('updatedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> updatedAtRemoteUsec = GeneratedColumn<int>(
    'updated_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtRemoteUsecMeta =
      const VerificationMeta('deletedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> deletedAtRemoteUsec = GeneratedColumn<int>(
    'deleted_at_remote_usec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idKey,
        externalId,
        conversationId,
        fromPhoneNumber,
        toPhoneNumber,
        sendingStatus,
        content,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
        deletedAtRemoteUsec,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('from_phone_number')) {
      context.handle(
        _fromPhoneNumberMeta,
        fromPhoneNumber.isAcceptableOrUnknown(
          data['from_phone_number']!,
          _fromPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromPhoneNumberMeta);
    }
    if (data.containsKey('to_phone_number')) {
      context.handle(
        _toPhoneNumberMeta,
        toPhoneNumber.isAcceptableOrUnknown(
          data['to_phone_number']!,
          _toPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toPhoneNumberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at_remote_usec')) {
      context.handle(
        _createdAtRemoteUsecMeta,
        createdAtRemoteUsec.isAcceptableOrUnknown(
          data['created_at_remote_usec']!,
          _createdAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtRemoteUsecMeta);
    }
    if (data.containsKey('updated_at_remote_usec')) {
      context.handle(
        _updatedAtRemoteUsecMeta,
        updatedAtRemoteUsec.isAcceptableOrUnknown(
          data['updated_at_remote_usec']!,
          _updatedAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtRemoteUsecMeta);
    }
    if (data.containsKey('deleted_at_remote_usec')) {
      context.handle(
        _deletedAtRemoteUsecMeta,
        deletedAtRemoteUsec.isAcceptableOrUnknown(
          data['deleted_at_remote_usec']!,
          _deletedAtRemoteUsecMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      fromPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_phone_number'],
      )!,
      toPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_phone_number'],
      )!,
      sendingStatus: $SmsMessagesTableTable.$convertersendingStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sending_status'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_remote_usec'],
      )!,
      updatedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_remote_usec'],
      )!,
      deletedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_remote_usec'],
      ),
    );
  }

  @override
  $SmsMessagesTableTable createAlias(String alias) {
    return $SmsMessagesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsSendingStatusEnum, String, String>
      $convertersendingStatus = const EnumNameConverter<SmsSendingStatusEnum>(
    SmsSendingStatusEnum.values,
  );
}

class SmsMessageData extends DataClass implements Insertable<SmsMessageData> {
  final int id;
  final String idKey;
  final String? externalId;
  final int conversationId;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final SmsSendingStatusEnum sendingStatus;
  final String content;
  final int createdAtRemoteUsec;
  final int updatedAtRemoteUsec;
  final int? deletedAtRemoteUsec;
  const SmsMessageData({
    required this.id,
    required this.idKey,
    this.externalId,
    required this.conversationId,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.sendingStatus,
    required this.content,
    required this.createdAtRemoteUsec,
    required this.updatedAtRemoteUsec,
    this.deletedAtRemoteUsec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    map['conversation_id'] = Variable<int>(conversationId);
    map['from_phone_number'] = Variable<String>(fromPhoneNumber);
    map['to_phone_number'] = Variable<String>(toPhoneNumber);
    {
      map['sending_status'] = Variable<String>(
        $SmsMessagesTableTable.$convertersendingStatus.toSql(sendingStatus),
      );
    }
    map['content'] = Variable<String>(content);
    map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec);
    map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec);
    if (!nullToAbsent || deletedAtRemoteUsec != null) {
      map['deleted_at_remote_usec'] = Variable<int>(deletedAtRemoteUsec);
    }
    return map;
  }

  SmsMessageDataCompanion toCompanion(bool nullToAbsent) {
    return SmsMessageDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      conversationId: Value(conversationId),
      fromPhoneNumber: Value(fromPhoneNumber),
      toPhoneNumber: Value(toPhoneNumber),
      sendingStatus: Value(sendingStatus),
      content: Value(content),
      createdAtRemoteUsec: Value(createdAtRemoteUsec),
      updatedAtRemoteUsec: Value(updatedAtRemoteUsec),
      deletedAtRemoteUsec: deletedAtRemoteUsec == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtRemoteUsec),
    );
  }

  factory SmsMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessageData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      fromPhoneNumber: serializer.fromJson<String>(json['fromPhoneNumber']),
      toPhoneNumber: serializer.fromJson<String>(json['toPhoneNumber']),
      sendingStatus: $SmsMessagesTableTable.$convertersendingStatus.fromJson(
        serializer.fromJson<String>(json['sendingStatus']),
      ),
      content: serializer.fromJson<String>(json['content']),
      createdAtRemoteUsec: serializer.fromJson<int>(
        json['createdAtRemoteUsec'],
      ),
      updatedAtRemoteUsec: serializer.fromJson<int>(
        json['updatedAtRemoteUsec'],
      ),
      deletedAtRemoteUsec: serializer.fromJson<int?>(
        json['deletedAtRemoteUsec'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'externalId': serializer.toJson<String?>(externalId),
      'conversationId': serializer.toJson<int>(conversationId),
      'fromPhoneNumber': serializer.toJson<String>(fromPhoneNumber),
      'toPhoneNumber': serializer.toJson<String>(toPhoneNumber),
      'sendingStatus': serializer.toJson<String>(
        $SmsMessagesTableTable.$convertersendingStatus.toJson(sendingStatus),
      ),
      'content': serializer.toJson<String>(content),
      'createdAtRemoteUsec': serializer.toJson<int>(createdAtRemoteUsec),
      'updatedAtRemoteUsec': serializer.toJson<int>(updatedAtRemoteUsec),
      'deletedAtRemoteUsec': serializer.toJson<int?>(deletedAtRemoteUsec),
    };
  }

  SmsMessageData copyWith({
    int? id,
    String? idKey,
    Value<String?> externalId = const Value.absent(),
    int? conversationId,
    String? fromPhoneNumber,
    String? toPhoneNumber,
    SmsSendingStatusEnum? sendingStatus,
    String? content,
    int? createdAtRemoteUsec,
    int? updatedAtRemoteUsec,
    Value<int?> deletedAtRemoteUsec = const Value.absent(),
  }) =>
      SmsMessageData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        externalId: externalId.present ? externalId.value : this.externalId,
        conversationId: conversationId ?? this.conversationId,
        fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
        toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
        sendingStatus: sendingStatus ?? this.sendingStatus,
        content: content ?? this.content,
        createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
        updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
        deletedAtRemoteUsec: deletedAtRemoteUsec.present
            ? deletedAtRemoteUsec.value
            : this.deletedAtRemoteUsec,
      );
  SmsMessageData copyWithCompanion(SmsMessageDataCompanion data) {
    return SmsMessageData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      fromPhoneNumber: data.fromPhoneNumber.present
          ? data.fromPhoneNumber.value
          : this.fromPhoneNumber,
      toPhoneNumber: data.toPhoneNumber.present
          ? data.toPhoneNumber.value
          : this.toPhoneNumber,
      sendingStatus: data.sendingStatus.present
          ? data.sendingStatus.value
          : this.sendingStatus,
      content: data.content.present ? data.content.value : this.content,
      createdAtRemoteUsec: data.createdAtRemoteUsec.present
          ? data.createdAtRemoteUsec.value
          : this.createdAtRemoteUsec,
      updatedAtRemoteUsec: data.updatedAtRemoteUsec.present
          ? data.updatedAtRemoteUsec.value
          : this.updatedAtRemoteUsec,
      deletedAtRemoteUsec: data.deletedAtRemoteUsec.present
          ? data.deletedAtRemoteUsec.value
          : this.deletedAtRemoteUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessageData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('externalId: $externalId, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromPhoneNumber: $fromPhoneNumber, ')
          ..write('toPhoneNumber: $toPhoneNumber, ')
          ..write('sendingStatus: $sendingStatus, ')
          ..write('content: $content, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec, ')
          ..write('deletedAtRemoteUsec: $deletedAtRemoteUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        idKey,
        externalId,
        conversationId,
        fromPhoneNumber,
        toPhoneNumber,
        sendingStatus,
        content,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
        deletedAtRemoteUsec,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessageData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.externalId == this.externalId &&
          other.conversationId == this.conversationId &&
          other.fromPhoneNumber == this.fromPhoneNumber &&
          other.toPhoneNumber == this.toPhoneNumber &&
          other.sendingStatus == this.sendingStatus &&
          other.content == this.content &&
          other.createdAtRemoteUsec == this.createdAtRemoteUsec &&
          other.updatedAtRemoteUsec == this.updatedAtRemoteUsec &&
          other.deletedAtRemoteUsec == this.deletedAtRemoteUsec);
}

class SmsMessageDataCompanion extends UpdateCompanion<SmsMessageData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<String?> externalId;
  final Value<int> conversationId;
  final Value<String> fromPhoneNumber;
  final Value<String> toPhoneNumber;
  final Value<SmsSendingStatusEnum> sendingStatus;
  final Value<String> content;
  final Value<int> createdAtRemoteUsec;
  final Value<int> updatedAtRemoteUsec;
  final Value<int?> deletedAtRemoteUsec;
  const SmsMessageDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.externalId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.fromPhoneNumber = const Value.absent(),
    this.toPhoneNumber = const Value.absent(),
    this.sendingStatus = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAtRemoteUsec = const Value.absent(),
    this.updatedAtRemoteUsec = const Value.absent(),
    this.deletedAtRemoteUsec = const Value.absent(),
  });
  SmsMessageDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    this.externalId = const Value.absent(),
    required int conversationId,
    required String fromPhoneNumber,
    required String toPhoneNumber,
    required SmsSendingStatusEnum sendingStatus,
    required String content,
    required int createdAtRemoteUsec,
    required int updatedAtRemoteUsec,
    this.deletedAtRemoteUsec = const Value.absent(),
  })  : idKey = Value(idKey),
        conversationId = Value(conversationId),
        fromPhoneNumber = Value(fromPhoneNumber),
        toPhoneNumber = Value(toPhoneNumber),
        sendingStatus = Value(sendingStatus),
        content = Value(content),
        createdAtRemoteUsec = Value(createdAtRemoteUsec),
        updatedAtRemoteUsec = Value(updatedAtRemoteUsec);
  static Insertable<SmsMessageData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<String>? externalId,
    Expression<int>? conversationId,
    Expression<String>? fromPhoneNumber,
    Expression<String>? toPhoneNumber,
    Expression<String>? sendingStatus,
    Expression<String>? content,
    Expression<int>? createdAtRemoteUsec,
    Expression<int>? updatedAtRemoteUsec,
    Expression<int>? deletedAtRemoteUsec,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (externalId != null) 'external_id': externalId,
      if (conversationId != null) 'conversation_id': conversationId,
      if (fromPhoneNumber != null) 'from_phone_number': fromPhoneNumber,
      if (toPhoneNumber != null) 'to_phone_number': toPhoneNumber,
      if (sendingStatus != null) 'sending_status': sendingStatus,
      if (content != null) 'content': content,
      if (createdAtRemoteUsec != null)
        'created_at_remote_usec': createdAtRemoteUsec,
      if (updatedAtRemoteUsec != null)
        'updated_at_remote_usec': updatedAtRemoteUsec,
      if (deletedAtRemoteUsec != null)
        'deleted_at_remote_usec': deletedAtRemoteUsec,
    });
  }

  SmsMessageDataCompanion copyWith({
    Value<int>? id,
    Value<String>? idKey,
    Value<String?>? externalId,
    Value<int>? conversationId,
    Value<String>? fromPhoneNumber,
    Value<String>? toPhoneNumber,
    Value<SmsSendingStatusEnum>? sendingStatus,
    Value<String>? content,
    Value<int>? createdAtRemoteUsec,
    Value<int>? updatedAtRemoteUsec,
    Value<int?>? deletedAtRemoteUsec,
  }) {
    return SmsMessageDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      externalId: externalId ?? this.externalId,
      conversationId: conversationId ?? this.conversationId,
      fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
      toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
      sendingStatus: sendingStatus ?? this.sendingStatus,
      content: content ?? this.content,
      createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
      updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
      deletedAtRemoteUsec: deletedAtRemoteUsec ?? this.deletedAtRemoteUsec,
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
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (fromPhoneNumber.present) {
      map['from_phone_number'] = Variable<String>(fromPhoneNumber.value);
    }
    if (toPhoneNumber.present) {
      map['to_phone_number'] = Variable<String>(toPhoneNumber.value);
    }
    if (sendingStatus.present) {
      map['sending_status'] = Variable<String>(
        $SmsMessagesTableTable.$convertersendingStatus.toSql(
          sendingStatus.value,
        ),
      );
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAtRemoteUsec.present) {
      map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec.value);
    }
    if (updatedAtRemoteUsec.present) {
      map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec.value);
    }
    if (deletedAtRemoteUsec.present) {
      map['deleted_at_remote_usec'] = Variable<int>(deletedAtRemoteUsec.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessageDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('externalId: $externalId, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromPhoneNumber: $fromPhoneNumber, ')
          ..write('toPhoneNumber: $toPhoneNumber, ')
          ..write('sendingStatus: $sendingStatus, ')
          ..write('content: $content, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec, ')
          ..write('deletedAtRemoteUsec: $deletedAtRemoteUsec')
          ..write(')'))
        .toString();
  }
}

class $SmsMessageSyncCursorTableTable extends SmsMessageSyncCursorTable
    with TableInfo<$SmsMessageSyncCursorTableTable, SmsMessageSyncCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsMessageSyncCursorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SmsSyncCursorTypeEnum, String>
      cursorType = GeneratedColumn<String>(
    'cursor_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SmsSyncCursorTypeEnum>(
    $SmsMessageSyncCursorTableTable.$convertercursorType,
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        conversationId,
        cursorType,
        timestampUsec,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_message_sync_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessageSyncCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId, cursorType};
  @override
  SmsMessageSyncCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessageSyncCursorData(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      cursorType: $SmsMessageSyncCursorTableTable.$convertercursorType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cursor_type'],
        )!,
      ),
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
    );
  }

  @override
  $SmsMessageSyncCursorTableTable createAlias(String alias) {
    return $SmsMessageSyncCursorTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsSyncCursorTypeEnum, String, String>
      $convertercursorType = const EnumNameConverter<SmsSyncCursorTypeEnum>(
    SmsSyncCursorTypeEnum.values,
  );
}

class SmsMessageSyncCursorData extends DataClass
    implements Insertable<SmsMessageSyncCursorData> {
  final int conversationId;
  final SmsSyncCursorTypeEnum cursorType;
  final int timestampUsec;
  const SmsMessageSyncCursorData({
    required this.conversationId,
    required this.cursorType,
    required this.timestampUsec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<int>(conversationId);
    {
      map['cursor_type'] = Variable<String>(
        $SmsMessageSyncCursorTableTable.$convertercursorType.toSql(cursorType),
      );
    }
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    return map;
  }

  SmsMessageSyncCursorDataCompanion toCompanion(bool nullToAbsent) {
    return SmsMessageSyncCursorDataCompanion(
      conversationId: Value(conversationId),
      cursorType: Value(cursorType),
      timestampUsec: Value(timestampUsec),
    );
  }

  factory SmsMessageSyncCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessageSyncCursorData(
      conversationId: serializer.fromJson<int>(json['conversationId']),
      cursorType: $SmsMessageSyncCursorTableTable.$convertercursorType.fromJson(
        serializer.fromJson<String>(json['cursorType']),
      ),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<int>(conversationId),
      'cursorType': serializer.toJson<String>(
        $SmsMessageSyncCursorTableTable.$convertercursorType.toJson(cursorType),
      ),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
    };
  }

  SmsMessageSyncCursorData copyWith({
    int? conversationId,
    SmsSyncCursorTypeEnum? cursorType,
    int? timestampUsec,
  }) =>
      SmsMessageSyncCursorData(
        conversationId: conversationId ?? this.conversationId,
        cursorType: cursorType ?? this.cursorType,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  SmsMessageSyncCursorData copyWithCompanion(
    SmsMessageSyncCursorDataCompanion data,
  ) {
    return SmsMessageSyncCursorData(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      cursorType:
          data.cursorType.present ? data.cursorType.value : this.cursorType,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessageSyncCursorData(')
          ..write('conversationId: $conversationId, ')
          ..write('cursorType: $cursorType, ')
          ..write('timestampUsec: $timestampUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(conversationId, cursorType, timestampUsec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessageSyncCursorData &&
          other.conversationId == this.conversationId &&
          other.cursorType == this.cursorType &&
          other.timestampUsec == this.timestampUsec);
}

class SmsMessageSyncCursorDataCompanion
    extends UpdateCompanion<SmsMessageSyncCursorData> {
  final Value<int> conversationId;
  final Value<SmsSyncCursorTypeEnum> cursorType;
  final Value<int> timestampUsec;
  final Value<int> rowid;
  const SmsMessageSyncCursorDataCompanion({
    this.conversationId = const Value.absent(),
    this.cursorType = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsMessageSyncCursorDataCompanion.insert({
    required int conversationId,
    required SmsSyncCursorTypeEnum cursorType,
    required int timestampUsec,
    this.rowid = const Value.absent(),
  })  : conversationId = Value(conversationId),
        cursorType = Value(cursorType),
        timestampUsec = Value(timestampUsec);
  static Insertable<SmsMessageSyncCursorData> custom({
    Expression<int>? conversationId,
    Expression<String>? cursorType,
    Expression<int>? timestampUsec,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (cursorType != null) 'cursor_type': cursorType,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsMessageSyncCursorDataCompanion copyWith({
    Value<int>? conversationId,
    Value<SmsSyncCursorTypeEnum>? cursorType,
    Value<int>? timestampUsec,
    Value<int>? rowid,
  }) {
    return SmsMessageSyncCursorDataCompanion(
      conversationId: conversationId ?? this.conversationId,
      cursorType: cursorType ?? this.cursorType,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (cursorType.present) {
      map['cursor_type'] = Variable<String>(
        $SmsMessageSyncCursorTableTable.$convertercursorType.toSql(
          cursorType.value,
        ),
      );
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
    return (StringBuffer('SmsMessageSyncCursorDataCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('cursorType: $cursorType, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsMessageReadCursorTableTable extends SmsMessageReadCursorTable
    with TableInfo<$SmsMessageReadCursorTableTable, SmsMessageReadCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsMessageReadCursorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [conversationId, userId, timestampUsec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_message_read_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessageReadCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId, userId};
  @override
  SmsMessageReadCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessageReadCursorData(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
    );
  }

  @override
  $SmsMessageReadCursorTableTable createAlias(String alias) {
    return $SmsMessageReadCursorTableTable(attachedDatabase, alias);
  }
}

class SmsMessageReadCursorData extends DataClass
    implements Insertable<SmsMessageReadCursorData> {
  final int conversationId;
  final String userId;
  final int timestampUsec;
  const SmsMessageReadCursorData({
    required this.conversationId,
    required this.userId,
    required this.timestampUsec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<int>(conversationId);
    map['user_id'] = Variable<String>(userId);
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    return map;
  }

  SmsMessageReadCursorDataCompanion toCompanion(bool nullToAbsent) {
    return SmsMessageReadCursorDataCompanion(
      conversationId: Value(conversationId),
      userId: Value(userId),
      timestampUsec: Value(timestampUsec),
    );
  }

  factory SmsMessageReadCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessageReadCursorData(
      conversationId: serializer.fromJson<int>(json['conversationId']),
      userId: serializer.fromJson<String>(json['userId']),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<int>(conversationId),
      'userId': serializer.toJson<String>(userId),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
    };
  }

  SmsMessageReadCursorData copyWith({
    int? conversationId,
    String? userId,
    int? timestampUsec,
  }) =>
      SmsMessageReadCursorData(
        conversationId: conversationId ?? this.conversationId,
        userId: userId ?? this.userId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
      );
  SmsMessageReadCursorData copyWithCompanion(
    SmsMessageReadCursorDataCompanion data,
  ) {
    return SmsMessageReadCursorData(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessageReadCursorData(')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('timestampUsec: $timestampUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(conversationId, userId, timestampUsec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessageReadCursorData &&
          other.conversationId == this.conversationId &&
          other.userId == this.userId &&
          other.timestampUsec == this.timestampUsec);
}

class SmsMessageReadCursorDataCompanion
    extends UpdateCompanion<SmsMessageReadCursorData> {
  final Value<int> conversationId;
  final Value<String> userId;
  final Value<int> timestampUsec;
  final Value<int> rowid;
  const SmsMessageReadCursorDataCompanion({
    this.conversationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsMessageReadCursorDataCompanion.insert({
    required int conversationId,
    required String userId,
    required int timestampUsec,
    this.rowid = const Value.absent(),
  })  : conversationId = Value(conversationId),
        userId = Value(userId),
        timestampUsec = Value(timestampUsec);
  static Insertable<SmsMessageReadCursorData> custom({
    Expression<int>? conversationId,
    Expression<String>? userId,
    Expression<int>? timestampUsec,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (userId != null) 'user_id': userId,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsMessageReadCursorDataCompanion copyWith({
    Value<int>? conversationId,
    Value<String>? userId,
    Value<int>? timestampUsec,
    Value<int>? rowid,
  }) {
    return SmsMessageReadCursorDataCompanion(
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
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
    return (StringBuffer('SmsMessageReadCursorDataCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsOutboxMessagesTableTable extends SmsOutboxMessagesTable
    with TableInfo<$SmsOutboxMessagesTableTable, SmsOutboxMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsOutboxMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromPhoneNumberMeta = const VerificationMeta(
    'fromPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> fromPhoneNumber = GeneratedColumn<String>(
    'from_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toPhoneNumberMeta = const VerificationMeta(
    'toPhoneNumber',
  );
  @override
  late final GeneratedColumn<String> toPhoneNumber = GeneratedColumn<String>(
    'to_phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recepientIdMeta = const VerificationMeta(
    'recepientId',
  );
  @override
  late final GeneratedColumn<String> recepientId = GeneratedColumn<String>(
    'recepient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        idKey,
        conversationId,
        fromPhoneNumber,
        toPhoneNumber,
        recepientId,
        content,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_outbox_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsOutboxMessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    }
    if (data.containsKey('from_phone_number')) {
      context.handle(
        _fromPhoneNumberMeta,
        fromPhoneNumber.isAcceptableOrUnknown(
          data['from_phone_number']!,
          _fromPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromPhoneNumberMeta);
    }
    if (data.containsKey('to_phone_number')) {
      context.handle(
        _toPhoneNumberMeta,
        toPhoneNumber.isAcceptableOrUnknown(
          data['to_phone_number']!,
          _toPhoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toPhoneNumberMeta);
    }
    if (data.containsKey('recepient_id')) {
      context.handle(
        _recepientIdMeta,
        recepientId.isAcceptableOrUnknown(
          data['recepient_id']!,
          _recepientIdMeta,
        ),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idKey};
  @override
  SmsOutboxMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsOutboxMessageData(
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      ),
      fromPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_phone_number'],
      )!,
      toPhoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_phone_number'],
      )!,
      recepientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recepient_id'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
    );
  }

  @override
  $SmsOutboxMessagesTableTable createAlias(String alias) {
    return $SmsOutboxMessagesTableTable(attachedDatabase, alias);
  }
}

class SmsOutboxMessageData extends DataClass
    implements Insertable<SmsOutboxMessageData> {
  final String idKey;
  final int? conversationId;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final String? recepientId;
  final String content;
  final int sendAttempts;
  const SmsOutboxMessageData({
    required this.idKey,
    this.conversationId,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    this.recepientId,
    required this.content,
    required this.sendAttempts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_key'] = Variable<String>(idKey);
    if (!nullToAbsent || conversationId != null) {
      map['conversation_id'] = Variable<int>(conversationId);
    }
    map['from_phone_number'] = Variable<String>(fromPhoneNumber);
    map['to_phone_number'] = Variable<String>(toPhoneNumber);
    if (!nullToAbsent || recepientId != null) {
      map['recepient_id'] = Variable<String>(recepientId);
    }
    map['content'] = Variable<String>(content);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  SmsOutboxMessageDataCompanion toCompanion(bool nullToAbsent) {
    return SmsOutboxMessageDataCompanion(
      idKey: Value(idKey),
      conversationId: conversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationId),
      fromPhoneNumber: Value(fromPhoneNumber),
      toPhoneNumber: Value(toPhoneNumber),
      recepientId: recepientId == null && nullToAbsent
          ? const Value.absent()
          : Value(recepientId),
      content: Value(content),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory SmsOutboxMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsOutboxMessageData(
      idKey: serializer.fromJson<String>(json['idKey']),
      conversationId: serializer.fromJson<int?>(json['conversationId']),
      fromPhoneNumber: serializer.fromJson<String>(json['fromPhoneNumber']),
      toPhoneNumber: serializer.fromJson<String>(json['toPhoneNumber']),
      recepientId: serializer.fromJson<String?>(json['recepientId']),
      content: serializer.fromJson<String>(json['content']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idKey': serializer.toJson<String>(idKey),
      'conversationId': serializer.toJson<int?>(conversationId),
      'fromPhoneNumber': serializer.toJson<String>(fromPhoneNumber),
      'toPhoneNumber': serializer.toJson<String>(toPhoneNumber),
      'recepientId': serializer.toJson<String?>(recepientId),
      'content': serializer.toJson<String>(content),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  SmsOutboxMessageData copyWith({
    String? idKey,
    Value<int?> conversationId = const Value.absent(),
    String? fromPhoneNumber,
    String? toPhoneNumber,
    Value<String?> recepientId = const Value.absent(),
    String? content,
    int? sendAttempts,
  }) =>
      SmsOutboxMessageData(
        idKey: idKey ?? this.idKey,
        conversationId:
            conversationId.present ? conversationId.value : this.conversationId,
        fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
        toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
        recepientId: recepientId.present ? recepientId.value : this.recepientId,
        content: content ?? this.content,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  SmsOutboxMessageData copyWithCompanion(SmsOutboxMessageDataCompanion data) {
    return SmsOutboxMessageData(
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      fromPhoneNumber: data.fromPhoneNumber.present
          ? data.fromPhoneNumber.value
          : this.fromPhoneNumber,
      toPhoneNumber: data.toPhoneNumber.present
          ? data.toPhoneNumber.value
          : this.toPhoneNumber,
      recepientId:
          data.recepientId.present ? data.recepientId.value : this.recepientId,
      content: data.content.present ? data.content.value : this.content,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsOutboxMessageData(')
          ..write('idKey: $idKey, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromPhoneNumber: $fromPhoneNumber, ')
          ..write('toPhoneNumber: $toPhoneNumber, ')
          ..write('recepientId: $recepientId, ')
          ..write('content: $content, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        idKey,
        conversationId,
        fromPhoneNumber,
        toPhoneNumber,
        recepientId,
        content,
        sendAttempts,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsOutboxMessageData &&
          other.idKey == this.idKey &&
          other.conversationId == this.conversationId &&
          other.fromPhoneNumber == this.fromPhoneNumber &&
          other.toPhoneNumber == this.toPhoneNumber &&
          other.recepientId == this.recepientId &&
          other.content == this.content &&
          other.sendAttempts == this.sendAttempts);
}

class SmsOutboxMessageDataCompanion
    extends UpdateCompanion<SmsOutboxMessageData> {
  final Value<String> idKey;
  final Value<int?> conversationId;
  final Value<String> fromPhoneNumber;
  final Value<String> toPhoneNumber;
  final Value<String?> recepientId;
  final Value<String> content;
  final Value<int> sendAttempts;
  final Value<int> rowid;
  const SmsOutboxMessageDataCompanion({
    this.idKey = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.fromPhoneNumber = const Value.absent(),
    this.toPhoneNumber = const Value.absent(),
    this.recepientId = const Value.absent(),
    this.content = const Value.absent(),
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsOutboxMessageDataCompanion.insert({
    required String idKey,
    this.conversationId = const Value.absent(),
    required String fromPhoneNumber,
    required String toPhoneNumber,
    this.recepientId = const Value.absent(),
    required String content,
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : idKey = Value(idKey),
        fromPhoneNumber = Value(fromPhoneNumber),
        toPhoneNumber = Value(toPhoneNumber),
        content = Value(content);
  static Insertable<SmsOutboxMessageData> custom({
    Expression<String>? idKey,
    Expression<int>? conversationId,
    Expression<String>? fromPhoneNumber,
    Expression<String>? toPhoneNumber,
    Expression<String>? recepientId,
    Expression<String>? content,
    Expression<int>? sendAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idKey != null) 'id_key': idKey,
      if (conversationId != null) 'conversation_id': conversationId,
      if (fromPhoneNumber != null) 'from_phone_number': fromPhoneNumber,
      if (toPhoneNumber != null) 'to_phone_number': toPhoneNumber,
      if (recepientId != null) 'recepient_id': recepientId,
      if (content != null) 'content': content,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsOutboxMessageDataCompanion copyWith({
    Value<String>? idKey,
    Value<int?>? conversationId,
    Value<String>? fromPhoneNumber,
    Value<String>? toPhoneNumber,
    Value<String?>? recepientId,
    Value<String>? content,
    Value<int>? sendAttempts,
    Value<int>? rowid,
  }) {
    return SmsOutboxMessageDataCompanion(
      idKey: idKey ?? this.idKey,
      conversationId: conversationId ?? this.conversationId,
      fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
      toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
      recepientId: recepientId ?? this.recepientId,
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
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (fromPhoneNumber.present) {
      map['from_phone_number'] = Variable<String>(fromPhoneNumber.value);
    }
    if (toPhoneNumber.present) {
      map['to_phone_number'] = Variable<String>(toPhoneNumber.value);
    }
    if (recepientId.present) {
      map['recepient_id'] = Variable<String>(recepientId.value);
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
    return (StringBuffer('SmsOutboxMessageDataCompanion(')
          ..write('idKey: $idKey, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromPhoneNumber: $fromPhoneNumber, ')
          ..write('toPhoneNumber: $toPhoneNumber, ')
          ..write('recepientId: $recepientId, ')
          ..write('content: $content, ')
          ..write('sendAttempts: $sendAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsOutboxMessageDeleteTableTable extends SmsOutboxMessageDeleteTable
    with
        TableInfo<$SmsOutboxMessageDeleteTableTable,
            SmsOutboxMessageDeleteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsOutboxMessageDeleteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idKey,
        conversationId,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_outbox_message_deletes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsOutboxMessageDeleteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsOutboxMessageDeleteData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsOutboxMessageDeleteData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
    );
  }

  @override
  $SmsOutboxMessageDeleteTableTable createAlias(String alias) {
    return $SmsOutboxMessageDeleteTableTable(attachedDatabase, alias);
  }
}

class SmsOutboxMessageDeleteData extends DataClass
    implements Insertable<SmsOutboxMessageDeleteData> {
  final int id;
  final String idKey;
  final int conversationId;
  final int sendAttempts;
  const SmsOutboxMessageDeleteData({
    required this.id,
    required this.idKey,
    required this.conversationId,
    required this.sendAttempts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['conversation_id'] = Variable<int>(conversationId);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  SmsOutboxMessageDeleteDataCompanion toCompanion(bool nullToAbsent) {
    return SmsOutboxMessageDeleteDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      conversationId: Value(conversationId),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory SmsOutboxMessageDeleteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsOutboxMessageDeleteData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'conversationId': serializer.toJson<int>(conversationId),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  SmsOutboxMessageDeleteData copyWith({
    int? id,
    String? idKey,
    int? conversationId,
    int? sendAttempts,
  }) =>
      SmsOutboxMessageDeleteData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        conversationId: conversationId ?? this.conversationId,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  SmsOutboxMessageDeleteData copyWithCompanion(
    SmsOutboxMessageDeleteDataCompanion data,
  ) {
    return SmsOutboxMessageDeleteData(
      id: data.id.present ? data.id.value : this.id,
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsOutboxMessageDeleteData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('conversationId: $conversationId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, conversationId, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsOutboxMessageDeleteData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.conversationId == this.conversationId &&
          other.sendAttempts == this.sendAttempts);
}

class SmsOutboxMessageDeleteDataCompanion
    extends UpdateCompanion<SmsOutboxMessageDeleteData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> conversationId;
  final Value<int> sendAttempts;
  const SmsOutboxMessageDeleteDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  SmsOutboxMessageDeleteDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int conversationId,
    this.sendAttempts = const Value.absent(),
  })  : idKey = Value(idKey),
        conversationId = Value(conversationId);
  static Insertable<SmsOutboxMessageDeleteData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? conversationId,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (conversationId != null) 'conversation_id': conversationId,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  SmsOutboxMessageDeleteDataCompanion copyWith({
    Value<int>? id,
    Value<String>? idKey,
    Value<int>? conversationId,
    Value<int>? sendAttempts,
  }) {
    return SmsOutboxMessageDeleteDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      conversationId: conversationId ?? this.conversationId,
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
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (sendAttempts.present) {
      map['send_attempts'] = Variable<int>(sendAttempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsOutboxMessageDeleteDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('conversationId: $conversationId, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

class $SmsOutboxReadCursorsTableTable extends SmsOutboxReadCursorsTable
    with TableInfo<$SmsOutboxReadCursorsTableTable, SmsOutboxReadCursorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsOutboxReadCursorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        conversationId,
        timestampUsec,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_outbox_read_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsOutboxReadCursorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampUsecMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId};
  @override
  SmsOutboxReadCursorData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsOutboxReadCursorData(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      )!,
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
    );
  }

  @override
  $SmsOutboxReadCursorsTableTable createAlias(String alias) {
    return $SmsOutboxReadCursorsTableTable(attachedDatabase, alias);
  }
}

class SmsOutboxReadCursorData extends DataClass
    implements Insertable<SmsOutboxReadCursorData> {
  final int conversationId;
  final int timestampUsec;
  final int sendAttempts;
  const SmsOutboxReadCursorData({
    required this.conversationId,
    required this.timestampUsec,
    required this.sendAttempts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<int>(conversationId);
    map['timestamp_usec'] = Variable<int>(timestampUsec);
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  SmsOutboxReadCursorDataCompanion toCompanion(bool nullToAbsent) {
    return SmsOutboxReadCursorDataCompanion(
      conversationId: Value(conversationId),
      timestampUsec: Value(timestampUsec),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory SmsOutboxReadCursorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsOutboxReadCursorData(
      conversationId: serializer.fromJson<int>(json['conversationId']),
      timestampUsec: serializer.fromJson<int>(json['timestampUsec']),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<int>(conversationId),
      'timestampUsec': serializer.toJson<int>(timestampUsec),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  SmsOutboxReadCursorData copyWith({
    int? conversationId,
    int? timestampUsec,
    int? sendAttempts,
  }) =>
      SmsOutboxReadCursorData(
        conversationId: conversationId ?? this.conversationId,
        timestampUsec: timestampUsec ?? this.timestampUsec,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  SmsOutboxReadCursorData copyWithCompanion(
    SmsOutboxReadCursorDataCompanion data,
  ) {
    return SmsOutboxReadCursorData(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
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
    return (StringBuffer('SmsOutboxReadCursorData(')
          ..write('conversationId: $conversationId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(conversationId, timestampUsec, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsOutboxReadCursorData &&
          other.conversationId == this.conversationId &&
          other.timestampUsec == this.timestampUsec &&
          other.sendAttempts == this.sendAttempts);
}

class SmsOutboxReadCursorDataCompanion
    extends UpdateCompanion<SmsOutboxReadCursorData> {
  final Value<int> conversationId;
  final Value<int> timestampUsec;
  final Value<int> sendAttempts;
  const SmsOutboxReadCursorDataCompanion({
    this.conversationId = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.sendAttempts = const Value.absent(),
  });
  SmsOutboxReadCursorDataCompanion.insert({
    this.conversationId = const Value.absent(),
    required int timestampUsec,
    this.sendAttempts = const Value.absent(),
  }) : timestampUsec = Value(timestampUsec);
  static Insertable<SmsOutboxReadCursorData> custom({
    Expression<int>? conversationId,
    Expression<int>? timestampUsec,
    Expression<int>? sendAttempts,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
    });
  }

  SmsOutboxReadCursorDataCompanion copyWith({
    Value<int>? conversationId,
    Value<int>? timestampUsec,
    Value<int>? sendAttempts,
  }) {
    return SmsOutboxReadCursorDataCompanion(
      conversationId: conversationId ?? this.conversationId,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
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
    return (StringBuffer('SmsOutboxReadCursorDataCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }
}

class $UserSmsNumbersTableTable extends UserSmsNumbersTable
    with TableInfo<$UserSmsNumbersTableTable, UserSmsNumberData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSmsNumbersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [phoneNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_sms_numbers';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSmsNumberData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber};
  @override
  UserSmsNumberData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSmsNumberData(
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
    );
  }

  @override
  $UserSmsNumbersTableTable createAlias(String alias) {
    return $UserSmsNumbersTableTable(attachedDatabase, alias);
  }
}

class UserSmsNumberData extends DataClass
    implements Insertable<UserSmsNumberData> {
  final String phoneNumber;
  const UserSmsNumberData({required this.phoneNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_number'] = Variable<String>(phoneNumber);
    return map;
  }

  UserSmsNumberDataCompanion toCompanion(bool nullToAbsent) {
    return UserSmsNumberDataCompanion(phoneNumber: Value(phoneNumber));
  }

  factory UserSmsNumberData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSmsNumberData(
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneNumber': serializer.toJson<String>(phoneNumber),
    };
  }

  UserSmsNumberData copyWith({String? phoneNumber}) =>
      UserSmsNumberData(phoneNumber: phoneNumber ?? this.phoneNumber);
  UserSmsNumberData copyWithCompanion(UserSmsNumberDataCompanion data) {
    return UserSmsNumberData(
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSmsNumberData(')
          ..write('phoneNumber: $phoneNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => phoneNumber.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSmsNumberData && other.phoneNumber == this.phoneNumber);
}

class UserSmsNumberDataCompanion extends UpdateCompanion<UserSmsNumberData> {
  final Value<String> phoneNumber;
  final Value<int> rowid;
  const UserSmsNumberDataCompanion({
    this.phoneNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSmsNumberDataCompanion.insert({
    required String phoneNumber,
    this.rowid = const Value.absent(),
  }) : phoneNumber = Value(phoneNumber);
  static Insertable<UserSmsNumberData> custom({
    Expression<String>? phoneNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSmsNumberDataCompanion copyWith({
    Value<String>? phoneNumber,
    Value<int>? rowid,
  }) {
    return UserSmsNumberDataCompanion(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSmsNumberDataCompanion(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActiveMessageNotificationsTableTable
    extends ActiveMessageNotificationsTable
    with
        TableInfo<$ActiveMessageNotificationsTableTable,
            ActiveMessageNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveMessageNotificationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<String> notificationId = GeneratedColumn<String>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        notificationId,
        messageId,
        conversationId,
        title,
        body,
        time,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_messaging_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveMessageNotificationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {notificationId};
  @override
  ActiveMessageNotificationData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveMessageNotificationData(
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notification_id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
    );
  }

  @override
  $ActiveMessageNotificationsTableTable createAlias(String alias) {
    return $ActiveMessageNotificationsTableTable(attachedDatabase, alias);
  }
}

class ActiveMessageNotificationData extends DataClass
    implements Insertable<ActiveMessageNotificationData> {
  final String notificationId;
  final int messageId;
  final int conversationId;
  final String title;
  final String body;
  final DateTime time;
  const ActiveMessageNotificationData({
    required this.notificationId,
    required this.messageId,
    required this.conversationId,
    required this.title,
    required this.body,
    required this.time,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['notification_id'] = Variable<String>(notificationId);
    map['message_id'] = Variable<int>(messageId);
    map['conversation_id'] = Variable<int>(conversationId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  ActiveMessageNotificationDataCompanion toCompanion(bool nullToAbsent) {
    return ActiveMessageNotificationDataCompanion(
      notificationId: Value(notificationId),
      messageId: Value(messageId),
      conversationId: Value(conversationId),
      title: Value(title),
      body: Value(body),
      time: Value(time),
    );
  }

  factory ActiveMessageNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveMessageNotificationData(
      notificationId: serializer.fromJson<String>(json['notificationId']),
      messageId: serializer.fromJson<int>(json['messageId']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'notificationId': serializer.toJson<String>(notificationId),
      'messageId': serializer.toJson<int>(messageId),
      'conversationId': serializer.toJson<int>(conversationId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  ActiveMessageNotificationData copyWith({
    String? notificationId,
    int? messageId,
    int? conversationId,
    String? title,
    String? body,
    DateTime? time,
  }) =>
      ActiveMessageNotificationData(
        notificationId: notificationId ?? this.notificationId,
        messageId: messageId ?? this.messageId,
        conversationId: conversationId ?? this.conversationId,
        title: title ?? this.title,
        body: body ?? this.body,
        time: time ?? this.time,
      );
  ActiveMessageNotificationData copyWithCompanion(
    ActiveMessageNotificationDataCompanion data,
  ) {
    return ActiveMessageNotificationData(
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveMessageNotificationData(')
          ..write('notificationId: $notificationId, ')
          ..write('messageId: $messageId, ')
          ..write('conversationId: $conversationId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(notificationId, messageId, conversationId, title, body, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveMessageNotificationData &&
          other.notificationId == this.notificationId &&
          other.messageId == this.messageId &&
          other.conversationId == this.conversationId &&
          other.title == this.title &&
          other.body == this.body &&
          other.time == this.time);
}

class ActiveMessageNotificationDataCompanion
    extends UpdateCompanion<ActiveMessageNotificationData> {
  final Value<String> notificationId;
  final Value<int> messageId;
  final Value<int> conversationId;
  final Value<String> title;
  final Value<String> body;
  final Value<DateTime> time;
  final Value<int> rowid;
  const ActiveMessageNotificationDataCompanion({
    this.notificationId = const Value.absent(),
    this.messageId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.time = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActiveMessageNotificationDataCompanion.insert({
    required String notificationId,
    required int messageId,
    required int conversationId,
    required String title,
    required String body,
    required DateTime time,
    this.rowid = const Value.absent(),
  })  : notificationId = Value(notificationId),
        messageId = Value(messageId),
        conversationId = Value(conversationId),
        title = Value(title),
        body = Value(body),
        time = Value(time);
  static Insertable<ActiveMessageNotificationData> custom({
    Expression<String>? notificationId,
    Expression<int>? messageId,
    Expression<int>? conversationId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<DateTime>? time,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (notificationId != null) 'notification_id': notificationId,
      if (messageId != null) 'message_id': messageId,
      if (conversationId != null) 'conversation_id': conversationId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (time != null) 'time': time,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActiveMessageNotificationDataCompanion copyWith({
    Value<String>? notificationId,
    Value<int>? messageId,
    Value<int>? conversationId,
    Value<String>? title,
    Value<String>? body,
    Value<DateTime>? time,
    Value<int>? rowid,
  }) {
    return ActiveMessageNotificationDataCompanion(
      notificationId: notificationId ?? this.notificationId,
      messageId: messageId ?? this.messageId,
      conversationId: conversationId ?? this.conversationId,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (notificationId.present) {
      map['notification_id'] = Variable<String>(notificationId.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveMessageNotificationDataCompanion(')
          ..write('notificationId: $notificationId, ')
          ..write('messageId: $messageId, ')
          ..write('conversationId: $conversationId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('time: $time, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VoicemailTableTable extends VoicemailTable
    with TableInfo<$VoicemailTableTable, VoicemailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoicemailTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<double> duration = GeneratedColumn<double>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverMeta = const VerificationMeta(
    'receiver',
  );
  @override
  late final GeneratedColumn<String> receiver = GeneratedColumn<String>(
    'receiver',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedColumn<bool> seen = GeneratedColumn<bool>(
    'seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("seen" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attachmentPathMeta = const VerificationMeta(
    'attachmentPath',
  );
  @override
  late final GeneratedColumn<String> attachmentPath = GeneratedColumn<String>(
    'attachment_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        duration,
        sender,
        receiver,
        seen,
        size,
        type,
        attachmentPath,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'voicemails';
  @override
  VerificationContext validateIntegrity(
    Insertable<VoicemailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('receiver')) {
      context.handle(
        _receiverMeta,
        receiver.isAcceptableOrUnknown(data['receiver']!, _receiverMeta),
      );
    } else if (isInserting) {
      context.missing(_receiverMeta);
    }
    if (data.containsKey('seen')) {
      context.handle(
        _seenMeta,
        seen.isAcceptableOrUnknown(data['seen']!, _seenMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('attachment_path')) {
      context.handle(
        _attachmentPathMeta,
        attachmentPath.isAcceptableOrUnknown(
          data['attachment_path']!,
          _attachmentPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoicemailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoicemailData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      receiver: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver'],
      )!,
      seen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}seen'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      attachmentPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_path'],
      ),
    );
  }

  @override
  $VoicemailTableTable createAlias(String alias) {
    return $VoicemailTableTable(attachedDatabase, alias);
  }
}

class VoicemailData extends DataClass implements Insertable<VoicemailData> {
  final String id;
  final String date;
  final double duration;
  final String sender;
  final String receiver;
  final bool seen;
  final int size;
  final String type;
  final String? attachmentPath;
  const VoicemailData({
    required this.id,
    required this.date,
    required this.duration,
    required this.sender,
    required this.receiver,
    required this.seen,
    required this.size,
    required this.type,
    this.attachmentPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['duration'] = Variable<double>(duration);
    map['sender'] = Variable<String>(sender);
    map['receiver'] = Variable<String>(receiver);
    map['seen'] = Variable<bool>(seen);
    map['size'] = Variable<int>(size);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || attachmentPath != null) {
      map['attachment_path'] = Variable<String>(attachmentPath);
    }
    return map;
  }

  VoicemailDataCompanion toCompanion(bool nullToAbsent) {
    return VoicemailDataCompanion(
      id: Value(id),
      date: Value(date),
      duration: Value(duration),
      sender: Value(sender),
      receiver: Value(receiver),
      seen: Value(seen),
      size: Value(size),
      type: Value(type),
      attachmentPath: attachmentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentPath),
    );
  }

  factory VoicemailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoicemailData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      duration: serializer.fromJson<double>(json['duration']),
      sender: serializer.fromJson<String>(json['sender']),
      receiver: serializer.fromJson<String>(json['receiver']),
      seen: serializer.fromJson<bool>(json['seen']),
      size: serializer.fromJson<int>(json['size']),
      type: serializer.fromJson<String>(json['type']),
      attachmentPath: serializer.fromJson<String?>(json['attachmentPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'duration': serializer.toJson<double>(duration),
      'sender': serializer.toJson<String>(sender),
      'receiver': serializer.toJson<String>(receiver),
      'seen': serializer.toJson<bool>(seen),
      'size': serializer.toJson<int>(size),
      'type': serializer.toJson<String>(type),
      'attachmentPath': serializer.toJson<String?>(attachmentPath),
    };
  }

  VoicemailData copyWith({
    String? id,
    String? date,
    double? duration,
    String? sender,
    String? receiver,
    bool? seen,
    int? size,
    String? type,
    Value<String?> attachmentPath = const Value.absent(),
  }) =>
      VoicemailData(
        id: id ?? this.id,
        date: date ?? this.date,
        duration: duration ?? this.duration,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        seen: seen ?? this.seen,
        size: size ?? this.size,
        type: type ?? this.type,
        attachmentPath:
            attachmentPath.present ? attachmentPath.value : this.attachmentPath,
      );
  VoicemailData copyWithCompanion(VoicemailDataCompanion data) {
    return VoicemailData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      duration: data.duration.present ? data.duration.value : this.duration,
      sender: data.sender.present ? data.sender.value : this.sender,
      receiver: data.receiver.present ? data.receiver.value : this.receiver,
      seen: data.seen.present ? data.seen.value : this.seen,
      size: data.size.present ? data.size.value : this.size,
      type: data.type.present ? data.type.value : this.type,
      attachmentPath: data.attachmentPath.present
          ? data.attachmentPath.value
          : this.attachmentPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VoicemailData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('sender: $sender, ')
          ..write('receiver: $receiver, ')
          ..write('seen: $seen, ')
          ..write('size: $size, ')
          ..write('type: $type, ')
          ..write('attachmentPath: $attachmentPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        date,
        duration,
        sender,
        receiver,
        seen,
        size,
        type,
        attachmentPath,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoicemailData &&
          other.id == this.id &&
          other.date == this.date &&
          other.duration == this.duration &&
          other.sender == this.sender &&
          other.receiver == this.receiver &&
          other.seen == this.seen &&
          other.size == this.size &&
          other.type == this.type &&
          other.attachmentPath == this.attachmentPath);
}

class VoicemailDataCompanion extends UpdateCompanion<VoicemailData> {
  final Value<String> id;
  final Value<String> date;
  final Value<double> duration;
  final Value<String> sender;
  final Value<String> receiver;
  final Value<bool> seen;
  final Value<int> size;
  final Value<String> type;
  final Value<String?> attachmentPath;
  final Value<int> rowid;
  const VoicemailDataCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.duration = const Value.absent(),
    this.sender = const Value.absent(),
    this.receiver = const Value.absent(),
    this.seen = const Value.absent(),
    this.size = const Value.absent(),
    this.type = const Value.absent(),
    this.attachmentPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VoicemailDataCompanion.insert({
    required String id,
    required String date,
    required double duration,
    required String sender,
    required String receiver,
    this.seen = const Value.absent(),
    required int size,
    required String type,
    this.attachmentPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        duration = Value(duration),
        sender = Value(sender),
        receiver = Value(receiver),
        size = Value(size),
        type = Value(type);
  static Insertable<VoicemailData> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<double>? duration,
    Expression<String>? sender,
    Expression<String>? receiver,
    Expression<bool>? seen,
    Expression<int>? size,
    Expression<String>? type,
    Expression<String>? attachmentPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (duration != null) 'duration': duration,
      if (sender != null) 'sender': sender,
      if (receiver != null) 'receiver': receiver,
      if (seen != null) 'seen': seen,
      if (size != null) 'size': size,
      if (type != null) 'type': type,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VoicemailDataCompanion copyWith({
    Value<String>? id,
    Value<String>? date,
    Value<double>? duration,
    Value<String>? sender,
    Value<String>? receiver,
    Value<bool>? seen,
    Value<int>? size,
    Value<String>? type,
    Value<String?>? attachmentPath,
    Value<int>? rowid,
  }) {
    return VoicemailDataCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      seen: seen ?? this.seen,
      size: size ?? this.size,
      type: type ?? this.type,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (duration.present) {
      map['duration'] = Variable<double>(duration.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (receiver.present) {
      map['receiver'] = Variable<String>(receiver.value);
    }
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (attachmentPath.present) {
      map['attachment_path'] = Variable<String>(attachmentPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoicemailDataCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('sender: $sender, ')
          ..write('receiver: $receiver, ')
          ..write('seen: $seen, ')
          ..write('size: $size, ')
          ..write('type: $type, ')
          ..write('attachmentPath: $attachmentPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SystemNotificationsTableTable extends SystemNotificationsTable
    with TableInfo<$SystemNotificationsTableTable, SystemNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SystemNotificationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SystemNotificationType, String>
      type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SystemNotificationType>(
    $SystemNotificationsTableTable.$convertertype,
  );
  static const VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedColumn<bool> seen = GeneratedColumn<bool>(
    'seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("seen" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtRemoteUsecMeta =
      const VerificationMeta('createdAtRemoteUsec');
  @override
  late final GeneratedColumn<int> createdAtRemoteUsec = GeneratedColumn<int>(
    'created_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtRemoteUsecMeta =
      const VerificationMeta('updatedAtRemoteUsec');
  @override
  late final GeneratedColumn<int> updatedAtRemoteUsec = GeneratedColumn<int>(
    'updated_at_remote_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        content,
        type,
        seen,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'system_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<SystemNotificationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('seen')) {
      context.handle(
        _seenMeta,
        seen.isAcceptableOrUnknown(data['seen']!, _seenMeta),
      );
    } else if (isInserting) {
      context.missing(_seenMeta);
    }
    if (data.containsKey('created_at_remote_usec')) {
      context.handle(
        _createdAtRemoteUsecMeta,
        createdAtRemoteUsec.isAcceptableOrUnknown(
          data['created_at_remote_usec']!,
          _createdAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtRemoteUsecMeta);
    }
    if (data.containsKey('updated_at_remote_usec')) {
      context.handle(
        _updatedAtRemoteUsecMeta,
        updatedAtRemoteUsec.isAcceptableOrUnknown(
          data['updated_at_remote_usec']!,
          _updatedAtRemoteUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtRemoteUsecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SystemNotificationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SystemNotificationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      type: $SystemNotificationsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      seen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}seen'],
      )!,
      createdAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_remote_usec'],
      )!,
      updatedAtRemoteUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_remote_usec'],
      )!,
    );
  }

  @override
  $SystemNotificationsTableTable createAlias(String alias) {
    return $SystemNotificationsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SystemNotificationType, String, String>
      $convertertype = const EnumNameConverter<SystemNotificationType>(
    SystemNotificationType.values,
  );
}

class SystemNotificationData extends DataClass
    implements Insertable<SystemNotificationData> {
  final int id;
  final String title;
  final String content;
  final SystemNotificationType type;
  final bool seen;
  final int createdAtRemoteUsec;
  final int updatedAtRemoteUsec;
  const SystemNotificationData({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.seen,
    required this.createdAtRemoteUsec,
    required this.updatedAtRemoteUsec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    {
      map['type'] = Variable<String>(
        $SystemNotificationsTableTable.$convertertype.toSql(type),
      );
    }
    map['seen'] = Variable<bool>(seen);
    map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec);
    map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec);
    return map;
  }

  SystemNotificationDataCompanion toCompanion(bool nullToAbsent) {
    return SystemNotificationDataCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      type: Value(type),
      seen: Value(seen),
      createdAtRemoteUsec: Value(createdAtRemoteUsec),
      updatedAtRemoteUsec: Value(updatedAtRemoteUsec),
    );
  }

  factory SystemNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SystemNotificationData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      type: $SystemNotificationsTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      seen: serializer.fromJson<bool>(json['seen']),
      createdAtRemoteUsec: serializer.fromJson<int>(
        json['createdAtRemoteUsec'],
      ),
      updatedAtRemoteUsec: serializer.fromJson<int>(
        json['updatedAtRemoteUsec'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'type': serializer.toJson<String>(
        $SystemNotificationsTableTable.$convertertype.toJson(type),
      ),
      'seen': serializer.toJson<bool>(seen),
      'createdAtRemoteUsec': serializer.toJson<int>(createdAtRemoteUsec),
      'updatedAtRemoteUsec': serializer.toJson<int>(updatedAtRemoteUsec),
    };
  }

  SystemNotificationData copyWith({
    int? id,
    String? title,
    String? content,
    SystemNotificationType? type,
    bool? seen,
    int? createdAtRemoteUsec,
    int? updatedAtRemoteUsec,
  }) =>
      SystemNotificationData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        type: type ?? this.type,
        seen: seen ?? this.seen,
        createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
        updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
      );
  SystemNotificationData copyWithCompanion(
    SystemNotificationDataCompanion data,
  ) {
    return SystemNotificationData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      type: data.type.present ? data.type.value : this.type,
      seen: data.seen.present ? data.seen.value : this.seen,
      createdAtRemoteUsec: data.createdAtRemoteUsec.present
          ? data.createdAtRemoteUsec.value
          : this.createdAtRemoteUsec,
      updatedAtRemoteUsec: data.updatedAtRemoteUsec.present
          ? data.updatedAtRemoteUsec.value
          : this.updatedAtRemoteUsec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SystemNotificationData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('seen: $seen, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        content,
        type,
        seen,
        createdAtRemoteUsec,
        updatedAtRemoteUsec,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemNotificationData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.type == this.type &&
          other.seen == this.seen &&
          other.createdAtRemoteUsec == this.createdAtRemoteUsec &&
          other.updatedAtRemoteUsec == this.updatedAtRemoteUsec);
}

class SystemNotificationDataCompanion
    extends UpdateCompanion<SystemNotificationData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<SystemNotificationType> type;
  final Value<bool> seen;
  final Value<int> createdAtRemoteUsec;
  final Value<int> updatedAtRemoteUsec;
  const SystemNotificationDataCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.seen = const Value.absent(),
    this.createdAtRemoteUsec = const Value.absent(),
    this.updatedAtRemoteUsec = const Value.absent(),
  });
  SystemNotificationDataCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required SystemNotificationType type,
    required bool seen,
    required int createdAtRemoteUsec,
    required int updatedAtRemoteUsec,
  })  : title = Value(title),
        content = Value(content),
        type = Value(type),
        seen = Value(seen),
        createdAtRemoteUsec = Value(createdAtRemoteUsec),
        updatedAtRemoteUsec = Value(updatedAtRemoteUsec);
  static Insertable<SystemNotificationData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? type,
    Expression<bool>? seen,
    Expression<int>? createdAtRemoteUsec,
    Expression<int>? updatedAtRemoteUsec,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (seen != null) 'seen': seen,
      if (createdAtRemoteUsec != null)
        'created_at_remote_usec': createdAtRemoteUsec,
      if (updatedAtRemoteUsec != null)
        'updated_at_remote_usec': updatedAtRemoteUsec,
    });
  }

  SystemNotificationDataCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? content,
    Value<SystemNotificationType>? type,
    Value<bool>? seen,
    Value<int>? createdAtRemoteUsec,
    Value<int>? updatedAtRemoteUsec,
  }) {
    return SystemNotificationDataCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      seen: seen ?? this.seen,
      createdAtRemoteUsec: createdAtRemoteUsec ?? this.createdAtRemoteUsec,
      updatedAtRemoteUsec: updatedAtRemoteUsec ?? this.updatedAtRemoteUsec,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $SystemNotificationsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    if (createdAtRemoteUsec.present) {
      map['created_at_remote_usec'] = Variable<int>(createdAtRemoteUsec.value);
    }
    if (updatedAtRemoteUsec.present) {
      map['updated_at_remote_usec'] = Variable<int>(updatedAtRemoteUsec.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SystemNotificationDataCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('seen: $seen, ')
          ..write('createdAtRemoteUsec: $createdAtRemoteUsec, ')
          ..write('updatedAtRemoteUsec: $updatedAtRemoteUsec')
          ..write(')'))
        .toString();
  }
}

class $SystemNotificationsOutboxTableTable
    extends SystemNotificationsOutboxTable
    with
        TableInfo<$SystemNotificationsOutboxTableTable,
            SystemNotificationOutboxEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SystemNotificationsOutboxTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES system_notifications (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SnOutboxDataActionType, String>
      actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SnOutboxDataActionType>(
    $SystemNotificationsOutboxTableTable.$converteractionType,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SnOutboxDataState, String> state =
      GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SnOutboxDataState>(
    $SystemNotificationsOutboxTableTable.$converterstate,
  );
  static const VerificationMeta _sendAttemptsMeta = const VerificationMeta(
    'sendAttempts',
  );
  @override
  late final GeneratedColumn<int> sendAttempts = GeneratedColumn<int>(
    'send_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
        notificationId,
        actionType,
        state,
        sendAttempts,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'system_notifications_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SystemNotificationOutboxEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('send_attempts')) {
      context.handle(
        _sendAttemptsMeta,
        sendAttempts.isAcceptableOrUnknown(
          data['send_attempts']!,
          _sendAttemptsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {notificationId, actionType};
  @override
  SystemNotificationOutboxEntryData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SystemNotificationOutboxEntryData(
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
      actionType:
          $SystemNotificationsOutboxTableTable.$converteractionType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}action_type'],
        )!,
      ),
      state: $SystemNotificationsOutboxTableTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}state'],
        )!,
      ),
      sendAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_attempts'],
      )!,
    );
  }

  @override
  $SystemNotificationsOutboxTableTable createAlias(String alias) {
    return $SystemNotificationsOutboxTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SnOutboxDataActionType, String, String>
      $converteractionType = const EnumNameConverter<SnOutboxDataActionType>(
    SnOutboxDataActionType.values,
  );
  static JsonTypeConverter2<SnOutboxDataState, String, String> $converterstate =
      const EnumNameConverter<SnOutboxDataState>(SnOutboxDataState.values);
}

class SystemNotificationOutboxEntryData extends DataClass
    implements Insertable<SystemNotificationOutboxEntryData> {
  final int notificationId;
  final SnOutboxDataActionType actionType;
  final SnOutboxDataState state;
  final int sendAttempts;
  const SystemNotificationOutboxEntryData({
    required this.notificationId,
    required this.actionType,
    required this.state,
    required this.sendAttempts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['notification_id'] = Variable<int>(notificationId);
    {
      map['action_type'] = Variable<String>(
        $SystemNotificationsOutboxTableTable.$converteractionType.toSql(
          actionType,
        ),
      );
    }
    {
      map['state'] = Variable<String>(
        $SystemNotificationsOutboxTableTable.$converterstate.toSql(state),
      );
    }
    map['send_attempts'] = Variable<int>(sendAttempts);
    return map;
  }

  SystemNotificationOutboxEntryDataCompanion toCompanion(bool nullToAbsent) {
    return SystemNotificationOutboxEntryDataCompanion(
      notificationId: Value(notificationId),
      actionType: Value(actionType),
      state: Value(state),
      sendAttempts: Value(sendAttempts),
    );
  }

  factory SystemNotificationOutboxEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SystemNotificationOutboxEntryData(
      notificationId: serializer.fromJson<int>(json['notificationId']),
      actionType: $SystemNotificationsOutboxTableTable.$converteractionType
          .fromJson(serializer.fromJson<String>(json['actionType'])),
      state: $SystemNotificationsOutboxTableTable.$converterstate.fromJson(
        serializer.fromJson<String>(json['state']),
      ),
      sendAttempts: serializer.fromJson<int>(json['sendAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'notificationId': serializer.toJson<int>(notificationId),
      'actionType': serializer.toJson<String>(
        $SystemNotificationsOutboxTableTable.$converteractionType.toJson(
          actionType,
        ),
      ),
      'state': serializer.toJson<String>(
        $SystemNotificationsOutboxTableTable.$converterstate.toJson(state),
      ),
      'sendAttempts': serializer.toJson<int>(sendAttempts),
    };
  }

  SystemNotificationOutboxEntryData copyWith({
    int? notificationId,
    SnOutboxDataActionType? actionType,
    SnOutboxDataState? state,
    int? sendAttempts,
  }) =>
      SystemNotificationOutboxEntryData(
        notificationId: notificationId ?? this.notificationId,
        actionType: actionType ?? this.actionType,
        state: state ?? this.state,
        sendAttempts: sendAttempts ?? this.sendAttempts,
      );
  SystemNotificationOutboxEntryData copyWithCompanion(
    SystemNotificationOutboxEntryDataCompanion data,
  ) {
    return SystemNotificationOutboxEntryData(
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      state: data.state.present ? data.state.value : this.state,
      sendAttempts: data.sendAttempts.present
          ? data.sendAttempts.value
          : this.sendAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SystemNotificationOutboxEntryData(')
          ..write('notificationId: $notificationId, ')
          ..write('actionType: $actionType, ')
          ..write('state: $state, ')
          ..write('sendAttempts: $sendAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(notificationId, actionType, state, sendAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemNotificationOutboxEntryData &&
          other.notificationId == this.notificationId &&
          other.actionType == this.actionType &&
          other.state == this.state &&
          other.sendAttempts == this.sendAttempts);
}

class SystemNotificationOutboxEntryDataCompanion
    extends UpdateCompanion<SystemNotificationOutboxEntryData> {
  final Value<int> notificationId;
  final Value<SnOutboxDataActionType> actionType;
  final Value<SnOutboxDataState> state;
  final Value<int> sendAttempts;
  final Value<int> rowid;
  const SystemNotificationOutboxEntryDataCompanion({
    this.notificationId = const Value.absent(),
    this.actionType = const Value.absent(),
    this.state = const Value.absent(),
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SystemNotificationOutboxEntryDataCompanion.insert({
    required int notificationId,
    required SnOutboxDataActionType actionType,
    required SnOutboxDataState state,
    this.sendAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : notificationId = Value(notificationId),
        actionType = Value(actionType),
        state = Value(state);
  static Insertable<SystemNotificationOutboxEntryData> custom({
    Expression<int>? notificationId,
    Expression<String>? actionType,
    Expression<String>? state,
    Expression<int>? sendAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (notificationId != null) 'notification_id': notificationId,
      if (actionType != null) 'action_type': actionType,
      if (state != null) 'state': state,
      if (sendAttempts != null) 'send_attempts': sendAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SystemNotificationOutboxEntryDataCompanion copyWith({
    Value<int>? notificationId,
    Value<SnOutboxDataActionType>? actionType,
    Value<SnOutboxDataState>? state,
    Value<int>? sendAttempts,
    Value<int>? rowid,
  }) {
    return SystemNotificationOutboxEntryDataCompanion(
      notificationId: notificationId ?? this.notificationId,
      actionType: actionType ?? this.actionType,
      state: state ?? this.state,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(
        $SystemNotificationsOutboxTableTable.$converteractionType.toSql(
          actionType.value,
        ),
      );
    }
    if (state.present) {
      map['state'] = Variable<String>(
        $SystemNotificationsOutboxTableTable.$converterstate.toSql(state.value),
      );
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
    return (StringBuffer('SystemNotificationOutboxEntryDataCompanion(')
          ..write('notificationId: $notificationId, ')
          ..write('actionType: $actionType, ')
          ..write('state: $state, ')
          ..write('sendAttempts: $sendAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PresenceInfoTableTable extends PresenceInfoTable
    with TableInfo<$PresenceInfoTableTable, PresenceInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PresenceInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idKeyMeta = const VerificationMeta('idKey');
  @override
  late final GeneratedColumn<String> idKey = GeneratedColumn<String>(
    'id_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableMeta = const VerificationMeta(
    'available',
  );
  @override
  late final GeneratedColumn<bool> available = GeneratedColumn<bool>(
    'available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("available" IN (0, 1))',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusIconMeta = const VerificationMeta(
    'statusIcon',
  );
  @override
  late final GeneratedColumn<String> statusIcon = GeneratedColumn<String>(
    'status_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceMeta = const VerificationMeta('device');
  @override
  late final GeneratedColumn<String> device = GeneratedColumn<String>(
    'device',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOffsetMinMeta = const VerificationMeta(
    'timeOffsetMin',
  );
  @override
  late final GeneratedColumn<int> timeOffsetMin = GeneratedColumn<int>(
    'time_offset_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampUsecMeta = const VerificationMeta(
    'timestampUsec',
  );
  @override
  late final GeneratedColumn<int> timestampUsec = GeneratedColumn<int>(
    'timestamp_usec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activitiesJsonMeta = const VerificationMeta(
    'activitiesJson',
  );
  @override
  late final GeneratedColumn<String> activitiesJson = GeneratedColumn<String>(
    'activities_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
        idKey,
        number,
        available,
        note,
        statusIcon,
        device,
        timeOffsetMin,
        timestampUsec,
        activitiesJson,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'presence_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<PresenceInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_key')) {
      context.handle(
        _idKeyMeta,
        idKey.isAcceptableOrUnknown(data['id_key']!, _idKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_idKeyMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('available')) {
      context.handle(
        _availableMeta,
        available.isAcceptableOrUnknown(data['available']!, _availableMeta),
      );
    } else if (isInserting) {
      context.missing(_availableMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('status_icon')) {
      context.handle(
        _statusIconMeta,
        statusIcon.isAcceptableOrUnknown(data['status_icon']!, _statusIconMeta),
      );
    }
    if (data.containsKey('device')) {
      context.handle(
        _deviceMeta,
        device.isAcceptableOrUnknown(data['device']!, _deviceMeta),
      );
    }
    if (data.containsKey('time_offset_min')) {
      context.handle(
        _timeOffsetMinMeta,
        timeOffsetMin.isAcceptableOrUnknown(
          data['time_offset_min']!,
          _timeOffsetMinMeta,
        ),
      );
    }
    if (data.containsKey('timestamp_usec')) {
      context.handle(
        _timestampUsecMeta,
        timestampUsec.isAcceptableOrUnknown(
          data['timestamp_usec']!,
          _timestampUsecMeta,
        ),
      );
    }
    if (data.containsKey('activities_json')) {
      context.handle(
        _activitiesJsonMeta,
        activitiesJson.isAcceptableOrUnknown(
          data['activities_json']!,
          _activitiesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activitiesJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idKey};
  @override
  PresenceInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PresenceInfoData(
      idKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_key'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      available: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}available'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      statusIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_icon'],
      ),
      device: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device'],
      ),
      timeOffsetMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_offset_min'],
      ),
      timestampUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_usec'],
      ),
      activitiesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activities_json'],
      )!,
    );
  }

  @override
  $PresenceInfoTableTable createAlias(String alias) {
    return $PresenceInfoTableTable(attachedDatabase, alias);
  }
}

class PresenceInfoData extends DataClass
    implements Insertable<PresenceInfoData> {
  final String idKey;
  final String number;
  final bool available;
  final String note;
  final String? statusIcon;
  final String? device;
  final int? timeOffsetMin;
  final int? timestampUsec;
  final String activitiesJson;
  const PresenceInfoData({
    required this.idKey,
    required this.number,
    required this.available,
    required this.note,
    this.statusIcon,
    this.device,
    this.timeOffsetMin,
    this.timestampUsec,
    required this.activitiesJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_key'] = Variable<String>(idKey);
    map['number'] = Variable<String>(number);
    map['available'] = Variable<bool>(available);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || statusIcon != null) {
      map['status_icon'] = Variable<String>(statusIcon);
    }
    if (!nullToAbsent || device != null) {
      map['device'] = Variable<String>(device);
    }
    if (!nullToAbsent || timeOffsetMin != null) {
      map['time_offset_min'] = Variable<int>(timeOffsetMin);
    }
    if (!nullToAbsent || timestampUsec != null) {
      map['timestamp_usec'] = Variable<int>(timestampUsec);
    }
    map['activities_json'] = Variable<String>(activitiesJson);
    return map;
  }

  PresenceInfoDataCompanion toCompanion(bool nullToAbsent) {
    return PresenceInfoDataCompanion(
      idKey: Value(idKey),
      number: Value(number),
      available: Value(available),
      note: Value(note),
      statusIcon: statusIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(statusIcon),
      device:
          device == null && nullToAbsent ? const Value.absent() : Value(device),
      timeOffsetMin: timeOffsetMin == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOffsetMin),
      timestampUsec: timestampUsec == null && nullToAbsent
          ? const Value.absent()
          : Value(timestampUsec),
      activitiesJson: Value(activitiesJson),
    );
  }

  factory PresenceInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PresenceInfoData(
      idKey: serializer.fromJson<String>(json['idKey']),
      number: serializer.fromJson<String>(json['number']),
      available: serializer.fromJson<bool>(json['available']),
      note: serializer.fromJson<String>(json['note']),
      statusIcon: serializer.fromJson<String?>(json['statusIcon']),
      device: serializer.fromJson<String?>(json['device']),
      timeOffsetMin: serializer.fromJson<int?>(json['timeOffsetMin']),
      timestampUsec: serializer.fromJson<int?>(json['timestampUsec']),
      activitiesJson: serializer.fromJson<String>(json['activitiesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idKey': serializer.toJson<String>(idKey),
      'number': serializer.toJson<String>(number),
      'available': serializer.toJson<bool>(available),
      'note': serializer.toJson<String>(note),
      'statusIcon': serializer.toJson<String?>(statusIcon),
      'device': serializer.toJson<String?>(device),
      'timeOffsetMin': serializer.toJson<int?>(timeOffsetMin),
      'timestampUsec': serializer.toJson<int?>(timestampUsec),
      'activitiesJson': serializer.toJson<String>(activitiesJson),
    };
  }

  PresenceInfoData copyWith({
    String? idKey,
    String? number,
    bool? available,
    String? note,
    Value<String?> statusIcon = const Value.absent(),
    Value<String?> device = const Value.absent(),
    Value<int?> timeOffsetMin = const Value.absent(),
    Value<int?> timestampUsec = const Value.absent(),
    String? activitiesJson,
  }) =>
      PresenceInfoData(
        idKey: idKey ?? this.idKey,
        number: number ?? this.number,
        available: available ?? this.available,
        note: note ?? this.note,
        statusIcon: statusIcon.present ? statusIcon.value : this.statusIcon,
        device: device.present ? device.value : this.device,
        timeOffsetMin:
            timeOffsetMin.present ? timeOffsetMin.value : this.timeOffsetMin,
        timestampUsec:
            timestampUsec.present ? timestampUsec.value : this.timestampUsec,
        activitiesJson: activitiesJson ?? this.activitiesJson,
      );
  PresenceInfoData copyWithCompanion(PresenceInfoDataCompanion data) {
    return PresenceInfoData(
      idKey: data.idKey.present ? data.idKey.value : this.idKey,
      number: data.number.present ? data.number.value : this.number,
      available: data.available.present ? data.available.value : this.available,
      note: data.note.present ? data.note.value : this.note,
      statusIcon:
          data.statusIcon.present ? data.statusIcon.value : this.statusIcon,
      device: data.device.present ? data.device.value : this.device,
      timeOffsetMin: data.timeOffsetMin.present
          ? data.timeOffsetMin.value
          : this.timeOffsetMin,
      timestampUsec: data.timestampUsec.present
          ? data.timestampUsec.value
          : this.timestampUsec,
      activitiesJson: data.activitiesJson.present
          ? data.activitiesJson.value
          : this.activitiesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PresenceInfoData(')
          ..write('idKey: $idKey, ')
          ..write('number: $number, ')
          ..write('available: $available, ')
          ..write('note: $note, ')
          ..write('statusIcon: $statusIcon, ')
          ..write('device: $device, ')
          ..write('timeOffsetMin: $timeOffsetMin, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('activitiesJson: $activitiesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        idKey,
        number,
        available,
        note,
        statusIcon,
        device,
        timeOffsetMin,
        timestampUsec,
        activitiesJson,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresenceInfoData &&
          other.idKey == this.idKey &&
          other.number == this.number &&
          other.available == this.available &&
          other.note == this.note &&
          other.statusIcon == this.statusIcon &&
          other.device == this.device &&
          other.timeOffsetMin == this.timeOffsetMin &&
          other.timestampUsec == this.timestampUsec &&
          other.activitiesJson == this.activitiesJson);
}

class PresenceInfoDataCompanion extends UpdateCompanion<PresenceInfoData> {
  final Value<String> idKey;
  final Value<String> number;
  final Value<bool> available;
  final Value<String> note;
  final Value<String?> statusIcon;
  final Value<String?> device;
  final Value<int?> timeOffsetMin;
  final Value<int?> timestampUsec;
  final Value<String> activitiesJson;
  final Value<int> rowid;
  const PresenceInfoDataCompanion({
    this.idKey = const Value.absent(),
    this.number = const Value.absent(),
    this.available = const Value.absent(),
    this.note = const Value.absent(),
    this.statusIcon = const Value.absent(),
    this.device = const Value.absent(),
    this.timeOffsetMin = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    this.activitiesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PresenceInfoDataCompanion.insert({
    required String idKey,
    required String number,
    required bool available,
    required String note,
    this.statusIcon = const Value.absent(),
    this.device = const Value.absent(),
    this.timeOffsetMin = const Value.absent(),
    this.timestampUsec = const Value.absent(),
    required String activitiesJson,
    this.rowid = const Value.absent(),
  })  : idKey = Value(idKey),
        number = Value(number),
        available = Value(available),
        note = Value(note),
        activitiesJson = Value(activitiesJson);
  static Insertable<PresenceInfoData> custom({
    Expression<String>? idKey,
    Expression<String>? number,
    Expression<bool>? available,
    Expression<String>? note,
    Expression<String>? statusIcon,
    Expression<String>? device,
    Expression<int>? timeOffsetMin,
    Expression<int>? timestampUsec,
    Expression<String>? activitiesJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idKey != null) 'id_key': idKey,
      if (number != null) 'number': number,
      if (available != null) 'available': available,
      if (note != null) 'note': note,
      if (statusIcon != null) 'status_icon': statusIcon,
      if (device != null) 'device': device,
      if (timeOffsetMin != null) 'time_offset_min': timeOffsetMin,
      if (timestampUsec != null) 'timestamp_usec': timestampUsec,
      if (activitiesJson != null) 'activities_json': activitiesJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PresenceInfoDataCompanion copyWith({
    Value<String>? idKey,
    Value<String>? number,
    Value<bool>? available,
    Value<String>? note,
    Value<String?>? statusIcon,
    Value<String?>? device,
    Value<int?>? timeOffsetMin,
    Value<int?>? timestampUsec,
    Value<String>? activitiesJson,
    Value<int>? rowid,
  }) {
    return PresenceInfoDataCompanion(
      idKey: idKey ?? this.idKey,
      number: number ?? this.number,
      available: available ?? this.available,
      note: note ?? this.note,
      statusIcon: statusIcon ?? this.statusIcon,
      device: device ?? this.device,
      timeOffsetMin: timeOffsetMin ?? this.timeOffsetMin,
      timestampUsec: timestampUsec ?? this.timestampUsec,
      activitiesJson: activitiesJson ?? this.activitiesJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idKey.present) {
      map['id_key'] = Variable<String>(idKey.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (statusIcon.present) {
      map['status_icon'] = Variable<String>(statusIcon.value);
    }
    if (device.present) {
      map['device'] = Variable<String>(device.value);
    }
    if (timeOffsetMin.present) {
      map['time_offset_min'] = Variable<int>(timeOffsetMin.value);
    }
    if (timestampUsec.present) {
      map['timestamp_usec'] = Variable<int>(timestampUsec.value);
    }
    if (activitiesJson.present) {
      map['activities_json'] = Variable<String>(activitiesJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresenceInfoDataCompanion(')
          ..write('idKey: $idKey, ')
          ..write('number: $number, ')
          ..write('available: $available, ')
          ..write('note: $note, ')
          ..write('statusIcon: $statusIcon, ')
          ..write('device: $device, ')
          ..write('timeOffsetMin: $timeOffsetMin, ')
          ..write('timestampUsec: $timestampUsec, ')
          ..write('activitiesJson: $activitiesJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CdrTableTable extends CdrTable
    with TableInfo<$CdrTableTable, CdrRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CdrTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _callIdMeta = const VerificationMeta('callId');
  @override
  late final GeneratedColumn<String> callId = GeneratedColumn<String>(
    'call_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CallDirectionData, String>
      direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<CallDirectionData>($CdrTableTable.$converterdirection);
  @override
  late final GeneratedColumnWithTypeConverter<CdrStatusData, String> status =
      GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<CdrStatusData>($CdrTableTable.$converterstatus);
  static const VerificationMeta _calleeMeta = const VerificationMeta('callee');
  @override
  late final GeneratedColumn<String> callee = GeneratedColumn<String>(
    'callee',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calleeNumberMeta = const VerificationMeta(
    'calleeNumber',
  );
  @override
  late final GeneratedColumn<String> calleeNumber = GeneratedColumn<String>(
    'callee_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _callerMeta = const VerificationMeta('caller');
  @override
  late final GeneratedColumn<String> caller = GeneratedColumn<String>(
    'caller',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _callerNumberMeta = const VerificationMeta(
    'callerNumber',
  );
  @override
  late final GeneratedColumn<String> callerNumber = GeneratedColumn<String>(
    'caller_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectTimeUsecMeta = const VerificationMeta(
    'connectTimeUsec',
  );
  @override
  late final GeneratedColumn<int> connectTimeUsec = GeneratedColumn<int>(
    'connect_time_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _disconnectTimeUsecMeta =
      const VerificationMeta('disconnectTimeUsec');
  @override
  late final GeneratedColumn<int> disconnectTimeUsec = GeneratedColumn<int>(
    'disconnect_time_usec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _disconnectReasonMeta = const VerificationMeta(
    'disconnectReason',
  );
  @override
  late final GeneratedColumn<String> disconnectReason = GeneratedColumn<String>(
    'disconnect_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordingIdMeta = const VerificationMeta(
    'recordingId',
  );
  @override
  late final GeneratedColumn<String> recordingId = GeneratedColumn<String>(
    'recording_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
        callId,
        direction,
        status,
        callee,
        calleeNumber,
        caller,
        callerNumber,
        connectTimeUsec,
        disconnectTimeUsec,
        disconnectReason,
        durationSeconds,
        recordingId,
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cdrs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CdrRecordData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('call_id')) {
      context.handle(
        _callIdMeta,
        callId.isAcceptableOrUnknown(data['call_id']!, _callIdMeta),
      );
    } else if (isInserting) {
      context.missing(_callIdMeta);
    }
    if (data.containsKey('callee')) {
      context.handle(
        _calleeMeta,
        callee.isAcceptableOrUnknown(data['callee']!, _calleeMeta),
      );
    } else if (isInserting) {
      context.missing(_calleeMeta);
    }
    if (data.containsKey('callee_number')) {
      context.handle(
        _calleeNumberMeta,
        calleeNumber.isAcceptableOrUnknown(
          data['callee_number']!,
          _calleeNumberMeta,
        ),
      );
    }
    if (data.containsKey('caller')) {
      context.handle(
        _callerMeta,
        caller.isAcceptableOrUnknown(data['caller']!, _callerMeta),
      );
    } else if (isInserting) {
      context.missing(_callerMeta);
    }
    if (data.containsKey('caller_number')) {
      context.handle(
        _callerNumberMeta,
        callerNumber.isAcceptableOrUnknown(
          data['caller_number']!,
          _callerNumberMeta,
        ),
      );
    }
    if (data.containsKey('connect_time_usec')) {
      context.handle(
        _connectTimeUsecMeta,
        connectTimeUsec.isAcceptableOrUnknown(
          data['connect_time_usec']!,
          _connectTimeUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_connectTimeUsecMeta);
    }
    if (data.containsKey('disconnect_time_usec')) {
      context.handle(
        _disconnectTimeUsecMeta,
        disconnectTimeUsec.isAcceptableOrUnknown(
          data['disconnect_time_usec']!,
          _disconnectTimeUsecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_disconnectTimeUsecMeta);
    }
    if (data.containsKey('disconnect_reason')) {
      context.handle(
        _disconnectReasonMeta,
        disconnectReason.isAcceptableOrUnknown(
          data['disconnect_reason']!,
          _disconnectReasonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_disconnectReasonMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('recording_id')) {
      context.handle(
        _recordingIdMeta,
        recordingId.isAcceptableOrUnknown(
          data['recording_id']!,
          _recordingIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {callId};
  @override
  CdrRecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CdrRecordData(
      callId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_id'],
      )!,
      direction: $CdrTableTable.$converterdirection.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}direction'],
        )!,
      ),
      status: $CdrTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      callee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callee'],
      )!,
      calleeNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callee_number'],
      ),
      caller: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caller'],
      )!,
      callerNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caller_number'],
      ),
      connectTimeUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}connect_time_usec'],
      )!,
      disconnectTimeUsec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disconnect_time_usec'],
      )!,
      disconnectReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}disconnect_reason'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      recordingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recording_id'],
      ),
    );
  }

  @override
  $CdrTableTable createAlias(String alias) {
    return $CdrTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CallDirectionData, String, String>
      $converterdirection = const EnumNameConverter<CallDirectionData>(
    CallDirectionData.values,
  );
  static JsonTypeConverter2<CdrStatusData, String, String> $converterstatus =
      const EnumNameConverter<CdrStatusData>(CdrStatusData.values);
}

class CdrRecordData extends DataClass implements Insertable<CdrRecordData> {
  final String callId;
  final CallDirectionData direction;
  final CdrStatusData status;
  final String callee;
  final String? calleeNumber;
  final String caller;
  final String? callerNumber;
  final int connectTimeUsec;
  final int disconnectTimeUsec;
  final String disconnectReason;
  final int durationSeconds;
  final String? recordingId;
  const CdrRecordData({
    required this.callId,
    required this.direction,
    required this.status,
    required this.callee,
    this.calleeNumber,
    required this.caller,
    this.callerNumber,
    required this.connectTimeUsec,
    required this.disconnectTimeUsec,
    required this.disconnectReason,
    required this.durationSeconds,
    this.recordingId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['call_id'] = Variable<String>(callId);
    {
      map['direction'] = Variable<String>(
        $CdrTableTable.$converterdirection.toSql(direction),
      );
    }
    {
      map['status'] = Variable<String>(
        $CdrTableTable.$converterstatus.toSql(status),
      );
    }
    map['callee'] = Variable<String>(callee);
    if (!nullToAbsent || calleeNumber != null) {
      map['callee_number'] = Variable<String>(calleeNumber);
    }
    map['caller'] = Variable<String>(caller);
    if (!nullToAbsent || callerNumber != null) {
      map['caller_number'] = Variable<String>(callerNumber);
    }
    map['connect_time_usec'] = Variable<int>(connectTimeUsec);
    map['disconnect_time_usec'] = Variable<int>(disconnectTimeUsec);
    map['disconnect_reason'] = Variable<String>(disconnectReason);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || recordingId != null) {
      map['recording_id'] = Variable<String>(recordingId);
    }
    return map;
  }

  CdrRecordDataCompanion toCompanion(bool nullToAbsent) {
    return CdrRecordDataCompanion(
      callId: Value(callId),
      direction: Value(direction),
      status: Value(status),
      callee: Value(callee),
      calleeNumber: calleeNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(calleeNumber),
      caller: Value(caller),
      callerNumber: callerNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(callerNumber),
      connectTimeUsec: Value(connectTimeUsec),
      disconnectTimeUsec: Value(disconnectTimeUsec),
      disconnectReason: Value(disconnectReason),
      durationSeconds: Value(durationSeconds),
      recordingId: recordingId == null && nullToAbsent
          ? const Value.absent()
          : Value(recordingId),
    );
  }

  factory CdrRecordData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CdrRecordData(
      callId: serializer.fromJson<String>(json['callId']),
      direction: $CdrTableTable.$converterdirection.fromJson(
        serializer.fromJson<String>(json['direction']),
      ),
      status: $CdrTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      callee: serializer.fromJson<String>(json['callee']),
      calleeNumber: serializer.fromJson<String?>(json['calleeNumber']),
      caller: serializer.fromJson<String>(json['caller']),
      callerNumber: serializer.fromJson<String?>(json['callerNumber']),
      connectTimeUsec: serializer.fromJson<int>(json['connectTimeUsec']),
      disconnectTimeUsec: serializer.fromJson<int>(json['disconnectTimeUsec']),
      disconnectReason: serializer.fromJson<String>(json['disconnectReason']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      recordingId: serializer.fromJson<String?>(json['recordingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'callId': serializer.toJson<String>(callId),
      'direction': serializer.toJson<String>(
        $CdrTableTable.$converterdirection.toJson(direction),
      ),
      'status': serializer.toJson<String>(
        $CdrTableTable.$converterstatus.toJson(status),
      ),
      'callee': serializer.toJson<String>(callee),
      'calleeNumber': serializer.toJson<String?>(calleeNumber),
      'caller': serializer.toJson<String>(caller),
      'callerNumber': serializer.toJson<String?>(callerNumber),
      'connectTimeUsec': serializer.toJson<int>(connectTimeUsec),
      'disconnectTimeUsec': serializer.toJson<int>(disconnectTimeUsec),
      'disconnectReason': serializer.toJson<String>(disconnectReason),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'recordingId': serializer.toJson<String?>(recordingId),
    };
  }

  CdrRecordData copyWith({
    String? callId,
    CallDirectionData? direction,
    CdrStatusData? status,
    String? callee,
    Value<String?> calleeNumber = const Value.absent(),
    String? caller,
    Value<String?> callerNumber = const Value.absent(),
    int? connectTimeUsec,
    int? disconnectTimeUsec,
    String? disconnectReason,
    int? durationSeconds,
    Value<String?> recordingId = const Value.absent(),
  }) =>
      CdrRecordData(
        callId: callId ?? this.callId,
        direction: direction ?? this.direction,
        status: status ?? this.status,
        callee: callee ?? this.callee,
        calleeNumber:
            calleeNumber.present ? calleeNumber.value : this.calleeNumber,
        caller: caller ?? this.caller,
        callerNumber:
            callerNumber.present ? callerNumber.value : this.callerNumber,
        connectTimeUsec: connectTimeUsec ?? this.connectTimeUsec,
        disconnectTimeUsec: disconnectTimeUsec ?? this.disconnectTimeUsec,
        disconnectReason: disconnectReason ?? this.disconnectReason,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        recordingId: recordingId.present ? recordingId.value : this.recordingId,
      );
  CdrRecordData copyWithCompanion(CdrRecordDataCompanion data) {
    return CdrRecordData(
      callId: data.callId.present ? data.callId.value : this.callId,
      direction: data.direction.present ? data.direction.value : this.direction,
      status: data.status.present ? data.status.value : this.status,
      callee: data.callee.present ? data.callee.value : this.callee,
      calleeNumber: data.calleeNumber.present
          ? data.calleeNumber.value
          : this.calleeNumber,
      caller: data.caller.present ? data.caller.value : this.caller,
      callerNumber: data.callerNumber.present
          ? data.callerNumber.value
          : this.callerNumber,
      connectTimeUsec: data.connectTimeUsec.present
          ? data.connectTimeUsec.value
          : this.connectTimeUsec,
      disconnectTimeUsec: data.disconnectTimeUsec.present
          ? data.disconnectTimeUsec.value
          : this.disconnectTimeUsec,
      disconnectReason: data.disconnectReason.present
          ? data.disconnectReason.value
          : this.disconnectReason,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      recordingId:
          data.recordingId.present ? data.recordingId.value : this.recordingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CdrRecordData(')
          ..write('callId: $callId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('callee: $callee, ')
          ..write('calleeNumber: $calleeNumber, ')
          ..write('caller: $caller, ')
          ..write('callerNumber: $callerNumber, ')
          ..write('connectTimeUsec: $connectTimeUsec, ')
          ..write('disconnectTimeUsec: $disconnectTimeUsec, ')
          ..write('disconnectReason: $disconnectReason, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('recordingId: $recordingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        callId,
        direction,
        status,
        callee,
        calleeNumber,
        caller,
        callerNumber,
        connectTimeUsec,
        disconnectTimeUsec,
        disconnectReason,
        durationSeconds,
        recordingId,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CdrRecordData &&
          other.callId == this.callId &&
          other.direction == this.direction &&
          other.status == this.status &&
          other.callee == this.callee &&
          other.calleeNumber == this.calleeNumber &&
          other.caller == this.caller &&
          other.callerNumber == this.callerNumber &&
          other.connectTimeUsec == this.connectTimeUsec &&
          other.disconnectTimeUsec == this.disconnectTimeUsec &&
          other.disconnectReason == this.disconnectReason &&
          other.durationSeconds == this.durationSeconds &&
          other.recordingId == this.recordingId);
}

class CdrRecordDataCompanion extends UpdateCompanion<CdrRecordData> {
  final Value<String> callId;
  final Value<CallDirectionData> direction;
  final Value<CdrStatusData> status;
  final Value<String> callee;
  final Value<String?> calleeNumber;
  final Value<String> caller;
  final Value<String?> callerNumber;
  final Value<int> connectTimeUsec;
  final Value<int> disconnectTimeUsec;
  final Value<String> disconnectReason;
  final Value<int> durationSeconds;
  final Value<String?> recordingId;
  final Value<int> rowid;
  const CdrRecordDataCompanion({
    this.callId = const Value.absent(),
    this.direction = const Value.absent(),
    this.status = const Value.absent(),
    this.callee = const Value.absent(),
    this.calleeNumber = const Value.absent(),
    this.caller = const Value.absent(),
    this.callerNumber = const Value.absent(),
    this.connectTimeUsec = const Value.absent(),
    this.disconnectTimeUsec = const Value.absent(),
    this.disconnectReason = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.recordingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CdrRecordDataCompanion.insert({
    required String callId,
    required CallDirectionData direction,
    required CdrStatusData status,
    required String callee,
    this.calleeNumber = const Value.absent(),
    required String caller,
    this.callerNumber = const Value.absent(),
    required int connectTimeUsec,
    required int disconnectTimeUsec,
    required String disconnectReason,
    required int durationSeconds,
    this.recordingId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : callId = Value(callId),
        direction = Value(direction),
        status = Value(status),
        callee = Value(callee),
        caller = Value(caller),
        connectTimeUsec = Value(connectTimeUsec),
        disconnectTimeUsec = Value(disconnectTimeUsec),
        disconnectReason = Value(disconnectReason),
        durationSeconds = Value(durationSeconds);
  static Insertable<CdrRecordData> custom({
    Expression<String>? callId,
    Expression<String>? direction,
    Expression<String>? status,
    Expression<String>? callee,
    Expression<String>? calleeNumber,
    Expression<String>? caller,
    Expression<String>? callerNumber,
    Expression<int>? connectTimeUsec,
    Expression<int>? disconnectTimeUsec,
    Expression<String>? disconnectReason,
    Expression<int>? durationSeconds,
    Expression<String>? recordingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (callId != null) 'call_id': callId,
      if (direction != null) 'direction': direction,
      if (status != null) 'status': status,
      if (callee != null) 'callee': callee,
      if (calleeNumber != null) 'callee_number': calleeNumber,
      if (caller != null) 'caller': caller,
      if (callerNumber != null) 'caller_number': callerNumber,
      if (connectTimeUsec != null) 'connect_time_usec': connectTimeUsec,
      if (disconnectTimeUsec != null)
        'disconnect_time_usec': disconnectTimeUsec,
      if (disconnectReason != null) 'disconnect_reason': disconnectReason,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (recordingId != null) 'recording_id': recordingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CdrRecordDataCompanion copyWith({
    Value<String>? callId,
    Value<CallDirectionData>? direction,
    Value<CdrStatusData>? status,
    Value<String>? callee,
    Value<String?>? calleeNumber,
    Value<String>? caller,
    Value<String?>? callerNumber,
    Value<int>? connectTimeUsec,
    Value<int>? disconnectTimeUsec,
    Value<String>? disconnectReason,
    Value<int>? durationSeconds,
    Value<String?>? recordingId,
    Value<int>? rowid,
  }) {
    return CdrRecordDataCompanion(
      callId: callId ?? this.callId,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      callee: callee ?? this.callee,
      calleeNumber: calleeNumber ?? this.calleeNumber,
      caller: caller ?? this.caller,
      callerNumber: callerNumber ?? this.callerNumber,
      connectTimeUsec: connectTimeUsec ?? this.connectTimeUsec,
      disconnectTimeUsec: disconnectTimeUsec ?? this.disconnectTimeUsec,
      disconnectReason: disconnectReason ?? this.disconnectReason,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      recordingId: recordingId ?? this.recordingId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (callId.present) {
      map['call_id'] = Variable<String>(callId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(
        $CdrTableTable.$converterdirection.toSql(direction.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CdrTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (callee.present) {
      map['callee'] = Variable<String>(callee.value);
    }
    if (calleeNumber.present) {
      map['callee_number'] = Variable<String>(calleeNumber.value);
    }
    if (caller.present) {
      map['caller'] = Variable<String>(caller.value);
    }
    if (callerNumber.present) {
      map['caller_number'] = Variable<String>(callerNumber.value);
    }
    if (connectTimeUsec.present) {
      map['connect_time_usec'] = Variable<int>(connectTimeUsec.value);
    }
    if (disconnectTimeUsec.present) {
      map['disconnect_time_usec'] = Variable<int>(disconnectTimeUsec.value);
    }
    if (disconnectReason.present) {
      map['disconnect_reason'] = Variable<String>(disconnectReason.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (recordingId.present) {
      map['recording_id'] = Variable<String>(recordingId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CdrRecordDataCompanion(')
          ..write('callId: $callId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('callee: $callee, ')
          ..write('calleeNumber: $calleeNumber, ')
          ..write('caller: $caller, ')
          ..write('callerNumber: $callerNumber, ')
          ..write('connectTimeUsec: $connectTimeUsec, ')
          ..write('disconnectTimeUsec: $disconnectTimeUsec, ')
          ..write('disconnectReason: $disconnectReason, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('recordingId: $recordingId, ')
          ..write('rowid: $rowid')
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
  late final $ChatMembersTableTable chatMembersTable = $ChatMembersTableTable(
    this,
  );
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
  late final $ChatOutboxReadCursorsTableTable chatOutboxReadCursorsTable =
      $ChatOutboxReadCursorsTableTable(this);
  late final $SmsConversationsTableTable smsConversationsTable =
      $SmsConversationsTableTable(this);
  late final $SmsMessagesTableTable smsMessagesTable = $SmsMessagesTableTable(
    this,
  );
  late final $SmsMessageSyncCursorTableTable smsMessageSyncCursorTable =
      $SmsMessageSyncCursorTableTable(this);
  late final $SmsMessageReadCursorTableTable smsMessageReadCursorTable =
      $SmsMessageReadCursorTableTable(this);
  late final $SmsOutboxMessagesTableTable smsOutboxMessagesTable =
      $SmsOutboxMessagesTableTable(this);
  late final $SmsOutboxMessageDeleteTableTable smsOutboxMessageDeleteTable =
      $SmsOutboxMessageDeleteTableTable(this);
  late final $SmsOutboxReadCursorsTableTable smsOutboxReadCursorsTable =
      $SmsOutboxReadCursorsTableTable(this);
  late final $UserSmsNumbersTableTable userSmsNumbersTable =
      $UserSmsNumbersTableTable(this);
  late final $ActiveMessageNotificationsTableTable
      activeMessageNotificationsTable =
      $ActiveMessageNotificationsTableTable(this);
  late final $VoicemailTableTable voicemailTable = $VoicemailTableTable(this);
  late final $SystemNotificationsTableTable systemNotificationsTable =
      $SystemNotificationsTableTable(this);
  late final $SystemNotificationsOutboxTableTable
      systemNotificationsOutboxTable =
      $SystemNotificationsOutboxTableTable(this);
  late final $PresenceInfoTableTable presenceInfoTable =
      $PresenceInfoTableTable(this);
  late final $CdrTableTable cdrTable = $CdrTableTable(this);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ContactPhonesDao contactPhonesDao = ContactPhonesDao(
    this as AppDatabase,
  );
  late final ContactEmailsDao contactEmailsDao = ContactEmailsDao(
    this as AppDatabase,
  );
  late final CallLogsDao callLogsDao = CallLogsDao(this as AppDatabase);
  late final RecentsDao recentsDao = RecentsDao(this as AppDatabase);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  late final ChatsDao chatsDao = ChatsDao(this as AppDatabase);
  late final SmsDao smsDao = SmsDao(this as AppDatabase);
  late final ActiveMessageNotificationsDao activeMessageNotificationsDao =
      ActiveMessageNotificationsDao(this as AppDatabase);
  late final VoicemailDao voicemailDao = VoicemailDao(this as AppDatabase);
  late final SystemNotificationsDao systemNotificationsDao =
      SystemNotificationsDao(this as AppDatabase);
  late final PresenceInfoDao presenceInfoDao = PresenceInfoDao(
    this as AppDatabase,
  );
  late final CdrsDao cdrsDao = CdrsDao(this as AppDatabase);
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
        chatOutboxReadCursorsTable,
        smsConversationsTable,
        smsMessagesTable,
        smsMessageSyncCursorTable,
        smsMessageReadCursorTable,
        smsOutboxMessagesTable,
        smsOutboxMessageDeleteTable,
        smsOutboxReadCursorsTable,
        userSmsNumbersTable,
        activeMessageNotificationsTable,
        voicemailTable,
        systemNotificationsTable,
        systemNotificationsOutboxTable,
        presenceInfoTable,
        cdrTable,
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'contacts',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [TableUpdate('contact_phones', kind: UpdateKind.delete)],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [TableUpdate('chat_members', kind: UpdateKind.delete)],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [TableUpdate('chat_messages', kind: UpdateKind.delete)],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_message_sync_cursors', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_message_read_cursors', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_outbox_messages', kind: UpdateKind.delete)
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_outbox_message_edits', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_outbox_message_deletes', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'chats',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('chat_outbox_read_cursors', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [TableUpdate('sms_messages', kind: UpdateKind.delete)],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('sms_message_sync_cursors', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('sms_message_read_cursors', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [TableUpdate('sms_outbox_messages', kind: UpdateKind.delete)],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('sms_outbox_message_deletes', kind: UpdateKind.delete),
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'sms_conversations',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('sms_outbox_read_cursors', kind: UpdateKind.delete)
          ],
        ),
        WritePropagation(
          on: TableUpdateQuery.onTableName(
            'system_notifications',
            limitUpdateKind: UpdateKind.delete,
          ),
          result: [
            TableUpdate('system_notifications_outbox', kind: UpdateKind.delete),
          ],
        ),
      ]);
}

typedef $$ContactsTableTableCreateCompanionBuilder = ContactDataCompanion
    Function({
  Value<int> id,
  required ContactSourceTypeEnum sourceType,
  Value<String?> sourceId,
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
  Value<String?> sourceId,
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

final class $$ContactsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTableTable, ContactData> {
  $$ContactsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ContactPhonesTableTable, List<ContactPhoneData>>
      _contactPhonesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
            db.contactPhonesTable,
            aliasName: $_aliasNameGenerator(
              db.contactsTable.id,
              db.contactPhonesTable.contactId,
            ),
          );

  $$ContactPhonesTableTableProcessedTableManager get contactPhonesTableRefs {
    final manager = $$ContactPhonesTableTableTableManager(
      $_db,
      $_db.contactPhonesTable,
    ).filter((f) => f.contactId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _contactPhonesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContactsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTableTable> {
  $$ContactsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<
          ContactSourceTypeEnum, ContactSourceTypeEnum, int>
      get sourceType => $composableBuilder(
            column: $table.sourceType,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<String> get sourceId => $composableBuilder(
        column: $table.sourceId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get firstName => $composableBuilder(
        column: $table.firstName,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get lastName => $composableBuilder(
        column: $table.lastName,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get aliasName => $composableBuilder(
        column: $table.aliasName,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<Uint8List> get thumbnail => $composableBuilder(
        column: $table.thumbnail,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get registered => $composableBuilder(
        column: $table.registered,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get userRegistered => $composableBuilder(
        column: $table.userRegistered,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get isCurrentUser => $composableBuilder(
        column: $table.isCurrentUser,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnFilters(column),
      );

  Expression<bool> contactPhonesTableRefs(
    Expression<bool> Function($$ContactPhonesTableTableFilterComposer f) f,
  ) {
    final $$ContactPhonesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contactPhonesTable,
      getReferencedColumn: (t) => t.contactId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ContactPhonesTableTableFilterComposer(
        $db: $db,
        $table: $db.contactPhonesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$ContactsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTableTable> {
  $$ContactsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sourceType => $composableBuilder(
        column: $table.sourceType,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get sourceId => $composableBuilder(
        column: $table.sourceId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get firstName => $composableBuilder(
        column: $table.firstName,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get lastName => $composableBuilder(
        column: $table.lastName,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get aliasName => $composableBuilder(
        column: $table.aliasName,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<Uint8List> get thumbnail => $composableBuilder(
        column: $table.thumbnail,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get registered => $composableBuilder(
        column: $table.registered,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get userRegistered => $composableBuilder(
        column: $table.userRegistered,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get isCurrentUser => $composableBuilder(
        column: $table.isCurrentUser,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$ContactsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTableTable> {
  $$ContactsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContactSourceTypeEnum, int> get sourceType =>
      $composableBuilder(
        column: $table.sourceType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get aliasName =>
      $composableBuilder(column: $table.aliasName, builder: (column) => column);

  GeneratedColumn<Uint8List> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  GeneratedColumn<bool> get registered => $composableBuilder(
        column: $table.registered,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get userRegistered => $composableBuilder(
        column: $table.userRegistered,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isCurrentUser => $composableBuilder(
        column: $table.isCurrentUser,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> contactPhonesTableRefs<T extends Object>(
    Expression<T> Function($$ContactPhonesTableTableAnnotationComposer a) f,
  ) {
    final $$ContactPhonesTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contactPhonesTable,
      getReferencedColumn: (t) => t.contactId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ContactPhonesTableTableAnnotationComposer(
        $db: $db,
        $table: $db.contactPhonesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$ContactsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTableTable,
    ContactData,
    $$ContactsTableTableFilterComposer,
    $$ContactsTableTableOrderingComposer,
    $$ContactsTableTableAnnotationComposer,
    $$ContactsTableTableCreateCompanionBuilder,
    $$ContactsTableTableUpdateCompanionBuilder,
    (ContactData, $$ContactsTableTableReferences),
    ContactData,
    PrefetchHooks Function({bool contactPhonesTableRefs})> {
  $$ContactsTableTableTableManager(_$AppDatabase db, $ContactsTableTable table)
      : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ContactsTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ContactsTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ContactsTableTableAnnotationComposer($db: db, $table: table),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<ContactSourceTypeEnum> sourceType = const Value.absent(),
              Value<String?> sourceId = const Value.absent(),
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
              Value<String?> sourceId = const Value.absent(),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ContactsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({contactPhonesTableRefs = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [
                  if (contactPhonesTableRefs) db.contactPhonesTable,
                ],
                addJoins: null,
                getPrefetchedDataCallback: (items) async {
                  return [
                    if (contactPhonesTableRefs)
                      await $_getPrefetchedData<ContactData,
                          $ContactsTableTable, ContactPhoneData>(
                        currentTable: table,
                        referencedTable: $$ContactsTableTableReferences
                            ._contactPhonesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).contactPhonesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items,
                      ),
                  ];
                },
              );
            },
          ),
        );
}

typedef $$ContactsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTableTable,
    ContactData,
    $$ContactsTableTableFilterComposer,
    $$ContactsTableTableOrderingComposer,
    $$ContactsTableTableAnnotationComposer,
    $$ContactsTableTableCreateCompanionBuilder,
    $$ContactsTableTableUpdateCompanionBuilder,
    (ContactData, $$ContactsTableTableReferences),
    ContactData,
    PrefetchHooks Function({bool contactPhonesTableRefs})>;
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

final class $$ContactPhonesTableTableReferences extends BaseReferences<
    _$AppDatabase, $ContactPhonesTableTable, ContactPhoneData> {
  $$ContactPhonesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContactsTableTable _contactIdTable(_$AppDatabase db) =>
      db.contactsTable.createAlias(
        $_aliasNameGenerator(
          db.contactPhonesTable.contactId,
          db.contactsTable.id,
        ),
      );

  $$ContactsTableTableProcessedTableManager get contactId {
    final $_column = $_itemColumn<int>('contact_id')!;

    final manager = $$ContactsTableTableTableManager(
      $_db,
      $_db.contactsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContactPhonesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ContactPhonesTableTable> {
  $$ContactPhonesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get label => $composableBuilder(
        column: $table.label,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnFilters(column),
      );

  $$ContactsTableTableFilterComposer get contactId {
    final $$ContactsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contactsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ContactsTableTableFilterComposer(
        $db: $db,
        $table: $db.contactsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ContactPhonesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactPhonesTableTable> {
  $$ContactPhonesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get label => $composableBuilder(
        column: $table.label,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnOrderings(column),
      );

  $$ContactsTableTableOrderingComposer get contactId {
    final $$ContactsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contactsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ContactsTableTableOrderingComposer(
        $db: $db,
        $table: $db.contactsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ContactPhonesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactPhonesTableTable> {
  $$ContactPhonesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ContactsTableTableAnnotationComposer get contactId {
    final $$ContactsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contactsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ContactsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.contactsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ContactPhonesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactPhonesTableTable,
    ContactPhoneData,
    $$ContactPhonesTableTableFilterComposer,
    $$ContactPhonesTableTableOrderingComposer,
    $$ContactPhonesTableTableAnnotationComposer,
    $$ContactPhonesTableTableCreateCompanionBuilder,
    $$ContactPhonesTableTableUpdateCompanionBuilder,
    (ContactPhoneData, $$ContactPhonesTableTableReferences),
    ContactPhoneData,
    PrefetchHooks Function({bool contactId})> {
  $$ContactPhonesTableTableTableManager(
    _$AppDatabase db,
    $ContactPhonesTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ContactPhonesTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ContactPhonesTableTableOrderingComposer(
                    $db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ContactPhonesTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ContactPhonesTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({contactId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (contactId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.contactId,
                      referencedTable: $$ContactPhonesTableTableReferences
                          ._contactIdTable(db),
                      referencedColumn: $$ContactPhonesTableTableReferences
                          ._contactIdTable(db)
                          .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ContactPhonesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactPhonesTableTable,
    ContactPhoneData,
    $$ContactPhonesTableTableFilterComposer,
    $$ContactPhonesTableTableOrderingComposer,
    $$ContactPhonesTableTableAnnotationComposer,
    $$ContactPhonesTableTableCreateCompanionBuilder,
    $$ContactPhonesTableTableUpdateCompanionBuilder,
    (ContactPhoneData, $$ContactPhonesTableTableReferences),
    ContactPhoneData,
    PrefetchHooks Function({bool contactId})>;
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

class $$ContactEmailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ContactEmailsTableTable> {
  $$ContactEmailsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get address => $composableBuilder(
        column: $table.address,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get label => $composableBuilder(
        column: $table.label,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get contactId => $composableBuilder(
        column: $table.contactId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnFilters(column),
      );
}

class $$ContactEmailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactEmailsTableTable> {
  $$ContactEmailsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get address => $composableBuilder(
        column: $table.address,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get label => $composableBuilder(
        column: $table.label,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get contactId => $composableBuilder(
        column: $table.contactId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$ContactEmailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactEmailsTableTable> {
  $$ContactEmailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<DateTime> get insertedAt => $composableBuilder(
        column: $table.insertedAt,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ContactEmailsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactEmailsTableTable,
    ContactEmailData,
    $$ContactEmailsTableTableFilterComposer,
    $$ContactEmailsTableTableOrderingComposer,
    $$ContactEmailsTableTableAnnotationComposer,
    $$ContactEmailsTableTableCreateCompanionBuilder,
    $$ContactEmailsTableTableUpdateCompanionBuilder,
    (
      ContactEmailData,
      BaseReferences<_$AppDatabase, $ContactEmailsTableTable, ContactEmailData>,
    ),
    ContactEmailData,
    PrefetchHooks Function()> {
  $$ContactEmailsTableTableTableManager(
    _$AppDatabase db,
    $ContactEmailsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ContactEmailsTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ContactEmailsTableTableOrderingComposer(
                    $db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ContactEmailsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$ContactEmailsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactEmailsTableTable,
    ContactEmailData,
    $$ContactEmailsTableTableFilterComposer,
    $$ContactEmailsTableTableOrderingComposer,
    $$ContactEmailsTableTableAnnotationComposer,
    $$ContactEmailsTableTableCreateCompanionBuilder,
    $$ContactEmailsTableTableUpdateCompanionBuilder,
    (
      ContactEmailData,
      BaseReferences<_$AppDatabase, $ContactEmailsTableTable, ContactEmailData>,
    ),
    ContactEmailData,
    PrefetchHooks Function()>;
typedef $$CallLogsTableTableCreateCompanionBuilder = CallLogDataCompanion
    Function({
  Value<int> id,
  required CallLogDirectionEnum direction,
  required String number,
  Value<String?> username,
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
  Value<String?> username,
  Value<bool> video,
  Value<DateTime> createdAt,
  Value<DateTime?> acceptedAt,
  Value<DateTime?> hungUpAt,
});

class $$CallLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CallLogsTableTable> {
  $$CallLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<
          CallLogDirectionEnum, CallLogDirectionEnum, int>
      get direction => $composableBuilder(
            column: $table.direction,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get username => $composableBuilder(
        column: $table.username,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get video => $composableBuilder(
        column: $table.video,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
        column: $table.createdAt,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get acceptedAt => $composableBuilder(
        column: $table.acceptedAt,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get hungUpAt => $composableBuilder(
        column: $table.hungUpAt,
        builder: (column) => ColumnFilters(column),
      );
}

class $$CallLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CallLogsTableTable> {
  $$CallLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get direction => $composableBuilder(
        column: $table.direction,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get username => $composableBuilder(
        column: $table.username,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get video => $composableBuilder(
        column: $table.video,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
        column: $table.createdAt,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get acceptedAt => $composableBuilder(
        column: $table.acceptedAt,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get hungUpAt => $composableBuilder(
        column: $table.hungUpAt,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$CallLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CallLogsTableTable> {
  $$CallLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CallLogDirectionEnum, int> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<bool> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get acceptedAt => $composableBuilder(
        column: $table.acceptedAt,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get hungUpAt =>
      $composableBuilder(column: $table.hungUpAt, builder: (column) => column);
}

class $$CallLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CallLogsTableTable,
    CallLogData,
    $$CallLogsTableTableFilterComposer,
    $$CallLogsTableTableOrderingComposer,
    $$CallLogsTableTableAnnotationComposer,
    $$CallLogsTableTableCreateCompanionBuilder,
    $$CallLogsTableTableUpdateCompanionBuilder,
    (
      CallLogData,
      BaseReferences<_$AppDatabase, $CallLogsTableTable, CallLogData>,
    ),
    CallLogData,
    PrefetchHooks Function()> {
  $$CallLogsTableTableTableManager(_$AppDatabase db, $CallLogsTableTable table)
      : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$CallLogsTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$CallLogsTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$CallLogsTableTableAnnotationComposer($db: db, $table: table),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<CallLogDirectionEnum> direction = const Value.absent(),
              Value<String> number = const Value.absent(),
              Value<String?> username = const Value.absent(),
              Value<bool> video = const Value.absent(),
              Value<DateTime> createdAt = const Value.absent(),
              Value<DateTime?> acceptedAt = const Value.absent(),
              Value<DateTime?> hungUpAt = const Value.absent(),
            }) =>
                CallLogDataCompanion(
              id: id,
              direction: direction,
              number: number,
              username: username,
              video: video,
              createdAt: createdAt,
              acceptedAt: acceptedAt,
              hungUpAt: hungUpAt,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required CallLogDirectionEnum direction,
              required String number,
              Value<String?> username = const Value.absent(),
              required bool video,
              required DateTime createdAt,
              Value<DateTime?> acceptedAt = const Value.absent(),
              Value<DateTime?> hungUpAt = const Value.absent(),
            }) =>
                CallLogDataCompanion.insert(
              id: id,
              direction: direction,
              number: number,
              username: username,
              video: video,
              createdAt: createdAt,
              acceptedAt: acceptedAt,
              hungUpAt: hungUpAt,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$CallLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CallLogsTableTable,
    CallLogData,
    $$CallLogsTableTableFilterComposer,
    $$CallLogsTableTableOrderingComposer,
    $$CallLogsTableTableAnnotationComposer,
    $$CallLogsTableTableCreateCompanionBuilder,
    $$CallLogsTableTableUpdateCompanionBuilder,
    (
      CallLogData,
      BaseReferences<_$AppDatabase, $CallLogsTableTable, CallLogData>,
    ),
    CallLogData,
    PrefetchHooks Function()>;
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

class $$FavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get contactPhoneId => $composableBuilder(
        column: $table.contactPhoneId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get position => $composableBuilder(
        column: $table.position,
        builder: (column) => ColumnFilters(column),
      );
}

class $$FavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get contactPhoneId => $composableBuilder(
        column: $table.contactPhoneId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get position => $composableBuilder(
        column: $table.position,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$FavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get contactPhoneId => $composableBuilder(
        column: $table.contactPhoneId,
        builder: (column) => column,
      );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$FavoritesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoritesTableTable,
    FavoriteData,
    $$FavoritesTableTableFilterComposer,
    $$FavoritesTableTableOrderingComposer,
    $$FavoritesTableTableAnnotationComposer,
    $$FavoritesTableTableCreateCompanionBuilder,
    $$FavoritesTableTableUpdateCompanionBuilder,
    (
      FavoriteData,
      BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteData>,
    ),
    FavoriteData,
    PrefetchHooks Function()> {
  $$FavoritesTableTableTableManager(
    _$AppDatabase db,
    $FavoritesTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$FavoritesTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$FavoritesTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$FavoritesTableTableAnnotationComposer($db: db, $table: table),
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
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$FavoritesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoritesTableTable,
    FavoriteData,
    $$FavoritesTableTableFilterComposer,
    $$FavoritesTableTableOrderingComposer,
    $$FavoritesTableTableAnnotationComposer,
    $$FavoritesTableTableCreateCompanionBuilder,
    $$FavoritesTableTableUpdateCompanionBuilder,
    (
      FavoriteData,
      BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteData>,
    ),
    FavoriteData,
    PrefetchHooks Function()>;
typedef $$ChatsTableTableCreateCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  required ChatTypeEnum type,
  Value<String?> name,
  required DateTime createdAtRemote,
  required DateTime updatedAtRemote,
});
typedef $$ChatsTableTableUpdateCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  Value<ChatTypeEnum> type,
  Value<String?> name,
  Value<DateTime> createdAtRemote,
  Value<DateTime> updatedAtRemote,
});

final class $$ChatsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ChatsTableTable, ChatData> {
  $$ChatsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatMembersTableTable, List<ChatMemberData>>
      _chatMembersTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
            db.chatMembersTable,
            aliasName: $_aliasNameGenerator(
              db.chatsTable.id,
              db.chatMembersTable.chatId,
            ),
          );

  $$ChatMembersTableTableProcessedTableManager get chatMembersTableRefs {
    final manager = $$ChatMembersTableTableTableManager(
      $_db,
      $_db.chatMembersTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatMembersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatMessagesTableTable, List<ChatMessageData>>
      _chatMessagesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
            db.chatMessagesTable,
            aliasName: $_aliasNameGenerator(
              db.chatsTable.id,
              db.chatMessagesTable.chatId,
            ),
          );

  $$ChatMessagesTableTableProcessedTableManager get chatMessagesTableRefs {
    final manager = $$ChatMessagesTableTableTableManager(
      $_db,
      $_db.chatMessagesTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatMessagesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatMessageSyncCursorTableTable,
      List<ChatMessageSyncCursorData>> _chatMessageSyncCursorTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatMessageSyncCursorTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatMessageSyncCursorTable.chatId,
        ),
      );

  $$ChatMessageSyncCursorTableTableProcessedTableManager
      get chatMessageSyncCursorTableRefs {
    final manager = $$ChatMessageSyncCursorTableTableTableManager(
      $_db,
      $_db.chatMessageSyncCursorTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatMessageSyncCursorTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatMessageReadCursorTableTable,
      List<ChatMessageReadCursorData>> _chatMessageReadCursorTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatMessageReadCursorTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatMessageReadCursorTable.chatId,
        ),
      );

  $$ChatMessageReadCursorTableTableProcessedTableManager
      get chatMessageReadCursorTableRefs {
    final manager = $$ChatMessageReadCursorTableTableTableManager(
      $_db,
      $_db.chatMessageReadCursorTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatMessageReadCursorTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatOutboxMessageTableTable,
      List<ChatOutboxMessageData>> _chatOutboxMessageTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatOutboxMessageTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatOutboxMessageTable.chatId,
        ),
      );

  $$ChatOutboxMessageTableTableProcessedTableManager
      get chatOutboxMessageTableRefs {
    final manager = $$ChatOutboxMessageTableTableTableManager(
      $_db,
      $_db.chatOutboxMessageTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatOutboxMessageTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatOutboxMessageEditTableTable,
      List<ChatOutboxMessageEditData>> _chatOutboxMessageEditTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatOutboxMessageEditTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatOutboxMessageEditTable.chatId,
        ),
      );

  $$ChatOutboxMessageEditTableTableProcessedTableManager
      get chatOutboxMessageEditTableRefs {
    final manager = $$ChatOutboxMessageEditTableTableTableManager(
      $_db,
      $_db.chatOutboxMessageEditTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatOutboxMessageEditTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatOutboxMessageDeleteTableTable,
      List<ChatOutboxMessageDeleteData>> _chatOutboxMessageDeleteTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatOutboxMessageDeleteTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatOutboxMessageDeleteTable.chatId,
        ),
      );

  $$ChatOutboxMessageDeleteTableTableProcessedTableManager
      get chatOutboxMessageDeleteTableRefs {
    final manager = $$ChatOutboxMessageDeleteTableTableTableManager(
      $_db,
      $_db.chatOutboxMessageDeleteTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatOutboxMessageDeleteTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatOutboxReadCursorsTableTable,
      List<ChatOutboxReadCursorData>> _chatOutboxReadCursorsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatOutboxReadCursorsTable,
        aliasName: $_aliasNameGenerator(
          db.chatsTable.id,
          db.chatOutboxReadCursorsTable.chatId,
        ),
      );

  $$ChatOutboxReadCursorsTableTableProcessedTableManager
      get chatOutboxReadCursorsTableRefs {
    final manager = $$ChatOutboxReadCursorsTableTableTableManager(
      $_db,
      $_db.chatOutboxReadCursorsTable,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatOutboxReadCursorsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<ChatTypeEnum, ChatTypeEnum, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
        column: $table.name,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => ColumnFilters(column),
      );

  Expression<bool> chatMembersTableRefs(
    Expression<bool> Function($$ChatMembersTableTableFilterComposer f) f,
  ) {
    final $$ChatMembersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMembersTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMembersTableTableFilterComposer(
        $db: $db,
        $table: $db.chatMembersTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatMessagesTableRefs(
    Expression<bool> Function($$ChatMessagesTableTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessagesTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessagesTableTableFilterComposer(
        $db: $db,
        $table: $db.chatMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatMessageSyncCursorTableRefs(
    Expression<bool> Function($$ChatMessageSyncCursorTableTableFilterComposer f)
        f,
  ) {
    final $$ChatMessageSyncCursorTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessageSyncCursorTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessageSyncCursorTableTableFilterComposer(
        $db: $db,
        $table: $db.chatMessageSyncCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatMessageReadCursorTableRefs(
    Expression<bool> Function($$ChatMessageReadCursorTableTableFilterComposer f)
        f,
  ) {
    final $$ChatMessageReadCursorTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessageReadCursorTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessageReadCursorTableTableFilterComposer(
        $db: $db,
        $table: $db.chatMessageReadCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatOutboxMessageTableRefs(
    Expression<bool> Function($$ChatOutboxMessageTableTableFilterComposer f) f,
  ) {
    final $$ChatOutboxMessageTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageTableTableFilterComposer(
        $db: $db,
        $table: $db.chatOutboxMessageTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatOutboxMessageEditTableRefs(
    Expression<bool> Function($$ChatOutboxMessageEditTableTableFilterComposer f)
        f,
  ) {
    final $$ChatOutboxMessageEditTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageEditTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageEditTableTableFilterComposer(
        $db: $db,
        $table: $db.chatOutboxMessageEditTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatOutboxMessageDeleteTableRefs(
    Expression<bool> Function(
      $$ChatOutboxMessageDeleteTableTableFilterComposer f,
    ) f,
  ) {
    final $$ChatOutboxMessageDeleteTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageDeleteTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageDeleteTableTableFilterComposer(
        $db: $db,
        $table: $db.chatOutboxMessageDeleteTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> chatOutboxReadCursorsTableRefs(
    Expression<bool> Function($$ChatOutboxReadCursorsTableTableFilterComposer f)
        f,
  ) {
    final $$ChatOutboxReadCursorsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxReadCursorsTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxReadCursorsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatOutboxReadCursorsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$ChatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get type => $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get name => $composableBuilder(
        column: $table.name,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$ChatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ChatTypeEnum, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => column,
      );

  Expression<T> chatMembersTableRefs<T extends Object>(
    Expression<T> Function($$ChatMembersTableTableAnnotationComposer a) f,
  ) {
    final $$ChatMembersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMembersTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMembersTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatMembersTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatMessagesTableRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessagesTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessagesTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatMessageSyncCursorTableRefs<T extends Object>(
    Expression<T> Function(
      $$ChatMessageSyncCursorTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$ChatMessageSyncCursorTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessageSyncCursorTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessageSyncCursorTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatMessageSyncCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatMessageReadCursorTableRefs<T extends Object>(
    Expression<T> Function(
      $$ChatMessageReadCursorTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$ChatMessageReadCursorTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessageReadCursorTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatMessageReadCursorTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatMessageReadCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatOutboxMessageTableRefs<T extends Object>(
    Expression<T> Function($$ChatOutboxMessageTableTableAnnotationComposer a) f,
  ) {
    final $$ChatOutboxMessageTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatOutboxMessageTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatOutboxMessageEditTableRefs<T extends Object>(
    Expression<T> Function(
      $$ChatOutboxMessageEditTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$ChatOutboxMessageEditTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageEditTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageEditTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatOutboxMessageEditTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatOutboxMessageDeleteTableRefs<T extends Object>(
    Expression<T> Function(
      $$ChatOutboxMessageDeleteTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$ChatOutboxMessageDeleteTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxMessageDeleteTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxMessageDeleteTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatOutboxMessageDeleteTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> chatOutboxReadCursorsTableRefs<T extends Object>(
    Expression<T> Function(
      $$ChatOutboxReadCursorsTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$ChatOutboxReadCursorsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatOutboxReadCursorsTable,
      getReferencedColumn: (t) => t.chatId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatOutboxReadCursorsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatOutboxReadCursorsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$ChatsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatsTableTable,
    ChatData,
    $$ChatsTableTableFilterComposer,
    $$ChatsTableTableOrderingComposer,
    $$ChatsTableTableAnnotationComposer,
    $$ChatsTableTableCreateCompanionBuilder,
    $$ChatsTableTableUpdateCompanionBuilder,
    (ChatData, $$ChatsTableTableReferences),
    ChatData,
    PrefetchHooks Function({
      bool chatMembersTableRefs,
      bool chatMessagesTableRefs,
      bool chatMessageSyncCursorTableRefs,
      bool chatMessageReadCursorTableRefs,
      bool chatOutboxMessageTableRefs,
      bool chatOutboxMessageEditTableRefs,
      bool chatOutboxMessageDeleteTableRefs,
      bool chatOutboxReadCursorsTableRefs,
    })> {
  $$ChatsTableTableTableManager(_$AppDatabase db, $ChatsTableTable table)
      : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatsTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ChatsTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ChatsTableTableAnnotationComposer($db: db, $table: table),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<ChatTypeEnum> type = const Value.absent(),
              Value<String?> name = const Value.absent(),
              Value<DateTime> createdAtRemote = const Value.absent(),
              Value<DateTime> updatedAtRemote = const Value.absent(),
            }) =>
                ChatDataCompanion(
              id: id,
              type: type,
              name: name,
              createdAtRemote: createdAtRemote,
              updatedAtRemote: updatedAtRemote,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required ChatTypeEnum type,
              Value<String?> name = const Value.absent(),
              required DateTime createdAtRemote,
              required DateTime updatedAtRemote,
            }) =>
                ChatDataCompanion.insert(
              id: id,
              type: type,
              name: name,
              createdAtRemote: createdAtRemote,
              updatedAtRemote: updatedAtRemote,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({
              chatMembersTableRefs = false,
              chatMessagesTableRefs = false,
              chatMessageSyncCursorTableRefs = false,
              chatMessageReadCursorTableRefs = false,
              chatOutboxMessageTableRefs = false,
              chatOutboxMessageEditTableRefs = false,
              chatOutboxMessageDeleteTableRefs = false,
              chatOutboxReadCursorsTableRefs = false,
            }) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [
                  if (chatMembersTableRefs) db.chatMembersTable,
                  if (chatMessagesTableRefs) db.chatMessagesTable,
                  if (chatMessageSyncCursorTableRefs)
                    db.chatMessageSyncCursorTable,
                  if (chatMessageReadCursorTableRefs)
                    db.chatMessageReadCursorTable,
                  if (chatOutboxMessageTableRefs) db.chatOutboxMessageTable,
                  if (chatOutboxMessageEditTableRefs)
                    db.chatOutboxMessageEditTable,
                  if (chatOutboxMessageDeleteTableRefs)
                    db.chatOutboxMessageDeleteTable,
                  if (chatOutboxReadCursorsTableRefs)
                    db.chatOutboxReadCursorsTable,
                ],
                addJoins: null,
                getPrefetchedDataCallback: (items) async {
                  return [
                    if (chatMembersTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatMemberData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatMembersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatMembersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatMessagesTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatMessageData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatMessagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatMessagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatMessageSyncCursorTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatMessageSyncCursorData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatMessageSyncCursorTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatMessageSyncCursorTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatMessageReadCursorTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatMessageReadCursorData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatMessageReadCursorTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatMessageReadCursorTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatOutboxMessageTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatOutboxMessageData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatOutboxMessageTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatOutboxMessageTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatOutboxMessageEditTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatOutboxMessageEditData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatOutboxMessageEditTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatOutboxMessageEditTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatOutboxMessageDeleteTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatOutboxMessageDeleteData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatOutboxMessageDeleteTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatOutboxMessageDeleteTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (chatOutboxReadCursorsTableRefs)
                      await $_getPrefetchedData<ChatData, $ChatsTableTable,
                          ChatOutboxReadCursorData>(
                        currentTable: table,
                        referencedTable: $$ChatsTableTableReferences
                            ._chatOutboxReadCursorsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).chatOutboxReadCursorsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.chatId == item.id,
                        ),
                        typedResults: items,
                      ),
                  ];
                },
              );
            },
          ),
        );
}

typedef $$ChatsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatsTableTable,
    ChatData,
    $$ChatsTableTableFilterComposer,
    $$ChatsTableTableOrderingComposer,
    $$ChatsTableTableAnnotationComposer,
    $$ChatsTableTableCreateCompanionBuilder,
    $$ChatsTableTableUpdateCompanionBuilder,
    (ChatData, $$ChatsTableTableReferences),
    ChatData,
    PrefetchHooks Function({
      bool chatMembersTableRefs,
      bool chatMessagesTableRefs,
      bool chatMessageSyncCursorTableRefs,
      bool chatMessageReadCursorTableRefs,
      bool chatOutboxMessageTableRefs,
      bool chatOutboxMessageEditTableRefs,
      bool chatOutboxMessageDeleteTableRefs,
      bool chatOutboxReadCursorsTableRefs,
    })>;
typedef $$ChatMembersTableTableCreateCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  required int chatId,
  required String userId,
  Value<GroupAuthoritiesEnum?> groupAuthorities,
});
typedef $$ChatMembersTableTableUpdateCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  Value<int> chatId,
  Value<String> userId,
  Value<GroupAuthoritiesEnum?> groupAuthorities,
});

final class $$ChatMembersTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatMembersTableTable, ChatMemberData> {
  $$ChatMembersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(db.chatMembersTable.chatId, db.chatsTable.id),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMembersTableTable> {
  $$ChatMembersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<
          GroupAuthoritiesEnum?, GroupAuthoritiesEnum, String>
      get groupAuthorities => $composableBuilder(
            column: $table.groupAuthorities,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMembersTableTable> {
  $$ChatMembersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get groupAuthorities => $composableBuilder(
        column: $table.groupAuthorities,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMembersTableTable> {
  $$ChatMembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GroupAuthoritiesEnum?, String>
      get groupAuthorities => $composableBuilder(
            column: $table.groupAuthorities,
            builder: (column) => column,
          );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMembersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMembersTableTable,
    ChatMemberData,
    $$ChatMembersTableTableFilterComposer,
    $$ChatMembersTableTableOrderingComposer,
    $$ChatMembersTableTableAnnotationComposer,
    $$ChatMembersTableTableCreateCompanionBuilder,
    $$ChatMembersTableTableUpdateCompanionBuilder,
    (ChatMemberData, $$ChatMembersTableTableReferences),
    ChatMemberData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatMembersTableTableTableManager(
    _$AppDatabase db,
    $ChatMembersTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatMembersTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ChatMembersTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ChatMembersTableTableAnnotationComposer(
                    $db: db, $table: table),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<int> chatId = const Value.absent(),
              Value<String> userId = const Value.absent(),
              Value<GroupAuthoritiesEnum?> groupAuthorities =
                  const Value.absent(),
            }) =>
                ChatMemberDataCompanion(
              id: id,
              chatId: chatId,
              userId: userId,
              groupAuthorities: groupAuthorities,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required int chatId,
              required String userId,
              Value<GroupAuthoritiesEnum?> groupAuthorities =
                  const Value.absent(),
            }) =>
                ChatMemberDataCompanion.insert(
              id: id,
              chatId: chatId,
              userId: userId,
              groupAuthorities: groupAuthorities,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatMembersTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatMembersTableTableReferences._chatIdTable(db),
                      referencedColumn:
                          $$ChatMembersTableTableReferences._chatIdTable(db).id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatMembersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMembersTableTable,
    ChatMemberData,
    $$ChatMembersTableTableFilterComposer,
    $$ChatMembersTableTableOrderingComposer,
    $$ChatMembersTableTableAnnotationComposer,
    $$ChatMembersTableTableCreateCompanionBuilder,
    $$ChatMembersTableTableUpdateCompanionBuilder,
    (ChatMemberData, $$ChatMembersTableTableReferences),
    ChatMemberData,
    PrefetchHooks Function({bool chatId})>;
typedef $$ChatMessagesTableTableCreateCompanionBuilder
    = ChatMessageDataCompanion Function({
  Value<int> id,
  required String idKey,
  required String senderId,
  required int chatId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
  required String content,
  required int createdAtRemoteUsec,
  required int updatedAtRemoteUsec,
  Value<int?> editedAtRemoteUsec,
  Value<int?> deletedAtRemoteUsec,
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
  Value<String> content,
  Value<int> createdAtRemoteUsec,
  Value<int> updatedAtRemoteUsec,
  Value<int?> editedAtRemoteUsec,
  Value<int?> deletedAtRemoteUsec,
});

final class $$ChatMessagesTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatMessagesTableTable, ChatMessageData> {
  $$ChatMessagesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(db.chatMessagesTable.chatId, db.chatsTable.id),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get senderId => $composableBuilder(
        column: $table.senderId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get replyToId => $composableBuilder(
        column: $table.replyToId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get authorId => $composableBuilder(
        column: $table.authorId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get editedAtRemoteUsec => $composableBuilder(
        column: $table.editedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get senderId => $composableBuilder(
        column: $table.senderId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get replyToId => $composableBuilder(
        column: $table.replyToId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get authorId => $composableBuilder(
        column: $table.authorId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get editedAtRemoteUsec => $composableBuilder(
        column: $table.editedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<int> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

  GeneratedColumn<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => column,
      );

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get editedAtRemoteUsec => $composableBuilder(
        column: $table.editedAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTableTable,
    ChatMessageData,
    $$ChatMessagesTableTableFilterComposer,
    $$ChatMessagesTableTableOrderingComposer,
    $$ChatMessagesTableTableAnnotationComposer,
    $$ChatMessagesTableTableCreateCompanionBuilder,
    $$ChatMessagesTableTableUpdateCompanionBuilder,
    (ChatMessageData, $$ChatMessagesTableTableReferences),
    ChatMessageData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatMessagesTableTableTableManager(
    _$AppDatabase db,
    $ChatMessagesTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatMessagesTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$ChatMessagesTableTableOrderingComposer(
                    $db: db, $table: table),
            createComputedFieldComposer: () =>
                $$ChatMessagesTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<String> idKey = const Value.absent(),
              Value<String> senderId = const Value.absent(),
              Value<int> chatId = const Value.absent(),
              Value<int?> replyToId = const Value.absent(),
              Value<int?> forwardFromId = const Value.absent(),
              Value<String?> authorId = const Value.absent(),
              Value<String> content = const Value.absent(),
              Value<int> createdAtRemoteUsec = const Value.absent(),
              Value<int> updatedAtRemoteUsec = const Value.absent(),
              Value<int?> editedAtRemoteUsec = const Value.absent(),
              Value<int?> deletedAtRemoteUsec = const Value.absent(),
            }) =>
                ChatMessageDataCompanion(
              id: id,
              idKey: idKey,
              senderId: senderId,
              chatId: chatId,
              replyToId: replyToId,
              forwardFromId: forwardFromId,
              authorId: authorId,
              content: content,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
              editedAtRemoteUsec: editedAtRemoteUsec,
              deletedAtRemoteUsec: deletedAtRemoteUsec,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required String idKey,
              required String senderId,
              required int chatId,
              Value<int?> replyToId = const Value.absent(),
              Value<int?> forwardFromId = const Value.absent(),
              Value<String?> authorId = const Value.absent(),
              required String content,
              required int createdAtRemoteUsec,
              required int updatedAtRemoteUsec,
              Value<int?> editedAtRemoteUsec = const Value.absent(),
              Value<int?> deletedAtRemoteUsec = const Value.absent(),
            }) =>
                ChatMessageDataCompanion.insert(
              id: id,
              idKey: idKey,
              senderId: senderId,
              chatId: chatId,
              replyToId: replyToId,
              forwardFromId: forwardFromId,
              authorId: authorId,
              content: content,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
              editedAtRemoteUsec: editedAtRemoteUsec,
              deletedAtRemoteUsec: deletedAtRemoteUsec,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatMessagesTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatMessagesTableTableReferences._chatIdTable(db),
                      referencedColumn: $$ChatMessagesTableTableReferences
                          ._chatIdTable(db)
                          .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatMessagesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessagesTableTable,
    ChatMessageData,
    $$ChatMessagesTableTableFilterComposer,
    $$ChatMessagesTableTableOrderingComposer,
    $$ChatMessagesTableTableAnnotationComposer,
    $$ChatMessagesTableTableCreateCompanionBuilder,
    $$ChatMessagesTableTableUpdateCompanionBuilder,
    (ChatMessageData, $$ChatMessagesTableTableReferences),
    ChatMessageData,
    PrefetchHooks Function({bool chatId})>;
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

final class $$ChatMessageSyncCursorTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $ChatMessageSyncCursorTableTable,
    ChatMessageSyncCursorData> {
  $$ChatMessageSyncCursorTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatMessageSyncCursorTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessageSyncCursorTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessageSyncCursorTableTable> {
  $$ChatMessageSyncCursorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<
          MessageSyncCursorTypeEnum, MessageSyncCursorTypeEnum, String>
      get cursorType => $composableBuilder(
            column: $table.cursorType,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageSyncCursorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessageSyncCursorTableTable> {
  $$ChatMessageSyncCursorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cursorType => $composableBuilder(
        column: $table.cursorType,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageSyncCursorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessageSyncCursorTableTable> {
  $$ChatMessageSyncCursorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<MessageSyncCursorTypeEnum, String>
      get cursorType => $composableBuilder(
            column: $table.cursorType,
            builder: (column) => column,
          );

  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageSyncCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessageSyncCursorTableTable,
    ChatMessageSyncCursorData,
    $$ChatMessageSyncCursorTableTableFilterComposer,
    $$ChatMessageSyncCursorTableTableOrderingComposer,
    $$ChatMessageSyncCursorTableTableAnnotationComposer,
    $$ChatMessageSyncCursorTableTableCreateCompanionBuilder,
    $$ChatMessageSyncCursorTableTableUpdateCompanionBuilder,
    (
      ChatMessageSyncCursorData,
      $$ChatMessageSyncCursorTableTableReferences,
    ),
    ChatMessageSyncCursorData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatMessageSyncCursorTableTableTableManager(
    _$AppDatabase db,
    $ChatMessageSyncCursorTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatMessageSyncCursorTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatMessageSyncCursorTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatMessageSyncCursorTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> chatId = const Value.absent(),
              Value<MessageSyncCursorTypeEnum> cursorType =
                  const Value.absent(),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatMessageSyncCursorTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatMessageSyncCursorTableTableReferences
                              ._chatIdTable(db),
                      referencedColumn:
                          $$ChatMessageSyncCursorTableTableReferences
                              ._chatIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatMessageSyncCursorTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatMessageSyncCursorTableTable,
        ChatMessageSyncCursorData,
        $$ChatMessageSyncCursorTableTableFilterComposer,
        $$ChatMessageSyncCursorTableTableOrderingComposer,
        $$ChatMessageSyncCursorTableTableAnnotationComposer,
        $$ChatMessageSyncCursorTableTableCreateCompanionBuilder,
        $$ChatMessageSyncCursorTableTableUpdateCompanionBuilder,
        (
          ChatMessageSyncCursorData,
          $$ChatMessageSyncCursorTableTableReferences
        ),
        ChatMessageSyncCursorData,
        PrefetchHooks Function({bool chatId})>;
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

final class $$ChatMessageReadCursorTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $ChatMessageReadCursorTableTable,
    ChatMessageReadCursorData> {
  $$ChatMessageReadCursorTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatMessageReadCursorTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessageReadCursorTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessageReadCursorTableTable> {
  $$ChatMessageReadCursorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageReadCursorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessageReadCursorTableTable> {
  $$ChatMessageReadCursorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageReadCursorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessageReadCursorTableTable> {
  $$ChatMessageReadCursorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatMessageReadCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessageReadCursorTableTable,
    ChatMessageReadCursorData,
    $$ChatMessageReadCursorTableTableFilterComposer,
    $$ChatMessageReadCursorTableTableOrderingComposer,
    $$ChatMessageReadCursorTableTableAnnotationComposer,
    $$ChatMessageReadCursorTableTableCreateCompanionBuilder,
    $$ChatMessageReadCursorTableTableUpdateCompanionBuilder,
    (
      ChatMessageReadCursorData,
      $$ChatMessageReadCursorTableTableReferences,
    ),
    ChatMessageReadCursorData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatMessageReadCursorTableTableTableManager(
    _$AppDatabase db,
    $ChatMessageReadCursorTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatMessageReadCursorTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatMessageReadCursorTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatMessageReadCursorTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatMessageReadCursorTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatMessageReadCursorTableTableReferences
                              ._chatIdTable(db),
                      referencedColumn:
                          $$ChatMessageReadCursorTableTableReferences
                              ._chatIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatMessageReadCursorTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatMessageReadCursorTableTable,
        ChatMessageReadCursorData,
        $$ChatMessageReadCursorTableTableFilterComposer,
        $$ChatMessageReadCursorTableTableOrderingComposer,
        $$ChatMessageReadCursorTableTableAnnotationComposer,
        $$ChatMessageReadCursorTableTableCreateCompanionBuilder,
        $$ChatMessageReadCursorTableTableUpdateCompanionBuilder,
        (
          ChatMessageReadCursorData,
          $$ChatMessageReadCursorTableTableReferences
        ),
        ChatMessageReadCursorData,
        PrefetchHooks Function({bool chatId})>;
typedef $$ChatOutboxMessageTableTableCreateCompanionBuilder
    = ChatOutboxMessageDataCompanion Function({
  required String idKey,
  Value<int?> chatId,
  Value<String?> participantId,
  Value<int?> replyToId,
  Value<int?> forwardFromId,
  Value<String?> authorId,
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
  Value<String> content,
  Value<int> sendAttempts,
  Value<int> rowid,
});

final class $$ChatOutboxMessageTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatOutboxMessageTableTable, ChatOutboxMessageData> {
  $$ChatOutboxMessageTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatOutboxMessageTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager? get chatId {
    final $_column = $_itemColumn<int>('chat_id');
    if ($_column == null) return null;
    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatOutboxMessageTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageTableTable> {
  $$ChatOutboxMessageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get participantId => $composableBuilder(
        column: $table.participantId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get replyToId => $composableBuilder(
        column: $table.replyToId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get authorId => $composableBuilder(
        column: $table.authorId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageTableTable> {
  $$ChatOutboxMessageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get participantId => $composableBuilder(
        column: $table.participantId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get replyToId => $composableBuilder(
        column: $table.replyToId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get authorId => $composableBuilder(
        column: $table.authorId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageTableTable> {
  $$ChatOutboxMessageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get participantId => $composableBuilder(
        column: $table.participantId,
        builder: (column) => column,
      );

  GeneratedColumn<int> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

  GeneratedColumn<int> get forwardFromId => $composableBuilder(
        column: $table.forwardFromId,
        builder: (column) => column,
      );

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageTableTable,
    ChatOutboxMessageData,
    $$ChatOutboxMessageTableTableFilterComposer,
    $$ChatOutboxMessageTableTableOrderingComposer,
    $$ChatOutboxMessageTableTableAnnotationComposer,
    $$ChatOutboxMessageTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageTableTableUpdateCompanionBuilder,
    (ChatOutboxMessageData, $$ChatOutboxMessageTableTableReferences),
    ChatOutboxMessageData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatOutboxMessageTableTableTableManager(
    _$AppDatabase db,
    $ChatOutboxMessageTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatOutboxMessageTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatOutboxMessageTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatOutboxMessageTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<String> idKey = const Value.absent(),
              Value<int?> chatId = const Value.absent(),
              Value<String?> participantId = const Value.absent(),
              Value<int?> replyToId = const Value.absent(),
              Value<int?> forwardFromId = const Value.absent(),
              Value<String?> authorId = const Value.absent(),
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
              content: content,
              sendAttempts: sendAttempts,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatOutboxMessageTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable: $$ChatOutboxMessageTableTableReferences
                          ._chatIdTable(db),
                      referencedColumn: $$ChatOutboxMessageTableTableReferences
                          ._chatIdTable(db)
                          .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatOutboxMessageTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageTableTable,
        ChatOutboxMessageData,
        $$ChatOutboxMessageTableTableFilterComposer,
        $$ChatOutboxMessageTableTableOrderingComposer,
        $$ChatOutboxMessageTableTableAnnotationComposer,
        $$ChatOutboxMessageTableTableCreateCompanionBuilder,
        $$ChatOutboxMessageTableTableUpdateCompanionBuilder,
        (ChatOutboxMessageData, $$ChatOutboxMessageTableTableReferences),
        ChatOutboxMessageData,
        PrefetchHooks Function({bool chatId})>;
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

final class $$ChatOutboxMessageEditTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $ChatOutboxMessageEditTableTable,
    ChatOutboxMessageEditData> {
  $$ChatOutboxMessageEditTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatOutboxMessageEditTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatOutboxMessageEditTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageEditTableTable> {
  $$ChatOutboxMessageEditTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get newContent => $composableBuilder(
        column: $table.newContent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageEditTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageEditTableTable> {
  $$ChatOutboxMessageEditTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get newContent => $composableBuilder(
        column: $table.newContent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageEditTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageEditTableTable> {
  $$ChatOutboxMessageEditTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get newContent => $composableBuilder(
        column: $table.newContent,
        builder: (column) => column,
      );

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageEditTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageEditTableTable,
    ChatOutboxMessageEditData,
    $$ChatOutboxMessageEditTableTableFilterComposer,
    $$ChatOutboxMessageEditTableTableOrderingComposer,
    $$ChatOutboxMessageEditTableTableAnnotationComposer,
    $$ChatOutboxMessageEditTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder,
    (
      ChatOutboxMessageEditData,
      $$ChatOutboxMessageEditTableTableReferences,
    ),
    ChatOutboxMessageEditData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatOutboxMessageEditTableTableTableManager(
    _$AppDatabase db,
    $ChatOutboxMessageEditTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatOutboxMessageEditTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatOutboxMessageEditTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatOutboxMessageEditTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatOutboxMessageEditTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatOutboxMessageEditTableTableReferences
                              ._chatIdTable(db),
                      referencedColumn:
                          $$ChatOutboxMessageEditTableTableReferences
                              ._chatIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatOutboxMessageEditTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageEditTableTable,
        ChatOutboxMessageEditData,
        $$ChatOutboxMessageEditTableTableFilterComposer,
        $$ChatOutboxMessageEditTableTableOrderingComposer,
        $$ChatOutboxMessageEditTableTableAnnotationComposer,
        $$ChatOutboxMessageEditTableTableCreateCompanionBuilder,
        $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder,
        (
          ChatOutboxMessageEditData,
          $$ChatOutboxMessageEditTableTableReferences
        ),
        ChatOutboxMessageEditData,
        PrefetchHooks Function({bool chatId})>;
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

final class $$ChatOutboxMessageDeleteTableTableReferences
    extends BaseReferences<_$AppDatabase, $ChatOutboxMessageDeleteTableTable,
        ChatOutboxMessageDeleteData> {
  $$ChatOutboxMessageDeleteTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatOutboxMessageDeleteTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatOutboxMessageDeleteTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageDeleteTableTable> {
  $$ChatOutboxMessageDeleteTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageDeleteTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageDeleteTableTable> {
  $$ChatOutboxMessageDeleteTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageDeleteTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatOutboxMessageDeleteTableTable> {
  $$ChatOutboxMessageDeleteTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxMessageDeleteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageDeleteTableTable,
    ChatOutboxMessageDeleteData,
    $$ChatOutboxMessageDeleteTableTableFilterComposer,
    $$ChatOutboxMessageDeleteTableTableOrderingComposer,
    $$ChatOutboxMessageDeleteTableTableAnnotationComposer,
    $$ChatOutboxMessageDeleteTableTableCreateCompanionBuilder,
    $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder,
    (
      ChatOutboxMessageDeleteData,
      $$ChatOutboxMessageDeleteTableTableReferences,
    ),
    ChatOutboxMessageDeleteData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatOutboxMessageDeleteTableTableTableManager(
    _$AppDatabase db,
    $ChatOutboxMessageDeleteTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatOutboxMessageDeleteTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatOutboxMessageDeleteTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatOutboxMessageDeleteTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatOutboxMessageDeleteTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatOutboxMessageDeleteTableTableReferences
                              ._chatIdTable(db),
                      referencedColumn:
                          $$ChatOutboxMessageDeleteTableTableReferences
                              ._chatIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatOutboxMessageDeleteTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageDeleteTableTable,
        ChatOutboxMessageDeleteData,
        $$ChatOutboxMessageDeleteTableTableFilterComposer,
        $$ChatOutboxMessageDeleteTableTableOrderingComposer,
        $$ChatOutboxMessageDeleteTableTableAnnotationComposer,
        $$ChatOutboxMessageDeleteTableTableCreateCompanionBuilder,
        $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder,
        (
          ChatOutboxMessageDeleteData,
          $$ChatOutboxMessageDeleteTableTableReferences,
        ),
        ChatOutboxMessageDeleteData,
        PrefetchHooks Function({bool chatId})>;
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

final class $$ChatOutboxReadCursorsTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatOutboxReadCursorsTableTable, ChatOutboxReadCursorData> {
  $$ChatOutboxReadCursorsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChatsTableTable _chatIdTable(_$AppDatabase db) =>
      db.chatsTable.createAlias(
        $_aliasNameGenerator(
          db.chatOutboxReadCursorsTable.chatId,
          db.chatsTable.id,
        ),
      );

  $$ChatsTableTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<int>('chat_id')!;

    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatOutboxReadCursorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatOutboxReadCursorsTableTable> {
  $$ChatOutboxReadCursorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$ChatsTableTableFilterComposer get chatId {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableFilterComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxReadCursorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatOutboxReadCursorsTableTable> {
  $$ChatOutboxReadCursorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$ChatsTableTableOrderingComposer get chatId {
    final $$ChatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableOrderingComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxReadCursorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatOutboxReadCursorsTableTable> {
  $$ChatOutboxReadCursorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$ChatsTableTableAnnotationComposer get chatId {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$ChatsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.chatsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$ChatOutboxReadCursorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxReadCursorsTableTable,
    ChatOutboxReadCursorData,
    $$ChatOutboxReadCursorsTableTableFilterComposer,
    $$ChatOutboxReadCursorsTableTableOrderingComposer,
    $$ChatOutboxReadCursorsTableTableAnnotationComposer,
    $$ChatOutboxReadCursorsTableTableCreateCompanionBuilder,
    $$ChatOutboxReadCursorsTableTableUpdateCompanionBuilder,
    (
      ChatOutboxReadCursorData,
      $$ChatOutboxReadCursorsTableTableReferences,
    ),
    ChatOutboxReadCursorData,
    PrefetchHooks Function({bool chatId})> {
  $$ChatOutboxReadCursorsTableTableTableManager(
    _$AppDatabase db,
    $ChatOutboxReadCursorsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ChatOutboxReadCursorsTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ChatOutboxReadCursorsTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ChatOutboxReadCursorsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
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
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$ChatOutboxReadCursorsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({chatId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (chatId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.chatId,
                      referencedTable:
                          $$ChatOutboxReadCursorsTableTableReferences
                              ._chatIdTable(db),
                      referencedColumn:
                          $$ChatOutboxReadCursorsTableTableReferences
                              ._chatIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$ChatOutboxReadCursorsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxReadCursorsTableTable,
        ChatOutboxReadCursorData,
        $$ChatOutboxReadCursorsTableTableFilterComposer,
        $$ChatOutboxReadCursorsTableTableOrderingComposer,
        $$ChatOutboxReadCursorsTableTableAnnotationComposer,
        $$ChatOutboxReadCursorsTableTableCreateCompanionBuilder,
        $$ChatOutboxReadCursorsTableTableUpdateCompanionBuilder,
        (ChatOutboxReadCursorData, $$ChatOutboxReadCursorsTableTableReferences),
        ChatOutboxReadCursorData,
        PrefetchHooks Function({bool chatId})>;
typedef $$SmsConversationsTableTableCreateCompanionBuilder
    = SmsConversationDataCompanion Function({
  Value<int> id,
  required String firstPhoneNumber,
  required String secondPhoneNumber,
  required DateTime createdAtRemote,
  required DateTime updatedAtRemote,
});
typedef $$SmsConversationsTableTableUpdateCompanionBuilder
    = SmsConversationDataCompanion Function({
  Value<int> id,
  Value<String> firstPhoneNumber,
  Value<String> secondPhoneNumber,
  Value<DateTime> createdAtRemote,
  Value<DateTime> updatedAtRemote,
});

final class $$SmsConversationsTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsConversationsTableTable, SmsConversationData> {
  $$SmsConversationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SmsMessagesTableTable, List<SmsMessageData>>
      _smsMessagesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
            db.smsMessagesTable,
            aliasName: $_aliasNameGenerator(
              db.smsConversationsTable.id,
              db.smsMessagesTable.conversationId,
            ),
          );

  $$SmsMessagesTableTableProcessedTableManager get smsMessagesTableRefs {
    final manager = $$SmsMessagesTableTableTableManager(
      $_db,
      $_db.smsMessagesTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsMessagesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmsMessageSyncCursorTableTable,
      List<SmsMessageSyncCursorData>> _smsMessageSyncCursorTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.smsMessageSyncCursorTable,
        aliasName: $_aliasNameGenerator(
          db.smsConversationsTable.id,
          db.smsMessageSyncCursorTable.conversationId,
        ),
      );

  $$SmsMessageSyncCursorTableTableProcessedTableManager
      get smsMessageSyncCursorTableRefs {
    final manager = $$SmsMessageSyncCursorTableTableTableManager(
      $_db,
      $_db.smsMessageSyncCursorTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsMessageSyncCursorTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmsMessageReadCursorTableTable,
      List<SmsMessageReadCursorData>> _smsMessageReadCursorTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.smsMessageReadCursorTable,
        aliasName: $_aliasNameGenerator(
          db.smsConversationsTable.id,
          db.smsMessageReadCursorTable.conversationId,
        ),
      );

  $$SmsMessageReadCursorTableTableProcessedTableManager
      get smsMessageReadCursorTableRefs {
    final manager = $$SmsMessageReadCursorTableTableTableManager(
      $_db,
      $_db.smsMessageReadCursorTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsMessageReadCursorTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmsOutboxMessagesTableTable,
      List<SmsOutboxMessageData>> _smsOutboxMessagesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.smsOutboxMessagesTable,
        aliasName: $_aliasNameGenerator(
          db.smsConversationsTable.id,
          db.smsOutboxMessagesTable.conversationId,
        ),
      );

  $$SmsOutboxMessagesTableTableProcessedTableManager
      get smsOutboxMessagesTableRefs {
    final manager = $$SmsOutboxMessagesTableTableTableManager(
      $_db,
      $_db.smsOutboxMessagesTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsOutboxMessagesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmsOutboxMessageDeleteTableTable,
      List<SmsOutboxMessageDeleteData>> _smsOutboxMessageDeleteTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.smsOutboxMessageDeleteTable,
        aliasName: $_aliasNameGenerator(
          db.smsConversationsTable.id,
          db.smsOutboxMessageDeleteTable.conversationId,
        ),
      );

  $$SmsOutboxMessageDeleteTableTableProcessedTableManager
      get smsOutboxMessageDeleteTableRefs {
    final manager = $$SmsOutboxMessageDeleteTableTableTableManager(
      $_db,
      $_db.smsOutboxMessageDeleteTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsOutboxMessageDeleteTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmsOutboxReadCursorsTableTable,
      List<SmsOutboxReadCursorData>> _smsOutboxReadCursorsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.smsOutboxReadCursorsTable,
        aliasName: $_aliasNameGenerator(
          db.smsConversationsTable.id,
          db.smsOutboxReadCursorsTable.conversationId,
        ),
      );

  $$SmsOutboxReadCursorsTableTableProcessedTableManager
      get smsOutboxReadCursorsTableRefs {
    final manager = $$SmsOutboxReadCursorsTableTableTableManager(
      $_db,
      $_db.smsOutboxReadCursorsTable,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smsOutboxReadCursorsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SmsConversationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsConversationsTableTable> {
  $$SmsConversationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get firstPhoneNumber => $composableBuilder(
        column: $table.firstPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get secondPhoneNumber => $composableBuilder(
        column: $table.secondPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => ColumnFilters(column),
      );

  Expression<bool> smsMessagesTableRefs(
    Expression<bool> Function($$SmsMessagesTableTableFilterComposer f) f,
  ) {
    final $$SmsMessagesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessagesTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessagesTableTableFilterComposer(
        $db: $db,
        $table: $db.smsMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> smsMessageSyncCursorTableRefs(
    Expression<bool> Function($$SmsMessageSyncCursorTableTableFilterComposer f)
        f,
  ) {
    final $$SmsMessageSyncCursorTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessageSyncCursorTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessageSyncCursorTableTableFilterComposer(
        $db: $db,
        $table: $db.smsMessageSyncCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> smsMessageReadCursorTableRefs(
    Expression<bool> Function($$SmsMessageReadCursorTableTableFilterComposer f)
        f,
  ) {
    final $$SmsMessageReadCursorTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessageReadCursorTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessageReadCursorTableTableFilterComposer(
        $db: $db,
        $table: $db.smsMessageReadCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> smsOutboxMessagesTableRefs(
    Expression<bool> Function($$SmsOutboxMessagesTableTableFilterComposer f) f,
  ) {
    final $$SmsOutboxMessagesTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxMessagesTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxMessagesTableTableFilterComposer(
        $db: $db,
        $table: $db.smsOutboxMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> smsOutboxMessageDeleteTableRefs(
    Expression<bool> Function(
      $$SmsOutboxMessageDeleteTableTableFilterComposer f,
    ) f,
  ) {
    final $$SmsOutboxMessageDeleteTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxMessageDeleteTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxMessageDeleteTableTableFilterComposer(
        $db: $db,
        $table: $db.smsOutboxMessageDeleteTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<bool> smsOutboxReadCursorsTableRefs(
    Expression<bool> Function($$SmsOutboxReadCursorsTableTableFilterComposer f)
        f,
  ) {
    final $$SmsOutboxReadCursorsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxReadCursorsTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxReadCursorsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsOutboxReadCursorsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$SmsConversationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsConversationsTableTable> {
  $$SmsConversationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get firstPhoneNumber => $composableBuilder(
        column: $table.firstPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get secondPhoneNumber => $composableBuilder(
        column: $table.secondPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$SmsConversationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsConversationsTableTable> {
  $$SmsConversationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstPhoneNumber => $composableBuilder(
        column: $table.firstPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumn<String> get secondPhoneNumber => $composableBuilder(
        column: $table.secondPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAtRemote => $composableBuilder(
        column: $table.createdAtRemote,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get updatedAtRemote => $composableBuilder(
        column: $table.updatedAtRemote,
        builder: (column) => column,
      );

  Expression<T> smsMessagesTableRefs<T extends Object>(
    Expression<T> Function($$SmsMessagesTableTableAnnotationComposer a) f,
  ) {
    final $$SmsMessagesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessagesTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessagesTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> smsMessageSyncCursorTableRefs<T extends Object>(
    Expression<T> Function($$SmsMessageSyncCursorTableTableAnnotationComposer a)
        f,
  ) {
    final $$SmsMessageSyncCursorTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessageSyncCursorTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessageSyncCursorTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsMessageSyncCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> smsMessageReadCursorTableRefs<T extends Object>(
    Expression<T> Function($$SmsMessageReadCursorTableTableAnnotationComposer a)
        f,
  ) {
    final $$SmsMessageReadCursorTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessageReadCursorTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsMessageReadCursorTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsMessageReadCursorTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> smsOutboxMessagesTableRefs<T extends Object>(
    Expression<T> Function($$SmsOutboxMessagesTableTableAnnotationComposer a) f,
  ) {
    final $$SmsOutboxMessagesTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxMessagesTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxMessagesTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsOutboxMessagesTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> smsOutboxMessageDeleteTableRefs<T extends Object>(
    Expression<T> Function(
      $$SmsOutboxMessageDeleteTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$SmsOutboxMessageDeleteTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxMessageDeleteTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxMessageDeleteTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsOutboxMessageDeleteTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }

  Expression<T> smsOutboxReadCursorsTableRefs<T extends Object>(
    Expression<T> Function($$SmsOutboxReadCursorsTableTableAnnotationComposer a)
        f,
  ) {
    final $$SmsOutboxReadCursorsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsOutboxReadCursorsTable,
      getReferencedColumn: (t) => t.conversationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsOutboxReadCursorsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsOutboxReadCursorsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$SmsConversationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsConversationsTableTable,
    SmsConversationData,
    $$SmsConversationsTableTableFilterComposer,
    $$SmsConversationsTableTableOrderingComposer,
    $$SmsConversationsTableTableAnnotationComposer,
    $$SmsConversationsTableTableCreateCompanionBuilder,
    $$SmsConversationsTableTableUpdateCompanionBuilder,
    (SmsConversationData, $$SmsConversationsTableTableReferences),
    SmsConversationData,
    PrefetchHooks Function({
      bool smsMessagesTableRefs,
      bool smsMessageSyncCursorTableRefs,
      bool smsMessageReadCursorTableRefs,
      bool smsOutboxMessagesTableRefs,
      bool smsOutboxMessageDeleteTableRefs,
      bool smsOutboxReadCursorsTableRefs,
    })> {
  $$SmsConversationsTableTableTableManager(
    _$AppDatabase db,
    $SmsConversationsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsConversationsTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsConversationsTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsConversationsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<String> firstPhoneNumber = const Value.absent(),
              Value<String> secondPhoneNumber = const Value.absent(),
              Value<DateTime> createdAtRemote = const Value.absent(),
              Value<DateTime> updatedAtRemote = const Value.absent(),
            }) =>
                SmsConversationDataCompanion(
              id: id,
              firstPhoneNumber: firstPhoneNumber,
              secondPhoneNumber: secondPhoneNumber,
              createdAtRemote: createdAtRemote,
              updatedAtRemote: updatedAtRemote,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required String firstPhoneNumber,
              required String secondPhoneNumber,
              required DateTime createdAtRemote,
              required DateTime updatedAtRemote,
            }) =>
                SmsConversationDataCompanion.insert(
              id: id,
              firstPhoneNumber: firstPhoneNumber,
              secondPhoneNumber: secondPhoneNumber,
              createdAtRemote: createdAtRemote,
              updatedAtRemote: updatedAtRemote,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsConversationsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({
              smsMessagesTableRefs = false,
              smsMessageSyncCursorTableRefs = false,
              smsMessageReadCursorTableRefs = false,
              smsOutboxMessagesTableRefs = false,
              smsOutboxMessageDeleteTableRefs = false,
              smsOutboxReadCursorsTableRefs = false,
            }) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [
                  if (smsMessagesTableRefs) db.smsMessagesTable,
                  if (smsMessageSyncCursorTableRefs)
                    db.smsMessageSyncCursorTable,
                  if (smsMessageReadCursorTableRefs)
                    db.smsMessageReadCursorTable,
                  if (smsOutboxMessagesTableRefs) db.smsOutboxMessagesTable,
                  if (smsOutboxMessageDeleteTableRefs)
                    db.smsOutboxMessageDeleteTable,
                  if (smsOutboxReadCursorsTableRefs)
                    db.smsOutboxReadCursorsTable,
                ],
                addJoins: null,
                getPrefetchedDataCallback: (items) async {
                  return [
                    if (smsMessagesTableRefs)
                      await $_getPrefetchedData<SmsConversationData,
                          $SmsConversationsTableTable, SmsMessageData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsMessagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsMessagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (smsMessageSyncCursorTableRefs)
                      await $_getPrefetchedData<
                          SmsConversationData,
                          $SmsConversationsTableTable,
                          SmsMessageSyncCursorData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsMessageSyncCursorTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsMessageSyncCursorTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (smsMessageReadCursorTableRefs)
                      await $_getPrefetchedData<
                          SmsConversationData,
                          $SmsConversationsTableTable,
                          SmsMessageReadCursorData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsMessageReadCursorTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsMessageReadCursorTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (smsOutboxMessagesTableRefs)
                      await $_getPrefetchedData<SmsConversationData,
                          $SmsConversationsTableTable, SmsOutboxMessageData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsOutboxMessagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsOutboxMessagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (smsOutboxMessageDeleteTableRefs)
                      await $_getPrefetchedData<
                          SmsConversationData,
                          $SmsConversationsTableTable,
                          SmsOutboxMessageDeleteData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsOutboxMessageDeleteTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsOutboxMessageDeleteTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                    if (smsOutboxReadCursorsTableRefs)
                      await $_getPrefetchedData<SmsConversationData,
                          $SmsConversationsTableTable, SmsOutboxReadCursorData>(
                        currentTable: table,
                        referencedTable: $$SmsConversationsTableTableReferences
                            ._smsOutboxReadCursorsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmsConversationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).smsOutboxReadCursorsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.conversationId == item.id,
                        ),
                        typedResults: items,
                      ),
                  ];
                },
              );
            },
          ),
        );
}

typedef $$SmsConversationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsConversationsTableTable,
        SmsConversationData,
        $$SmsConversationsTableTableFilterComposer,
        $$SmsConversationsTableTableOrderingComposer,
        $$SmsConversationsTableTableAnnotationComposer,
        $$SmsConversationsTableTableCreateCompanionBuilder,
        $$SmsConversationsTableTableUpdateCompanionBuilder,
        (SmsConversationData, $$SmsConversationsTableTableReferences),
        SmsConversationData,
        PrefetchHooks Function({
          bool smsMessagesTableRefs,
          bool smsMessageSyncCursorTableRefs,
          bool smsMessageReadCursorTableRefs,
          bool smsOutboxMessagesTableRefs,
          bool smsOutboxMessageDeleteTableRefs,
          bool smsOutboxReadCursorsTableRefs,
        })>;
typedef $$SmsMessagesTableTableCreateCompanionBuilder = SmsMessageDataCompanion
    Function({
  Value<int> id,
  required String idKey,
  Value<String?> externalId,
  required int conversationId,
  required String fromPhoneNumber,
  required String toPhoneNumber,
  required SmsSendingStatusEnum sendingStatus,
  required String content,
  required int createdAtRemoteUsec,
  required int updatedAtRemoteUsec,
  Value<int?> deletedAtRemoteUsec,
});
typedef $$SmsMessagesTableTableUpdateCompanionBuilder = SmsMessageDataCompanion
    Function({
  Value<int> id,
  Value<String> idKey,
  Value<String?> externalId,
  Value<int> conversationId,
  Value<String> fromPhoneNumber,
  Value<String> toPhoneNumber,
  Value<SmsSendingStatusEnum> sendingStatus,
  Value<String> content,
  Value<int> createdAtRemoteUsec,
  Value<int> updatedAtRemoteUsec,
  Value<int?> deletedAtRemoteUsec,
});

final class $$SmsMessagesTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsMessagesTableTable, SmsMessageData> {
  $$SmsMessagesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsMessagesTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get externalId => $composableBuilder(
        column: $table.externalId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<
          SmsSendingStatusEnum, SmsSendingStatusEnum, String>
      get sendingStatus => $composableBuilder(
            column: $table.sendingStatus,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get externalId => $composableBuilder(
        column: $table.externalId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get sendingStatus => $composableBuilder(
        column: $table.sendingStatus,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
        column: $table.externalId,
        builder: (column) => column,
      );

  GeneratedColumn<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumn<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SmsSendingStatusEnum, String>
      get sendingStatus => $composableBuilder(
            column: $table.sendingStatus,
            builder: (column) => column,
          );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get deletedAtRemoteUsec => $composableBuilder(
        column: $table.deletedAtRemoteUsec,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsMessagesTableTable,
    SmsMessageData,
    $$SmsMessagesTableTableFilterComposer,
    $$SmsMessagesTableTableOrderingComposer,
    $$SmsMessagesTableTableAnnotationComposer,
    $$SmsMessagesTableTableCreateCompanionBuilder,
    $$SmsMessagesTableTableUpdateCompanionBuilder,
    (SmsMessageData, $$SmsMessagesTableTableReferences),
    SmsMessageData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsMessagesTableTableTableManager(
    _$AppDatabase db,
    $SmsMessagesTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsMessagesTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$SmsMessagesTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$SmsMessagesTableTableAnnotationComposer(
                    $db: db, $table: table),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<String> idKey = const Value.absent(),
              Value<String?> externalId = const Value.absent(),
              Value<int> conversationId = const Value.absent(),
              Value<String> fromPhoneNumber = const Value.absent(),
              Value<String> toPhoneNumber = const Value.absent(),
              Value<SmsSendingStatusEnum> sendingStatus = const Value.absent(),
              Value<String> content = const Value.absent(),
              Value<int> createdAtRemoteUsec = const Value.absent(),
              Value<int> updatedAtRemoteUsec = const Value.absent(),
              Value<int?> deletedAtRemoteUsec = const Value.absent(),
            }) =>
                SmsMessageDataCompanion(
              id: id,
              idKey: idKey,
              externalId: externalId,
              conversationId: conversationId,
              fromPhoneNumber: fromPhoneNumber,
              toPhoneNumber: toPhoneNumber,
              sendingStatus: sendingStatus,
              content: content,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
              deletedAtRemoteUsec: deletedAtRemoteUsec,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required String idKey,
              Value<String?> externalId = const Value.absent(),
              required int conversationId,
              required String fromPhoneNumber,
              required String toPhoneNumber,
              required SmsSendingStatusEnum sendingStatus,
              required String content,
              required int createdAtRemoteUsec,
              required int updatedAtRemoteUsec,
              Value<int?> deletedAtRemoteUsec = const Value.absent(),
            }) =>
                SmsMessageDataCompanion.insert(
              id: id,
              idKey: idKey,
              externalId: externalId,
              conversationId: conversationId,
              fromPhoneNumber: fromPhoneNumber,
              toPhoneNumber: toPhoneNumber,
              sendingStatus: sendingStatus,
              content: content,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
              deletedAtRemoteUsec: deletedAtRemoteUsec,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsMessagesTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable: $$SmsMessagesTableTableReferences
                          ._conversationIdTable(db),
                      referencedColumn: $$SmsMessagesTableTableReferences
                          ._conversationIdTable(db)
                          .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsMessagesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SmsMessagesTableTable,
    SmsMessageData,
    $$SmsMessagesTableTableFilterComposer,
    $$SmsMessagesTableTableOrderingComposer,
    $$SmsMessagesTableTableAnnotationComposer,
    $$SmsMessagesTableTableCreateCompanionBuilder,
    $$SmsMessagesTableTableUpdateCompanionBuilder,
    (SmsMessageData, $$SmsMessagesTableTableReferences),
    SmsMessageData,
    PrefetchHooks Function({bool conversationId})>;
typedef $$SmsMessageSyncCursorTableTableCreateCompanionBuilder
    = SmsMessageSyncCursorDataCompanion Function({
  required int conversationId,
  required SmsSyncCursorTypeEnum cursorType,
  required int timestampUsec,
  Value<int> rowid,
});
typedef $$SmsMessageSyncCursorTableTableUpdateCompanionBuilder
    = SmsMessageSyncCursorDataCompanion Function({
  Value<int> conversationId,
  Value<SmsSyncCursorTypeEnum> cursorType,
  Value<int> timestampUsec,
  Value<int> rowid,
});

final class $$SmsMessageSyncCursorTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsMessageSyncCursorTableTable, SmsMessageSyncCursorData> {
  $$SmsMessageSyncCursorTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsMessageSyncCursorTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsMessageSyncCursorTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsMessageSyncCursorTableTable> {
  $$SmsMessageSyncCursorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<
          SmsSyncCursorTypeEnum, SmsSyncCursorTypeEnum, String>
      get cursorType => $composableBuilder(
            column: $table.cursorType,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageSyncCursorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsMessageSyncCursorTableTable> {
  $$SmsMessageSyncCursorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cursorType => $composableBuilder(
        column: $table.cursorType,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageSyncCursorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsMessageSyncCursorTableTable> {
  $$SmsMessageSyncCursorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<SmsSyncCursorTypeEnum, String>
      get cursorType => $composableBuilder(
            column: $table.cursorType,
            builder: (column) => column,
          );

  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageSyncCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsMessageSyncCursorTableTable,
    SmsMessageSyncCursorData,
    $$SmsMessageSyncCursorTableTableFilterComposer,
    $$SmsMessageSyncCursorTableTableOrderingComposer,
    $$SmsMessageSyncCursorTableTableAnnotationComposer,
    $$SmsMessageSyncCursorTableTableCreateCompanionBuilder,
    $$SmsMessageSyncCursorTableTableUpdateCompanionBuilder,
    (
      SmsMessageSyncCursorData,
      $$SmsMessageSyncCursorTableTableReferences,
    ),
    SmsMessageSyncCursorData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsMessageSyncCursorTableTableTableManager(
    _$AppDatabase db,
    $SmsMessageSyncCursorTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsMessageSyncCursorTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsMessageSyncCursorTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsMessageSyncCursorTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> conversationId = const Value.absent(),
              Value<SmsSyncCursorTypeEnum> cursorType = const Value.absent(),
              Value<int> timestampUsec = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsMessageSyncCursorDataCompanion(
              conversationId: conversationId,
              cursorType: cursorType,
              timestampUsec: timestampUsec,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required int conversationId,
              required SmsSyncCursorTypeEnum cursorType,
              required int timestampUsec,
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsMessageSyncCursorDataCompanion.insert(
              conversationId: conversationId,
              cursorType: cursorType,
              timestampUsec: timestampUsec,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsMessageSyncCursorTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable:
                          $$SmsMessageSyncCursorTableTableReferences
                              ._conversationIdTable(db),
                      referencedColumn:
                          $$SmsMessageSyncCursorTableTableReferences
                              ._conversationIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsMessageSyncCursorTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsMessageSyncCursorTableTable,
        SmsMessageSyncCursorData,
        $$SmsMessageSyncCursorTableTableFilterComposer,
        $$SmsMessageSyncCursorTableTableOrderingComposer,
        $$SmsMessageSyncCursorTableTableAnnotationComposer,
        $$SmsMessageSyncCursorTableTableCreateCompanionBuilder,
        $$SmsMessageSyncCursorTableTableUpdateCompanionBuilder,
        (SmsMessageSyncCursorData, $$SmsMessageSyncCursorTableTableReferences),
        SmsMessageSyncCursorData,
        PrefetchHooks Function({bool conversationId})>;
typedef $$SmsMessageReadCursorTableTableCreateCompanionBuilder
    = SmsMessageReadCursorDataCompanion Function({
  required int conversationId,
  required String userId,
  required int timestampUsec,
  Value<int> rowid,
});
typedef $$SmsMessageReadCursorTableTableUpdateCompanionBuilder
    = SmsMessageReadCursorDataCompanion Function({
  Value<int> conversationId,
  Value<String> userId,
  Value<int> timestampUsec,
  Value<int> rowid,
});

final class $$SmsMessageReadCursorTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsMessageReadCursorTableTable, SmsMessageReadCursorData> {
  $$SmsMessageReadCursorTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsMessageReadCursorTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsMessageReadCursorTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsMessageReadCursorTableTable> {
  $$SmsMessageReadCursorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageReadCursorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsMessageReadCursorTableTable> {
  $$SmsMessageReadCursorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
        column: $table.userId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageReadCursorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsMessageReadCursorTableTable> {
  $$SmsMessageReadCursorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsMessageReadCursorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsMessageReadCursorTableTable,
    SmsMessageReadCursorData,
    $$SmsMessageReadCursorTableTableFilterComposer,
    $$SmsMessageReadCursorTableTableOrderingComposer,
    $$SmsMessageReadCursorTableTableAnnotationComposer,
    $$SmsMessageReadCursorTableTableCreateCompanionBuilder,
    $$SmsMessageReadCursorTableTableUpdateCompanionBuilder,
    (
      SmsMessageReadCursorData,
      $$SmsMessageReadCursorTableTableReferences,
    ),
    SmsMessageReadCursorData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsMessageReadCursorTableTableTableManager(
    _$AppDatabase db,
    $SmsMessageReadCursorTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsMessageReadCursorTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsMessageReadCursorTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsMessageReadCursorTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> conversationId = const Value.absent(),
              Value<String> userId = const Value.absent(),
              Value<int> timestampUsec = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsMessageReadCursorDataCompanion(
              conversationId: conversationId,
              userId: userId,
              timestampUsec: timestampUsec,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required int conversationId,
              required String userId,
              required int timestampUsec,
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsMessageReadCursorDataCompanion.insert(
              conversationId: conversationId,
              userId: userId,
              timestampUsec: timestampUsec,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsMessageReadCursorTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable:
                          $$SmsMessageReadCursorTableTableReferences
                              ._conversationIdTable(db),
                      referencedColumn:
                          $$SmsMessageReadCursorTableTableReferences
                              ._conversationIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsMessageReadCursorTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsMessageReadCursorTableTable,
        SmsMessageReadCursorData,
        $$SmsMessageReadCursorTableTableFilterComposer,
        $$SmsMessageReadCursorTableTableOrderingComposer,
        $$SmsMessageReadCursorTableTableAnnotationComposer,
        $$SmsMessageReadCursorTableTableCreateCompanionBuilder,
        $$SmsMessageReadCursorTableTableUpdateCompanionBuilder,
        (SmsMessageReadCursorData, $$SmsMessageReadCursorTableTableReferences),
        SmsMessageReadCursorData,
        PrefetchHooks Function({bool conversationId})>;
typedef $$SmsOutboxMessagesTableTableCreateCompanionBuilder
    = SmsOutboxMessageDataCompanion Function({
  required String idKey,
  Value<int?> conversationId,
  required String fromPhoneNumber,
  required String toPhoneNumber,
  Value<String?> recepientId,
  required String content,
  Value<int> sendAttempts,
  Value<int> rowid,
});
typedef $$SmsOutboxMessagesTableTableUpdateCompanionBuilder
    = SmsOutboxMessageDataCompanion Function({
  Value<String> idKey,
  Value<int?> conversationId,
  Value<String> fromPhoneNumber,
  Value<String> toPhoneNumber,
  Value<String?> recepientId,
  Value<String> content,
  Value<int> sendAttempts,
  Value<int> rowid,
});

final class $$SmsOutboxMessagesTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsOutboxMessagesTableTable, SmsOutboxMessageData> {
  $$SmsOutboxMessagesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsOutboxMessagesTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager? get conversationId {
    final $_column = $_itemColumn<int>('conversation_id');
    if ($_column == null) return null;
    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsOutboxMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessagesTableTable> {
  $$SmsOutboxMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get recepientId => $composableBuilder(
        column: $table.recepientId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessagesTableTable> {
  $$SmsOutboxMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get recepientId => $composableBuilder(
        column: $table.recepientId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessagesTableTable> {
  $$SmsOutboxMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get fromPhoneNumber => $composableBuilder(
        column: $table.fromPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumn<String> get toPhoneNumber => $composableBuilder(
        column: $table.toPhoneNumber,
        builder: (column) => column,
      );

  GeneratedColumn<String> get recepientId => $composableBuilder(
        column: $table.recepientId,
        builder: (column) => column,
      );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsOutboxMessagesTableTable,
    SmsOutboxMessageData,
    $$SmsOutboxMessagesTableTableFilterComposer,
    $$SmsOutboxMessagesTableTableOrderingComposer,
    $$SmsOutboxMessagesTableTableAnnotationComposer,
    $$SmsOutboxMessagesTableTableCreateCompanionBuilder,
    $$SmsOutboxMessagesTableTableUpdateCompanionBuilder,
    (SmsOutboxMessageData, $$SmsOutboxMessagesTableTableReferences),
    SmsOutboxMessageData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsOutboxMessagesTableTableTableManager(
    _$AppDatabase db,
    $SmsOutboxMessagesTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsOutboxMessagesTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsOutboxMessagesTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsOutboxMessagesTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<String> idKey = const Value.absent(),
              Value<int?> conversationId = const Value.absent(),
              Value<String> fromPhoneNumber = const Value.absent(),
              Value<String> toPhoneNumber = const Value.absent(),
              Value<String?> recepientId = const Value.absent(),
              Value<String> content = const Value.absent(),
              Value<int> sendAttempts = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsOutboxMessageDataCompanion(
              idKey: idKey,
              conversationId: conversationId,
              fromPhoneNumber: fromPhoneNumber,
              toPhoneNumber: toPhoneNumber,
              recepientId: recepientId,
              content: content,
              sendAttempts: sendAttempts,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String idKey,
              Value<int?> conversationId = const Value.absent(),
              required String fromPhoneNumber,
              required String toPhoneNumber,
              Value<String?> recepientId = const Value.absent(),
              required String content,
              Value<int> sendAttempts = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SmsOutboxMessageDataCompanion.insert(
              idKey: idKey,
              conversationId: conversationId,
              fromPhoneNumber: fromPhoneNumber,
              toPhoneNumber: toPhoneNumber,
              recepientId: recepientId,
              content: content,
              sendAttempts: sendAttempts,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsOutboxMessagesTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable: $$SmsOutboxMessagesTableTableReferences
                          ._conversationIdTable(db),
                      referencedColumn: $$SmsOutboxMessagesTableTableReferences
                          ._conversationIdTable(db)
                          .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsOutboxMessagesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsOutboxMessagesTableTable,
        SmsOutboxMessageData,
        $$SmsOutboxMessagesTableTableFilterComposer,
        $$SmsOutboxMessagesTableTableOrderingComposer,
        $$SmsOutboxMessagesTableTableAnnotationComposer,
        $$SmsOutboxMessagesTableTableCreateCompanionBuilder,
        $$SmsOutboxMessagesTableTableUpdateCompanionBuilder,
        (SmsOutboxMessageData, $$SmsOutboxMessagesTableTableReferences),
        SmsOutboxMessageData,
        PrefetchHooks Function({bool conversationId})>;
typedef $$SmsOutboxMessageDeleteTableTableCreateCompanionBuilder
    = SmsOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int conversationId,
  Value<int> sendAttempts,
});
typedef $$SmsOutboxMessageDeleteTableTableUpdateCompanionBuilder
    = SmsOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> conversationId,
  Value<int> sendAttempts,
});

final class $$SmsOutboxMessageDeleteTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $SmsOutboxMessageDeleteTableTable,
    SmsOutboxMessageDeleteData> {
  $$SmsOutboxMessageDeleteTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsOutboxMessageDeleteTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsOutboxMessageDeleteTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessageDeleteTableTable> {
  $$SmsOutboxMessageDeleteTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessageDeleteTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessageDeleteTableTable> {
  $$SmsOutboxMessageDeleteTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessageDeleteTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsOutboxMessageDeleteTableTable> {
  $$SmsOutboxMessageDeleteTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxMessageDeleteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsOutboxMessageDeleteTableTable,
    SmsOutboxMessageDeleteData,
    $$SmsOutboxMessageDeleteTableTableFilterComposer,
    $$SmsOutboxMessageDeleteTableTableOrderingComposer,
    $$SmsOutboxMessageDeleteTableTableAnnotationComposer,
    $$SmsOutboxMessageDeleteTableTableCreateCompanionBuilder,
    $$SmsOutboxMessageDeleteTableTableUpdateCompanionBuilder,
    (
      SmsOutboxMessageDeleteData,
      $$SmsOutboxMessageDeleteTableTableReferences,
    ),
    SmsOutboxMessageDeleteData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsOutboxMessageDeleteTableTableTableManager(
    _$AppDatabase db,
    $SmsOutboxMessageDeleteTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsOutboxMessageDeleteTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsOutboxMessageDeleteTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsOutboxMessageDeleteTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<String> idKey = const Value.absent(),
              Value<int> conversationId = const Value.absent(),
              Value<int> sendAttempts = const Value.absent(),
            }) =>
                SmsOutboxMessageDeleteDataCompanion(
              id: id,
              idKey: idKey,
              conversationId: conversationId,
              sendAttempts: sendAttempts,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required String idKey,
              required int conversationId,
              Value<int> sendAttempts = const Value.absent(),
            }) =>
                SmsOutboxMessageDeleteDataCompanion.insert(
              id: id,
              idKey: idKey,
              conversationId: conversationId,
              sendAttempts: sendAttempts,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsOutboxMessageDeleteTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable:
                          $$SmsOutboxMessageDeleteTableTableReferences
                              ._conversationIdTable(db),
                      referencedColumn:
                          $$SmsOutboxMessageDeleteTableTableReferences
                              ._conversationIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsOutboxMessageDeleteTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsOutboxMessageDeleteTableTable,
        SmsOutboxMessageDeleteData,
        $$SmsOutboxMessageDeleteTableTableFilterComposer,
        $$SmsOutboxMessageDeleteTableTableOrderingComposer,
        $$SmsOutboxMessageDeleteTableTableAnnotationComposer,
        $$SmsOutboxMessageDeleteTableTableCreateCompanionBuilder,
        $$SmsOutboxMessageDeleteTableTableUpdateCompanionBuilder,
        (
          SmsOutboxMessageDeleteData,
          $$SmsOutboxMessageDeleteTableTableReferences,
        ),
        SmsOutboxMessageDeleteData,
        PrefetchHooks Function({bool conversationId})>;
typedef $$SmsOutboxReadCursorsTableTableCreateCompanionBuilder
    = SmsOutboxReadCursorDataCompanion Function({
  Value<int> conversationId,
  required int timestampUsec,
  Value<int> sendAttempts,
});
typedef $$SmsOutboxReadCursorsTableTableUpdateCompanionBuilder
    = SmsOutboxReadCursorDataCompanion Function({
  Value<int> conversationId,
  Value<int> timestampUsec,
  Value<int> sendAttempts,
});

final class $$SmsOutboxReadCursorsTableTableReferences extends BaseReferences<
    _$AppDatabase, $SmsOutboxReadCursorsTableTable, SmsOutboxReadCursorData> {
  $$SmsOutboxReadCursorsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsConversationsTableTable _conversationIdTable(_$AppDatabase db) =>
      db.smsConversationsTable.createAlias(
        $_aliasNameGenerator(
          db.smsOutboxReadCursorsTable.conversationId,
          db.smsConversationsTable.id,
        ),
      );

  $$SmsConversationsTableTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$SmsConversationsTableTableTableManager(
      $_db,
      $_db.smsConversationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsOutboxReadCursorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsOutboxReadCursorsTableTable> {
  $$SmsOutboxReadCursorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$SmsConversationsTableTableFilterComposer get conversationId {
    final $$SmsConversationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableFilterComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxReadCursorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsOutboxReadCursorsTableTable> {
  $$SmsOutboxReadCursorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$SmsConversationsTableTableOrderingComposer get conversationId {
    final $$SmsConversationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxReadCursorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsOutboxReadCursorsTableTable> {
  $$SmsOutboxReadCursorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$SmsConversationsTableTableAnnotationComposer get conversationId {
    final $$SmsConversationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.smsConversationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SmsConversationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.smsConversationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SmsOutboxReadCursorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsOutboxReadCursorsTableTable,
    SmsOutboxReadCursorData,
    $$SmsOutboxReadCursorsTableTableFilterComposer,
    $$SmsOutboxReadCursorsTableTableOrderingComposer,
    $$SmsOutboxReadCursorsTableTableAnnotationComposer,
    $$SmsOutboxReadCursorsTableTableCreateCompanionBuilder,
    $$SmsOutboxReadCursorsTableTableUpdateCompanionBuilder,
    (SmsOutboxReadCursorData, $$SmsOutboxReadCursorsTableTableReferences),
    SmsOutboxReadCursorData,
    PrefetchHooks Function({bool conversationId})> {
  $$SmsOutboxReadCursorsTableTableTableManager(
    _$AppDatabase db,
    $SmsOutboxReadCursorsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SmsOutboxReadCursorsTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SmsOutboxReadCursorsTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SmsOutboxReadCursorsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> conversationId = const Value.absent(),
              Value<int> timestampUsec = const Value.absent(),
              Value<int> sendAttempts = const Value.absent(),
            }) =>
                SmsOutboxReadCursorDataCompanion(
              conversationId: conversationId,
              timestampUsec: timestampUsec,
              sendAttempts: sendAttempts,
            ),
            createCompanionCallback: ({
              Value<int> conversationId = const Value.absent(),
              required int timestampUsec,
              Value<int> sendAttempts = const Value.absent(),
            }) =>
                SmsOutboxReadCursorDataCompanion.insert(
              conversationId: conversationId,
              timestampUsec: timestampUsec,
              sendAttempts: sendAttempts,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SmsOutboxReadCursorsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({conversationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (conversationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.conversationId,
                      referencedTable:
                          $$SmsOutboxReadCursorsTableTableReferences
                              ._conversationIdTable(db),
                      referencedColumn:
                          $$SmsOutboxReadCursorsTableTableReferences
                              ._conversationIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SmsOutboxReadCursorsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SmsOutboxReadCursorsTableTable,
        SmsOutboxReadCursorData,
        $$SmsOutboxReadCursorsTableTableFilterComposer,
        $$SmsOutboxReadCursorsTableTableOrderingComposer,
        $$SmsOutboxReadCursorsTableTableAnnotationComposer,
        $$SmsOutboxReadCursorsTableTableCreateCompanionBuilder,
        $$SmsOutboxReadCursorsTableTableUpdateCompanionBuilder,
        (SmsOutboxReadCursorData, $$SmsOutboxReadCursorsTableTableReferences),
        SmsOutboxReadCursorData,
        PrefetchHooks Function({bool conversationId})>;
typedef $$UserSmsNumbersTableTableCreateCompanionBuilder
    = UserSmsNumberDataCompanion Function({
  required String phoneNumber,
  Value<int> rowid,
});
typedef $$UserSmsNumbersTableTableUpdateCompanionBuilder
    = UserSmsNumberDataCompanion Function({
  Value<String> phoneNumber,
  Value<int> rowid,
});

class $$UserSmsNumbersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserSmsNumbersTableTable> {
  $$UserSmsNumbersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get phoneNumber => $composableBuilder(
        column: $table.phoneNumber,
        builder: (column) => ColumnFilters(column),
      );
}

class $$UserSmsNumbersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSmsNumbersTableTable> {
  $$UserSmsNumbersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get phoneNumber => $composableBuilder(
        column: $table.phoneNumber,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$UserSmsNumbersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSmsNumbersTableTable> {
  $$UserSmsNumbersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get phoneNumber => $composableBuilder(
        column: $table.phoneNumber,
        builder: (column) => column,
      );
}

class $$UserSmsNumbersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSmsNumbersTableTable,
    UserSmsNumberData,
    $$UserSmsNumbersTableTableFilterComposer,
    $$UserSmsNumbersTableTableOrderingComposer,
    $$UserSmsNumbersTableTableAnnotationComposer,
    $$UserSmsNumbersTableTableCreateCompanionBuilder,
    $$UserSmsNumbersTableTableUpdateCompanionBuilder,
    (
      UserSmsNumberData,
      BaseReferences<_$AppDatabase, $UserSmsNumbersTableTable,
          UserSmsNumberData>,
    ),
    UserSmsNumberData,
    PrefetchHooks Function()> {
  $$UserSmsNumbersTableTableTableManager(
    _$AppDatabase db,
    $UserSmsNumbersTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$UserSmsNumbersTableTableFilterComposer(
                    $db: db, $table: table),
            createOrderingComposer: () =>
                $$UserSmsNumbersTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$UserSmsNumbersTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<String> phoneNumber = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                UserSmsNumberDataCompanion(
              phoneNumber: phoneNumber,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String phoneNumber,
              Value<int> rowid = const Value.absent(),
            }) =>
                UserSmsNumberDataCompanion.insert(
              phoneNumber: phoneNumber,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$UserSmsNumbersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSmsNumbersTableTable,
    UserSmsNumberData,
    $$UserSmsNumbersTableTableFilterComposer,
    $$UserSmsNumbersTableTableOrderingComposer,
    $$UserSmsNumbersTableTableAnnotationComposer,
    $$UserSmsNumbersTableTableCreateCompanionBuilder,
    $$UserSmsNumbersTableTableUpdateCompanionBuilder,
    (
      UserSmsNumberData,
      BaseReferences<_$AppDatabase, $UserSmsNumbersTableTable,
          UserSmsNumberData>,
    ),
    UserSmsNumberData,
    PrefetchHooks Function()>;
typedef $$ActiveMessageNotificationsTableTableCreateCompanionBuilder
    = ActiveMessageNotificationDataCompanion Function({
  required String notificationId,
  required int messageId,
  required int conversationId,
  required String title,
  required String body,
  required DateTime time,
  Value<int> rowid,
});
typedef $$ActiveMessageNotificationsTableTableUpdateCompanionBuilder
    = ActiveMessageNotificationDataCompanion Function({
  Value<String> notificationId,
  Value<int> messageId,
  Value<int> conversationId,
  Value<String> title,
  Value<String> body,
  Value<DateTime> time,
  Value<int> rowid,
});

class $$ActiveMessageNotificationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ActiveMessageNotificationsTableTable> {
  $$ActiveMessageNotificationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get notificationId => $composableBuilder(
        column: $table.notificationId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get messageId => $composableBuilder(
        column: $table.messageId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get conversationId => $composableBuilder(
        column: $table.conversationId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
        column: $table.title,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get body => $composableBuilder(
        column: $table.body,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get time => $composableBuilder(
        column: $table.time,
        builder: (column) => ColumnFilters(column),
      );
}

class $$ActiveMessageNotificationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ActiveMessageNotificationsTableTable> {
  $$ActiveMessageNotificationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get notificationId => $composableBuilder(
        column: $table.notificationId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get messageId => $composableBuilder(
        column: $table.messageId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get conversationId => $composableBuilder(
        column: $table.conversationId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get title => $composableBuilder(
        column: $table.title,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get body => $composableBuilder(
        column: $table.body,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get time => $composableBuilder(
        column: $table.time,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$ActiveMessageNotificationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActiveMessageNotificationsTableTable> {
  $$ActiveMessageNotificationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get notificationId => $composableBuilder(
        column: $table.notificationId,
        builder: (column) => column,
      );

  GeneratedColumn<int> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<int> get conversationId => $composableBuilder(
        column: $table.conversationId,
        builder: (column) => column,
      );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);
}

class $$ActiveMessageNotificationsTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $ActiveMessageNotificationsTableTable,
        ActiveMessageNotificationData,
        $$ActiveMessageNotificationsTableTableFilterComposer,
        $$ActiveMessageNotificationsTableTableOrderingComposer,
        $$ActiveMessageNotificationsTableTableAnnotationComposer,
        $$ActiveMessageNotificationsTableTableCreateCompanionBuilder,
        $$ActiveMessageNotificationsTableTableUpdateCompanionBuilder,
        (
          ActiveMessageNotificationData,
          BaseReferences<_$AppDatabase, $ActiveMessageNotificationsTableTable,
              ActiveMessageNotificationData>,
        ),
        ActiveMessageNotificationData,
        PrefetchHooks Function()> {
  $$ActiveMessageNotificationsTableTableTableManager(
    _$AppDatabase db,
    $ActiveMessageNotificationsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$ActiveMessageNotificationsTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$ActiveMessageNotificationsTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$ActiveMessageNotificationsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<String> notificationId = const Value.absent(),
              Value<int> messageId = const Value.absent(),
              Value<int> conversationId = const Value.absent(),
              Value<String> title = const Value.absent(),
              Value<String> body = const Value.absent(),
              Value<DateTime> time = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                ActiveMessageNotificationDataCompanion(
              notificationId: notificationId,
              messageId: messageId,
              conversationId: conversationId,
              title: title,
              body: body,
              time: time,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String notificationId,
              required int messageId,
              required int conversationId,
              required String title,
              required String body,
              required DateTime time,
              Value<int> rowid = const Value.absent(),
            }) =>
                ActiveMessageNotificationDataCompanion.insert(
              notificationId: notificationId,
              messageId: messageId,
              conversationId: conversationId,
              title: title,
              body: body,
              time: time,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$ActiveMessageNotificationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ActiveMessageNotificationsTableTable,
        ActiveMessageNotificationData,
        $$ActiveMessageNotificationsTableTableFilterComposer,
        $$ActiveMessageNotificationsTableTableOrderingComposer,
        $$ActiveMessageNotificationsTableTableAnnotationComposer,
        $$ActiveMessageNotificationsTableTableCreateCompanionBuilder,
        $$ActiveMessageNotificationsTableTableUpdateCompanionBuilder,
        (
          ActiveMessageNotificationData,
          BaseReferences<_$AppDatabase, $ActiveMessageNotificationsTableTable,
              ActiveMessageNotificationData>,
        ),
        ActiveMessageNotificationData,
        PrefetchHooks Function()>;
typedef $$VoicemailTableTableCreateCompanionBuilder = VoicemailDataCompanion
    Function({
  required String id,
  required String date,
  required double duration,
  required String sender,
  required String receiver,
  Value<bool> seen,
  required int size,
  required String type,
  Value<String?> attachmentPath,
  Value<int> rowid,
});
typedef $$VoicemailTableTableUpdateCompanionBuilder = VoicemailDataCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<double> duration,
  Value<String> sender,
  Value<String> receiver,
  Value<bool> seen,
  Value<int> size,
  Value<String> type,
  Value<String?> attachmentPath,
  Value<int> rowid,
});

class $$VoicemailTableTableFilterComposer
    extends Composer<_$AppDatabase, $VoicemailTableTable> {
  $$VoicemailTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get date => $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<double> get duration => $composableBuilder(
        column: $table.duration,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get sender => $composableBuilder(
        column: $table.sender,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get receiver => $composableBuilder(
        column: $table.receiver,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get seen => $composableBuilder(
        column: $table.seen,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get size => $composableBuilder(
        column: $table.size,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get type => $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get attachmentPath => $composableBuilder(
        column: $table.attachmentPath,
        builder: (column) => ColumnFilters(column),
      );
}

class $$VoicemailTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VoicemailTableTable> {
  $$VoicemailTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get date => $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get duration => $composableBuilder(
        column: $table.duration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get sender => $composableBuilder(
        column: $table.sender,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get receiver => $composableBuilder(
        column: $table.receiver,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get seen => $composableBuilder(
        column: $table.seen,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get size => $composableBuilder(
        column: $table.size,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get type => $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get attachmentPath => $composableBuilder(
        column: $table.attachmentPath,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$VoicemailTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VoicemailTableTable> {
  $$VoicemailTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get receiver =>
      $composableBuilder(column: $table.receiver, builder: (column) => column);

  GeneratedColumn<bool> get seen =>
      $composableBuilder(column: $table.seen, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get attachmentPath => $composableBuilder(
        column: $table.attachmentPath,
        builder: (column) => column,
      );
}

class $$VoicemailTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VoicemailTableTable,
    VoicemailData,
    $$VoicemailTableTableFilterComposer,
    $$VoicemailTableTableOrderingComposer,
    $$VoicemailTableTableAnnotationComposer,
    $$VoicemailTableTableCreateCompanionBuilder,
    $$VoicemailTableTableUpdateCompanionBuilder,
    (
      VoicemailData,
      BaseReferences<_$AppDatabase, $VoicemailTableTable, VoicemailData>,
    ),
    VoicemailData,
    PrefetchHooks Function()> {
  $$VoicemailTableTableTableManager(
    _$AppDatabase db,
    $VoicemailTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$VoicemailTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$VoicemailTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$VoicemailTableTableAnnotationComposer($db: db, $table: table),
            updateCompanionCallback: ({
              Value<String> id = const Value.absent(),
              Value<String> date = const Value.absent(),
              Value<double> duration = const Value.absent(),
              Value<String> sender = const Value.absent(),
              Value<String> receiver = const Value.absent(),
              Value<bool> seen = const Value.absent(),
              Value<int> size = const Value.absent(),
              Value<String> type = const Value.absent(),
              Value<String?> attachmentPath = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                VoicemailDataCompanion(
              id: id,
              date: date,
              duration: duration,
              sender: sender,
              receiver: receiver,
              seen: seen,
              size: size,
              type: type,
              attachmentPath: attachmentPath,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String id,
              required String date,
              required double duration,
              required String sender,
              required String receiver,
              Value<bool> seen = const Value.absent(),
              required int size,
              required String type,
              Value<String?> attachmentPath = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                VoicemailDataCompanion.insert(
              id: id,
              date: date,
              duration: duration,
              sender: sender,
              receiver: receiver,
              seen: seen,
              size: size,
              type: type,
              attachmentPath: attachmentPath,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$VoicemailTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VoicemailTableTable,
    VoicemailData,
    $$VoicemailTableTableFilterComposer,
    $$VoicemailTableTableOrderingComposer,
    $$VoicemailTableTableAnnotationComposer,
    $$VoicemailTableTableCreateCompanionBuilder,
    $$VoicemailTableTableUpdateCompanionBuilder,
    (
      VoicemailData,
      BaseReferences<_$AppDatabase, $VoicemailTableTable, VoicemailData>,
    ),
    VoicemailData,
    PrefetchHooks Function()>;
typedef $$SystemNotificationsTableTableCreateCompanionBuilder
    = SystemNotificationDataCompanion Function({
  Value<int> id,
  required String title,
  required String content,
  required SystemNotificationType type,
  required bool seen,
  required int createdAtRemoteUsec,
  required int updatedAtRemoteUsec,
});
typedef $$SystemNotificationsTableTableUpdateCompanionBuilder
    = SystemNotificationDataCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<SystemNotificationType> type,
  Value<bool> seen,
  Value<int> createdAtRemoteUsec,
  Value<int> updatedAtRemoteUsec,
});

final class $$SystemNotificationsTableTableReferences extends BaseReferences<
    _$AppDatabase, $SystemNotificationsTableTable, SystemNotificationData> {
  $$SystemNotificationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SystemNotificationsOutboxTableTable,
          List<SystemNotificationOutboxEntryData>>
      _systemNotificationsOutboxTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
            db.systemNotificationsOutboxTable,
            aliasName: $_aliasNameGenerator(
              db.systemNotificationsTable.id,
              db.systemNotificationsOutboxTable.notificationId,
            ),
          );

  $$SystemNotificationsOutboxTableTableProcessedTableManager
      get systemNotificationsOutboxTableRefs {
    final manager = $$SystemNotificationsOutboxTableTableTableManager(
      $_db,
      $_db.systemNotificationsOutboxTable,
    ).filter((f) => f.notificationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _systemNotificationsOutboxTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SystemNotificationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SystemNotificationsTableTable> {
  $$SystemNotificationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
        column: $table.title,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<
          SystemNotificationType, SystemNotificationType, String>
      get type => $composableBuilder(
            column: $table.type,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<bool> get seen => $composableBuilder(
        column: $table.seen,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnFilters(column),
      );

  Expression<bool> systemNotificationsOutboxTableRefs(
    Expression<bool> Function(
      $$SystemNotificationsOutboxTableTableFilterComposer f,
    ) f,
  ) {
    final $$SystemNotificationsOutboxTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.systemNotificationsOutboxTable,
      getReferencedColumn: (t) => t.notificationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SystemNotificationsOutboxTableTableFilterComposer(
        $db: $db,
        $table: $db.systemNotificationsOutboxTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$SystemNotificationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SystemNotificationsTableTable> {
  $$SystemNotificationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get title => $composableBuilder(
        column: $table.title,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get content => $composableBuilder(
        column: $table.content,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get type => $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get seen => $composableBuilder(
        column: $table.seen,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$SystemNotificationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SystemNotificationsTableTable> {
  $$SystemNotificationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SystemNotificationType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get seen =>
      $composableBuilder(column: $table.seen, builder: (column) => column);

  GeneratedColumn<int> get createdAtRemoteUsec => $composableBuilder(
        column: $table.createdAtRemoteUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get updatedAtRemoteUsec => $composableBuilder(
        column: $table.updatedAtRemoteUsec,
        builder: (column) => column,
      );

  Expression<T> systemNotificationsOutboxTableRefs<T extends Object>(
    Expression<T> Function(
      $$SystemNotificationsOutboxTableTableAnnotationComposer a,
    ) f,
  ) {
    final $$SystemNotificationsOutboxTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.systemNotificationsOutboxTable,
      getReferencedColumn: (t) => t.notificationId,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SystemNotificationsOutboxTableTableAnnotationComposer(
        $db: $db,
        $table: $db.systemNotificationsOutboxTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return f(composer);
  }
}

class $$SystemNotificationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SystemNotificationsTableTable,
    SystemNotificationData,
    $$SystemNotificationsTableTableFilterComposer,
    $$SystemNotificationsTableTableOrderingComposer,
    $$SystemNotificationsTableTableAnnotationComposer,
    $$SystemNotificationsTableTableCreateCompanionBuilder,
    $$SystemNotificationsTableTableUpdateCompanionBuilder,
    (SystemNotificationData, $$SystemNotificationsTableTableReferences),
    SystemNotificationData,
    PrefetchHooks Function({bool systemNotificationsOutboxTableRefs})> {
  $$SystemNotificationsTableTableTableManager(
    _$AppDatabase db,
    $SystemNotificationsTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SystemNotificationsTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SystemNotificationsTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SystemNotificationsTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> id = const Value.absent(),
              Value<String> title = const Value.absent(),
              Value<String> content = const Value.absent(),
              Value<SystemNotificationType> type = const Value.absent(),
              Value<bool> seen = const Value.absent(),
              Value<int> createdAtRemoteUsec = const Value.absent(),
              Value<int> updatedAtRemoteUsec = const Value.absent(),
            }) =>
                SystemNotificationDataCompanion(
              id: id,
              title: title,
              content: content,
              type: type,
              seen: seen,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
            ),
            createCompanionCallback: ({
              Value<int> id = const Value.absent(),
              required String title,
              required String content,
              required SystemNotificationType type,
              required bool seen,
              required int createdAtRemoteUsec,
              required int updatedAtRemoteUsec,
            }) =>
                SystemNotificationDataCompanion.insert(
              id: id,
              title: title,
              content: content,
              type: type,
              seen: seen,
              createdAtRemoteUsec: createdAtRemoteUsec,
              updatedAtRemoteUsec: updatedAtRemoteUsec,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SystemNotificationsTableTableReferences(db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: (
                {systemNotificationsOutboxTableRefs = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [
                  if (systemNotificationsOutboxTableRefs)
                    db.systemNotificationsOutboxTable,
                ],
                addJoins: null,
                getPrefetchedDataCallback: (items) async {
                  return [
                    if (systemNotificationsOutboxTableRefs)
                      await $_getPrefetchedData<
                          SystemNotificationData,
                          $SystemNotificationsTableTable,
                          SystemNotificationOutboxEntryData>(
                        currentTable: table,
                        referencedTable:
                            $$SystemNotificationsTableTableReferences
                                ._systemNotificationsOutboxTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SystemNotificationsTableTableReferences(
                          db,
                          table,
                          p0,
                        ).systemNotificationsOutboxTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                          (e) => e.notificationId == item.id,
                        ),
                        typedResults: items,
                      ),
                  ];
                },
              );
            },
          ),
        );
}

typedef $$SystemNotificationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SystemNotificationsTableTable,
        SystemNotificationData,
        $$SystemNotificationsTableTableFilterComposer,
        $$SystemNotificationsTableTableOrderingComposer,
        $$SystemNotificationsTableTableAnnotationComposer,
        $$SystemNotificationsTableTableCreateCompanionBuilder,
        $$SystemNotificationsTableTableUpdateCompanionBuilder,
        (SystemNotificationData, $$SystemNotificationsTableTableReferences),
        SystemNotificationData,
        PrefetchHooks Function({bool systemNotificationsOutboxTableRefs})>;
typedef $$SystemNotificationsOutboxTableTableCreateCompanionBuilder
    = SystemNotificationOutboxEntryDataCompanion Function({
  required int notificationId,
  required SnOutboxDataActionType actionType,
  required SnOutboxDataState state,
  Value<int> sendAttempts,
  Value<int> rowid,
});
typedef $$SystemNotificationsOutboxTableTableUpdateCompanionBuilder
    = SystemNotificationOutboxEntryDataCompanion Function({
  Value<int> notificationId,
  Value<SnOutboxDataActionType> actionType,
  Value<SnOutboxDataState> state,
  Value<int> sendAttempts,
  Value<int> rowid,
});

final class $$SystemNotificationsOutboxTableTableReferences
    extends BaseReferences<_$AppDatabase, $SystemNotificationsOutboxTableTable,
        SystemNotificationOutboxEntryData> {
  $$SystemNotificationsOutboxTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SystemNotificationsTableTable _notificationIdTable(
    _$AppDatabase db,
  ) =>
      db.systemNotificationsTable.createAlias(
        $_aliasNameGenerator(
          db.systemNotificationsOutboxTable.notificationId,
          db.systemNotificationsTable.id,
        ),
      );

  $$SystemNotificationsTableTableProcessedTableManager get notificationId {
    final $_column = $_itemColumn<int>('notification_id')!;

    final manager = $$SystemNotificationsTableTableTableManager(
      $_db,
      $_db.systemNotificationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_notificationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SystemNotificationsOutboxTableTableFilterComposer
    extends Composer<_$AppDatabase, $SystemNotificationsOutboxTableTable> {
  $$SystemNotificationsOutboxTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<
          SnOutboxDataActionType, SnOutboxDataActionType, String>
      get actionType => $composableBuilder(
            column: $table.actionType,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnWithTypeConverterFilters<SnOutboxDataState, SnOutboxDataState, String>
      get state => $composableBuilder(
            column: $table.state,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnFilters(column),
      );

  $$SystemNotificationsTableTableFilterComposer get notificationId {
    final $$SystemNotificationsTableTableFilterComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notificationId,
      referencedTable: $db.systemNotificationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SystemNotificationsTableTableFilterComposer(
        $db: $db,
        $table: $db.systemNotificationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SystemNotificationsOutboxTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SystemNotificationsOutboxTableTable> {
  $$SystemNotificationsOutboxTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get actionType => $composableBuilder(
        column: $table.actionType,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get state => $composableBuilder(
        column: $table.state,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => ColumnOrderings(column),
      );

  $$SystemNotificationsTableTableOrderingComposer get notificationId {
    final $$SystemNotificationsTableTableOrderingComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notificationId,
      referencedTable: $db.systemNotificationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SystemNotificationsTableTableOrderingComposer(
        $db: $db,
        $table: $db.systemNotificationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SystemNotificationsOutboxTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SystemNotificationsOutboxTableTable> {
  $$SystemNotificationsOutboxTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<SnOutboxDataActionType, String>
      get actionType => $composableBuilder(
            column: $table.actionType,
            builder: (column) => column,
          );

  GeneratedColumnWithTypeConverter<SnOutboxDataState, String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get sendAttempts => $composableBuilder(
        column: $table.sendAttempts,
        builder: (column) => column,
      );

  $$SystemNotificationsTableTableAnnotationComposer get notificationId {
    final $$SystemNotificationsTableTableAnnotationComposer composer =
        $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.notificationId,
      referencedTable: $db.systemNotificationsTable,
      getReferencedColumn: (t) => t.id,
      builder: (
        joinBuilder, {
        $addJoinBuilderToRootComposer,
        $removeJoinBuilderFromRootComposer,
      }) =>
          $$SystemNotificationsTableTableAnnotationComposer(
        $db: $db,
        $table: $db.systemNotificationsTable,
        $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
        joinBuilder: joinBuilder,
        $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
      ),
    );
    return composer;
  }
}

class $$SystemNotificationsOutboxTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $SystemNotificationsOutboxTableTable,
        SystemNotificationOutboxEntryData,
        $$SystemNotificationsOutboxTableTableFilterComposer,
        $$SystemNotificationsOutboxTableTableOrderingComposer,
        $$SystemNotificationsOutboxTableTableAnnotationComposer,
        $$SystemNotificationsOutboxTableTableCreateCompanionBuilder,
        $$SystemNotificationsOutboxTableTableUpdateCompanionBuilder,
        (
          SystemNotificationOutboxEntryData,
          $$SystemNotificationsOutboxTableTableReferences,
        ),
        SystemNotificationOutboxEntryData,
        PrefetchHooks Function({bool notificationId})> {
  $$SystemNotificationsOutboxTableTableTableManager(
    _$AppDatabase db,
    $SystemNotificationsOutboxTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$SystemNotificationsOutboxTableTableFilterComposer(
              $db: db,
              $table: table,
            ),
            createOrderingComposer: () =>
                $$SystemNotificationsOutboxTableTableOrderingComposer(
              $db: db,
              $table: table,
            ),
            createComputedFieldComposer: () =>
                $$SystemNotificationsOutboxTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<int> notificationId = const Value.absent(),
              Value<SnOutboxDataActionType> actionType = const Value.absent(),
              Value<SnOutboxDataState> state = const Value.absent(),
              Value<int> sendAttempts = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SystemNotificationOutboxEntryDataCompanion(
              notificationId: notificationId,
              actionType: actionType,
              state: state,
              sendAttempts: sendAttempts,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required int notificationId,
              required SnOutboxDataActionType actionType,
              required SnOutboxDataState state,
              Value<int> sendAttempts = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                SystemNotificationOutboxEntryDataCompanion.insert(
              notificationId: notificationId,
              actionType: actionType,
              state: state,
              sendAttempts: sendAttempts,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map(
                  (e) => (
                    e.readTable(table),
                    $$SystemNotificationsOutboxTableTableReferences(
                        db, table, e),
                  ),
                )
                .toList(),
            prefetchHooksCallback: ({notificationId = false}) {
              return PrefetchHooks(
                db: db,
                explicitlyWatchedTables: [],
                addJoins: <
                    T extends TableManagerState<
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic,
                        dynamic>>(state) {
                  if (notificationId) {
                    state = state.withJoin(
                      currentTable: table,
                      currentColumn: table.notificationId,
                      referencedTable:
                          $$SystemNotificationsOutboxTableTableReferences
                              ._notificationIdTable(db),
                      referencedColumn:
                          $$SystemNotificationsOutboxTableTableReferences
                              ._notificationIdTable(db)
                              .id,
                    ) as T;
                  }

                  return state;
                },
                getPrefetchedDataCallback: (items) async {
                  return [];
                },
              );
            },
          ),
        );
}

typedef $$SystemNotificationsOutboxTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SystemNotificationsOutboxTableTable,
        SystemNotificationOutboxEntryData,
        $$SystemNotificationsOutboxTableTableFilterComposer,
        $$SystemNotificationsOutboxTableTableOrderingComposer,
        $$SystemNotificationsOutboxTableTableAnnotationComposer,
        $$SystemNotificationsOutboxTableTableCreateCompanionBuilder,
        $$SystemNotificationsOutboxTableTableUpdateCompanionBuilder,
        (
          SystemNotificationOutboxEntryData,
          $$SystemNotificationsOutboxTableTableReferences,
        ),
        SystemNotificationOutboxEntryData,
        PrefetchHooks Function({bool notificationId})>;
typedef $$PresenceInfoTableTableCreateCompanionBuilder
    = PresenceInfoDataCompanion Function({
  required String idKey,
  required String number,
  required bool available,
  required String note,
  Value<String?> statusIcon,
  Value<String?> device,
  Value<int?> timeOffsetMin,
  Value<int?> timestampUsec,
  required String activitiesJson,
  Value<int> rowid,
});
typedef $$PresenceInfoTableTableUpdateCompanionBuilder
    = PresenceInfoDataCompanion Function({
  Value<String> idKey,
  Value<String> number,
  Value<bool> available,
  Value<String> note,
  Value<String?> statusIcon,
  Value<String?> device,
  Value<int?> timeOffsetMin,
  Value<int?> timestampUsec,
  Value<String> activitiesJson,
  Value<int> rowid,
});

class $$PresenceInfoTableTableFilterComposer
    extends Composer<_$AppDatabase, $PresenceInfoTableTable> {
  $$PresenceInfoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get available => $composableBuilder(
        column: $table.available,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get note => $composableBuilder(
        column: $table.note,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get statusIcon => $composableBuilder(
        column: $table.statusIcon,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get device => $composableBuilder(
        column: $table.device,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get timeOffsetMin => $composableBuilder(
        column: $table.timeOffsetMin,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get activitiesJson => $composableBuilder(
        column: $table.activitiesJson,
        builder: (column) => ColumnFilters(column),
      );
}

class $$PresenceInfoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PresenceInfoTableTable> {
  $$PresenceInfoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idKey => $composableBuilder(
        column: $table.idKey,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get number => $composableBuilder(
        column: $table.number,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get available => $composableBuilder(
        column: $table.available,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get note => $composableBuilder(
        column: $table.note,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get statusIcon => $composableBuilder(
        column: $table.statusIcon,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get device => $composableBuilder(
        column: $table.device,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timeOffsetMin => $composableBuilder(
        column: $table.timeOffsetMin,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get activitiesJson => $composableBuilder(
        column: $table.activitiesJson,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$PresenceInfoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PresenceInfoTableTable> {
  $$PresenceInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idKey =>
      $composableBuilder(column: $table.idKey, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<bool> get available =>
      $composableBuilder(column: $table.available, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get statusIcon => $composableBuilder(
        column: $table.statusIcon,
        builder: (column) => column,
      );

  GeneratedColumn<String> get device =>
      $composableBuilder(column: $table.device, builder: (column) => column);

  GeneratedColumn<int> get timeOffsetMin => $composableBuilder(
        column: $table.timeOffsetMin,
        builder: (column) => column,
      );

  GeneratedColumn<int> get timestampUsec => $composableBuilder(
        column: $table.timestampUsec,
        builder: (column) => column,
      );

  GeneratedColumn<String> get activitiesJson => $composableBuilder(
        column: $table.activitiesJson,
        builder: (column) => column,
      );
}

class $$PresenceInfoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PresenceInfoTableTable,
    PresenceInfoData,
    $$PresenceInfoTableTableFilterComposer,
    $$PresenceInfoTableTableOrderingComposer,
    $$PresenceInfoTableTableAnnotationComposer,
    $$PresenceInfoTableTableCreateCompanionBuilder,
    $$PresenceInfoTableTableUpdateCompanionBuilder,
    (
      PresenceInfoData,
      BaseReferences<_$AppDatabase, $PresenceInfoTableTable, PresenceInfoData>,
    ),
    PresenceInfoData,
    PrefetchHooks Function()> {
  $$PresenceInfoTableTableTableManager(
    _$AppDatabase db,
    $PresenceInfoTableTable table,
  ) : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$PresenceInfoTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$PresenceInfoTableTableOrderingComposer(
                    $db: db, $table: table),
            createComputedFieldComposer: () =>
                $$PresenceInfoTableTableAnnotationComposer(
              $db: db,
              $table: table,
            ),
            updateCompanionCallback: ({
              Value<String> idKey = const Value.absent(),
              Value<String> number = const Value.absent(),
              Value<bool> available = const Value.absent(),
              Value<String> note = const Value.absent(),
              Value<String?> statusIcon = const Value.absent(),
              Value<String?> device = const Value.absent(),
              Value<int?> timeOffsetMin = const Value.absent(),
              Value<int?> timestampUsec = const Value.absent(),
              Value<String> activitiesJson = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                PresenceInfoDataCompanion(
              idKey: idKey,
              number: number,
              available: available,
              note: note,
              statusIcon: statusIcon,
              device: device,
              timeOffsetMin: timeOffsetMin,
              timestampUsec: timestampUsec,
              activitiesJson: activitiesJson,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String idKey,
              required String number,
              required bool available,
              required String note,
              Value<String?> statusIcon = const Value.absent(),
              Value<String?> device = const Value.absent(),
              Value<int?> timeOffsetMin = const Value.absent(),
              Value<int?> timestampUsec = const Value.absent(),
              required String activitiesJson,
              Value<int> rowid = const Value.absent(),
            }) =>
                PresenceInfoDataCompanion.insert(
              idKey: idKey,
              number: number,
              available: available,
              note: note,
              statusIcon: statusIcon,
              device: device,
              timeOffsetMin: timeOffsetMin,
              timestampUsec: timestampUsec,
              activitiesJson: activitiesJson,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$PresenceInfoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PresenceInfoTableTable,
    PresenceInfoData,
    $$PresenceInfoTableTableFilterComposer,
    $$PresenceInfoTableTableOrderingComposer,
    $$PresenceInfoTableTableAnnotationComposer,
    $$PresenceInfoTableTableCreateCompanionBuilder,
    $$PresenceInfoTableTableUpdateCompanionBuilder,
    (
      PresenceInfoData,
      BaseReferences<_$AppDatabase, $PresenceInfoTableTable, PresenceInfoData>,
    ),
    PresenceInfoData,
    PrefetchHooks Function()>;
typedef $$CdrTableTableCreateCompanionBuilder = CdrRecordDataCompanion
    Function({
  required String callId,
  required CallDirectionData direction,
  required CdrStatusData status,
  required String callee,
  Value<String?> calleeNumber,
  required String caller,
  Value<String?> callerNumber,
  required int connectTimeUsec,
  required int disconnectTimeUsec,
  required String disconnectReason,
  required int durationSeconds,
  Value<String?> recordingId,
  Value<int> rowid,
});
typedef $$CdrTableTableUpdateCompanionBuilder = CdrRecordDataCompanion
    Function({
  Value<String> callId,
  Value<CallDirectionData> direction,
  Value<CdrStatusData> status,
  Value<String> callee,
  Value<String?> calleeNumber,
  Value<String> caller,
  Value<String?> callerNumber,
  Value<int> connectTimeUsec,
  Value<int> disconnectTimeUsec,
  Value<String> disconnectReason,
  Value<int> durationSeconds,
  Value<String?> recordingId,
  Value<int> rowid,
});

class $$CdrTableTableFilterComposer
    extends Composer<_$AppDatabase, $CdrTableTable> {
  $$CdrTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get callId => $composableBuilder(
        column: $table.callId,
        builder: (column) => ColumnFilters(column),
      );

  ColumnWithTypeConverterFilters<CallDirectionData, CallDirectionData, String>
      get direction => $composableBuilder(
            column: $table.direction,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnWithTypeConverterFilters<CdrStatusData, CdrStatusData, String>
      get status => $composableBuilder(
            column: $table.status,
            builder: (column) => ColumnWithTypeConverterFilters(column),
          );

  ColumnFilters<String> get callee => $composableBuilder(
        column: $table.callee,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get calleeNumber => $composableBuilder(
        column: $table.calleeNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get caller => $composableBuilder(
        column: $table.caller,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get callerNumber => $composableBuilder(
        column: $table.callerNumber,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get connectTimeUsec => $composableBuilder(
        column: $table.connectTimeUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get disconnectTimeUsec => $composableBuilder(
        column: $table.disconnectTimeUsec,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get disconnectReason => $composableBuilder(
        column: $table.disconnectReason,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
        column: $table.durationSeconds,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get recordingId => $composableBuilder(
        column: $table.recordingId,
        builder: (column) => ColumnFilters(column),
      );
}

class $$CdrTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CdrTableTable> {
  $$CdrTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get callId => $composableBuilder(
        column: $table.callId,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get direction => $composableBuilder(
        column: $table.direction,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get status => $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get callee => $composableBuilder(
        column: $table.callee,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get calleeNumber => $composableBuilder(
        column: $table.calleeNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get caller => $composableBuilder(
        column: $table.caller,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get callerNumber => $composableBuilder(
        column: $table.callerNumber,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get connectTimeUsec => $composableBuilder(
        column: $table.connectTimeUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get disconnectTimeUsec => $composableBuilder(
        column: $table.disconnectTimeUsec,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get disconnectReason => $composableBuilder(
        column: $table.disconnectReason,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
        column: $table.durationSeconds,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get recordingId => $composableBuilder(
        column: $table.recordingId,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$CdrTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CdrTableTable> {
  $$CdrTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get callId =>
      $composableBuilder(column: $table.callId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CallDirectionData, String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CdrStatusData, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get callee =>
      $composableBuilder(column: $table.callee, builder: (column) => column);

  GeneratedColumn<String> get calleeNumber => $composableBuilder(
        column: $table.calleeNumber,
        builder: (column) => column,
      );

  GeneratedColumn<String> get caller =>
      $composableBuilder(column: $table.caller, builder: (column) => column);

  GeneratedColumn<String> get callerNumber => $composableBuilder(
        column: $table.callerNumber,
        builder: (column) => column,
      );

  GeneratedColumn<int> get connectTimeUsec => $composableBuilder(
        column: $table.connectTimeUsec,
        builder: (column) => column,
      );

  GeneratedColumn<int> get disconnectTimeUsec => $composableBuilder(
        column: $table.disconnectTimeUsec,
        builder: (column) => column,
      );

  GeneratedColumn<String> get disconnectReason => $composableBuilder(
        column: $table.disconnectReason,
        builder: (column) => column,
      );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
        column: $table.durationSeconds,
        builder: (column) => column,
      );

  GeneratedColumn<String> get recordingId => $composableBuilder(
        column: $table.recordingId,
        builder: (column) => column,
      );
}

class $$CdrTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CdrTableTable,
    CdrRecordData,
    $$CdrTableTableFilterComposer,
    $$CdrTableTableOrderingComposer,
    $$CdrTableTableAnnotationComposer,
    $$CdrTableTableCreateCompanionBuilder,
    $$CdrTableTableUpdateCompanionBuilder,
    (
      CdrRecordData,
      BaseReferences<_$AppDatabase, $CdrTableTable, CdrRecordData>,
    ),
    CdrRecordData,
    PrefetchHooks Function()> {
  $$CdrTableTableTableManager(_$AppDatabase db, $CdrTableTable table)
      : super(
          TableManagerState(
            db: db,
            table: table,
            createFilteringComposer: () =>
                $$CdrTableTableFilterComposer($db: db, $table: table),
            createOrderingComposer: () =>
                $$CdrTableTableOrderingComposer($db: db, $table: table),
            createComputedFieldComposer: () =>
                $$CdrTableTableAnnotationComposer($db: db, $table: table),
            updateCompanionCallback: ({
              Value<String> callId = const Value.absent(),
              Value<CallDirectionData> direction = const Value.absent(),
              Value<CdrStatusData> status = const Value.absent(),
              Value<String> callee = const Value.absent(),
              Value<String?> calleeNumber = const Value.absent(),
              Value<String> caller = const Value.absent(),
              Value<String?> callerNumber = const Value.absent(),
              Value<int> connectTimeUsec = const Value.absent(),
              Value<int> disconnectTimeUsec = const Value.absent(),
              Value<String> disconnectReason = const Value.absent(),
              Value<int> durationSeconds = const Value.absent(),
              Value<String?> recordingId = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                CdrRecordDataCompanion(
              callId: callId,
              direction: direction,
              status: status,
              callee: callee,
              calleeNumber: calleeNumber,
              caller: caller,
              callerNumber: callerNumber,
              connectTimeUsec: connectTimeUsec,
              disconnectTimeUsec: disconnectTimeUsec,
              disconnectReason: disconnectReason,
              durationSeconds: durationSeconds,
              recordingId: recordingId,
              rowid: rowid,
            ),
            createCompanionCallback: ({
              required String callId,
              required CallDirectionData direction,
              required CdrStatusData status,
              required String callee,
              Value<String?> calleeNumber = const Value.absent(),
              required String caller,
              Value<String?> callerNumber = const Value.absent(),
              required int connectTimeUsec,
              required int disconnectTimeUsec,
              required String disconnectReason,
              required int durationSeconds,
              Value<String?> recordingId = const Value.absent(),
              Value<int> rowid = const Value.absent(),
            }) =>
                CdrRecordDataCompanion.insert(
              callId: callId,
              direction: direction,
              status: status,
              callee: callee,
              calleeNumber: calleeNumber,
              caller: caller,
              callerNumber: callerNumber,
              connectTimeUsec: connectTimeUsec,
              disconnectTimeUsec: disconnectTimeUsec,
              disconnectReason: disconnectReason,
              durationSeconds: durationSeconds,
              recordingId: recordingId,
              rowid: rowid,
            ),
            withReferenceMapper: (p0) => p0
                .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
                .toList(),
            prefetchHooksCallback: null,
          ),
        );
}

typedef $$CdrTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CdrTableTable,
    CdrRecordData,
    $$CdrTableTableFilterComposer,
    $$CdrTableTableOrderingComposer,
    $$CdrTableTableAnnotationComposer,
    $$CdrTableTableCreateCompanionBuilder,
    $$CdrTableTableUpdateCompanionBuilder,
    (
      CdrRecordData,
      BaseReferences<_$AppDatabase, $CdrTableTable, CdrRecordData>,
    ),
    CdrRecordData,
    PrefetchHooks Function()>;

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
            _db,
            _db.chatMessageSyncCursorTable,
          );
  $$ChatMessageReadCursorTableTableTableManager
      get chatMessageReadCursorTable =>
          $$ChatMessageReadCursorTableTableTableManager(
            _db,
            _db.chatMessageReadCursorTable,
          );
  $$ChatOutboxMessageTableTableTableManager get chatOutboxMessageTable =>
      $$ChatOutboxMessageTableTableTableManager(
        _db,
        _db.chatOutboxMessageTable,
      );
  $$ChatOutboxMessageEditTableTableTableManager
      get chatOutboxMessageEditTable =>
          $$ChatOutboxMessageEditTableTableTableManager(
            _db,
            _db.chatOutboxMessageEditTable,
          );
  $$ChatOutboxMessageDeleteTableTableTableManager
      get chatOutboxMessageDeleteTable =>
          $$ChatOutboxMessageDeleteTableTableTableManager(
            _db,
            _db.chatOutboxMessageDeleteTable,
          );
  $$ChatOutboxReadCursorsTableTableTableManager
      get chatOutboxReadCursorsTable =>
          $$ChatOutboxReadCursorsTableTableTableManager(
            _db,
            _db.chatOutboxReadCursorsTable,
          );
  $$SmsConversationsTableTableTableManager get smsConversationsTable =>
      $$SmsConversationsTableTableTableManager(_db, _db.smsConversationsTable);
  $$SmsMessagesTableTableTableManager get smsMessagesTable =>
      $$SmsMessagesTableTableTableManager(_db, _db.smsMessagesTable);
  $$SmsMessageSyncCursorTableTableTableManager get smsMessageSyncCursorTable =>
      $$SmsMessageSyncCursorTableTableTableManager(
        _db,
        _db.smsMessageSyncCursorTable,
      );
  $$SmsMessageReadCursorTableTableTableManager get smsMessageReadCursorTable =>
      $$SmsMessageReadCursorTableTableTableManager(
        _db,
        _db.smsMessageReadCursorTable,
      );
  $$SmsOutboxMessagesTableTableTableManager get smsOutboxMessagesTable =>
      $$SmsOutboxMessagesTableTableTableManager(
        _db,
        _db.smsOutboxMessagesTable,
      );
  $$SmsOutboxMessageDeleteTableTableTableManager
      get smsOutboxMessageDeleteTable =>
          $$SmsOutboxMessageDeleteTableTableTableManager(
            _db,
            _db.smsOutboxMessageDeleteTable,
          );
  $$SmsOutboxReadCursorsTableTableTableManager get smsOutboxReadCursorsTable =>
      $$SmsOutboxReadCursorsTableTableTableManager(
        _db,
        _db.smsOutboxReadCursorsTable,
      );
  $$UserSmsNumbersTableTableTableManager get userSmsNumbersTable =>
      $$UserSmsNumbersTableTableTableManager(_db, _db.userSmsNumbersTable);
  $$ActiveMessageNotificationsTableTableTableManager
      get activeMessageNotificationsTable =>
          $$ActiveMessageNotificationsTableTableTableManager(
            _db,
            _db.activeMessageNotificationsTable,
          );
  $$VoicemailTableTableTableManager get voicemailTable =>
      $$VoicemailTableTableTableManager(_db, _db.voicemailTable);
  $$SystemNotificationsTableTableTableManager get systemNotificationsTable =>
      $$SystemNotificationsTableTableTableManager(
        _db,
        _db.systemNotificationsTable,
      );
  $$SystemNotificationsOutboxTableTableTableManager
      get systemNotificationsOutboxTable =>
          $$SystemNotificationsOutboxTableTableTableManager(
            _db,
            _db.systemNotificationsOutboxTable,
          );
  $$PresenceInfoTableTableTableManager get presenceInfoTable =>
      $$PresenceInfoTableTableTableManager(_db, _db.presenceInfoTable);
  $$CdrTableTableTableManager get cdrTable =>
      $$CdrTableTableTableManager(_db, _db.cdrTable);
}
