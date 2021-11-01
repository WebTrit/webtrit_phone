// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final ContactsSource sourceType;
  final String sourceId;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  Contact(
      {required this.id,
      required this.sourceType,
      required this.sourceId,
      this.displayName,
      this.firstName,
      this.lastName,
      this.insertedAt,
      this.updatedAt});
  factory Contact.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Contact(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sourceType: $ContactsTable.$converter0.mapToDart(const IntType()
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
      final converter = $ContactsTable.$converter0;
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

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
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

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      sourceType: serializer.fromJson<ContactsSource>(json['sourceType']),
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
      'sourceType': serializer.toJson<ContactsSource>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'displayName': serializer.toJson<String?>(displayName),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'insertedAt': serializer.toJson<DateTime?>(insertedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Contact copyWith(
          {int? id,
          ContactsSource? sourceType,
          String? sourceId,
          Value<String?> displayName = const Value.absent(),
          Value<String?> firstName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Contact(
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
    return (StringBuffer('Contact(')
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
      (other is Contact &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.displayName == this.displayName &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<ContactsSource> sourceType;
  final Value<String> sourceId;
  final Value<String?> displayName;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required ContactsSource sourceType,
    required String sourceId,
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sourceType = Value(sourceType),
        sourceId = Value(sourceId);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<ContactsSource>? sourceType,
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

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<ContactsSource>? sourceType,
      Value<String>? sourceId,
      Value<String?>? displayName,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactsCompanion(
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
      final converter = $ContactsTable.$converter0;
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
    return (StringBuffer('ContactsCompanion(')
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

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sourceTypeMeta = const VerificationMeta('sourceType');
  late final GeneratedColumnWithTypeConverter<ContactsSource, int?> sourceType =
      GeneratedColumn<int?>('source_type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<ContactsSource>($ContactsTable.$converter0);
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
  VerificationContext validateIntegrity(Insertable<Contact> instance,
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
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Contact.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(_db, alias);
  }

  static TypeConverter<ContactsSource, int> $converter0 =
      const EnumIndexConverter<ContactsSource>(ContactsSource.values);
}

class ContactPhone extends DataClass implements Insertable<ContactPhone> {
  final int id;
  final String number;
  final String label;
  final int contactId;
  final DateTime? insertedAt;
  final DateTime? updatedAt;
  ContactPhone(
      {required this.id,
      required this.number,
      required this.label,
      required this.contactId,
      this.insertedAt,
      this.updatedAt});
  factory ContactPhone.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactPhone(
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

  ContactPhonesCompanion toCompanion(bool nullToAbsent) {
    return ContactPhonesCompanion(
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

  factory ContactPhone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactPhone(
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

  ContactPhone copyWith(
          {int? id,
          String? number,
          String? label,
          int? contactId,
          Value<DateTime?> insertedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ContactPhone(
        id: id ?? this.id,
        number: number ?? this.number,
        label: label ?? this.label,
        contactId: contactId ?? this.contactId,
        insertedAt: insertedAt.present ? insertedAt.value : this.insertedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ContactPhone(')
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
      (other is ContactPhone &&
          other.id == this.id &&
          other.number == this.number &&
          other.label == this.label &&
          other.contactId == this.contactId &&
          other.insertedAt == this.insertedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactPhonesCompanion extends UpdateCompanion<ContactPhone> {
  final Value<int> id;
  final Value<String> number;
  final Value<String> label;
  final Value<int> contactId;
  final Value<DateTime?> insertedAt;
  final Value<DateTime?> updatedAt;
  const ContactPhonesCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.label = const Value.absent(),
    this.contactId = const Value.absent(),
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactPhonesCompanion.insert({
    this.id = const Value.absent(),
    required String number,
    required String label,
    required int contactId,
    this.insertedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : number = Value(number),
        label = Value(label),
        contactId = Value(contactId);
  static Insertable<ContactPhone> custom({
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

  ContactPhonesCompanion copyWith(
      {Value<int>? id,
      Value<String>? number,
      Value<String>? label,
      Value<int>? contactId,
      Value<DateTime?>? insertedAt,
      Value<DateTime?>? updatedAt}) {
    return ContactPhonesCompanion(
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
    return (StringBuffer('ContactPhonesCompanion(')
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

class $ContactPhonesTable extends ContactPhones
    with TableInfo<$ContactPhonesTable, ContactPhone> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactPhonesTable(this._db, [this._alias]);
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
  VerificationContext validateIntegrity(Insertable<ContactPhone> instance,
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
  ContactPhone map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContactPhone.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactPhonesTable createAlias(String alias) {
    return $ContactPhonesTable(_db, alias);
  }
}

class CallLog extends DataClass implements Insertable<CallLog> {
  final int id;
  final Direction direction;
  final String number;
  final DateTime? initiatedAt;
  final DateTime? acceptedAt;
  final DateTime? hungUpAt;
  CallLog(
      {required this.id,
      required this.direction,
      required this.number,
      this.initiatedAt,
      this.acceptedAt,
      this.hungUpAt});
  factory CallLog.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CallLog(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      direction: $CallLogsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}direction']))!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      initiatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}initiated_at']),
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
      final converter = $CallLogsTable.$converter0;
      map['direction'] = Variable<int>(converter.mapToSql(direction)!);
    }
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || initiatedAt != null) {
      map['initiated_at'] = Variable<DateTime?>(initiatedAt);
    }
    if (!nullToAbsent || acceptedAt != null) {
      map['accepted_at'] = Variable<DateTime?>(acceptedAt);
    }
    if (!nullToAbsent || hungUpAt != null) {
      map['hung_up_at'] = Variable<DateTime?>(hungUpAt);
    }
    return map;
  }

  CallLogsCompanion toCompanion(bool nullToAbsent) {
    return CallLogsCompanion(
      id: Value(id),
      direction: Value(direction),
      number: Value(number),
      initiatedAt: initiatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(initiatedAt),
      acceptedAt: acceptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acceptedAt),
      hungUpAt: hungUpAt == null && nullToAbsent
          ? const Value.absent()
          : Value(hungUpAt),
    );
  }

  factory CallLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallLog(
      id: serializer.fromJson<int>(json['id']),
      direction: serializer.fromJson<Direction>(json['direction']),
      number: serializer.fromJson<String>(json['number']),
      initiatedAt: serializer.fromJson<DateTime?>(json['initiatedAt']),
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
      'initiatedAt': serializer.toJson<DateTime?>(initiatedAt),
      'acceptedAt': serializer.toJson<DateTime?>(acceptedAt),
      'hungUpAt': serializer.toJson<DateTime?>(hungUpAt),
    };
  }

  CallLog copyWith(
          {int? id,
          Direction? direction,
          String? number,
          Value<DateTime?> initiatedAt = const Value.absent(),
          Value<DateTime?> acceptedAt = const Value.absent(),
          Value<DateTime?> hungUpAt = const Value.absent()}) =>
      CallLog(
        id: id ?? this.id,
        direction: direction ?? this.direction,
        number: number ?? this.number,
        initiatedAt: initiatedAt.present ? initiatedAt.value : this.initiatedAt,
        acceptedAt: acceptedAt.present ? acceptedAt.value : this.acceptedAt,
        hungUpAt: hungUpAt.present ? hungUpAt.value : this.hungUpAt,
      );
  @override
  String toString() {
    return (StringBuffer('CallLog(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('number: $number, ')
          ..write('initiatedAt: $initiatedAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('hungUpAt: $hungUpAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, direction, number, initiatedAt, acceptedAt, hungUpAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLog &&
          other.id == this.id &&
          other.direction == this.direction &&
          other.number == this.number &&
          other.initiatedAt == this.initiatedAt &&
          other.acceptedAt == this.acceptedAt &&
          other.hungUpAt == this.hungUpAt);
}

class CallLogsCompanion extends UpdateCompanion<CallLog> {
  final Value<int> id;
  final Value<Direction> direction;
  final Value<String> number;
  final Value<DateTime?> initiatedAt;
  final Value<DateTime?> acceptedAt;
  final Value<DateTime?> hungUpAt;
  const CallLogsCompanion({
    this.id = const Value.absent(),
    this.direction = const Value.absent(),
    this.number = const Value.absent(),
    this.initiatedAt = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.hungUpAt = const Value.absent(),
  });
  CallLogsCompanion.insert({
    this.id = const Value.absent(),
    required Direction direction,
    required String number,
    this.initiatedAt = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.hungUpAt = const Value.absent(),
  })  : direction = Value(direction),
        number = Value(number);
  static Insertable<CallLog> custom({
    Expression<int>? id,
    Expression<Direction>? direction,
    Expression<String>? number,
    Expression<DateTime?>? initiatedAt,
    Expression<DateTime?>? acceptedAt,
    Expression<DateTime?>? hungUpAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (direction != null) 'direction': direction,
      if (number != null) 'number': number,
      if (initiatedAt != null) 'initiated_at': initiatedAt,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (hungUpAt != null) 'hung_up_at': hungUpAt,
    });
  }

  CallLogsCompanion copyWith(
      {Value<int>? id,
      Value<Direction>? direction,
      Value<String>? number,
      Value<DateTime?>? initiatedAt,
      Value<DateTime?>? acceptedAt,
      Value<DateTime?>? hungUpAt}) {
    return CallLogsCompanion(
      id: id ?? this.id,
      direction: direction ?? this.direction,
      number: number ?? this.number,
      initiatedAt: initiatedAt ?? this.initiatedAt,
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
      final converter = $CallLogsTable.$converter0;
      map['direction'] = Variable<int>(converter.mapToSql(direction.value)!);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (initiatedAt.present) {
      map['initiated_at'] = Variable<DateTime?>(initiatedAt.value);
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
    return (StringBuffer('CallLogsCompanion(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('number: $number, ')
          ..write('initiatedAt: $initiatedAt, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('hungUpAt: $hungUpAt')
          ..write(')'))
        .toString();
  }
}

class $CallLogsTable extends CallLogs with TableInfo<$CallLogsTable, CallLog> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CallLogsTable(this._db, [this._alias]);
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
          .withConverter<Direction>($CallLogsTable.$converter0);
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)');
  final VerificationMeta _initiatedAtMeta =
      const VerificationMeta('initiatedAt');
  late final GeneratedColumn<DateTime?> initiatedAt =
      GeneratedColumn<DateTime?>('initiated_at', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
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
      [id, direction, number, initiatedAt, acceptedAt, hungUpAt];
  @override
  String get aliasedName => _alias ?? 'call_logs';
  @override
  String get actualTableName => 'call_logs';
  @override
  VerificationContext validateIntegrity(Insertable<CallLog> instance,
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
    if (data.containsKey('initiated_at')) {
      context.handle(
          _initiatedAtMeta,
          initiatedAt.isAcceptableOrUnknown(
              data['initiated_at']!, _initiatedAtMeta));
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
  CallLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CallLog.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CallLogsTable createAlias(String alias) {
    return $CallLogsTable(_db, alias);
  }

  static TypeConverter<Direction, int> $converter0 =
      const EnumIndexConverter<Direction>(Direction.values);
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $ContactPhonesTable contactPhones = $ContactPhonesTable(this);
  late final $CallLogsTable callLogs = $CallLogsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [contacts, contactPhones, callLogs];
}
