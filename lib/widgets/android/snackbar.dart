import 'package:flutter/material.dart';

SnackBar snackBar(String message, TextStyle bodyMedium, Color onInverseSurface, void Function()? onTap, String androidActionLabel, Duration duration) {
  return SnackBar(
    content: Text(
      message,
      style: bodyMedium.copyWith(
          color: onInverseSurface,
          height: 1.4,
          fontSize: 14,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400),
    ),
    action: onTap != null
        ? SnackBarAction(
      label: androidActionLabel,
      onPressed: onTap,
    )
        : null,
    duration: duration,
    behavior: SnackBarBehavior.floating,
  );
}