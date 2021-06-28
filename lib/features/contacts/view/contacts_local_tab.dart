import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import '../contacts.dart';

class ContactsLocalTab extends StatelessWidget {
  const ContactsLocalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalContactsBloc, LocalContactsState>(
      listener: (context, state) {
        if (state is LocalContactsLoadFailure) {
          context.showErrorSnackBar('Ups error happened ☹️');
        }
      },
      buildWhen: (previous, current) {
        return current is! LocalContactsRefreshFailure;
      },
      builder: (context, state) {
        if (state is LocalContactsInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LocalContactsLoadSuccess) {
          return RefreshIndicator(
            onRefresh: () {
              context.hideCurrentSnackBar();
              return (context.read<LocalContactsBloc>()..add(LocalContactsRefreshed()))
                  .stream
                  .firstWhere((state) => state is LocalContactsLoadSuccess || state is LocalContactsRefreshFailure);
            },
            child: ListView.separated(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ContactTile(
                  displayName: contact.displayName,
                  thumbnail: contact.thumbnail,
                  onTap: () {
                    context.showSnackBar('Phone contact details not implemented yet');
                  },
                  onLongPress: () {
                    context.showSnackBar('LongPress on "${contact.displayName}"');
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
                return Divider(
                  height: 1,
                );
              },
            ),
          );
        }
        if (state is ExternalContactsInitialLoadFailure) {
          return Center(
            child: OutlineButton(
              onPressed: () => context.read<ExternalContactsBloc>().add(ExternalContactsInitialLoaded()),
              child: Text('Refresh'),
            ),
          );
        }
        throw StateError(''); // TODO fix if logic
      },
    );
  }
}
