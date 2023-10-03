import 'package:flutter/cupertino.dart';
import 'package:sf_symbols/sf_symbols.dart';

class IOSToast extends StatelessWidget {
  const IOSToast({
    super.key,
    required this.iOSMessage,
    required this.iOSSubtitle,
    required this.iconName,
  });

  final String iOSMessage;
  final String? iOSSubtitle;
  final String? iconName;

  @override
  Widget build(BuildContext context) {
    var stackChildren = <Widget>[];

    if (iconName != null) {
      stackChildren.add(
        Positioned(
          left: 12,
          top: 0,
          bottom: 0,
          child: Column(
            children: [
              const Spacer(),
              SfSymbol(
                name: iconName!,
                color: CupertinoTheme.of(context)
                    .textTheme
                    .textStyle
                    .color!
                    .withOpacity(0.55),
                size: 20,
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    }

    stackChildren.add(
      Container(
        constraints: const BoxConstraints(minWidth: 195.0, minHeight: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 9),
        child: Align(
          alignment: Alignment.center,
          widthFactor: 1,
          heightFactor: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    iOSMessage,
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .textStyle
                        .copyWith(
                        fontSize: 13,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.bold,
                        color: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .color!
                            .withOpacity(0.55)),
                  ),
                  Text(
                    iOSSubtitle ?? "",
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .textStyle
                        .copyWith(
                        fontSize: 13,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.bold,
                        color: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .color!
                            .withOpacity(0.3)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: GestureDetector(
        child: CupertinoUserInterfaceLevel(
          data: CupertinoUserInterfaceLevelData.elevated,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 195.0,
              minHeight: 50.0,
            ),
            decoration: BoxDecoration(
              color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                  ? const Color.fromRGBO(37, 35, 35, 1.0)
                  : const Color.fromRGBO(243, 238, 238, 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.2),
                  spreadRadius: 9,
                  blurRadius: 15,
                  offset: const Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: stackChildren,
            ),
          ),
        ),
      ),
    );
  }
}