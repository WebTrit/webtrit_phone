import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/features/voicemail/models/voicemail_screen_context.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/mocks/mocks.dart';

class MainScreenScreenshot extends StatefulWidget {
  const MainScreenScreenshot(
    this.flavor,
    this.title, {
    super.key,
    this.keypadDialing = false,
    this.interactive = false,
    this.pullableCallDialogs = const [],
  });

  final MainFlavor flavor;
  final Widget? title;

  /// Calls active on other devices; a non-empty list puts the call pull badge
  /// into the app bar.
  final List<DialogInfo> pullableCallDialogs;

  /// When the keypad flavor is shown, pre-fill it with a dialed number and resolved contact.
  /// Ignored when [interactive] is true (the live keypad starts empty and reacts to input).
  final bool keypadDialing;

  /// Enables bottom-menu tab switching and wires a live keypad cubit, so the
  /// preview behaves like the app instead of a single static snapshot.
  final bool interactive;

  @override
  State<MainScreenScreenshot> createState() => _MainScreenScreenshotState();
}

class _MainScreenScreenshotState extends State<MainScreenScreenshot> {
  /// Selected by position, not by kind: two embedded sections share one
  /// flavor, and remembering the flavor would highlight the first of them
  /// whichever one was pressed.
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    // Fetch tabs for the bottom menu using FeatureAccess, which is specifically used in the configurator project.
    // If FeatureAccess is not available, fallback to predefined default tabs.
    final featureAccess = context.read<FeatureAccess?>();

    final configTabs = featureAccess?.bottomMenuConfig.tabs;
    // Demo tabs stand in only when there is no configuration to show at all.
    // A real config keeps its own tabs whatever their count: substituting the
    // demo menu for a one-tab config made the preview show five sections the
    // app would never render.
    final tabs = (configTabs != null && configTabs.isNotEmpty) ? configTabs : _defaultTabs(context);

    Widget screen = MultiProvider(
      providers: [
        // TODO(Vladislav): Replace workaround with ContactsRepository in _ContactInfoBuilderState.
        Provider<ContactsRepository>(create: (c) => MockContactsRepository()),
      ],
      child: MultiBlocProvider(
        providers: _createMockBlocProviders(),
        child: Builder(
          builder: (context) {
            final flavorIndex = tabs.indexWhere((tab) => tab.flavor == widget.flavor);
            // A capture asks for a section by name; silently substituting
            // another would produce differently-named screenshots of one and
            // the same screen. An interactive preview may start anywhere.
            assert(
              widget.interactive || flavorIndex >= 0,
              'the configured menu has no ${widget.flavor} section to capture',
            );
            // Clamped rather than trusted: the remembered position can outlive
            // a config change that shrank the tabs list.
            final selectedIndex = (_selectedIndex ?? (flavorIndex < 0 ? 0 : flavorIndex)).clamp(0, tabs.length - 1);
            final body = AppBarParams(
              systemNotificationsEnabled: true,
              pullableCallDialogs: widget.pullableCallDialogs,
              child: _buildFlavorWidget(context, tabs[selectedIndex].flavor, featureAccess),
            );
            // MainScreen itself drops the bar for a single-section menu - the
            // preview inherits the rule instead of restating it.
            return MainScreen(
              // The mock unread state below backs this the way the shell does
              // in the app.
              decorateTabIcon: MessagingFlavorOverlay.forTab,
              body: body,
              tabs: tabs,
              currentIndex: selectedIndex,
              onTabSelected: widget.interactive ? _selectTab : null,
            );
          },
        ),
      ),
    );

    if (widget.pullableCallDialogs.isNotEmpty) {
      // The call pull badge wobbles on a timer, which a snapshot cannot capture
      // deterministically; the badge holds still when animations are disabled.
      screen = MediaQuery(data: MediaQuery.of(context).copyWith(disableAnimations: true), child: screen);
    }

