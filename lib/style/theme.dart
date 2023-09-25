import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themes {
  static final ThemeData materialDarkTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFFC00100),
    ),
  );

  static final ThemeData materialLightTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFFC00100),
    ),
  );

  static final CupertinoThemeData cupertinoDarkTheme =
      materialToCupertino(materialDarkTheme);

  static final CupertinoThemeData cupertinoLightTheme =
      materialToCupertino(materialLightTheme);

  static CupertinoThemeData materialToCupertino(ThemeData data) {
    return CupertinoThemeData(
      brightness: data.brightness,
      barBackgroundColor: ElevationOverlay.applySurfaceTint(
          data.colorScheme.background, data.colorScheme.surfaceTint, 3),
      scaffoldBackgroundColor: data.scaffoldBackgroundColor,
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: data.colorScheme.primary,
        darkColor: data.colorScheme.primary,
      ),
    );
  }

  static ThemeData materialFromColor(Color color, Brightness brightness) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: color,
      ),
    );
  }
}
