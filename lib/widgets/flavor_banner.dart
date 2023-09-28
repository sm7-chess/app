import 'package:d2chess/flavors.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({super.key, required this.show, required this.child});

  final bool show;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            child: child,
          )
        : child;
  }
}
