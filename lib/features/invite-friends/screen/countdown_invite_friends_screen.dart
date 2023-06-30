import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../bloc/invite_friends_bloc_cubit.dart';
import '../widgets/invite_dialog.dart';

class CountDownInviteFriendsScreen extends StatelessWidget {
  final Widget child;
  //TODO: Fast fix
  final bool isStart;

  const CountDownInviteFriendsScreen({
    super.key,
    required this.child,
    required this.isStart,
  });

  @override
  Widget build(BuildContext context) {
    return isStart
        ? BlocListener<InviteFriendsBlocCubit, InviteFriendsBlocState>(
            listener: (context, state) {
              if (state is DisplayInviteFriendsDialog) {
                final location = GoRouter.of(context).location;
                final router = GoRouter.of(context);

                if (router.namedLocation(MainRoute.favorites) == location ||
                    router.namedLocation(MainRoute.recents) == location ||
                    router.namedLocation(MainRoute.contacts) == location ||
                    router.namedLocation(MainRoute.keypad) == location) {
                  _showInviteDialog(context, state.inviteUrl!);
                } else {
                  context.read<InviteFriendsBlocCubit>().postponeDialogCountdown();
                }
              }
            },
            child: child,
          )
        : child;
  }

  void _showInviteDialog(BuildContext context, String url) {
    final router = GoRouter.of(context);
    final bloc = context.read<InviteFriendsBlocCubit>();

    showDialog(
      context: context,
      builder: (context) => InviteDialog(
        onInvite: () {
          Navigator.pop(context);
          router.pushNamed(
            MainRoute.inviteFriends,
            queryParameters: {'invite-url': url},
          );
        },
        onHide: () {
          Navigator.pop(context);
          bloc.postponeDialogCountdown();
        },
      ),
    );
  }
}
