import 'package:d2chess/universal/universal_style.dart';
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
    var icons = Universal.of(context).data.icons;
    return PlatformScaffold(
      body: navigationShell,
      bottomNavBar: PlatformNavBar(
        currentIndex: navigationShell.currentIndex,
        itemChanged: itemChanged,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "The homepage",
            icon: Icon(icons.home),
            activeIcon: Icon(icons.homeFilled),
          ),
          BottomNavigationBarItem(
            label: "Nearby Connections",
            tooltip: "Page for testing Nearby Connections",
            icon: Icon(icons.info),
            activeIcon: Icon(icons.infoFilled),
          ),
          BottomNavigationBarItem(
            label: "Chess test",
            tooltip: "Page for testing chess",
            icon: Icon(icons.game),
            activeIcon: Icon(icons.gameFilled),
          ),
        ],
      ),
    );
  }
}
