import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactsPage extends StatelessWidget with PageSnackBarMixin {
  const ContactsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state is ContactsLoadFailure) {
            showErrorSnackBar(context, 'Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! ContactsRefreshFailure && current is! ContactsLoadUnchangedSuccess;
        },
        // ignore: missing_return
        builder: (context, state) {
          if (state is ContactsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ContactsLoadSuccess) {
            return RefreshIndicator(
              onRefresh: () {
                hideSnackBar(context);
                return (BlocProvider.of<ContactsBloc>(context)..add(ContactsRefreshed()))
                    .skip(1)
                    .firstWhere((state) => state is ContactsLoadSuccess || state is ContactsRefreshFailure);
              },
              child: ListView.separated(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ContactTile(
                    contact: contact,
                    onTap: () {
                      showSnackBar(context, 'Tap on "${contact.username}"');
                    },
                    onLongPress: () {
                      showSnackBar(context, 'LongPress on "${contact.username}"');
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
          if (state is ContactsInitialLoadFailure) {
            return Center(
              child: OutlineButton(
                onPressed: () => BlocProvider.of<ContactsBloc>(context).add(ContactsInitialLoaded()),
                child: Text('Refresh'),
              ),
            );
          }
        },
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final Contact contact;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  ContactTile({
    Key key,
    @required this.contact,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.username),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
