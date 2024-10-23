export 'extensions/extensions.dart';
export 'bloc/messaging_bloc.dart';
export 'features/conversations/conversations.dart';
export 'features/chat_conversation/chat_conversation.dart';
export 'features/chat_conversation_builder/chat_conversation_builder.dart';
export 'features/sms_conversation/sms_conversation.dart';
export 'cubits/cubits.dart';
export 'services/services.dart';
export 'widgets/widgets.dart';


// TODO: 
// - remove messaging service envs
// - wrap messaging socket as dedicated class and inject/read using context provider
// - extract conversations/new_chat/group/sms builder as separate features and refactor
// - random refacfotring (like ephemeral logic to blocs, constants for keys, etc)
// - maybe tests?