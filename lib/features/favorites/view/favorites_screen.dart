import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (favorites.isEmpty) {
              final themeData = Theme.of(context);
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 80,
                      color: themeData.textTheme.bodySmall!.color,
                    ),
                    Padding(
                      padding: kAllPadding16,
                      child: Text(
                        context.l10n.favorites_BodyCenter_empty,
                        style: themeData.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return FavoriteTile(
                    favorite: favorite,
                    onTap: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: favorite.number,
                        displayName: favorite.name,
                        video: false,
                      ));
                    },
                    onLongPress: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: favorite.number,
                        displayName: favorite.name,
                        video: true,
                      ));
                    },
                    onInfoPressed: () {
                      context.pushNamed(MainRoute.favoritesDetails, pathParameters: {
                        contactIdPathParameterName: favorite.contact.id.toString(),
                      });
                    },
                    onDeleted: (favorite) {
                      context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.name));

                      context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
