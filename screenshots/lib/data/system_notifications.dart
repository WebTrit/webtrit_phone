import 'package:webtrit_phone/models/models.dart';

import 'clock.dart';

final dMockSystemNotifications = [
  SystemNotification(
    id: 1,
    title: 'Scheduled Maintenance',
    content: 'Our servers will undergo maintenance on July 25th from 2:00 AM to 4:00 AM UTC.',
    type: SystemNotificationType.system,
    seen: true,
    createdAt: dFixedTime.subtract(const Duration(days: 2)),
    updatedAt: dFixedTime.subtract(const Duration(days: 2)),
  ),
  SystemNotification(
    id: 2,
    title: 'New Feature: Video Calls',
    content: 'We are excited to announce HD video calling is now available for all users.',
    type: SystemNotificationType.announcement,
    seen: false,
    createdAt: dFixedTime.subtract(const Duration(days: 1)),
    updatedAt: dFixedTime.subtract(const Duration(days: 1)),
  ),
  SystemNotification(
    id: 3,
    title: 'Security Update',
    content: 'Your account password was changed successfully. If you did not make this change, contact support.',
    type: SystemNotificationType.security,
    seen: false,
    createdAt: dFixedTime.subtract(const Duration(hours: 6)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 6)),
  ),
  SystemNotification(
    id: 4,
    title: 'Special Offer',
    content: 'Upgrade to Premium and get 50% off for the first 3 months.',
    type: SystemNotificationType.promotion,
    seen: true,
    createdAt: dFixedTime.subtract(const Duration(hours: 3)),
    updatedAt: dFixedTime.subtract(const Duration(hours: 3)),
  ),
];
