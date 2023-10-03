import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class CustomHaptics {
  static Future<void> hapticError(RenderObject? renderObject) async {
    if (Platform.isAndroid) {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      renderObject?.sendSemanticsEvent(const LongPressSemanticsEvent());
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.heavyImpact();
    } else {
      await Haptics.vibrate(HapticsType.error);
    }
  }
}
