import 'package:d2chess/core/scaffold.dart';
import 'package:d2chess/pages/chess_test.dart';
import 'package:d2chess/pages/home.dart';
import 'package:d2chess/pages/test.dart';
import 'package:d2chess/style/theme.dart';
import 'package:d2chess/style/universal_style.dart';
import 'package:d2chess/widgets/theme_color_picker.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings:
          PlatformSettingsData(iosUseZeroPaddingForAppbarPlatformIcon: true),
      builder: (context) => CustomColorProvider(
        child: PlatformApp(
          title: F.title,
          debugShowCheckedModeBanner: false,
          home: FlavorBanner(
            show: kDebugMode,
            child: AppScaffold(
              homeIndex: 0,
              items: [
                NavBarItem(
                  title: "Home Page",
                  navBarItem: BottomNavigationBarItem(
                    icon: Icon(PlatformIcons(context).home),
                    label: "Home",
                    tooltip: "The homepage",
                  ),
                  child: const HomePage(),
                ),
                NavBarItem(
                  title: "Test Page",
                  navBarItem: BottomNavigationBarItem(
                    icon: Icon(PlatformIcons(context).info),
                    label: "Nearby Connections",
                    tooltip: "A testing page",
                  ),
                  child: const TestPage(),
                ),
                NavBarItem(
                  title: "Chess Test Page",
                  navBarItem: BottomNavigationBarItem(
                    icon: Icon(PlatformIcons(context).gameController),
                    activeIcon:
                        Icon(PlatformIcons(context).gameControllerSolid),
                    label: "Chess Test",
                    tooltip: "A testing page",
                  ),
                  child: const ChessTestPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomColorProvider extends ConsumerWidget {
  const CustomColorProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeHueProvider);

    return DynamicColorBuilder(
      builder: (light, dark) {
        var materialLightTheme =
            Themes.materialFromColor(color, Brightness.light);
        var materialDarkTheme =
            Themes.materialFromColor(color, Brightness.dark);

        if (light != null && dark != null) {
          materialLightTheme =
              Themes.materialFromColor(color, Brightness.light);
          materialDarkTheme = Themes.materialFromColor(color, Brightness.dark);
        }

        return PlatformTheme(
          themeMode: ThemeMode.system,
          materialLightTheme: materialLightTheme,
          materialDarkTheme: materialDarkTheme,
          cupertinoLightTheme: Themes.materialToCupertino(materialLightTheme),
          cupertinoDarkTheme: Themes.materialToCupertino(materialDarkTheme),
          builder: (context) => UniversalStyleProvider(child: child),
        );
      },
    );
  }
}

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({super.key, required this.show, required this.child});

  final bool show;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : Container(
            child: child,
          );
  }
}
