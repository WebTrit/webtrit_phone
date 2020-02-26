import 'package:flutter/material.dart';

import 'package:webtrit_phone/pages/contacts.dart';
import 'package:webtrit_phone/pages/keypad.dart';
import 'package:webtrit_phone/pages/messages.dart';
import 'package:webtrit_phone/pages/recents.dart';
import 'package:webtrit_phone/pages/settings.dart';

class Tab {
  const Tab({
    @required this.icon,
    this.title,
    this.build,
  }) : assert(icon != null);

  final IconData icon;
  final String title;
  final Widget Function(BuildContext context) build;
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

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  int _selectedIndex = 0;
  List<Key> _tabKeys;
  List<AnimationController> _faders;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _tabKeys =
        List<Key>.generate(tabs.length, (int index) => GlobalKey()).toList();

    _faders = tabs.map<AnimationController>((Tab tab) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      );
    }).toList();
    _faders[_selectedIndex].value = 1.0;
  }

  @override
  void dispose() {
    _faders.forEach((controller) {
      controller.dispose();
    });

    super.dispose();
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

              final Widget view = FadeTransition(
                opacity: _faders[index]
                    .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                child: KeyedSubtree(
                  key: _tabKeys[index],
                  child: tab.build(context),
                ),
              );
              if (index == _selectedIndex) {
                _faders[index].forward();
                return view;
              } else {
                if (_faders[index].value == 1.0) {
                  _faders[index].reverse().whenComplete(() {
                    setState(
                        () {}); // need to replace IgnorePointer by Offstage
                  });
                  return IgnorePointer(child: view);
                } else {
                  return Offstage(child: view);
                }
              }
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
