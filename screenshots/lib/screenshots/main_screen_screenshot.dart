import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/mocks/mocks.dart';

class MainScreenScreenshot extends StatelessWidget {
  const MainScreenScreenshot(
    this.flavor,
    this.title, {
    super.key,
  });

  final MainFlavor flavor;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    // Fetch tabs for the bottom menu using FeatureAccess, which is specifically used in the configurator project.
    // If FeatureAccess is not available, fallback to predefined default tabs.
    final featureAccess = context.read<FeatureAccess?>();
    final tabs = featureAccess?.bottomMenuFeature.tabs ?? _defaultTabs(context);

    return MultiProvider(
      providers: [
        // TODO(Vladislav): Replace workaround with ContactsRepository in _ContactInfoBuilderState.
        // The data source should be moved to the BLoC for better architecture.
        Provider<ContactsRepository>(
          create: (c) => MockContactsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: _createMockBlocProviders(),
        child: MainScreen(
          body: AppBarParams(
            systemNotificationsEnabled: true,
            pullableCalls: const [],
            child: _buildFlavorWidget(context, flavor, featureAccess!),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, tabs),
        ),
      ),
    );
  }

  List<BlocProvider> _createMockBlocProviders() {
    return [
      BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
      BlocProvider<CallRoutingCubit>(create: (_) => MockCallRoutingCubit.initial()),
      BlocProvider<MainBloc>(create: (_) => MockMainBloc.mainScreen()),
      BlocProvider<SessionStatusCubit>(create: (_) => MockSessionStatusCubit.initial()),
      BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.initial()),
      BlocProvider<SystemNotificationsCounterCubit>(create: (_) => MockSystemNotificationCounterCubit.withDefaults()),
    ];
  }

  List<BottomMenuTab> _defaultTabs(BuildContext context) {
    return [
      const FavoritesBottomMenuTab(
        enabled: true,
        initial: true,
        titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
        icon: Icons.star,
      ),
      const RecentsBottomMenuTab(
        enabled: true,
        initial: false,
        titleL10n: 'main_BottomNavigationBarItemLabel_recents',
        icon: Icons.history,
        useCdrs: false,
      ),
      const ContactsBottomMenuTab(
        enabled: true,
        initial: false,
        titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
        icon: Icons.people,
        contactSourceTypes: [],
      ),
      const KeypadBottomMenuTab(
        enabled: true,
        initial: false,
        titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
        icon: Icons.dialpad,
      ),
      MessagingBottomMenuTab(
        enabled: true,
        initial: false,
        titleL10n: context.l10n.main_BottomNavigationBarItemLabel_chats,
        icon: Icons.messenger_outline,
      ),
    ];
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context, List<BottomMenuTab> tabs) {
    final textTheme = Theme.of(context).textTheme;

    return BottomNavigationBar(
      currentIndex: tabs.indexWhere((tab) => tab.flavor == flavor),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: textTheme.bodySmall,
      unselectedLabelStyle: textTheme.bodySmall,
      items: tabs
          .map((tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: context.parseL10n(tab.titleL10n),
              ))
          .toList(),
    );
  }

  Widget _buildFlavorWidget(BuildContext context, MainFlavor flavor, FeatureAccess featureAccess) {
    final appMetadataProvider = context.read<AppMetadataProvider>();

    switch (flavor) {
      case MainFlavor.favorites:
        return BlocProvider<FavoritesBloc>(
          create: (_) => MockFavoritesBloc.mainScreen(),
          child: FavoritesScreen(
            title: title,
            transferEnabled: false,
            videoEnabled: true,
            chatsEnabled: false,
            smssEnabled: false,
            cdrsEnabled: false,
          ),
        );
      case MainFlavor.recents:
        return BlocProvider<RecentsBloc>(
          create: (_) => MockRecentsBloc.mainScreen(),
          child: RecentsScreen(
            title: title,
            transferEnabled: false,
            videoEnabled: true,
            chatsEnabled: false,
            smssEnabled: false,
          ),
        );
      case MainFlavor.contacts:
        return BlocProvider<ContactsBloc>(
          create: (_) => MockContactsSearchBloc.mainScreen(),
          child: ContactsScreen(
            sourceTypes: const [
              ContactSourceType.local,
              ContactSourceType.external,
            ],
            sourceTypeWidgetBuilder: _buildContactSourceTypeWidget,
            title: title,
          ),
        );
      case MainFlavor.keypad:
        return BlocProvider<KeypadCubit>(
          create: (_) => MockKeypadCubit.mainScreen(),
          child: KeypadScreen(
            title: title,
            videoEnabled: true,
            transferEnabled: false,
          ),
        );
      case MainFlavor.embedded:
        return BlocProvider<EmbeddedCubit>(
          create: (_) => MockEmbeddedCubit.mainScreen(),
          child: EmbeddedScreen(
            initialUri: Uri.parse('https://example.com'),
            userAgent: appMetadataProvider.userAgent,
            mediaQueryMetricsData: null,
            deviceInfoData: null,
            appBar: MainAppBar(
              title: const Text('Embedded'),
              context: context,
            ),
            connectivityRecoveryStrategyBuilder: () => NoneConnectivityRecoveryStrategy(),
            pageInjectionStrategyBuilder: () => DefaultPayloadInjectionStrategy(),
          ),
        );
      case MainFlavor.messaging:
        return MultiBlocProvider(
          providers: [
            BlocProvider<MessagingBloc>(create: (_) => MockMessagingBloc.initial()),
            BlocProvider<ChatConversationsCubit>(create: (_) => MockChatConversationsCubit.withMockData()),
            BlocProvider<SmsConversationsCubit>(create: (_) => MockSmsConversationsCubit.withConversations()),
            BlocProvider<UnreadCountCubit>(create: (_) => MockUnreadCountCubit.withUnreadMessages()),
          ],
          child: const ConversationsScreen(
            title: Text(
              EnvironmentConfig.APP_NAME,
            ),
          ),
        );
    }
  }

  Widget _buildContactSourceTypeWidget(BuildContext context, ContactSourceType sourceType) {
    switch (sourceType) {
      case ContactSourceType.local:
        return BlocProvider<ContactsLocalTabBloc>(
          create: (_) => MockContactsLocalTabBloc.mainScreen(),
          child: const ContactsLocalTab(),
        );
      case ContactSourceType.external:
        return BlocProvider<ContactsExternalTabBloc>(
          create: (_) => MockContactsExternalTabBloc.mainScreen(),
          child: const ContactsExternalTab(),
        );
    }
  }
}
