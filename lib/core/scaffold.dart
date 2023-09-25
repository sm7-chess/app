import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NavBarItem {
  final BottomNavigationBarItem navBarItem;
  final String title;
  final Widget child;

  NavBarItem({
    required this.navBarItem,
    required this.title,
    required this.child,
  });
}

class AppScaffold extends StatefulWidget {
  final int homeIndex;
  final List<NavBarItem> items;

  const AppScaffold({super.key, required this.homeIndex, required this.items});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _index = 0;
  String title = "";

  late final List<NavBarItem> items;
  late final List<BottomNavigationBarItem> navBarItems;

  @override
  initState() {
    super.initState();
    setState(() {
      items = widget.items;
      navBarItems = items.map((e) => e.navBarItem).toList();

      if (widget.homeIndex < widget.items.length) {
        _index = widget.homeIndex;
        title = widget.items[_index].title;
      }
    });
  }

  void navBarItemChanged(int index) {
    setState(() {
      _index = index;
      title = widget.items[_index].title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          title,
          style: Platform.isAndroid
              ? Theme.of(context).textTheme.titleLarge
              : CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      body: widget.items[_index].child,
      bottomNavBar: PlatformNavBar(
        currentIndex: _index,
        items: navBarItems,
        itemChanged: navBarItemChanged,
        cupertino: (context, target) {
          return CupertinoTabBarData(iconSize: 25);
        },
      ),
    );
  }
}
