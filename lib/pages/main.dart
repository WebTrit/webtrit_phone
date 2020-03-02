import 'package:flutter/material.dart';

import 'package:webtrit_phone/pages/contacts.dart';
import 'package:webtrit_phone/pages/keypad.dart';
import 'package:webtrit_phone/pages/messages.dart';
import 'package:webtrit_phone/pages/recents.dart';
import 'package:webtrit_phone/pages/settings.dart';

class Tab {
  Tab({
    @required this.icon,
    @required this.title,
    @required this.build,
  })  : assert(icon != null),
        assert(title != null),
        assert(build != null),
        globalKey = LabeledGlobalKey('${title}TabGlobalKey');

  final IconData icon;
  final String title;
  final Widget Function(BuildContext context) build;
  final GlobalKey globalKey;
}

final List<Tab> tabs = <Tab>[
  Tab(
    icon: Icons.history,
    title: 'Recents',
    build: (BuildContext context) => RecentsPage(),
  ),
  Tab(
    icon: Icons.contacts,
    title: 'Contacts',
    build: (BuildContext context) => ContactsPage(),
  ),
  Tab(
    icon: Icons.dialpad,
    title: 'Keypad',
    build: (BuildContext context) => KeypadPage(),
  ),
  Tab(
    icon: Icons.mail,
    title: 'Messages',
    build: (BuildContext context) => MessagesPage(),
  ),
  Tab(
    icon: Icons.settings,
    title: 'Settings',
    build: (BuildContext context) => SettingsPage(),
  ),
];

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

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
      body: Center(
        child: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: tabs.asMap().entries.map((entry) {
              final int index = entry.key;
              final Tab tab = entry.value;

              return TabPage(
                active: index == _selectedIndex,
                child: KeyedSubtree(
                  key: tab.globalKey,
                  child: tab.build(context),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: tabs.map((Tab tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            title: Text(tab.title),
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
    Key key,
    this.active,
    this.child,
  }) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin<TabPage> {
  AnimationController _fader;

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
