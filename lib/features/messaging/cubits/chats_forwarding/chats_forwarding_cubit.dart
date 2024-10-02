import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/models/chat_message.dart';

class ChatsForwardingCubit extends Cubit<ChatMessage?> {
  ChatsForwardingCubit() : super(null);

  void setForForward(ChatMessage message) => emit(message);

  void clear() => emit(null);
}
