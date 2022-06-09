import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../contact.dart';

class ContactScaffold extends StatelessWidget {
  const ContactScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          final themeData = Theme.of(context);
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
                style: themeData.textTheme.headline4,
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
                    favorite: phone.favorite,
                    onFavoriteChanged: (favorite) {
                      if (favorite) {
                        context.read<ContactCubit>().addToFavorites(phone);
                      } else {
                        context.read<ContactCubit>().removeFromFavorites(phone);
                      }
                    },
                    onAudioPressed: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: phone.number,
                        displayName: contact.name,
                        video: false,
                      ));
                      context.pop();
                    },
                    onVideoPressed: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: phone.number,
                        displayName: contact.name,
                        video: true,
                      ));
                      context.pop();
                    },
                  )
            ],
          );
        },
      ),
    );
  }
}
