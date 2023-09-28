import 'dart:io';

import 'package:d2chess/universal/icons.dart';
import 'package:d2chess/universal/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Universal extends InheritedWidget {
  const Universal({
    super.key,
    required this.data,
    required super.child,
  });

  final UniversalData data;

  static Universal? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Universal>();
  }

  static Universal of(BuildContext context) {
    final Universal? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Universal oldWidget) => data != oldWidget.data;
}

class UniversalData {
  final UniversalTextStyle textStyle;

  final UniversalIcons icons;

  UniversalData({required this.textStyle, required this.icons});
}

class UniversalStyleProvider extends StatelessWidget {
  final Widget child;

  const UniversalStyleProvider({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    var ia = Platform.isAndroid;
    var t = Theme.of(context);
    var ct = CupertinoTheme.of(context);
    var textStyle = UniversalTextStyle.fromTheme(ia, t, ct);
    var icons = UniversalIcons.fromTheme(ia, t, ct);

    return Universal(
      data: UniversalData(textStyle: textStyle, icons: icons),
      child: child,
    );
  }
}
