import 'package:flutter/material.dart';

class TabBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const TabBarSearch({
    Key? key,
    required this.tabBar,
    required this.search,
  }) : super(key: key);

  final PreferredSizeWidget tabBar;
  final Widget search;

  static const _searchHeight = kMinInteractiveDimension;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tabBar,
        SizedBox(
          height: _searchHeight,
          child: search,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(tabBar.preferredSize.height + _searchHeight);
}
