import 'dart:io';

import 'package:d2chess/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalStyle extends InheritedWidget {
  const UniversalStyle({
    super.key,
    required this.styles,
    required super.child,
  });

  final UniversalStyleData styles;

  static UniversalStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UniversalStyle>();
  }

  static UniversalStyle of(BuildContext context) {
    final UniversalStyle? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UniversalStyle oldWidget) =>
      styles != oldWidget.styles;
}

class UniversalStyleData {
  final UniversalTextStyle textStyle;

  UniversalStyleData({required this.textStyle});
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

    return UniversalStyle(
      styles: UniversalStyleData(textStyle: textStyle),
      child: child,
    );
  }
}
