import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin SystemNotificationApiMapper {
  SystemNotification systemNotificationFromApi(api.SystemNotification systemInfo) {
    return SystemNotification(
      id: systemInfo.id,
      title: systemInfo.title,
      content: systemInfo.content,
      seen: systemInfo.seen,
      type: SystemNotificationType.values.byName(systemInfo.type.name),
      createdAt: systemInfo.createdAt,
      updatedAt: systemInfo.updatedAt,
    );
  }
}
