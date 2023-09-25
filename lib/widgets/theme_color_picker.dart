import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeHueProvider = StateNotifierProvider<ThemeHueState, Color>((ref) {
  return ThemeHueState();
});

class ThemeHueState extends StateNotifier<Color> {
  ThemeHueState() : super(const Color(0xffff0000));

  void setColor(Color color) => state = color;
}

final internalColorProvider =
    StateNotifierProvider<ThemeHueState, Color>((ref) {
  return ThemeHueState();
});

List<Color> hueColors = <Color>[
  HSVColor.fromColor(const Color(0xffff0000)).withHue(0.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(60.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(120.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(180.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(240.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(300.0).toColor(),
  HSVColor.fromColor(const Color(0xffff0000)).withHue(0.0).toColor()
];

class ThemeHuePicker extends ConsumerWidget {
  const ThemeHuePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final color = ref.watch(themeHueProvider);
    final colorProviderRef = ref.read(themeHueProvider.notifier);

    final internalColor = ref.watch(internalColorProvider);
    final internalColorProviderRef = ref.read(internalColorProvider.notifier);

    return SliderPicker(
      max: 360.0,
      height: 40,
      colors: hueColors,
      value: HSVColor.fromColor(internalColor).hue,
      onChanged: (hue) {
        internalColorProviderRef
            .setColor(HSVColor.fromColor(color).withHue(hue).toColor());

        //Putting this in a future prevents UI lock-up (it's still bad performance though)
        Future.delayed(Duration.zero, () {
          colorProviderRef
              .setColor(HSVColor.fromColor(color).withHue(hue).toColor());
        });
      },
    );
  }
}
