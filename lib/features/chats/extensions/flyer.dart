import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:webtrit_phone/models/models.dart';

extension FlyierTypes on types.Message {
  ChatMessage? get chatMessage {
    if (metadata?.containsKey('message') == true) {
      return metadata!['message'] as ChatMessage;
    }
    return null;
  }

  bool get isEdited => metadata?['edited'] == true;
  bool get isDeleted => metadata?['deleted'] == true;
}
