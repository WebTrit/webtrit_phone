import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

class Tab {
  Tab({
    required this.icon,
    required this.title,
    required create,
  })  : _create = create,
        _globalKey = LabeledGlobalKey('${title}TabGlobalKey');

  final IconData icon;
  final String title;
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
    icon: Icons.star_outline,
    title: 'Favorites',
    create: (Key key) => FavoritesPage(key: key),
  ),
  Tab(
    icon: Icons.access_time,
    title: 'Recents',
    create: (Key key) => RecentsPage(key: key),
  ),
  Tab(
    icon: Icons.account_circle_outlined,
    title: 'Contacts',
    create: (Key key) => ContactsPage(key: key),
  ),
  Tab(
    icon: Icons.dialpad,
    title: 'Keypad',
    create: (Key key) => KeypadPage(key: key),
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
  String get restorationId => 'MainPage';

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
            label: tab.title,
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
