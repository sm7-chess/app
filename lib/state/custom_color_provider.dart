import 'package:d2chess/universal/theme.dart';
import 'package:d2chess/universal/universal_style.dart';
import 'package:d2chess/widgets/theme_color_picker.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
