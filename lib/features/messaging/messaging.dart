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
// - routing remake
// - finish resolve naming issues
// - notifications autodismiss on read and showed message tracking
// - expiration time setting for message storage (like week, month, year etc)
// - move userId retrieving to main auth flow
// - random refacfotring (like ephemeral logic to blocs, structs for ws events, constants for keys, etc)
// - maybe tests?