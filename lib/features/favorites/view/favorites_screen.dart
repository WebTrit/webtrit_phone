import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
    this.title,
    required this.videoCallEnable,
  });

  final Widget? title;
  final bool videoCallEnable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: title,
        context: context,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (favorites.isEmpty) {
              return NoDataPlaceholder(
                content: Text(context.l10n.favorites_BodyCenter_empty),
              );
            } else {
              return BlocBuilder<CallBloc, CallState>(
                buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
                builder: (context, callState) {
                  final blingTransferInitiated = callState.isBlingTransferInitiated;
                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final favorite = favorites[index];
                      return FavoriteTile(
                        favorite: favorite,
                        onTap: blingTransferInitiated
                            ? () {
                                final callBloc = context.read<CallBloc>();
                                callBloc.add(CallControlEvent.blindTransferSubmitted(
                                  number: favorite.number,
                                ));
                              }
                            : () {
                                final callBloc = context.read<CallBloc>();
                                callBloc.add(CallControlEvent.started(
                                  number: favorite.number,
                                  displayName: favorite.name,
                                  video: false,
                                ));
                              },
                        onLongPress: blingTransferInitiated
                            ? null
                            : () {
                                final callBloc = context.read<CallBloc>();
                                callBloc.add(CallControlEvent.started(
                                  number: favorite.number,
                                  displayName: favorite.name,
                                  video: videoCallEnable,
                                ));
                              },
                        onInfoPressed: () {
                          context.router.navigate(ContactScreenPageRoute(
                            contactId: favorite.contact.id,
                          ));
                        },
                        onDeleted: (favorite) {
                          context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.name));

                          context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
                        },
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CallBloc, CallState>(
        buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
        builder: (context, callState) {
          if (callState.isBlingTransferInitiated) {
            return TransferBottomNavigationBar(context.l10n.favorites_Text_blingTransferInitiated);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
