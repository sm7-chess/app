import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squares/squares.dart';

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

  static BoardTheme materialToBoard(ThemeData data, Brightness brightness) {
    return BoardTheme.blueGrey.copyWith(
      lightSquare: brightness == Brightness.dark
          ? data.colorScheme.primary
          : data.colorScheme.primaryContainer,
      darkSquare: brightness == Brightness.dark
          ? data.colorScheme.primaryContainer
          : data.colorScheme.primary,
      selected: brightness == Brightness.dark
          ? data.colorScheme.onPrimary.withAlpha(125)
          : data.colorScheme.onPrimaryContainer.withAlpha(100),
      previous: brightness == Brightness.dark
          ? data.colorScheme.onPrimary.withAlpha(125)
          : data.colorScheme.onPrimaryContainer.withAlpha(100),
      premove: brightness == Brightness.dark
          ? data.colorScheme.onPrimary.withAlpha(125)
          : data.colorScheme.onPrimaryContainer.withAlpha(100),
    );
  }
}
