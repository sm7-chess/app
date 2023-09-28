import 'dart:io';

import 'package:d2chess/discovery/defs.dart';
import 'package:d2chess/discovery/nearby.dart';
import 'package:d2chess/widgets/theme_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

final endpointProvider =
    StateNotifierProvider<Endpoints, List<Endpoint>>((ref) {
  return Endpoints();
});

class Endpoints extends StateNotifier<List<Endpoint>> {
  Endpoints() : super([]);

  void add(Endpoint endpoint) {
    state.add(endpoint);
    state = state.followedBy([endpoint]).toList();
  }

  void remove(String endpointId) {
    state = state.where((x) => x.endpointId != endpointId).toList();
  }
}

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final endpointList = ref.watch(endpointProvider);
    final endpoints = ref.read(endpointProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformTextButton(
              onPressed: () async {
                await Permission.location.isGranted;
                await Permission.location.request();

                await Location.instance.requestService();

                bool granted = !(await Future.wait([
                  Permission.bluetooth.isGranted,
                  Permission.bluetoothAdvertise.isGranted,
                  Permission.bluetoothConnect.isGranted,
                  Permission.bluetoothScan.isGranted,
                  Permission.nearbyWifiDevices.isGranted,
                ]))
                    .any((element) => false);
                await [
                  Permission.bluetooth,
                  Permission.bluetoothAdvertise,
                  Permission.bluetoothConnect,
                  Permission.bluetoothScan,
                  Permission.nearbyWifiDevices
                ].request();
                PlatformNearby.instance
                    .init(Platform.isAndroid ? "Android stuff" : "iOS stuff");
              },
              child: const Text("Init"),
            ),
            PlatformTextButton(
              onPressed: () {
                PlatformNearby.instance.startAdvertising();
              },
              child: const Text("Start Advertising"),
            ),
            PlatformTextButton(
              onPressed: () {
                PlatformNearby.instance.startDiscovery(
                    onEndpointFound: endpoints.add,
                    onEndpointLost: endpoints.remove);
              },
              child: const Text("Start Listening"),
            ),
            const ThemeHuePicker(),
            ListView.builder(
                itemCount: endpointList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => PlatformListTile(
                    title: Text(endpointList[index].endpointName)))
          ],
        ),
      ),
    );
  }
}
