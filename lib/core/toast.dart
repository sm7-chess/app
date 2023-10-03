import 'dart:io';

import 'package:d2chess/core/haptics.dart';
import 'package:d2chess/universal/universal_style.dart';
import 'package:d2chess/widgets/android/snackbar.dart';
import 'package:d2chess/widgets/ios/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sf_symbols/sf_symbols.dart';

//Currently very specific to Location permission denied
void showPlatformToast(
  BuildContext context,
  String message, {
  String? iOSMessage,
  String? iOSSubtitle,
  String? iOSIcon,
  void Function()? onTap,
  void Function()? onDismissed,
  String androidActionLabel = "OK",
  Duration duration = const Duration(seconds: 2),
}) {
  if (Platform.isAndroid) {
    _showAndroidToast(
      context,
      message,
      onTap,
      androidActionLabel,
      onDismissed,
      duration,
    );
  } else {
    _showIOSToast(
      iOSMessage,
      message,
      iOSSubtitle,
      iOSIcon,
      onTap,
      onDismissed,
      duration,
    );
  }

  CustomHaptics.hapticError(context.findRenderObject());
}

void _showIOSToast(
  String? iOSMessage,
  String message,
  String? iOSSubtitle,
  String? iOSIcon,
  void Function()? onTap,
  void Function()? onDismissed,
  Duration duration,
) {
  showToastWidget(
    IOSToast(
      iOSMessage: iOSMessage ?? message,
      iOSSubtitle: iOSSubtitle,
      iconName: iOSIcon,
    ),
    animationCurve: Curves.easeInOutCubic,
    position: ToastPosition.top.copyWith(offset: ToastPosition.top.offset - 35),
    handleTouch: true,
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 450),
    animationBuilder: (context, widget, animationController, value) {
      return Opacity(
        opacity: 0 + 1 * value,
        child: Transform.translate(
          offset: Offset(0, -100 + 100 * value),
          filterQuality: FilterQuality.high,
          child: widget,
        ),
      );
    },
  );
}

void _showAndroidToast(
  BuildContext context,
  String message,
  void Function()? onTap,
  String androidActionLabel,
  void Function()? onDismissed,
  Duration duration,
) {
  var onInverseSurface = Theme.of(context).colorScheme.onInverseSurface;
  var bodyMedium = Universal.of(context).data.textStyle.bodyMedium;
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar(message, bodyMedium, onInverseSurface, onTap, androidActionLabel, duration))
      .closed
      .then((reason) {
    if (reason == SnackBarClosedReason.swipe ||
        reason == SnackBarClosedReason.dismiss) {
      onDismissed?.call();
    }
  });
}