    return screen;
  }

  List<BlocProvider> _createMockBlocProviders() {
    return [
      BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
      BlocProvider<CallRoutingCubit>(create: (_) => MockCallRoutingCubit.initial()),
      // The app bar renders the call pull badge only on a ready session, so the
      // badge preview needs a connected one; the other states keep the default
      // "Connecting..." look.
      BlocProvider<SessionStatusCubit>(
        create: (_) =>
            widget.pullableCallDialogs.isNotEmpty ? MockSessionStatusCubit.ready() : MockSessionStatusCubit.initial(),
      ),
      BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.initial()),
      BlocProvider<SystemNotificationsCounterCubit>(create: (_) => MockSystemNotificationCounterCubit.withDefaults()),
      BlocProvider<MicrophoneStatusBloc>(create: (_) => MockMicrophoneStatusBloc.initial(isGranted: true)),
      // One unread-count cubit serves both the bar's badge and the messaging
      // body, the way production provides it. The static messaging capture
      // carries real counts and the other captures stay badge-free, but the
      // interactive preview always has them: it is created with whatever tab
      // is first, and the messaging screen the user taps into afterwards must
      // demonstrate its counters, not a menu that happens to be empty.
      BlocProvider<UnreadCountCubit>(
        create: (_) => widget.interactive || widget.flavor == MainFlavor.messaging
            ? MockUnreadCountCubit.withUnreadMessages()
            : MockUnreadCountCubit.initial(),
      ),
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
        supportsCallHistory: false,
      ),
      ContactsBottomMenuTab(
        enabled: true,
        initial: false,
        titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
        icon: Icons.people,
        contactSourceTypes: [],
        layout: const ContactsTabbedLayout(),
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

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
  }

  Widget _buildFlavorWidget(BuildContext context, MainFlavor flavor, FeatureAccess? featureAccess) {
    final appMetadataProvider = context.read<AppMetadataProvider>();

    switch (flavor) {
      case MainFlavor.favorites:
        return BlocProvider<FavoritesBloc>(
          create: (_) => MockFavoritesBloc.mainScreen(),
          child: FavoritesScreen(
            title: widget.title,
            transferEnabled: false,
            videoEnabled: true,
            chatsEnabled: false,
            smssEnabled: false,
            cdrsEnabled: false,
          ),
        );
      case MainFlavor.recents:
        // Mirror the app's tab routing: with the callHistory adapter capability
        // the recents tab shows remote CDRs instead of local recents.
        final recentsTab = featureAccess?.bottomMenuConfig.getTabEnabled<RecentsBottomMenuTab>();
        if (recentsTab?.supportsCallHistory ?? false) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<FullRecentCdrsCubit>(create: (_) => MockFullRecentCdrsCubit.withCdrs()),
              BlocProvider<MissedRecentCdrsCubit>(create: (_) => MockMissedRecentCdrsCubit.withRecords()),
            ],
            child: RecentCdrsScreen(
              title: widget.title,
              transferEnabled: false,
              videoEnabled: true,
              chatsEnabled: false,
              smssEnabled: false,
            ),
          );
        }
        return BlocProvider<RecentsBloc>(
          create: (_) => MockRecentsBloc.mainScreen(),
          child: RecentsScreen(
            title: widget.title,
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
            sourceTypes: const [ContactSourceType.local, ContactSourceType.external],
            sourceTypeWidgetBuilder: _buildContactSourceTypeWidget,
            title: widget.title,
          ),
        );
      case MainFlavor.keypad:
        return BlocProvider<KeypadCubit>(
          create: (context) => widget.interactive
              ? KeypadCubit(MockContactResolver(context.read<ContactsRepository>()))
              : (widget.keypadDialing ? MockKeypadCubit.dialing() : MockKeypadCubit.mainScreen()),
          child: Builder(
            // CallControllerScope is only read when a call action is tapped; provide it so the
            // interactive keypad's call buttons dispatch to the (mock) CallBloc instead of asserting.
            builder: (context) => CallControllerScope(
              controller: CallController(callBloc: context.read<CallBloc>()),
              child: KeypadScreen(title: widget.title, videoEnabled: true, transferEnabled: false),
            ),
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
            appBar: MainAppBar(title: const Text('Embedded'), context: context),
            connectivityRecoveryStrategyBuilder: () => NoneConnectivityRecoveryStrategy(),
            pageInjectionStrategyBuilder: () => DefaultPayloadInjectionStrategy(),
          ),
        );
      case MainFlavor.voicemail:
        // The same provider set the standalone voicemail preview builds; the
        // tiles resolve the playback controller through it.
        return MultiProvider(
          providers: [
            Provider<VoicemailScreenContext>(
              create: (_) => VoicemailScreenContext(
                mediaCacheBasePath: '/tmp/screenshots_cache',
                dateFormat: DateFormat.yMMMd().add_Hm(),
                mediaHeaders: const {},
              ),
            ),
            BlocProvider<VoicemailCubit>(create: (_) => MockVoicemailCubit.withItems()),
            ChangeNotifierProvider(create: (_) => VoicemailPlaybackController()),
          ],
          child: const VoicemailTabScreen(),
        );
      case MainFlavor.messaging:
        return MultiBlocProvider(
          providers: [
            BlocProvider<MessagingBloc>(create: (_) => MockMessagingBloc.initial()),
            BlocProvider<ChatConversationsCubit>(create: (_) => MockChatConversationsCubit.withMockData()),
            BlocProvider<SmsConversationsCubit>(create: (_) => MockSmsConversationsCubit.withConversations()),
          ],
          child: ConversationsScreen(
            title: Text(EnvironmentConfig.APP_NAME),
            // Dual tabs expose the chat/sms tab bar (its TabController is local, so switching
            // works) for the interactive preview; the snapshot stays chat-only.
            initialTabsState: widget.interactive
                ? const DualTabState(ConversationsTab.chat, true)
                : const SingleTabState(ConversationsTab.chat, true),
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
