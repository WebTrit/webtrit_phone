import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<CallBloc, CallState>(
      buildWhen: (previous, current) => previous.intent != current.intent,
      builder: (context, state) {
        return AutoTabsScaffold(
          lazyLoad: false,
          appBarBuilder: state.intent == null
              ? null
              : (context, tabsRouter) => AppBar(
                    centerTitle: true,
                    title: PreferredSize(
                      preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
                      child: Card(
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              state.intent == TransferType.attended
                                  ? context.l10n.call_CallActionsTooltip_attended_transfer
                                  : context.l10n.call_CallActionsTooltip_unattended_transfer,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          routes: const [
            FavoritesTabPageRoute(),
            RecentsTabPageRoute(),
            ContactsTabPageRoute(),
            KeypadScreenPageRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: themeData.textTheme.bodySmall,
              unselectedLabelStyle: themeData.textTheme.bodySmall,
              onTap: tabsRouter.setActiveIndex,
              items: MainFlavor.values.map((flavor) {
                return BottomNavigationBarItem(
                  icon: Icon(flavor.icon),
                  label: flavor.labelL10n(context),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
