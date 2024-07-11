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
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ContactData(
      {required this.id,
      required this.sourceType,
      required this.sourceId,
      this.firstName,
      this.lastName,
      this.aliasName,
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
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactData(
        id: id ?? this.id,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        aliasName: aliasName.present ? aliasName.value : this.aliasName,
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
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceType, sourceId, firstName, lastName,
      aliasName, insertedAt, updatedAt);
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
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactDataCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.aliasName = const Value.absent(),
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
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactDataCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aliasName: aliasName ?? this.aliasName,
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
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<String> creatorId = GeneratedColumn<String>(
      'creator_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
        type,
        name,
        creatorId,
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
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    } else if (isInserting) {
      context.missing(_creatorIdMeta);
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
  ChatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $ChatsTableTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      creatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator_id'])!,
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
  final String creatorId;
  final DateTime createdAtRemote;
  final DateTime updatedAtRemote;
  final DateTime? deletedAtRemote;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ChatData(
      {required this.id,
      required this.type,
      this.name,
      required this.creatorId,
      required this.createdAtRemote,
      required this.updatedAtRemote,
      this.deletedAtRemote,
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
    map['creator_id'] = Variable<String>(creatorId);
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

  ChatDataCompanion toCompanion(bool nullToAbsent) {
    return ChatDataCompanion(
      id: Value(id),
      type: Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      creatorId: Value(creatorId),
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

  factory ChatData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatData(
      id: serializer.fromJson<int>(json['id']),
      type: $ChatsTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      name: serializer.fromJson<String?>(json['name']),
      creatorId: serializer.fromJson<String>(json['creatorId']),
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
      'type': serializer
          .toJson<String>($ChatsTableTable.$convertertype.toJson(type)),
      'name': serializer.toJson<String?>(name),
      'creatorId': serializer.toJson<String>(creatorId),
      'createdAtRemote': serializer.toJson<DateTime>(createdAtRemote),
      'updatedAtRemote': serializer.toJson<DateTime>(updatedAtRemote),
      'deletedAtRemote': serializer.toJson<DateTime?>(deletedAtRemote),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ChatData copyWith(
          {int? id,
          ChatTypeEnum? type,
          Value<String?> name = const Value.absent(),
          String? creatorId,
          DateTime? createdAtRemote,
          DateTime? updatedAtRemote,
          Value<DateTime?> deletedAtRemote = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ChatData(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name.present ? name.value : this.name,
        creatorId: creatorId ?? this.creatorId,
        createdAtRemote: createdAtRemote ?? this.createdAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
        deletedAtRemote: deletedAtRemote.present
            ? deletedAtRemote.value
            : this.deletedAtRemote,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ChatData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('deletedAtRemote: $deletedAtRemote, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, name, creatorId, createdAtRemote,
      updatedAtRemote, deletedAtRemote, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatData &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.creatorId == this.creatorId &&
          other.createdAtRemote == this.createdAtRemote &&
          other.updatedAtRemote == this.updatedAtRemote &&
          other.deletedAtRemote == this.deletedAtRemote &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ChatDataCompanion extends UpdateCompanion<ChatData> {
  final Value<int> id;
  final Value<ChatTypeEnum> type;
  final Value<String?> name;
  final Value<String> creatorId;
  final Value<DateTime> createdAtRemote;
  final Value<DateTime> updatedAtRemote;
  final Value<DateTime?> deletedAtRemote;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ChatDataCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.createdAtRemote = const Value.absent(),
    this.updatedAtRemote = const Value.absent(),
    this.deletedAtRemote = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatDataCompanion.insert({
    this.id = const Value.absent(),
    required ChatTypeEnum type,
    this.name = const Value.absent(),
    required String creatorId,
    required DateTime createdAtRemote,
    required DateTime updatedAtRemote,
    this.deletedAtRemote = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : type = Value(type),
        creatorId = Value(creatorId),
        createdAtRemote = Value(createdAtRemote),
        updatedAtRemote = Value(updatedAtRemote);
  static Insertable<ChatData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? creatorId,
    Expression<DateTime>? createdAtRemote,
    Expression<DateTime>? updatedAtRemote,
    Expression<DateTime>? deletedAtRemote,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (creatorId != null) 'creator_id': creatorId,
      if (createdAtRemote != null) 'created_at_remote': createdAtRemote,
      if (updatedAtRemote != null) 'updated_at_remote': updatedAtRemote,
      if (deletedAtRemote != null) 'deleted_at_remote': deletedAtRemote,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatDataCompanion copyWith(
      {Value<int>? id,
      Value<ChatTypeEnum>? type,
      Value<String?>? name,
      Value<String>? creatorId,
      Value<DateTime>? createdAtRemote,
      Value<DateTime>? updatedAtRemote,
      Value<DateTime?>? deletedAtRemote,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ChatDataCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      creatorId: creatorId ?? this.creatorId,
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
    if (type.present) {
      map['type'] =
          Variable<String>($ChatsTableTable.$convertertype.toSql(type.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<String>(creatorId.value);
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
    return (StringBuffer('ChatDataCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('createdAtRemote: $createdAtRemote, ')
          ..write('updatedAtRemote: $updatedAtRemote, ')
          ..write('deletedAtRemote: $deletedAtRemote, ')
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
  static const VerificationMeta _joinedAtMeta =
      const VerificationMeta('joinedAt');
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _leftAtMeta = const VerificationMeta('leftAt');
  @override
  late final GeneratedColumn<DateTime> leftAt = GeneratedColumn<DateTime>(
      'left_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _blockedAtMeta =
      const VerificationMeta('blockedAt');
  @override
  late final GeneratedColumn<DateTime> blockedAt = GeneratedColumn<DateTime>(
      'blocked_at', aliasedName, true,
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
  List<GeneratedColumn> get $columns =>
      [id, chatId, userId, joinedAt, leftAt, blockedAt, insertedAt, updatedAt];
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
    if (data.containsKey('joined_at')) {
      context.handle(_joinedAtMeta,
          joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta));
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    if (data.containsKey('left_at')) {
      context.handle(_leftAtMeta,
          leftAt.isAcceptableOrUnknown(data['left_at']!, _leftAtMeta));
    }
    if (data.containsKey('blocked_at')) {
      context.handle(_blockedAtMeta,
          blockedAt.isAcceptableOrUnknown(data['blocked_at']!, _blockedAtMeta));
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
  ChatMemberData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMemberData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      joinedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joined_at'])!,
      leftAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}left_at']),
      blockedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}blocked_at']),
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
}

class ChatMemberData extends DataClass implements Insertable<ChatMemberData> {
  final int id;
  final int chatId;
  final String userId;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final DateTime? blockedAt;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  const ChatMemberData(
      {required this.id,
      required this.chatId,
      required this.userId,
      required this.joinedAt,
      this.leftAt,
      this.blockedAt,
      this.insertedAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['user_id'] = Variable<String>(userId);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    if (!nullToAbsent || leftAt != null) {
      map['left_at'] = Variable<DateTime>(leftAt);
    }
    if (!nullToAbsent || blockedAt != null) {
      map['blocked_at'] = Variable<DateTime>(blockedAt);
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
      joinedAt: Value(joinedAt),
      leftAt:
          leftAt == null && nullToAbsent ? const Value.absent() : Value(leftAt),
      blockedAt: blockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(blockedAt),
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
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      leftAt: serializer.fromJson<DateTime?>(json['leftAt']),
      blockedAt: serializer.fromJson<DateTime?>(json['blockedAt']),
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
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'leftAt': serializer.toJson<DateTime?>(leftAt),
      'blockedAt': serializer.toJson<DateTime?>(blockedAt),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ChatMemberData copyWith(
          {int? id,
          int? chatId,
          String? userId,
          DateTime? joinedAt,
          Value<DateTime?> leftAt = const Value.absent(),
          Value<DateTime?> blockedAt = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ChatMemberData(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        joinedAt: joinedAt ?? this.joinedAt,
        leftAt: leftAt.present ? leftAt.value : this.leftAt,
        blockedAt: blockedAt.present ? blockedAt.value : this.blockedAt,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ChatMemberData(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('leftAt: $leftAt, ')
          ..write('blockedAt: $blockedAt, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, chatId, userId, joinedAt, leftAt, blockedAt, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMemberData &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.userId == this.userId &&
          other.joinedAt == this.joinedAt &&
          other.leftAt == this.leftAt &&
          other.blockedAt == this.blockedAt &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ChatMemberDataCompanion extends UpdateCompanion<ChatMemberData> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> userId;
  final Value<DateTime> joinedAt;
  final Value<DateTime?> leftAt;
  final Value<DateTime?> blockedAt;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ChatMemberDataCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.leftAt = const Value.absent(),
    this.blockedAt = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChatMemberDataCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String userId,
    required DateTime joinedAt,
    this.leftAt = const Value.absent(),
    this.blockedAt = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : chatId = Value(chatId),
        userId = Value(userId),
        joinedAt = Value(joinedAt);
  static Insertable<ChatMemberData> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? userId,
    Expression<DateTime>? joinedAt,
    Expression<DateTime>? leftAt,
    Expression<DateTime>? blockedAt,
    Expression<DateTime>? insertedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (userId != null) 'user_id': userId,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (leftAt != null) 'left_at': leftAt,
      if (blockedAt != null) 'blocked_at': blockedAt,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChatMemberDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? chatId,
      Value<String>? userId,
      Value<DateTime>? joinedAt,
      Value<DateTime?>? leftAt,
      Value<DateTime?>? blockedAt,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ChatMemberDataCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt ?? this.leftAt,
      blockedAt: blockedAt ?? this.blockedAt,
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
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (leftAt.present) {
      map['left_at'] = Variable<DateTime>(leftAt.value);
    }
    if (blockedAt.present) {
      map['blocked_at'] = Variable<DateTime>(blockedAt.value);
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
          ..write('joinedAt: $joinedAt, ')
          ..write('leftAt: $leftAt, ')
          ..write('blockedAt: $blockedAt, ')
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
        editedAt: editedAt.present ? editedAt.value : this.editedAt,
        createdAtRemote: createdAtRemote ?? this.createdAtRemote,
        updatedAtRemote: updatedAtRemote ?? this.updatedAtRemote,
        deletedAtRemote: deletedAtRemote.present
            ? deletedAtRemote.value
            : this.deletedAtRemote,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
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
        content
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
  const ChatOutboxMessageData(
      {required this.idKey,
      this.chatId,
      this.participantId,
      this.replyToId,
      this.forwardFromId,
      this.authorId,
      required this.viaSms,
      this.smsNumber,
      required this.content});
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
          String? content}) =>
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
      );
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
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idKey, chatId, participantId, replyToId,
      forwardFromId, authorId, viaSms, smsNumber, content);
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
          other.content == this.content);
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
  @override
  List<GeneratedColumn> get $columns => [id, idKey, chatId, newContent];
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
  const ChatOutboxMessageEditData(
      {required this.id,
      required this.idKey,
      required this.chatId,
      required this.newContent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['chat_id'] = Variable<int>(chatId);
    map['new_content'] = Variable<String>(newContent);
    return map;
  }

  ChatOutboxMessageEditDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageEditDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      chatId: Value(chatId),
      newContent: Value(newContent),
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
    };
  }

  ChatOutboxMessageEditData copyWith(
          {int? id, String? idKey, int? chatId, String? newContent}) =>
      ChatOutboxMessageEditData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
        newContent: newContent ?? this.newContent,
      );
  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageEditData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('newContent: $newContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, chatId, newContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageEditData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId &&
          other.newContent == this.newContent);
}

class ChatOutboxMessageEditDataCompanion
    extends UpdateCompanion<ChatOutboxMessageEditData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> chatId;
  final Value<String> newContent;
  const ChatOutboxMessageEditDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
    this.newContent = const Value.absent(),
  });
  ChatOutboxMessageEditDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int chatId,
    required String newContent,
  })  : idKey = Value(idKey),
        chatId = Value(chatId),
        newContent = Value(newContent);
  static Insertable<ChatOutboxMessageEditData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? chatId,
    Expression<String>? newContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
      if (newContent != null) 'new_content': newContent,
    });
  }

  ChatOutboxMessageEditDataCompanion copyWith(
      {Value<int>? id,
      Value<String>? idKey,
      Value<int>? chatId,
      Value<String>? newContent}) {
    return ChatOutboxMessageEditDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      newContent: newContent ?? this.newContent,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageEditDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId, ')
          ..write('newContent: $newContent')
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
  @override
  List<GeneratedColumn> get $columns => [id, idKey, chatId];
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
  const ChatOutboxMessageDeleteData(
      {required this.id, required this.idKey, required this.chatId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_key'] = Variable<String>(idKey);
    map['chat_id'] = Variable<int>(chatId);
    return map;
  }

  ChatOutboxMessageDeleteDataCompanion toCompanion(bool nullToAbsent) {
    return ChatOutboxMessageDeleteDataCompanion(
      id: Value(id),
      idKey: Value(idKey),
      chatId: Value(chatId),
    );
  }

  factory ChatOutboxMessageDeleteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatOutboxMessageDeleteData(
      id: serializer.fromJson<int>(json['id']),
      idKey: serializer.fromJson<String>(json['idKey']),
      chatId: serializer.fromJson<int>(json['chatId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idKey': serializer.toJson<String>(idKey),
      'chatId': serializer.toJson<int>(chatId),
    };
  }

  ChatOutboxMessageDeleteData copyWith({int? id, String? idKey, int? chatId}) =>
      ChatOutboxMessageDeleteData(
        id: id ?? this.id,
        idKey: idKey ?? this.idKey,
        chatId: chatId ?? this.chatId,
      );
  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageDeleteData(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idKey, chatId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatOutboxMessageDeleteData &&
          other.id == this.id &&
          other.idKey == this.idKey &&
          other.chatId == this.chatId);
}

class ChatOutboxMessageDeleteDataCompanion
    extends UpdateCompanion<ChatOutboxMessageDeleteData> {
  final Value<int> id;
  final Value<String> idKey;
  final Value<int> chatId;
  const ChatOutboxMessageDeleteDataCompanion({
    this.id = const Value.absent(),
    this.idKey = const Value.absent(),
    this.chatId = const Value.absent(),
  });
  ChatOutboxMessageDeleteDataCompanion.insert({
    this.id = const Value.absent(),
    required String idKey,
    required int chatId,
  })  : idKey = Value(idKey),
        chatId = Value(chatId);
  static Insertable<ChatOutboxMessageDeleteData> custom({
    Expression<int>? id,
    Expression<String>? idKey,
    Expression<int>? chatId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idKey != null) 'id_key': idKey,
      if (chatId != null) 'chat_id': chatId,
    });
  }

  ChatOutboxMessageDeleteDataCompanion copyWith(
      {Value<int>? id, Value<String>? idKey, Value<int>? chatId}) {
    return ChatOutboxMessageDeleteDataCompanion(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatOutboxMessageDeleteDataCompanion(')
          ..write('id: $id, ')
          ..write('idKey: $idKey, ')
          ..write('chatId: $chatId')
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
  late final $ChatsTableTable chatsTable = $ChatsTableTable(this);
  late final $ChatMembersTableTable chatMembersTable =
      $ChatMembersTableTable(this);
  late final $ChatMessagesTableTable chatMessagesTable =
      $ChatMessagesTableTable(this);
  late final $ChatOutboxMessageTableTable chatOutboxMessageTable =
      $ChatOutboxMessageTableTable(this);
  late final $ChatOutboxMessageEditTableTable chatOutboxMessageEditTable =
      $ChatOutboxMessageEditTableTable(this);
  late final $ChatOutboxMessageDeleteTableTable chatOutboxMessageDeleteTable =
      $ChatOutboxMessageDeleteTableTable(this);
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
        chatOutboxMessageTable,
        chatOutboxMessageEditTable,
        chatOutboxMessageDeleteTable
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

typedef $$ChatsTableTableInsertCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  required ChatTypeEnum type,
  Value<String?> name,
  required String creatorId,
  required DateTime createdAtRemote,
  required DateTime updatedAtRemote,
  Value<DateTime?> deletedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ChatsTableTableUpdateCompanionBuilder = ChatDataCompanion Function({
  Value<int> id,
  Value<ChatTypeEnum> type,
  Value<String?> name,
  Value<String> creatorId,
  Value<DateTime> createdAtRemote,
  Value<DateTime> updatedAtRemote,
  Value<DateTime?> deletedAtRemote,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ChatsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatsTableTable,
    ChatData,
    $$ChatsTableTableFilterComposer,
    $$ChatsTableTableOrderingComposer,
    $$ChatsTableTableProcessedTableManager,
    $$ChatsTableTableInsertCompanionBuilder,
    $$ChatsTableTableUpdateCompanionBuilder> {
  $$ChatsTableTableTableManager(_$AppDatabase db, $ChatsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ChatsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ChatsTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ChatsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<ChatTypeEnum> type = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> creatorId = const Value.absent(),
            Value<DateTime> createdAtRemote = const Value.absent(),
            Value<DateTime> updatedAtRemote = const Value.absent(),
            Value<DateTime?> deletedAtRemote = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatDataCompanion(
            id: id,
            type: type,
            name: name,
            creatorId: creatorId,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required ChatTypeEnum type,
            Value<String?> name = const Value.absent(),
            required String creatorId,
            required DateTime createdAtRemote,
            required DateTime updatedAtRemote,
            Value<DateTime?> deletedAtRemote = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatDataCompanion.insert(
            id: id,
            type: type,
            name: name,
            creatorId: creatorId,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatsTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ChatsTableTable,
    ChatData,
    $$ChatsTableTableFilterComposer,
    $$ChatsTableTableOrderingComposer,
    $$ChatsTableTableProcessedTableManager,
    $$ChatsTableTableInsertCompanionBuilder,
    $$ChatsTableTableUpdateCompanionBuilder> {
  $$ChatsTableTableProcessedTableManager(super.$state);
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

  ColumnFilters<String> get creatorId => $state.composableBuilder(
      column: $state.table.creatorId,
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

  ColumnOrderings<String> get creatorId => $state.composableBuilder(
      column: $state.table.creatorId,
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
}

typedef $$ChatMembersTableTableInsertCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  required int chatId,
  required String userId,
  required DateTime joinedAt,
  Value<DateTime?> leftAt,
  Value<DateTime?> blockedAt,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});
typedef $$ChatMembersTableTableUpdateCompanionBuilder = ChatMemberDataCompanion
    Function({
  Value<int> id,
  Value<int> chatId,
  Value<String> userId,
  Value<DateTime> joinedAt,
  Value<DateTime?> leftAt,
  Value<DateTime?> blockedAt,
  Value<DateTime?> insertedAt,
  Value<DateTime?> updatedAt,
});

class $$ChatMembersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMembersTableTable,
    ChatMemberData,
    $$ChatMembersTableTableFilterComposer,
    $$ChatMembersTableTableOrderingComposer,
    $$ChatMembersTableTableProcessedTableManager,
    $$ChatMembersTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ChatMembersTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> joinedAt = const Value.absent(),
            Value<DateTime?> leftAt = const Value.absent(),
            Value<DateTime?> blockedAt = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMemberDataCompanion(
            id: id,
            chatId: chatId,
            userId: userId,
            joinedAt: joinedAt,
            leftAt: leftAt,
            blockedAt: blockedAt,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int chatId,
            required String userId,
            required DateTime joinedAt,
            Value<DateTime?> leftAt = const Value.absent(),
            Value<DateTime?> blockedAt = const Value.absent(),
            Value<DateTime?> insertedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ChatMemberDataCompanion.insert(
            id: id,
            chatId: chatId,
            userId: userId,
            joinedAt: joinedAt,
            leftAt: leftAt,
            blockedAt: blockedAt,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatMembersTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatMembersTableTable,
        ChatMemberData,
        $$ChatMembersTableTableFilterComposer,
        $$ChatMembersTableTableOrderingComposer,
        $$ChatMembersTableTableProcessedTableManager,
        $$ChatMembersTableTableInsertCompanionBuilder,
        $$ChatMembersTableTableUpdateCompanionBuilder> {
  $$ChatMembersTableTableProcessedTableManager(super.$state);
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

  ColumnFilters<DateTime> get joinedAt => $state.composableBuilder(
      column: $state.table.joinedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get leftAt => $state.composableBuilder(
      column: $state.table.leftAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get blockedAt => $state.composableBuilder(
      column: $state.table.blockedAt,
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

  ColumnOrderings<DateTime> get joinedAt => $state.composableBuilder(
      column: $state.table.joinedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get leftAt => $state.composableBuilder(
      column: $state.table.leftAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get blockedAt => $state.composableBuilder(
      column: $state.table.blockedAt,
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

typedef $$ChatMessagesTableTableInsertCompanionBuilder
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
    $$ChatMessagesTableTableProcessedTableManager,
    $$ChatMessagesTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ChatMessagesTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
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
            editedAt: editedAt,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
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
            editedAt: editedAt,
            createdAtRemote: createdAtRemote,
            updatedAtRemote: updatedAtRemote,
            deletedAtRemote: deletedAtRemote,
            insertedAt: insertedAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$ChatMessagesTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatMessagesTableTable,
        ChatMessageData,
        $$ChatMessagesTableTableFilterComposer,
        $$ChatMessagesTableTableOrderingComposer,
        $$ChatMessagesTableTableProcessedTableManager,
        $$ChatMessagesTableTableInsertCompanionBuilder,
        $$ChatMessagesTableTableUpdateCompanionBuilder> {
  $$ChatMessagesTableTableProcessedTableManager(super.$state);
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

typedef $$ChatOutboxMessageTableTableInsertCompanionBuilder
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
  Value<int> rowid,
});

class $$ChatOutboxMessageTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageTableTable,
    ChatOutboxMessageData,
    $$ChatOutboxMessageTableTableFilterComposer,
    $$ChatOutboxMessageTableTableOrderingComposer,
    $$ChatOutboxMessageTableTableProcessedTableManager,
    $$ChatOutboxMessageTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ChatOutboxMessageTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> idKey = const Value.absent(),
            Value<int?> chatId = const Value.absent(),
            Value<String?> participantId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            Value<String> content = const Value.absent(),
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
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String idKey,
            Value<int?> chatId = const Value.absent(),
            Value<String?> participantId = const Value.absent(),
            Value<int?> replyToId = const Value.absent(),
            Value<int?> forwardFromId = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<bool> viaSms = const Value.absent(),
            Value<String?> smsNumber = const Value.absent(),
            required String content,
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
            rowid: rowid,
          ),
        ));
}

class $$ChatOutboxMessageTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageTableTable,
        ChatOutboxMessageData,
        $$ChatOutboxMessageTableTableFilterComposer,
        $$ChatOutboxMessageTableTableOrderingComposer,
        $$ChatOutboxMessageTableTableProcessedTableManager,
        $$ChatOutboxMessageTableTableInsertCompanionBuilder,
        $$ChatOutboxMessageTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageTableTableProcessedTableManager(super.$state);
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

typedef $$ChatOutboxMessageEditTableTableInsertCompanionBuilder
    = ChatOutboxMessageEditDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int chatId,
  required String newContent,
});
typedef $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder
    = ChatOutboxMessageEditDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> chatId,
  Value<String> newContent,
});

class $$ChatOutboxMessageEditTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageEditTableTable,
    ChatOutboxMessageEditData,
    $$ChatOutboxMessageEditTableTableFilterComposer,
    $$ChatOutboxMessageEditTableTableOrderingComposer,
    $$ChatOutboxMessageEditTableTableProcessedTableManager,
    $$ChatOutboxMessageEditTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ChatOutboxMessageEditTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> newContent = const Value.absent(),
          }) =>
              ChatOutboxMessageEditDataCompanion(
            id: id,
            idKey: idKey,
            chatId: chatId,
            newContent: newContent,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required int chatId,
            required String newContent,
          }) =>
              ChatOutboxMessageEditDataCompanion.insert(
            id: id,
            idKey: idKey,
            chatId: chatId,
            newContent: newContent,
          ),
        ));
}

class $$ChatOutboxMessageEditTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageEditTableTable,
        ChatOutboxMessageEditData,
        $$ChatOutboxMessageEditTableTableFilterComposer,
        $$ChatOutboxMessageEditTableTableOrderingComposer,
        $$ChatOutboxMessageEditTableTableProcessedTableManager,
        $$ChatOutboxMessageEditTableTableInsertCompanionBuilder,
        $$ChatOutboxMessageEditTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageEditTableTableProcessedTableManager(super.$state);
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

typedef $$ChatOutboxMessageDeleteTableTableInsertCompanionBuilder
    = ChatOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  required String idKey,
  required int chatId,
});
typedef $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder
    = ChatOutboxMessageDeleteDataCompanion Function({
  Value<int> id,
  Value<String> idKey,
  Value<int> chatId,
});

class $$ChatOutboxMessageDeleteTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatOutboxMessageDeleteTableTable,
    ChatOutboxMessageDeleteData,
    $$ChatOutboxMessageDeleteTableTableFilterComposer,
    $$ChatOutboxMessageDeleteTableTableOrderingComposer,
    $$ChatOutboxMessageDeleteTableTableProcessedTableManager,
    $$ChatOutboxMessageDeleteTableTableInsertCompanionBuilder,
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
          getChildManagerBuilder: (p) =>
              $$ChatOutboxMessageDeleteTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> idKey = const Value.absent(),
            Value<int> chatId = const Value.absent(),
          }) =>
              ChatOutboxMessageDeleteDataCompanion(
            id: id,
            idKey: idKey,
            chatId: chatId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String idKey,
            required int chatId,
          }) =>
              ChatOutboxMessageDeleteDataCompanion.insert(
            id: id,
            idKey: idKey,
            chatId: chatId,
          ),
        ));
}

class $$ChatOutboxMessageDeleteTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $ChatOutboxMessageDeleteTableTable,
        ChatOutboxMessageDeleteData,
        $$ChatOutboxMessageDeleteTableTableFilterComposer,
        $$ChatOutboxMessageDeleteTableTableOrderingComposer,
        $$ChatOutboxMessageDeleteTableTableProcessedTableManager,
        $$ChatOutboxMessageDeleteTableTableInsertCompanionBuilder,
        $$ChatOutboxMessageDeleteTableTableUpdateCompanionBuilder> {
  $$ChatOutboxMessageDeleteTableTableProcessedTableManager(super.$state);
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
  $$ChatsTableTableTableManager get chatsTable =>
      $$ChatsTableTableTableManager(_db, _db.chatsTable);
  $$ChatMembersTableTableTableManager get chatMembersTable =>
      $$ChatMembersTableTableTableManager(_db, _db.chatMembersTable);
  $$ChatMessagesTableTableTableManager get chatMessagesTable =>
      $$ChatMessagesTableTableTableManager(_db, _db.chatMessagesTable);
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
mixin _$ChatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ChatsTableTable get chatsTable => attachedDatabase.chatsTable;
  $ChatMembersTableTable get chatMembersTable =>
      attachedDatabase.chatMembersTable;
  $ChatMessagesTableTable get chatMessagesTable =>
      attachedDatabase.chatMessagesTable;
  $ChatOutboxMessageTableTable get chatOutboxMessageTable =>
      attachedDatabase.chatOutboxMessageTable;
  $ChatOutboxMessageEditTableTable get chatOutboxMessageEditTable =>
      attachedDatabase.chatOutboxMessageEditTable;
  $ChatOutboxMessageDeleteTableTable get chatOutboxMessageDeleteTable =>
      attachedDatabase.chatOutboxMessageDeleteTable;
}
