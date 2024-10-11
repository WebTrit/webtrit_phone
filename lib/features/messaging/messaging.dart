export 'extensions/extensions.dart';
export 'bloc/messaging_bloc.dart';
export 'features/conversations/conversations.dart';
export 'features/chat_conversation/chat_conversation.dart';
export 'features/sms_conversation/sms_conversation.dart';
export 'cubits/cubits.dart';
export 'view/router_page.dart';
export 'services/services.dart';
export 'widgets/widgets.dart';


// TODO: 
// - expiration time setting for message storage (like week, month, year etc)
// - remove messaging service envs
// - sync error codes with backend and handle them
// - random refacfotring (like ephemeral logic to blocs, structs for ws events, constants for keys, etc)
// - maybe tests?