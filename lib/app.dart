import 'package:d2chess/core/top_level_scaffold.dart';
import 'package:d2chess/flavors.dart';
import 'package:d2chess/pages/chess_test.dart';
import 'package:d2chess/pages/home.dart';
import 'package:d2chess/pages/test.dart';
import 'package:d2chess/state/custom_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeShell');
final _testShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'testShell');
final _chessTestShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'chessTestShell');

final GoRouter _router = GoRouter(
  initialLocation: "/home",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => TopLevelScaffold(
        state: state,
        navigationShell: shell,
        key: GlobalKey(),
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeShellNavigatorKey,
          initialLocation: "/home",
          routes: [
            GoRoute(
              path: "/home",
              pageBuilder: (context, state) => platformPage(
                  context: context,
                  maintainState: true,
                  child: const HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _testShellNavigatorKey,
          initialLocation: "/test",
          routes: [
            GoRoute(
              path: "/test",
              pageBuilder: (context, state) => platformPage(
                context: context,
                maintainState: true,
                child: const TestPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _chessTestShellNavigatorKey,
          initialLocation: "/chess_test",
          routes: [
            GoRoute(
              parentNavigatorKey: _chessTestShellNavigatorKey,
              path: "/chess_test",
              pageBuilder: (context, state) => platformPage(
                context: context,
                maintainState: true,
                child: const ChessTestPage(),
              ),
            ),
          ],
        )
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings:
          PlatformSettingsData(iosUseZeroPaddingForAppbarPlatformIcon: true),
      builder: (context) => CustomColorProvider(
        child: PlatformApp.router(
          title: F.title,
          routerConfig: _router,
        ),
      ),
    );
  }
}
