/// A tab of the conversations section: written chats, or text messages.
///
/// Which of them a build shows comes from its configuration - one, the other,
/// or both - so anything that has to address a tab addresses it by this rather
/// than by a caption or a position. It is a model rather than a screen detail
/// because more than the screen answers for a tab: a preview and an embedded
/// host open the same section.
enum ConversationsTab { chat, sms }
