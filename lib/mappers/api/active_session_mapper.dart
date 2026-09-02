import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin ActiveSessionApiMapper {
  ActiveSession activeSessionFromApi(api.UserSession session) {
    return ActiveSession(
      id: session.id,
      current: session.current,
      userAgent: session.userAgent,
      location: session.location,
      lastActivityLocation: session.lastActivityLocation,
      appType: session.appType,
      appIdentifier: session.appIdentifier,
      appBundleId: session.appBundleId,
      createdAt: session.createdAt,
      lastActivityAt: session.lastActivityAt,
    );
  }
}
