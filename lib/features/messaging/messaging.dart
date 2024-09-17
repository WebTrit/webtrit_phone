export 'extensions/extensions.dart';
export 'bloc/messaging_bloc.dart';
export 'features/conversations/conversations.dart';
export 'features/chat_conversation/conversation.dart';
export 'features/sms_conversation/sms_conversation.dart';
export 'features/group_conversation/group.dart';
export 'features/group_builder/group_builder.dart';
export 'cubits/cubits.dart';
export 'view/router_page.dart';
export 'services/services.dart';
export 'widgets/widgets.dart';
export 'utils/utils.dart';


// TODO: 
// - chats creation screen split
// - group creation new stepper flow
// - chat info screens 
// - localizations
// - routing remake
// - finish resolve naming issues
// - notifications autodismiss on read
// - integratiions with Dima's optional pages
// - move userId retrieving to main auth flow
// - random refacfotring, maybe tests?
// (like ephemeral logic to blocs, structs for ws events, constants for keys, etc)