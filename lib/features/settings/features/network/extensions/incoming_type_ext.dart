import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

extension IncomingTypeExt on IncomingCallType {
  String titleL10n(BuildContext context) {
    return switch (this) {
      IncomingCallType.pushNotification => "Пуш-нотифікація",
      IncomingCallType.socket => "Постійне підключення до серверу",
    };
  }

  String descriptionL10n(BuildContext context) {
    return switch (this) {
      IncomingCallType.pushNotification =>
        "Коли додаток не використувується, він зупиняється і не використовує ресурси, що дозволяє мінімізувати споживання батареї. Під час вхідного дзвінку <brand> сервер посилає push нотифікацію на телефон, після чого мобільна операціонна система запускає додаток для отримання дзвінка. Цей спосіб не гарантує отримання всіх дзвінків, бо якщо телефон довго не використовується, то деякі версії Android можуть обмежити отримання push нотифікацій, і ви можете не отримати вхідний дзвінок.",
      IncomingCallType.socket =>
        "Додаток залишається працювати в background і завжди підтримує активне підключення до сервера. Це збільшує шанси отримати вхідний дзвінок, але може швидше розряджати батарею.",
    };
  }
}
