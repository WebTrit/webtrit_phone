import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: ContactsSource.values.length,
      child: Scaffold(
        appBar: MainAppBar(
          bottom: TabBar(
            tabs: ContactsSource.values.map((value) => Tab(child: Text(value.l10n(context), softWrap: false))).toList(),
            labelColor: themeData.textTheme.caption!.color,
          ),
        ),
        body: TabBarView(children: [
          _LocalContacts(),
          _ExternalContacts(),
        ]),
      ),
    );
  }
}

class _LocalContacts extends StatelessWidget {
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
                    context.read<CallBloc>().add(CallOutgoingStarted(username: contact.displayName));
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

class _ExternalContacts extends StatelessWidget {
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
                  displayName: contact.username,
                  onTap: () {
                    context.read<CallBloc>().add(CallOutgoingStarted(username: contact.username));
                  },
                  onLongPress: () {
                    context.showSnackBar('LongPress on "${contact.username}"');
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

class ContactTile extends StatelessWidget {
  ContactTile({
    Key? key,
    required this.displayName,
    this.thumbnail,
    this.smart = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final String displayName;
  final Uint8List? thumbnail;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final Uint8List? thumbnail = this.thumbnail;
    final avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        if (thumbnail == null)
          LeadingAvatar(
            username: displayName,
          )
        else
          CircleAvatar(
            foregroundImage: MemoryImage(thumbnail),
          ),
        if (smart)
          Positioned(
            right: -4,
            bottom: -4,
            width: 20,
            height: 20,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(
                Icons.person,
                size: 18,
              ),
            ),
          )
      ],
    );

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16.0),
      leading: avatar,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.call),
            onPressed: () {
              print('onTap call');
            },
          ),
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.videocam),
            onPressed: () {
              print('onTap videocam');
            },
          ),
        ],
      ),
      title: Text(displayName),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
