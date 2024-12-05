import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

extension ContactSourceTypeExtension on ContactSourceType {
  ContactSourceTypeEnum toData() {
    switch (this) {
      case ContactSourceType.local:
        return ContactSourceTypeEnum.local;
      case ContactSourceType.external:
        return ContactSourceTypeEnum.external;
    }
  }
}

extension ContactSourceTypeEnumExtension on ContactSourceTypeEnum {
  ContactSourceType toModel() {
    switch (this) {
      case ContactSourceTypeEnum.local:
        return ContactSourceType.local;
      case ContactSourceTypeEnum.external:
        return ContactSourceType.external;
    }
  }
}
