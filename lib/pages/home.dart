import 'package:d2chess/style/universal_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final count = ref.watch(counterProvider);
    final counter = ref.read(counterProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Count $count',
                  style:
                      UniversalStyle.of(context).styles.textStyle.headlineLarge,
                ),
                const Spacer()
              ],
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce luctus a massa quis pulvinar. Aliquam eu ligula aliquam, mattis nisi id, porttitor sapien. Aliquam vel sem lectus. Phasellus interdum urna augue, in maximus tellus blandit eu. In ultrices tellus et gravida convallis. Cras aliquet, ante in imperdiet suscipit, est tortor iaculis arcu.',
              style: UniversalStyle.of(context).styles.textStyle.bodyLarge,
            ),
            Row(
              children: [
                Text(
                  'Count $count',
                  style: UniversalStyle.of(context)
                      .styles
                      .textStyle
                      .headlineMedium,
                ),
                const Spacer()
              ],
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce luctus a massa quis pulvinar. Aliquam eu ligula aliquam, mattis nisi id, porttitor sapien. Aliquam vel sem lectus. Phasellus interdum urna augue, in maximus tellus blandit eu. In ultrices tellus et gravida convallis. Cras aliquet, ante in imperdiet suscipit, est tortor iaculis arcu.',
              style: UniversalStyle.of(context).styles.textStyle.bodyMedium,
            ),
            Row(
              children: [
                Text(
                  'Count $count',
                  style:
                      UniversalStyle.of(context).styles.textStyle.headlineSmall,
                ),
                const Spacer()
              ],
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce luctus a massa quis pulvinar. Aliquam eu ligula aliquam, mattis nisi id, porttitor sapien. Aliquam vel sem lectus. Phasellus interdum urna augue, in maximus tellus blandit eu. In ultrices tellus et gravida convallis. Cras aliquet, ante in imperdiet suscipit, est tortor iaculis arcu.',
              style: UniversalStyle.of(context).styles.textStyle.bodySmall,
            ),
            Text(
              'Count $count',
              style: UniversalStyle.of(context).styles.textStyle.displayLarge,
            ),
            Text(
              'Count $count',
              style: UniversalStyle.of(context).styles.textStyle.displayMedium,
            ),
            Text(
              'Count $count',
              style: UniversalStyle.of(context).styles.textStyle.displaySmall,
            ),
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).add, size: 32),
              onPressed: counter.increment,
              material: (context, target) => MaterialIconButtonData(
                enableFeedback: true,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
