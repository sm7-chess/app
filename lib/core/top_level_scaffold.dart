import 'package:d2chess/universal/universal_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

class TopLevelScaffold extends StatelessWidget {
  const TopLevelScaffold({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  final StatefulNavigationShell navigationShell;
  final GoRouterState state;

  void itemChanged(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: navigationShell.currentIndex == index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: navigationShell,
      bottomNavBar: PlatformNavBar(
        currentIndex: navigationShell.currentIndex,
        itemChanged: itemChanged,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "The homepage",
            icon: Icon(Universal.of(context).data.icons.home),
            activeIcon: Icon(Universal.of(context).data.icons.homeFilled),
          ),
          BottomNavigationBarItem(
            label: "Nearby Connections",
            tooltip: "Page for testing Nearby Connections",
            icon: Icon(Universal.of(context).data.icons.info),
            activeIcon: Icon(Universal.of(context).data.icons.infoFilled),
          ),
          BottomNavigationBarItem(
            label: "Chess test",
            tooltip: "Page for testing chess",
            icon: Icon(Universal.of(context).data.icons.game),
            activeIcon: Icon(Universal.of(context).data.icons.gameFilled),
          ),
        ],
      ),
    );
  }
}
