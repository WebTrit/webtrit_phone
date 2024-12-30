import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/sms_conversation_builder_cubit.dart';

class SmsConversationBuilderView extends StatefulWidget {
  const SmsConversationBuilderView({super.key});

  @override
  State<SmsConversationBuilderView> createState() => _SmsConversationBuilderViewState();
}

class _SmsConversationBuilderViewState extends State<SmsConversationBuilderView> {
  late final builderCubit = context.read<SmsConversationBuilderCubit>();

  onMultipleUserNumbers(List<String> userNumbers) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Column(
          children: [
            ListTile(
              title: Text(
                context.l10n.messaging_ConversationsScreen_selectNumberSheet_title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            ...userNumbers.map((number) {
              return ListTile(
                title: Text(number),
                onTap: () => Navigator.of(context).pop(number),
              );
            }),
          ],
        ),
      ),
    );

    result is String ? builderCubit.onConfirmUserNumber(result) : builderCubit.onBackToCommon();
  }

  onEmptyUserNumbers() async {
    await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AlertDialog(
          title: Text(context.l10n.messaging_ConversationsScreen_noNumberAlert_title),
          content: Text(context.l10n.messaging_ConversationsScreen_noNumberAlert_text),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
        ),
      ),
    );
    builderCubit.onBackToCommon();
  }

  onWrongNumberSelected(String recipientNumber) async {
    await showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: AlertDialog(
            title: Text(
              context.l10n.messaging_ConversationBuilders_invalidNumber_title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            content: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_invalidNumber_message1,
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_invalidNumber_message2,
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                ],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.messaging_ConversationBuilders_invalidNumber_ok),
              ),
            ],
          ),
        );
      },
    );

    builderCubit.onBackToCommon();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsConversationBuilderCubit, SmsCBState>(
      listener: (context, state) {
        if (state is SmsCBUserNumberConfirmationNeeded) {
          state.userNumbers.isNotEmpty ? onMultipleUserNumbers(state.userNumbers) : onEmptyUserNumbers();
        }
        if (state is SmsCBWrongNumberSelected) {
          onWrongNumberSelected(state.recipientNumber);
        }
      },
      builder: (context, state) {
        final isValidNumberInField = state is SmsCBCommon && state.parsedNumber.isNotEmpty;

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            appBar: buildAppBar(isValidNumberInField),
            body: switch (state) {
              SmsCBInitializing() => const Center(child: CircularProgressIndicator()),
              SmsCBInitializingError() => buildInitErrror(state.error),
              SmsCBCommon() => FadeIn(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildField(state.searchFilter, isValidNumberInField),
                      ),
                      const SizedBox(height: 8),
                      Expanded(child: buildContactsList(state.externalContacts, state.localContacts)),
                    ],
                  ),
                ),
            },
          ),
        );
      },
    );
  }

  AppBar buildAppBar(bool isValidNumberInField) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(context.l10n.messaging_ConversationBuilders_title_new),
      automaticallyImplyLeading: false,
      leading: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          context.l10n.messaging_ConversationBuilders_cancel,
          style: TextStyle(color: colorScheme.primary),
        ),
      ),
      leadingWidth: 100,
      actions: [
        if (isValidNumberInField)
          TextButton(
            onPressed: builderCubit.onConfirmByParsedNumber,
            child: Text(
              context.l10n.messaging_ConversationBuilders_create,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
      ],
    );
  }

  Widget buildContactsList(Iterable<Contact> externalContactsToShow, Iterable<Contact> localContactsToShow) {
    if (externalContactsToShow.isEmpty && localContactsToShow.isEmpty) {
      return buildNoContactsError();
    }

    return ListView(
      children: [
        if (externalContactsToShow.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.messaging_ConversationBuilders_externalContacts_heading,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 8)
        ],
        ...externalContactsToShow.map((Contact contact) => buildTile(contact)),
        const SizedBox(height: 8),
        if (localContactsToShow.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.messaging_ConversationBuilders_localContacts_heading,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 8)
        ],
        ...localContactsToShow.map((Contact contact) => buildTile(contact)),
      ],
    );
  }

  Widget buildNoContactsError() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: FadeIn(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 64),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            context.l10n.messaging_ConversationBuilders_noContacts,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildInitErrror(Object error) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: FadeIn(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 64),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            error.toString(),
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildField(String searchFilter, bool isValidNumberInField) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      decoration: InputDecoration(
        error: Builder(builder: (context) {
          final numbersEntered = searchFilter.length > 3 && RegExp(r'^[0-9]*$').hasMatch(searchFilter);

          if (numbersEntered && !isValidNumberInField) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_numberSearch_errorError,
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
                style: theme.textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 13),
              ),
            );
          }

          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: context.l10n.messaging_ConversationBuilders_numberSearch_errorHint,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(
                    text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
              style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey, fontSize: 13),
            ),
          );
        }),
        hintText: context.l10n.messaging_ConversationBuilders_contactOrNumberSearch_hint,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.search),
        errorMaxLines: 3,
      ),
      onChanged: (v) => builderCubit.setSearchFilter(v),
    );
  }

  Widget buildTile(Contact contact) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final extId = contact.sourceType == ContactSourceType.external ? contact.sourceId : null;
    var phones = contact.smsNumbers;

    if (phones.length > 1) {
      return Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
          highlightColor: colorScheme.primary.withValues(alpha: 0.1),
        ),
        child: ExpansionTile(
          leading: LeadingAvatar(
            username: contact.displayTitle,
            thumbnail: contact.thumbnail,
            thumbnailUrl: contact.thumbnailUrl,
            registered: contact.registered,
            radius: 24,
          ),
          title: Text(contact.displayTitle),
          subtitle: Text(phones.first, style: theme.textTheme.bodySmall),
          children: phones.map((number) {
            return ListTile(
              title: Text(number),
              onTap: () => builderCubit.onConfirm(number, extId),
            );
          }).toList(),
        ),
      );
    }

    return ListTile(
      leading: LeadingAvatar(
        username: contact.displayTitle,
        thumbnail: contact.thumbnail,
        thumbnailUrl: contact.thumbnailUrl,
        registered: contact.registered,
        radius: 24,
      ),
      title: Text(contact.displayTitle),
      subtitle: Text(phones.first, style: theme.textTheme.bodySmall),
      onTap: () => builderCubit.onConfirm(phones.first, extId),
    );
  }
}
