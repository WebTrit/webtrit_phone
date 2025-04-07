export 'extensions/extensions.dart';
export 'bloc/messaging_bloc.dart';
export 'features/conversations/conversations.dart';
export 'features/chat_conversation/chat_conversation.dart';
export 'features/chat_conversation_builder/chat_conversation_builder.dart';
export 'features/sms_conversation/sms_conversation.dart';
export 'features/sms_conversation_builder/sms_conversation_builder.dart';
export 'cubits/cubits.dart';
export 'services/services.dart';
export 'widgets/widgets.dart';

// TODO:
// - Refactor orientations bloc to acquire-release flow for locking/unlocking orientation
// main case is open media view and call conucurently
// - add bloc for setSystemUIOverlayStyle and setEnabledSystemUIMode same as orientations or combine them as systemUI bloc
// - localize storage settings, media view
// - skip image compression if already jpeg and size
// - limit file size on picker
