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
  static const VerificationMeta _registeredMeta =
      const VerificationMeta('registered');
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
      'registered', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("registered" IN (0, 1))'));
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
        registered,
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
    if (data.containsKey('registered')) {
      context.handle(
          _registeredMeta,
          registered.isAcceptableOrUnknown(
              data['registered']!, _registeredMeta));
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
      registered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}registered']),
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
  final bool? registered;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactData(
      {required this.id,
      required this.sourceType,
      required this.sourceId,
      this.firstName,
      this.lastName,
      this.aliasName,
      this.registered,
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
    if (!nullToAbsent || registered != null) {
      map['registered'] = Variable<bool>(registered);
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
      registered: registered == null && nullToAbsent
          ? const Value.absent()
          : Value(registered),
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
      registered: serializer.fromJson<bool?>(json['registered']),
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
      'registered': serializer.toJson<bool?>(registered),
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
          Value<bool?> registered = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactData(
        id: id ?? this.id,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        aliasName: aliasName.present ? aliasName.value : this.aliasName,
        registered: registered.present ? registered.value : this.registered,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ContactData(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('aliasName: $aliasName, ')
          ..write('registered: $registered, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceType, sourceId, firstName, lastName,
      aliasName, registered, insertedAt, updatedAt);
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
          other.registered == this.registered &&
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
  final Value<bool?> registered;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactDataCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.aliasName = const Value.absent(),
    this.registered = const Value.absent(),
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
    this.registered = const Value.absent(),
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
    Expression<bool>? registered,
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
      if (registered != null) 'registered': registered,
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
      Value<bool?>? registered,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactDataCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aliasName: aliasName ?? this.aliasName,
      registered: registered ?? this.registered,
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
    if (registered.present) {
      map['registered'] = Variable<bool>(registered.value);
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
          ..write('registered: $registered, ')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $ContactsTableTable contactsTable = $ContactsTableTable(this);
  late final $ContactPhonesTableTable contactPhonesTable =
      $ContactPhonesTableTable(this);
  late final $ContactEmailsTableTable contactEmailsTable =
      $ContactEmailsTableTable(this);
  late final $CallLogsTableTable callLogsTable = $CallLogsTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ContactPhonesDao contactPhonesDao =
      ContactPhonesDao(this as AppDatabase);
  late final ContactEmailsDao contactEmailsDao =
      ContactEmailsDao(this as AppDatabase);
  late final CallLogsDao callLogsDao = CallLogsDao(this as AppDatabase);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contactsTable,
        contactPhonesTable,
        contactEmailsTable,
        callLogsTable,
        favoritesTable
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
        ],
      );
}

typedef $$ContactsTableTableInsertCompanionBuilder = ContactDataCompanion
    Function({
  Value<int> id,
  required ContactSourceTypeEnum sourceType,
  required String sourceId,
  Value<String?> firstName,
  Value<String?> lastName,
  Value<String?> aliasName,
  Value<bool?> registered,
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
  Value<bool?> registered,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ContactsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTableTable,
    ContactData,
    $$ContactsTableTableFilterComposer,
    $$ContactsTableTableOrderingComposer,
    $$ContactsTableTableProcessedTableManager,
    $$ContactsTableTableInsertCompanionBuilder,
    $$ContactsTableTableUpdateCompanionBuilder> {
  $$ContactsTableTableTableManager(_$AppDatabase db, $ContactsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContactsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContactsTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ContactsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<ContactSourceTypeEnum> sourceType = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> aliasName = const Value.absent(),
            Value<bool?> registered = const Value.absent(),
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
            registered: registered,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required ContactSourceTypeEnum sourceType,
            required String sourceId,
            Value<String?> firstName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> aliasName = const Value.absent(),
            Value<bool?> registered = const Value.absent(),
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
            registered: registered,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ContactsTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ContactsTableTable,
    ContactData,
    $$ContactsTableTableFilterComposer,
    $$ContactsTableTableOrderingComposer,
    $$ContactsTableTableProcessedTableManager,
    $$ContactsTableTableInsertCompanionBuilder,
    $$ContactsTableTableUpdateCompanionBuilder> {
  $$ContactsTableTableProcessedTableManager(super.$state);
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

  ColumnFilters<bool> get registered => $state.composableBuilder(
      column: $state.table.registered,
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

  ColumnOrderings<bool> get registered => $state.composableBuilder(
      column: $state.table.registered,
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

typedef $$ContactPhonesTableTableInsertCompanionBuilder
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
    $$ContactPhonesTableTableProcessedTableManager,
    $$ContactPhonesTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ContactPhonesTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
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
          getInsertCompanionBuilder: ({
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

class $$ContactPhonesTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ContactPhonesTableTable,
        ContactPhoneData,
        $$ContactPhonesTableTableFilterComposer,
        $$ContactPhonesTableTableOrderingComposer,
        $$ContactPhonesTableTableProcessedTableManager,
        $$ContactPhonesTableTableInsertCompanionBuilder,
        $$ContactPhonesTableTableUpdateCompanionBuilder> {
  $$ContactPhonesTableTableProcessedTableManager(super.$state);
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

typedef $$ContactEmailsTableTableInsertCompanionBuilder
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
    $$ContactEmailsTableTableProcessedTableManager,
    $$ContactEmailsTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ContactEmailsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
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
          getInsertCompanionBuilder: ({
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

class $$ContactEmailsTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ContactEmailsTableTable,
        ContactEmailData,
        $$ContactEmailsTableTableFilterComposer,
        $$ContactEmailsTableTableOrderingComposer,
        $$ContactEmailsTableTableProcessedTableManager,
        $$ContactEmailsTableTableInsertCompanionBuilder,
        $$ContactEmailsTableTableUpdateCompanionBuilder> {
  $$ContactEmailsTableTableProcessedTableManager(super.$state);
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

typedef $$CallLogsTableTableInsertCompanionBuilder = CallLogDataCompanion
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
    $$CallLogsTableTableProcessedTableManager,
    $$CallLogsTableTableInsertCompanionBuilder,
    $$CallLogsTableTableUpdateCompanionBuilder> {
  $$CallLogsTableTableTableManager(_$AppDatabase db, $CallLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CallLogsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CallLogsTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CallLogsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
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
          getInsertCompanionBuilder: ({
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

class $$CallLogsTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $CallLogsTableTable,
    CallLogData,
    $$CallLogsTableTableFilterComposer,
    $$CallLogsTableTableOrderingComposer,
    $$CallLogsTableTableProcessedTableManager,
    $$CallLogsTableTableInsertCompanionBuilder,
    $$CallLogsTableTableUpdateCompanionBuilder> {
  $$CallLogsTableTableProcessedTableManager(super.$state);
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

typedef $$FavoritesTableTableInsertCompanionBuilder = FavoriteDataCompanion
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
    $$FavoritesTableTableProcessedTableManager,
    $$FavoritesTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$FavoritesTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> contactPhoneId = const Value.absent(),
            Value<int> position = const Value.absent(),
          }) =>
              FavoriteDataCompanion(
            id: id,
            contactPhoneId: contactPhoneId,
            position: position,
          ),
          getInsertCompanionBuilder: ({
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

class $$FavoritesTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $FavoritesTableTable,
    FavoriteData,
    $$FavoritesTableTableFilterComposer,
    $$FavoritesTableTableOrderingComposer,
    $$FavoritesTableTableProcessedTableManager,
    $$FavoritesTableTableInsertCompanionBuilder,
    $$FavoritesTableTableUpdateCompanionBuilder> {
  $$FavoritesTableTableProcessedTableManager(super.$state);
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

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
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
}

mixin _$ContactsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
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
