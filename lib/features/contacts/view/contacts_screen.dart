import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/models.dart';

import '../bloc/contacts_search_bloc.dart';
import 'contacts_scaffold.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({
    super.key,
    required this.sourceTypes,
  });

  final List<ContactSourceType> sourceTypes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsSearchBloc(),
      child: ContactsScaffold(
        sourceTypes: sourceTypes,
      ),
    );
  }
}
