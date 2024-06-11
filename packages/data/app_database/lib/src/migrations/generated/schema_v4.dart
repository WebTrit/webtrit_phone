// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
//@dart=2.12
import 'package:drift/drift.dart';

class Contacts extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Contacts(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<int> sourceType = GeneratedColumn<int>(
      'source_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> aliasName = GeneratedColumn<String>(
      'alias_name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {sourceType, sourceId},
      ];
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  Contacts createAlias(String alias) {
    return Contacts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['UNIQUE(source_type, source_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ContactPhones extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ContactPhones(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES contacts(id)ON DELETE CASCADE');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, label, contactId, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_phones';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {number, contactId},
      ];
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  ContactPhones createAlias(String alias) {
    return ContactPhones(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(number, contact_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ContactEmails extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ContactEmails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES contacts(id)ON DELETE CASCADE');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, address, label, contactId, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_emails';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {address, contactId},
      ];
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  ContactEmails createAlias(String alias) {
    return ContactEmails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(address, contact_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CallLogs extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CallLogs(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<int> direction = GeneratedColumn<int>(
      'direction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)');
  late final GeneratedColumn<int> video = GeneratedColumn<int>(
      'video', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (video IN (0, 1))');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> acceptedAt = GeneratedColumn<int>(
      'accepted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> hungUpAt = GeneratedColumn<int>(
      'hung_up_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, direction, number, video, createdAt, acceptedAt, hungUpAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_logs';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  CallLogs createAlias(String alias) {
    return CallLogs(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Favorites extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Favorites(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<int> contactPhoneId = GeneratedColumn<int>(
      'contact_phone_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES contact_phones(id)ON DELETE CASCADE');
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, contactPhoneId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  Favorites createAlias(String alias) {
    return Favorites(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Chats extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Chats(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> creatorId = GeneratedColumn<String>(
      'creator_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> createdAtRemote = GeneratedColumn<int>(
      'created_at_remote', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> updatedAtRemote = GeneratedColumn<int>(
      'updated_at_remote', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> deletedAtRemote = GeneratedColumn<int>(
      'deleted_at_remote', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  Chats createAlias(String alias) {
    return Chats(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChatMembers extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChatMembers(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES chats(id)ON DELETE CASCADE');
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> joinedAt = GeneratedColumn<int>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> leftAt = GeneratedColumn<int>(
      'left_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> blockedAt = GeneratedColumn<int>(
      'blocked_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [chatId, userId, joinedAt, leftAt, blockedAt, insertedAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_members';
  @override
  Set<GeneratedColumn> get $primaryKey => {chatId, userId};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  ChatMembers createAlias(String alias) {
    return ChatMembers(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(chat_id, user_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChatMessages extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChatMessages(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
      'sender_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES chats(id)ON DELETE CASCADE');
  late final GeneratedColumn<int> replyToId = GeneratedColumn<int>(
      'reply_to_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> forwardFromId = GeneratedColumn<int>(
      'forward_from_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> viaSms = GeneratedColumn<int>(
      'via_sms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0 CHECK (via_sms IN (0, 1))',
      defaultValue: const CustomExpression('0'));
  late final GeneratedColumn<String> smsOutState = GeneratedColumn<String>(
      'sms_out_state', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> smsNumber = GeneratedColumn<String>(
      'sms_number', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> createdAtRemote = GeneratedColumn<int>(
      'created_at_remote', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> updatedAtRemote = GeneratedColumn<int>(
      'updated_at_remote', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> deletedAtRemote = GeneratedColumn<int>(
      'deleted_at_remote', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> insertedAt = GeneratedColumn<int>(
      'inserted_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        senderId,
        chatId,
        replyToId,
        forwardFromId,
        authorId,
        viaSms,
        smsOutState,
        smsNumber,
        content,
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  ChatMessages createAlias(String alias) {
    return ChatMessages(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class DatabaseAtV4 extends GeneratedDatabase {
  DatabaseAtV4(QueryExecutor e) : super(e);
  late final Contacts contacts = Contacts(this);
  late final ContactPhones contactPhones = ContactPhones(this);
  late final ContactEmails contactEmails = ContactEmails(this);
  late final CallLogs callLogs = CallLogs(this);
  late final Favorites favorites = Favorites(this);
  late final Chats chats = Chats(this);
  late final ChatMembers chatMembers = ChatMembers(this);
  late final ChatMessages chatMessages = ChatMessages(this);
  late final Trigger contactsAfterInsertTrigger = Trigger(
      'CREATE TRIGGER contacts_after_insert_trigger AFTER INSERT ON contacts BEGIN UPDATE contacts SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE contacts SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contacts_after_insert_trigger');
  late final Trigger contactsAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER contacts_after_update_trigger AFTER UPDATE ON contacts BEGIN UPDATE contacts SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contacts_after_update_trigger');
  late final Trigger contactPhonesAfterInsertTrigger = Trigger(
      'CREATE TRIGGER contact_phones_after_insert_trigger AFTER INSERT ON contact_phones BEGIN UPDATE contact_phones SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE contact_phones SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contact_phones_after_insert_trigger');
  late final Trigger contactPhonesAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER contact_phones_after_update_trigger AFTER UPDATE ON contact_phones BEGIN UPDATE contact_phones SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contact_phones_after_update_trigger');
  late final Trigger contactEmailsAfterInsertTrigger = Trigger(
      'CREATE TRIGGER contact_emails_after_insert_trigger AFTER INSERT ON contact_emails BEGIN UPDATE contact_emails SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE contact_emails SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contact_emails_after_insert_trigger');
  late final Trigger contactEmailsAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER contact_emails_after_update_trigger AFTER UPDATE ON contact_emails BEGIN UPDATE contact_emails SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'contact_emails_after_update_trigger');
  late final Trigger chatsAfterInsertTrigger = Trigger(
      'CREATE TRIGGER chats_after_insert_trigger AFTER INSERT ON chats BEGIN UPDATE chats SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE chats SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chats_after_insert_trigger');
  late final Trigger chatsAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER chats_after_update_trigger AFTER UPDATE ON chats BEGIN UPDATE chats SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chats_after_update_trigger');
  late final Trigger chatMembersAfterInsertTrigger = Trigger(
      'CREATE TRIGGER chat_members_after_insert_trigger AFTER INSERT ON chat_members BEGIN UPDATE chat_members SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE chat_members SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chat_members_after_insert_trigger');
  late final Trigger chatMembersAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER chat_members_after_update_trigger AFTER UPDATE ON chat_members BEGIN UPDATE chat_members SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chat_members_after_update_trigger');
  late final Trigger chatMessagesAfterInsertTrigger = Trigger(
      'CREATE TRIGGER chat_messages_after_insert_trigger AFTER INSERT ON chat_messages BEGIN UPDATE chat_messages SET inserted_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id AND inserted_at IS NULL;UPDATE chat_messages SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chat_messages_after_insert_trigger');
  late final Trigger chatMessagesAfterUpdateTrigger = Trigger(
      'CREATE TRIGGER chat_messages_after_update_trigger AFTER UPDATE ON chat_messages BEGIN UPDATE chat_messages SET updated_at = STRFTIME(\'%s\', \'NOW\') WHERE id = NEW.id;END',
      'chat_messages_after_update_trigger');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contacts,
        contactPhones,
        contactEmails,
        callLogs,
        favorites,
        chats,
        chatMembers,
        chatMessages,
        contactsAfterInsertTrigger,
        contactsAfterUpdateTrigger,
        contactPhonesAfterInsertTrigger,
        contactPhonesAfterUpdateTrigger,
        contactEmailsAfterInsertTrigger,
        contactEmailsAfterUpdateTrigger,
        chatsAfterInsertTrigger,
        chatsAfterUpdateTrigger,
        chatMembersAfterInsertTrigger,
        chatMembersAfterUpdateTrigger,
        chatMessagesAfterInsertTrigger,
        chatMessagesAfterUpdateTrigger
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contact_phones',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contact_phones',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contact_emails',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contact_emails',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chats',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chat_members',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chat_members',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chat_messages',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('chat_messages',
                limitUpdateKind: UpdateKind.delete),
            result: [],
          ),
        ],
      );
  @override
  int get schemaVersion => 4;
}
