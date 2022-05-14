import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../../contacts.dart';
import '../contacts_local_tab.dart';

class ContactsLocalTab extends StatelessWidget {
  const ContactsLocalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final contactsSearchBloc = context.read<ContactsSearchBloc>();
        return ContactsLocalTabBloc(
          contactsRepository: context.read<ContactsRepository>(),
          contactsSearchBloc: contactsSearchBloc,
          localContactsSyncBloc: context.read<LocalContactsSyncBloc>(),
        )..add(ContactsLocalTabStarted(search: contactsSearchBloc.state));
      },
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
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                displayName: contact.name,
                thumbnail: contact.thumbnail,
                onTap: () async {
                  context.goNamed('contact', extra: contact);
                },
              );
            },
          );
        } else {
          late final List<Widget> children;
          if (state.status == ContactsLocalTabStatus.failure) {
            children = [
              const Text('Failure to get local contacts'),
            ];
          } else {
            if (state.searching) {
              children = [
                const Text('No local contacts found'),
              ];
            } else {
              children = [
                const Text('No local contacts'),
                OutlinedButton(
                  onPressed: () => context.read<ContactsLocalTabBloc>().add(const ContactsLocalTabRefreshed()),
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
