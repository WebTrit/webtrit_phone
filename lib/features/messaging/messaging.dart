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
// - chat info screens 
// - routing remake
// - finish resolve naming issues
// - typing animation
// - notifications autodismiss on read
// - expiration time setting for message storage (like week, month, year etc)
// - integration with Dima's optional pages
// - merge messaging to dev or dev to messaging?
// - move userId retrieving to main auth flow
// - random refacfotring, maybe tests?
// (like ephemeral logic to blocs, structs for ws events, constants for keys, etc)