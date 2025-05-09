import '../models/models.dart';

class BottomMenuTabSchemeParser {
  static BottomMenuTabScheme fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String;
    final type = BottomMenuTabType.values.firstWhere((it) => it.name == typeString);

    switch (type) {
      case BottomMenuTabType.contacts:
        return ContactsTabScheme(
          enabled: json['enabled'] as bool? ?? true,
          initial: json['initial'] as bool? ?? false,
          type: type,
          titleL10n: json['titleL10n'] as String,
          icon: json['icon'] as String,
          contactSourceTypes: (json['contactSourceTypes'] as List<dynamic>).map((e) => e as String).toList(),
        );
      case BottomMenuTabType.embedded:
        return EmbededTabScheme(
          enabled: json['enabled'] as bool? ?? true,
          initial: json['initial'] as bool? ?? false,
          type: type,
          titleL10n: json['titleL10n'] as String,
          icon: json['icon'] as String,
          embeddedResourceId: json['embeddedResourceId'] as int,
        );
      default:
        return BaseTabScheme(
          enabled: json['enabled'] as bool? ?? true,
          initial: json['initial'] as bool? ?? false,
          type: type,
          titleL10n: json['titleL10n'] as String,
          icon: json['icon'] as String,
        );
    }
  }

  static Map<String, dynamic> toJson(BottomMenuTabScheme tab) {
    return tab.when(
      base: (enabled, initial, type, titleL10n, icon) => {
        'enabled': enabled,
        'initial': initial,
        'type': type.name,
        'titleL10n': titleL10n,
        'icon': icon,
      },
      contacts: (enabled, initial, type, titleL10n, icon, contactSourceTypes) => {
        'enabled': enabled,
        'initial': initial,
        'type': type.name,
        'titleL10n': titleL10n,
        'icon': icon,
        'contactSourceTypes': contactSourceTypes,
      },
      embedded: (enabled, initial, type, titleL10n, icon, embeddedResourceId) => {
        'enabled': enabled,
        'initial': initial,
        'type': type.name,
        'titleL10n': titleL10n,
        'icon': icon,
        'embeddedResourceId': embeddedResourceId,
      },
    );
  }
}
