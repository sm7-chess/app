import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalIcons {
  final IconData home;
  final IconData homeFilled;
  final IconData info;
  final IconData infoFilled;
  final IconData game;
  final IconData gameFilled;

  static UniversalIcons fromTheme(bool ia, ThemeData t, CupertinoThemeData ct) {
    return UniversalIcons(
        home: ia ? Icons.home_outlined : CupertinoIcons.house,
        homeFilled: ia ? Icons.home : CupertinoIcons.house_fill,
        info: ia ? Icons.info_outline : CupertinoIcons.info_circle,
        infoFilled: ia ? Icons.info : CupertinoIcons.info_circle_fill,
        game: ia ? Icons.gamepad_outlined : CupertinoIcons.game_controller,
        gameFilled: ia ? Icons.gamepad : CupertinoIcons.game_controller_solid);
  }

  UniversalIcons({
    required this.home,
    required this.homeFilled,
    required this.info,
    required this.infoFilled,
    required this.game,
    required this.gameFilled,
  });
}
