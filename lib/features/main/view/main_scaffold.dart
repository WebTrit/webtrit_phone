import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class Tab {
  Tab({
    required String debugLabelPrefix,
    required this.icon,
    required this.label,
    required Widget Function(Key key) create,
  })  : _create = create,
        _globalKey = LabeledGlobalKey('${debugLabelPrefix}TabGlobalKey');

  final IconData icon;
  final String Function(BuildContext context) label;
  final Widget Function(Key key) _create;
  final GlobalKey _globalKey;

  bool _wasActive = false;

  Widget createWithGlobalKey(bool active) {
    if (_wasActive) {
      return _create(_globalKey);
    } else if (active) {
      _wasActive = active;
      return _create(_globalKey);
    } else {
      return Container();
    }
  }
}

final List<Tab> tabs = <Tab>[
  Tab(
    debugLabelPrefix: 'Favorites',
    icon: Icons.star_outline,
    label: (context) => context.l10n.main_BottomNavigationBarItemLabel_favorites,
    create: (key) => FavoritesPage(key: key),
  ),
  Tab(
    debugLabelPrefix: 'Recents',
    icon: Icons.access_time,
    label: (context) => context.l10n.main_BottomNavigationBarItemLabel_recents,
    create: (key) => RecentsPage(key: key),
  ),
  Tab(
    debugLabelPrefix: 'Contacts',
    icon: Icons.account_circle_outlined,
    label: (context) => context.l10n.main_BottomNavigationBarItemLabel_contacts,
    create: (key) => ContactsPage(key: key),
  ),
  Tab(
    debugLabelPrefix: 'Keypad',
    icon: Icons.dialpad,
    label: (context) => context.l10n.main_BottomNavigationBarItemLabel_keypad,
    create: (key) => KeypadPage(key: key),
  ),
];

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> with RestorationMixin {
  final _restorableSelectedIndex = RestorableInt(0);

  @override
  void dispose() {
    _restorableSelectedIndex.dispose();
    super.dispose();
  }

  @override
  String get restorationId => 'Main';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableSelectedIndex, 'BottomNavigationSelectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: tabs.asMap().entries.map((entry) {
            final int index = entry.key;
            final Tab tab = entry.value;

            final active = index == _restorableSelectedIndex.value;
            return TabPage(
              active: active,
              child: tab.createWithGlobalKey(active),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.caption,
        unselectedLabelStyle: themeData.textTheme.caption,
        currentIndex: _restorableSelectedIndex.value,
        onTap: _onItemTapped,
        items: tabs.map((Tab tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            label: tab.label(context),
          );
        }).toList(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _restorableSelectedIndex.value = index;
    });
  }
}

class TabPage extends StatefulWidget {
  final bool active;
  final Widget child;

  const TabPage({
    Key? key,
    required this.active,
    required this.child,
  }) : super(key: key);

  @override
  TabPageState createState() => TabPageState();
}

class TabPageState extends State<TabPage> with SingleTickerProviderStateMixin<TabPage> {
  late AnimationController _fader;

  @override
  void initState() {
    super.initState();

    _fader = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    if (widget.active) {
      _fader.value = _fader.upperBound;
    }
  }

  @override
  void dispose() {
    _fader.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget view = FadeTransition(
      opacity: _fader.drive(CurveTween(curve: Curves.fastOutSlowIn)),
      child: widget.child,
    );
    if (widget.active) {
      if (_fader.status != AnimationStatus.completed) {
        _fader.forward();
      }
      return view;
    } else {
      if (_fader.status != AnimationStatus.dismissed) {
        _fader.reverse().whenComplete(() {
          setState(() {}); // need to replace IgnorePointer by Offstage
        });
        return IgnorePointer(child: view);
      } else {
        return Offstage(child: view);
      }
    }
  }
}
