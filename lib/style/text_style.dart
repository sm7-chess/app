import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversalTextStyle {
  final TextStyle? headlineLarge;
  final TextStyle? headlineMedium;
  final TextStyle? headlineSmall;

  final TextStyle? bodyLarge;
  final TextStyle? bodyMedium;
  final TextStyle? bodySmall;

  final TextStyle? displayLarge;
  final TextStyle? displayMedium;
  final TextStyle? displaySmall;

  static UniversalTextStyle fromTheme(
      bool ia, ThemeData t, CupertinoThemeData ct) {
    var bodyFont = GoogleFonts.firaSansCondensed;
    var font = GoogleFonts.firaSans;

    return UniversalTextStyle(
      headlineLarge: font(
        letterSpacing: 1,
        height: 1.1,
        fontWeight: FontWeight.w500,
        textStyle: ia
            ? t.textTheme.headlineLarge
            : ct.textTheme.navLargeTitleTextStyle.copyWith(
                fontSize: t.textTheme.headlineLarge?.fontSize,
                color: t.textTheme.headlineLarge?.color),
      ),
      headlineMedium: font(
        letterSpacing: 0.5,
        height: 1.1,
        fontWeight: FontWeight.w400,
        textStyle: ia
            ? t.textTheme.headlineMedium
            : ct.textTheme.navTitleTextStyle.copyWith(
                fontSize: t.textTheme.headlineMedium?.fontSize,
                color: t.textTheme.headlineMedium?.color),
      ),
      headlineSmall: font(
        letterSpacing: 0.5,
        height: 1.1,
        fontWeight: FontWeight.w300,
        textStyle: ia
            ? t.textTheme.headlineSmall
            : ct.textTheme.navTitleTextStyle.copyWith(
                fontSize: t.textTheme.headlineSmall?.fontSize,
                color: t.textTheme.headlineSmall?.color),
      ),
      bodyLarge: bodyFont(
        letterSpacing: 0.2,
        height: 1,
        fontWeight: FontWeight.w300,
        textStyle: ia
            ? t.textTheme.bodyLarge
            : ct.textTheme.textStyle.copyWith(
                fontSize: t.textTheme.bodyLarge?.fontSize,
                color: t.textTheme.bodyLarge?.color),
      ),
      bodyMedium: bodyFont(
        letterSpacing: 0.2,
        height: 1,
        fontWeight: FontWeight.w300,
        textStyle: ia
            ? t.textTheme.bodyMedium
            : ct.textTheme.textStyle.copyWith(
                fontSize: t.textTheme.bodyMedium?.fontSize,
                color: t.textTheme.bodyMedium?.color,
              ),
      ),
      bodySmall: bodyFont(
        letterSpacing: 0.4,
        height: 1.1,
        fontWeight: FontWeight.w300,
        textStyle: ia
            ? t.textTheme.bodySmall
            : ct.textTheme.textStyle.copyWith(
                fontSize: t.textTheme.bodySmall?.fontSize,
                color: t.textTheme.bodySmall?.color,
              ),
      ),
      displayLarge: font(
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500,
        textStyle: ia
            ? t.textTheme.displayLarge
            : ct.textTheme.navLargeTitleTextStyle.copyWith(
                fontSize: t.textTheme.displayLarge?.fontSize,
                color: t.textTheme.displayLarge?.color,
              ),
      ),
      displayMedium: font(
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400,
        textStyle: ia
            ? t.textTheme.displayMedium
            : ct.textTheme.navLargeTitleTextStyle.copyWith(
                fontSize: t.textTheme.displayMedium?.fontSize,
                color: t.textTheme.displayMedium?.color,
              ),
      ),
      displaySmall: font(
        letterSpacing: 0.5,
        fontWeight: FontWeight.w300,
        textStyle: ia
            ? t.textTheme.displaySmall
            : ct.textTheme.navLargeTitleTextStyle.copyWith(
                fontSize: t.textTheme.displaySmall?.fontSize,
                color: t.textTheme.displaySmall?.color,
              ),
      ),
    );
  }

  UniversalTextStyle({
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
  });
}
