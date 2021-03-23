import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> with PageSnackBarMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: ContactsSource.values.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      // TODO introduce FilteredRecentsBloc
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        bottom: TabBar(
          tabs: ContactsSource.values.map((value) => Tab(child: Text(value.l10n(context), softWrap: false))).toList(),
          controller: _tabController,
          labelColor: themeData.textTheme.caption.color,
        ),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
          if (state is ContactsLoadFailure) {
            showErrorSnackBar(context, 'Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! ContactsRefreshFailure;
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
                return (context.read<ContactsBloc>()..add(ContactsRefreshed()))
                    .stream
                    .firstWhere((state) => state is ContactsLoadSuccess || state is ContactsRefreshFailure);
              },
              child: ListView.separated(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ContactTile(
                    contact: contact,
                    onTap: () {
                      context.read<CallBloc>().add(CallOutgoingStarted(username: contact.username));
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
                onPressed: () => context.read<ContactsBloc>().add(ContactsInitialLoaded()),
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
      contentPadding: EdgeInsets.only(left: 16.0),
      leading: LeadingAvatar(
        username: contact.username,
      ),
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
      title: Text(contact.username),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
