export 'extensions/extensions.dart';
export 'bloc/messaging_bloc.dart';
export 'features/conversations/conversations.dart';
export 'features/chat_conversation/conversation.dart';
export 'features/sms_conversation/sms_conversation.dart';
export 'features/group_conversation/group.dart';
export 'cubits/cubits.dart';
export 'view/router_page.dart';
export 'services/services.dart';
export 'widgets/widgets.dart';


// TODO: 
// - notifications autodismiss on read and background message tracking
// - expiration time setting for message storage (like week, month, year etc)
// - popup menu or swipe menu for chat leave/delete in conversations list 
// - scroll to bottom on messages list
// - move userId retrieving to main auth flow
// - remove messaging service envs
// - sync error codes with backend and handle them
// - random refacfotring (like ephemeral logic to blocs, structs for ws events, constants for keys, etc)
// - maybe tests?