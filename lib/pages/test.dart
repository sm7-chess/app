import 'dart:developer' as developer;

import 'package:d2chess/discovery/defs.dart';
import 'package:d2chess/discovery/nearby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

final endpointProvider =
    StateNotifierProvider<Endpoints, List<Endpoint>>((ref) {
  return Endpoints();
});

class Endpoints extends StateNotifier<List<Endpoint>> {
  Endpoints() : super([]);

  void add(Endpoint endpoint) {
    state.removeWhere((element) => element.endpointId == endpoint.endpointId);
    state.add(endpoint);
    state = state.followedBy([endpoint]).toList();
    developer.log("${endpoint.endpointName}:${endpoint.endpointId}");
  }

  void remove(String endpointId) {
    state = state.where((x) => x.endpointId != endpointId).toList();

    developer.log(endpointId);
  }
}

final uniqueUuid = const Uuid().v4();

class TestPage extends ConsumerStatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  bool isInitialized = false;
  bool isDiscovering = false;
  String? nickname = "Default";

  @override
  void dispose() {
    super.dispose();

    PlatformNearby().dispose();
  }

  Future<void> requestLocationPermission() async {
    if (await Permission.location.isPermanentlyDenied) {
      if (!await openAppSettings()) {}
      return;
    }

    await Permission.location.isGranted;
    await Permission.location.request();
    await Location.instance.requestService();
  }

  Future<void> requestNearbyDevicesPermission() async {
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
  }

  Future<void> initialize() async {
    await requestLocationPermission();

    await requestNearbyDevicesPermission();
    PlatformNearby();
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final endpointList = ref.watch(endpointProvider);
    final endpoints = ref.read(endpointProvider.notifier);
    final identifier = NearbyClientIdentifier(
      nickName: nickname ?? "Default nickname",
      id: uniqueUuid,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformTextField(
              hintText: "Nickname",
              textCapitalization: TextCapitalization.sentences,
              onChanged: (newValue) {
                setState(() {
                  nickname = newValue;
                });
              },
            ),
            PlatformTextButton(
              onPressed: () async {
                if (isInitialized) {
                  return;
                }

                await initialize();

                PlatformNearby().startAdvertising(identifier);
              },
              child: const Text("Start Nearby Connections"),
            ),
            PlatformTextButton(
              onPressed: () async {
                if (!isInitialized) {
                  await initialize();
                }

                if (isDiscovering) {
                  return;
                }

                PlatformNearby().startDiscovery(
                  identifier,
                  onEndpointFound: endpoints.add,
                  onEndpointLost: endpoints.remove,
                );
              },
              child: Text(isDiscovering ? 'Stop' : 'Start' " Discovery"),
            ),
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
