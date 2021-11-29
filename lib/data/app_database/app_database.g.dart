// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ContactData extends DataClass implements Insertable<ContactData> {
  final int id;
  final ContactSourceType sourceType;
  final String sourceId;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  ContactData(
      {required this.id,
      required this.sourceType,
      required this.sourceId,
      this.displayName,
      this.firstName,
      this.lastName,
      this.insertedAt,
      this.updatedAt});
  factory ContactData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sourceType: $ContactsTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}source_type']))!,
      sourceId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}source_id'])!,
      displayName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      insertedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inserted_at']),
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $ContactsTableTable.$converter0;
      map['source_type'] = Variable<int>(converter.mapToSql(sourceType)!);
    }
    map['source_id'] = Variable<String>(sourceId);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String?>(displayName);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String?>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String?>(lastName);
    }
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime?>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    return map;
  }

  ContactDataCompanion toCompanion(bool nullToAbsent) {
    return ContactDataCompanion(
      id: Value(id),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
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
      sourceType: serializer.fromJson<ContactSourceType>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      insertedAt: serializer.fromJson<DateTime?>(json['insertedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceType': serializer.toJson<ContactSourceType>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'displayName': serializer.toJson<String?>(displayName),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ContactData copyWith(
          {int? id,
          ContactSourceType? sourceType,
          String? sourceId,
          Value<String?> displayName = const Value.absent(),
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactData(
        id: id ?? this.id,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        displayName: displayName.present ? displayName.value : this.displayName,
        firstName: firstName.present ? firstName.value : this.firstName,
        lastName: lastName.present ? lastName.value : this.lastName,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ContactData(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceType, sourceId, displayName,
      firstName, lastName, insertedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactData &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.displayName == this.displayName &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactDataCompanion extends UpdateCompanion<ContactData> {
  final Value<int> id;
  final Value<ContactSourceType> sourceType;
  final Value<String> sourceId;
  final Value<String?> displayName;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactDataCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactDataCompanion.insert({
    this.id = const Value.absent(),
    required ContactSourceType sourceType,
    required String sourceId,
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sourceType = Value(sourceType),
        sourceId = Value(sourceId);
  static Insertable<ContactData> custom({
    Expression<int>? id,
    Expression<ContactSourceType>? sourceType,
    Expression<String>? sourceId,
    Expression<String?>? displayName,
    Expression<String?>? firstName,
    Expression<String?>? lastName,
    Expression<DateTime?>? insertedAt,
    Expression<DateTime?>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (displayName != null) 'display_name': displayName,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (insertedAt != null) 'inserted_at': insertedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ContactDataCompanion copyWith(
      {Value<int>? id,
      Value<ContactSourceType>? sourceType,
      Value<String>? sourceId,
      Value<String?>? displayName,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactDataCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
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
      final converter = $ContactsTableTable.$converter0;
      map['source_type'] = Variable<int>(converter.mapToSql(sourceType.value)!);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String?>(displayName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String?>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String?>(lastName.value);
    }
    if (insertedAt.present) {
      map['inserted_at'] = Variable<DateTime?>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactDataCompanion(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('insertedAt: $insertedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTableTable extends ContactsTable
    with TableInfo<$ContactsTableTable, ContactData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sourceTypeMeta = const VerificationMeta('sourceType');
  late final GeneratedColumnWithTypeConverter<ContactSourceType, int?>
      sourceType = GeneratedColumn<int?>('source_type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<ContactSourceType>($ContactsTableTable.$converter0);
  final VerificationMeta _sourceIdMeta = const VerificationMeta('sourceId');
  late final GeneratedColumn<String?> sourceId = GeneratedColumn<String?>(
      'source_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  late final GeneratedColumn<String?> displayName = GeneratedColumn<String?>(
      'display_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _insertedAtMeta = const VerificationMeta('insertedAt');
  late final GeneratedColumn<DateTime?> insertedAt = GeneratedColumn<DateTime?>(
      'inserted_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceType,
        sourceId,
        displayName,
        firstName,
        lastName,
        insertedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'contacts';
  @override
  String get actualTableName => 'contacts';
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
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
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
    return ContactData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTableTable createAlias(String alias) {
    return $ContactsTableTable(_db, alias);
  }

  static TypeConverter<ContactSourceType, int> $converter0 =
      const EnumIndexConverter<ContactSourceType>(ContactSourceType.values);
}

class ContactPhoneData extends DataClass
    implements Insertable<ContactPhoneData> {
  final int id;
  final String number;
  final String label;
  final int contactId;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  ContactPhoneData(
      {required this.id,
      required this.number,
      required this.label,
      required this.contactId,
      this.insertedAt,
      this.updatedAt});
  factory ContactPhoneData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactPhoneData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
      contactId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_id'])!,
      insertedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inserted_at']),
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<String>(number);
    map['label'] = Variable<String>(label);
    map['contact_id'] = Variable<int>(contactId);
    if (!nullToAbsent || insertedAt != null) {
      map['inserted_at'] = Variable<DateTime?>(insertedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
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
    Expression<DateTime?>? insertedAt,
    Expression<DateTime?>? updatedAt,
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
      map['inserted_at'] = Variable<DateTime?>(insertedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
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

class $ContactPhonesTableTable extends ContactPhonesTable
    with TableInfo<$ContactPhonesTableTable, ContactPhoneData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactPhonesTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _contactIdMeta = const VerificationMeta('contactId');
  late final GeneratedColumn<int?> contactId = GeneratedColumn<int?>(
      'contact_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES contacts(id) ON DELETE CASCADE');
  final VerificationMeta _insertedAtMeta = const VerificationMeta('insertedAt');
  late final GeneratedColumn<DateTime?> insertedAt = GeneratedColumn<DateTime?>(
      'inserted_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, label, contactId, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'contact_phones';
  @override
  String get actualTableName => 'contact_phones';
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
    return ContactPhoneData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactPhonesTableTable createAlias(String alias) {
    return $ContactPhonesTableTable(_db, alias);
  }
}

class CallLogData extends DataClass implements Insertable<CallLogData> {
  final int id;
  final Direction direction;
  final String number;
  final bool video;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? hungUpAt;
  CallLogData(
      {required this.id,
      required this.direction,
      required this.number,
      required this.video,
      required this.createdAt,
      this.acceptedAt,
      this.hungUpAt});
  factory CallLogData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CallLogData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      direction: $CallLogsTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}direction']))!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      video: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      acceptedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}accepted_at']),
      hungUpAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hung_up_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $CallLogsTableTable.$converter0;
      map['direction'] = Variable<int>(converter.mapToSql(direction)!);
    }
    map['number'] = Variable<String>(number);
    map['video'] = Variable<bool>(video);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || acceptedAt != null) {
      map['accepted_at'] = Variable<DateTime?>(acceptedAt);
    }
    if (!nullToAbsent || hungUpAt != null) {
      map['hung_up_at'] = Variable<DateTime?>(hungUpAt);
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
      direction: serializer.fromJson<Direction>(json['direction']),
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
      'direction': serializer.toJson<Direction>(direction),
      'number': serializer.toJson<String>(number),
      'video': serializer.toJson<bool>(video),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'acceptedAt': serializer.toJson<DateTime?>(acceptedAt),
      'hungUpAt': serializer.toJson<DateTime?>(hungUpAt),
    };
  }

  CallLogData copyWith(
          {int? id,
          Direction? direction,
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
  final Value<Direction> direction;
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
    required Direction direction,
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
    Expression<Direction>? direction,
    Expression<String>? number,
    Expression<bool>? video,
    Expression<DateTime>? createdAt,
    Expression<DateTime?>? acceptedAt,
    Expression<DateTime?>? hungUpAt,
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
      Value<Direction>? direction,
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
      final converter = $CallLogsTableTable.$converter0;
      map['direction'] = Variable<int>(converter.mapToSql(direction.value)!);
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
      map['accepted_at'] = Variable<DateTime?>(acceptedAt.value);
    }
    if (hungUpAt.present) {
      map['hung_up_at'] = Variable<DateTime?>(hungUpAt.value);
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

class $CallLogsTableTable extends CallLogsTable
    with TableInfo<$CallLogsTableTable, CallLogData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CallLogsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _directionMeta = const VerificationMeta('direction');
  late final GeneratedColumnWithTypeConverter<Direction, int?> direction =
      GeneratedColumn<int?>('direction', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<Direction>($CallLogsTableTable.$converter0);
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)');
  final VerificationMeta _videoMeta = const VerificationMeta('video');
  late final GeneratedColumn<bool?> video = GeneratedColumn<bool?>(
      'video', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (video IN (0, 1))');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _acceptedAtMeta = const VerificationMeta('acceptedAt');
  late final GeneratedColumn<DateTime?> acceptedAt = GeneratedColumn<DateTime?>(
      'accepted_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _hungUpAtMeta = const VerificationMeta('hungUpAt');
  late final GeneratedColumn<DateTime?> hungUpAt = GeneratedColumn<DateTime?>(
      'hung_up_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, direction, number, video, createdAt, acceptedAt, hungUpAt];
  @override
  String get aliasedName => _alias ?? 'call_logs';
  @override
  String get actualTableName => 'call_logs';
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
    return CallLogData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CallLogsTableTable createAlias(String alias) {
    return $CallLogsTableTable(_db, alias);
  }

  static TypeConverter<Direction, int> $converter0 =
      const EnumIndexConverter<Direction>(Direction.values);
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final int contactPhoneId;
  final int position;
  FavoriteData(
      {required this.id, required this.contactPhoneId, required this.position});
  factory FavoriteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      contactPhoneId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_phone_id'])!,
      position: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}position'])!,
    );
  }
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

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FavoritesTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _contactPhoneIdMeta =
      const VerificationMeta('contactPhoneId');
  late final GeneratedColumn<int?> contactPhoneId = GeneratedColumn<int?>(
      'contact_phone_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES contact_phones(id) ON DELETE CASCADE');
  final VerificationMeta _positionMeta = const VerificationMeta('position');
  late final GeneratedColumn<int?> position = GeneratedColumn<int?>(
      'position', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, contactPhoneId, position];
  @override
  String get aliasedName => _alias ?? 'favorites';
  @override
  String get actualTableName => 'favorites';
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
    return FavoriteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTableTable contactsTable = $ContactsTableTable(this);
  late final $ContactPhonesTableTable contactPhonesTable =
      $ContactPhonesTableTable(this);
  late final $CallLogsTableTable callLogsTable = $CallLogsTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ContactPhonesDao contactPhonesDao =
      ContactPhonesDao(this as AppDatabase);
  late final CallLogsDao callLogsDao = CallLogsDao(this as AppDatabase);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [contactsTable, contactPhonesTable, callLogsTable, favoritesTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ContactsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
}
mixin _$ContactPhonesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
}
mixin _$CallLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CallLogsTableTable get callLogsTable => attachedDatabase.callLogsTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
}
mixin _$FavoritesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FavoritesTableTable get favoritesTable => attachedDatabase.favoritesTable;
  $ContactPhonesTableTable get contactPhonesTable =>
      attachedDatabase.contactPhonesTable;
  $ContactsTableTable get contactsTable => attachedDatabase.contactsTable;
}
