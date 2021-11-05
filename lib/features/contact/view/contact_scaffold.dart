import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contact.dart';

class ContactScaffold extends StatelessWidget {
  const ContactScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          final contact = state.contact;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LeadingAvatar(
                  username: contact.name,
                  radius: 50,
                ),
              ),
              Text(
                contact.name,
                style: theme.textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 16,
              ),
              if (state is! ContactSuccess)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                for (final phone in state.phones)
                  ContactPhoneTile(
                    number: phone.number,
                    label: phone.label,
                    onAudioPressed: () {
                      Navigator.pop(context, CallOutgoingStarted(number: phone.number, video: false));
                    },
                    onVideoPressed: () {
                      Navigator.pop(context, CallOutgoingStarted(number: phone.number, video: true));
                    },
                  )
            ],
          );
        },
      ),
    );
  }
}
