import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import '../contacts.dart';

class ContactsExternalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExternalContactsBloc, ExternalContactsState>(
      listener: (context, state) {
        if (state is ExternalContactsLoadFailure) {
          context.showErrorSnackBar('Ups error happened ☹️');
        }
      },
      buildWhen: (previous, current) {
        return current is! ExternalContactsRefreshFailure;
      },
      builder: (context, state) {
        if (state is ExternalContactsInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ExternalContactsLoadSuccess) {
          return RefreshIndicator(
            onRefresh: () {
              context.hideCurrentSnackBar();
              return (context.read<ExternalContactsBloc>()..add(ExternalContactsRefreshed())).stream.firstWhere(
                      (state) => state is ExternalContactsLoadSuccess || state is ExternalContactsRefreshFailure);
            },
            child: ListView.separated(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ContactTile(
                  displayName: contact.displayName,
                  onTap: () {
                    context.read<CallBloc>().add(CallOutgoingStarted(username: contact.number));
                  },
                  onLongPress: () {
                    context.showSnackBar('LongPress on "${contact.displayName}"');
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

