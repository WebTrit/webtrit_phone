import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../../contacts.dart';
import '../contacts_external_tab.dart';

class ContactsExternalTab extends StatelessWidget {
  const ContactsExternalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final contactsSearchBloc = context.read<ContactsSearchBloc>();
        return ContactsExternalTabBloc(
          contactsRepository: context.read<ContactsRepository>(),
          contactsSearchBloc: contactsSearchBloc,
          externalContactsSyncBloc: context.read<ExternalContactsSyncBloc>(),
        )..add(ContactsExternalTabStarted(search: contactsSearchBloc.state));
      },
      child: const _ContactsExternal(),
    );
  }
}

class _ContactsExternal extends StatelessWidget {
  const _ContactsExternal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsExternalTabBloc, ContactsExternalTabState>(
      builder: (context, state) {
        if (state.status == ContactsExternalTabStatus.initial || state.status == ContactsExternalTabStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.contacts.isNotEmpty) {
          return ListView.separated(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                displayName: contact.name,
                onTap: () async {
                  final command = await Navigator.pushNamed(context, '/main/contact', arguments: contact);
                  // TODO change this odd technique of call execute
                  if (command is CallOutgoingStarted) {
                    context.read<CallBloc>().add(command);
                  }
                },
                onLongPress: () {
                  context.showSnackBar('LongPress on "${contact.displayName}"');
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
              );
            },
          );
        } else {
          late final List<Widget> children;
          if (state.status == ContactsExternalTabStatus.failure) {
            children = [
              const Text('Failure to get external contacts'),
            ];
          } else {
            if (state.searching) {
              children = [
                const Text('No external contacts found'),
              ];
            } else {
              children = [
                const Text('No external contacts'),
                OutlinedButton(
                  onPressed: () => context.read<ContactsExternalTabBloc>().add(const ContactsExternalTabRefreshed()),
                  child: const Text('Refresh'),
                ),
              ];
            }
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          );
        }
      },
    );
  }
}
