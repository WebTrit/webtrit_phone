import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/pages/recents.dart';

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
    icon: Icons.history,
    title: 'Recents',
    create: (Key key) => RecentsPage(key: key),
  ),
  Tab(
    icon: Icons.contacts_outlined,
    title: 'Contacts',
    create: (Key key) => ContactsPage(key: key),
  ),
  Tab(
    icon: Icons.dialpad,
    title: 'Keypad',
    create: (Key key) => KeypadPage(key: key),
  ),
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: tabs.asMap().entries.map((entry) {
            final int index = entry.key;
            final Tab tab = entry.value;

            final active = index == _selectedIndex;
            return TabPage(
              active: active,
              child: tab.createWithGlobalKey(active),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedFontSize: Theme.of(context).textTheme.caption!.fontSize!,
        unselectedFontSize: Theme.of(context).textTheme.caption!.fontSize!,
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
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin<TabPage> {
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
