import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../contacts_local_tab.dart';
import '../../../contacts.dart';

class ContactsLocalTab extends StatelessWidget {
  const ContactsLocalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsLocalTabBloc(
        contactsRepository: context.read<ContactsRepository>(),
        localContactsSyncBloc: context.read<LocalContactsSyncBloc>(),
      )..add(ContactsLocalTabStarted()),
      child: const _ContactsLocal(),
    );
  }
}

class _ContactsLocal extends StatelessWidget {
  const _ContactsLocal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsLocalTabBloc, ContactsLocalTabState>(
      builder: (context, state) {
        if (state.status == ContactsLocalTabStatus.initial || state.status == ContactsLocalTabStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == ContactsLocalTabStatus.permissionFailure) {
          return const Center(
            child: Text('Permission failure to get local contacts'),
          );
        } else if (state.contacts.isNotEmpty) {
          return ListView.separated(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                displayName: contact.name,
                thumbnail: contact.thumbnail,
                onTap: () {
                  context.showSnackBar('Phone contact details not implemented yet');
                },
                onLongPress: () {
                  context.showSnackBar('LongPress on "${contact.name}"');
                },
                onAudioPressed: () {
                  context.showSnackBar('Audio call for phone contact not implemented yet');
                },
                onVideoPressed: () {
                  context.showSnackBar('Video call for phone contact not implemented yet');
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.status == ContactsLocalTabStatus.failure)
                  const Text('Failure to get local contacts')
                else
                  const Text('No local contacts'),
                OutlinedButton(
                  onPressed: () => context.read<ContactsLocalTabBloc>().add(const ContactsLocalTabRefreshed()),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
