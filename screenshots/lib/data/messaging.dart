import 'dart:typed_data';

import 'package:webtrit_phone/models/models.dart';

import 'clock.dart';

/// Mock chats for `MockChatsRepository`
final dChatsMockChatsRepository = [
  Chat(
    id: 101,
    type: ChatType.direct,
    name: null,
    createdAt: dFixedTime.subtract(const Duration(days: 5)),
    updatedAt: dFixedTime.add(const Duration(hours: 2)),
    members: const [
      ChatMember(id: 1, chatId: 101, userId: 'user_1', groupAuthorities: null),
      ChatMember(id: 2, chatId: 101, userId: 'user_2', groupAuthorities: null),
    ],
  ),
  Chat(
    id: 102,
    type: ChatType.group,
    name: 'Developers Group',
    createdAt: dFixedTime.subtract(const Duration(days: 3)),
    updatedAt: dFixedTime.add(const Duration(hours: 2)),
    members: const [
      ChatMember(id: 3, chatId: 102, userId: 'user_3', groupAuthorities: GroupAuthorities.moderator),
      ChatMember(id: 4, chatId: 102, userId: 'user_4', groupAuthorities: GroupAuthorities.moderator),
      ChatMember(id: 5, chatId: 102, userId: 'user_5', groupAuthorities: null),
    ],
  ),
];

/// Mock messages for `MockChatsRepository`
final dMessagesMockChatsRepository = [
  ChatMessage(
    id: 1,
    idKey: 'msg-001',
    senderId: 'user_1',
    chatId: 101,
    replyToId: null,
    forwardFromId: null,
    authorId: 'user_1',
    content: 'Hello, how are you?',
    createdAt: dFixedTime.subtract(const Duration(days: 5)),
    updatedAt: dFixedTime.add(const Duration(hours: 2)),
    editedAt: null,
    deletedAt: null,
  ),
  ChatMessage(
    id: 2,
    idKey: 'msg-002',
    senderId: 'user_3',
    chatId: 102,
    replyToId: null,
    forwardFromId: null,
    authorId: 'user_3',
    content: 'Good morning, team!',
    createdAt: dFixedTime.subtract(const Duration(days: 3)),
    updatedAt: dFixedTime.add(const Duration(hours: 2)),
    editedAt: null,
    deletedAt: null,
  ),
];

/// Mock contacts for `MockContactsRepository`
final dContactsRepository = [
  Contact(
    id: 1,
    sourceType: ContactSourceType.external,
    sourceId: 'user_1',
    firstName: 'Alice',
    lastName: 'Johnson',
    aliasName: 'AJ',
    registered: true,
    userRegistered: true,
    isCurrentUser: false,
    phones: const [
      ContactPhone(id: 101, number: '+1234567890', label: 'mobile', favorite: true),
      ContactPhone(id: 102, number: '1001', label: 'ext', favorite: false),
    ],
    emails: const [],
    thumbnail: null,
    thumbnailUrl: null,
  ),
  Contact(
    id: 2,
    sourceType: ContactSourceType.local,
    sourceId: 'user_2',
    firstName: 'Bob',
    lastName: 'Smith',
    aliasName: null,
    registered: false,
    userRegistered: false,
    isCurrentUser: false,
    phones: const [
      ContactPhone(id: 201, number: '+1987654321', label: 'mobile', favorite: true),
    ],
    emails: const [],
    thumbnail: Uint8List.fromList([0, 1, 2, 3]),
    thumbnailUrl: Uri.parse('https://example.com/avatar.png'),
  ),
];

/// Mock conversations for `MockChatConversationsCubit`
final dConversationsMockChatConversationsCubit = [
  (
    chat: dChatsMockChatsRepository[0],
    message: dMessagesMockChatsRepository[0],
    contacts: [dContactsRepository[0], dContactsRepository[1]],
  ),
  (
    chat: dChatsMockChatsRepository[1],
    message: dMessagesMockChatsRepository[1],
    contacts: [dContactsRepository[0], dContactsRepository[1]],
  ),
];

/// Mock SMS conversations for `MockSmsConversationsCubit`
final dConversationsMockSmsConversationsCubit = [
  SmsConversation(
    id: 201,
    firstPhoneNumber: '+1234567890',
    secondPhoneNumber: '+0987654321',
    createdAt: dFixedTime.subtract(const Duration(days: 3)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 5)),
  ),
  SmsConversation(
    id: 202,
    firstPhoneNumber: '+1111111111',
    secondPhoneNumber: '+2222222222',
    createdAt: dFixedTime.subtract(const Duration(days: 7)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 2)),
  ),
];

/// Mock SMS messages for `MockSmsConversationsCubit`
final dMessagesMockSmsConversationsCubit = [
  SmsMessage(
    id: 1,
    idKey: 'msg-001',
    externalId: 'ext-001',
    conversationId: 201,
    fromPhoneNumber: '+1234567890',
    toPhoneNumber: '+0987654321',
    sendingStatus: SmsSendingStatus.delivered,
    content: 'Hello, how are you?',
    createdAt: dFixedTime.subtract(const Duration(hours: 4)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 4)),
    deletedAt: null,
  ),
  SmsMessage(
    id: 2,
    idKey: 'msg-002',
    externalId: 'ext-002',
    conversationId: 202,
    fromPhoneNumber: '+2222222222',
    toPhoneNumber: '+1111111111',
    sendingStatus: SmsSendingStatus.sent,
    content: 'Hey, let’s meet up!',
    createdAt: dFixedTime.subtract(const Duration(hours: 1)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 1)),
    deletedAt: null,
  ),
];

/// Mock unread message count for `MockUnreadCountCubit`
final dChatUnreadCountsMockUnreadCountCubit = {
  101: 3, // Chat ID 101 has 3 unread messages
  102: 5, // Chat ID 102 has 5 unread messages
};

final dSmsUnreadCountsMockUnreadCountCubit = {
  201: 2, // SMS conversation ID 201 has 2 unread messages
};
