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

extension DirectionExtension on Direction {
  CallLogDirectionEnum toData() {
    switch (this) {
      case Direction.incoming:
        return CallLogDirectionEnum.incoming;
      case Direction.outgoing:
        return CallLogDirectionEnum.outgoing;
    }
  }
}

extension CallLogDirectionEnumExtension on CallLogDirectionEnum {
  Direction toModel() {
    switch (this) {
      case CallLogDirectionEnum.incoming:
        return Direction.incoming;
      case CallLogDirectionEnum.outgoing:
        return Direction.outgoing;
    }
  }
}
