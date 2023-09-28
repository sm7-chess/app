import 'dart:developer' as developer;
import 'dart:io';

import 'package:d2chess/discovery/defs.dart';
import 'package:d2chess/pigeon.g.dart';
import 'package:flutter/services.dart';
import 'package:nearby_connections/nearby_connections.dart' as android_nearby;

class PlatformNearby {
  //Singleton pattern for maintaining only 1 instance of this class
  static final PlatformNearby instance = PlatformNearby();
  static android_nearby.Nearby? _androidInstance;
  static NearbyApi? _iosInstance;

  static String _nickName = "device";

  static const String _serviceType = "nl.dylannas.chess";

  static const MethodChannel _channel =
      MethodChannel("nl.dylannas.chess/nearby");

  OnEndpointFound? _onEndpointFound;
  OnEndpointLost? _onEndpointLost;

  PlatformNearby() {
    if (Platform.isAndroid) {
      _androidInstance ??= android_nearby.Nearby();
    } else {
      _iosInstance ??= NearbyApi();
      _channel.setMethodCallHandler((call) async {
        if (call.method == "endpointFound") {
          String endpointString = call.arguments;
          List<String> splitted = endpointString.split(',');
          if (splitted.length != 2) {
            splitted = [
              splitted[0],
              splitted.getRange(1, splitted.length).join(",")
            ];
          }

          String endpointId = splitted[0];
          String endpointName = splitted[1];
          _onEndpointFound?.call(
              Endpoint(endpointId: endpointId, endpointName: endpointName));
        } else if (call.method == "endpointLost") {
          _onEndpointLost?.call(call.arguments as String);
        } else {
          developer.log("Unknown method called via 'nl.dylannas.chess/nearby'");
        }
      });
    }
  }

  void init(String? nickName) {
    if (nickName == null) {
      _nickName = Platform.isAndroid ? "Android device" : "iOS device";
    } else {
      _nickName = nickName;
    }
    if (Platform.isIOS) {
      _iosInstance?.initializeNearby(_serviceType, _nickName);
    }
  }

  Future<bool> startAdvertising() async {
    if (Platform.isAndroid) {
      _androidInstance?.startAdvertising(
          _nickName, android_nearby.Strategy.P2P_CLUSTER,
          onConnectionInitiated: (endpointId, connectionInfo) {},
          onConnectionResult: (endpointId, status) {},
          onDisconnected: (endpointId) {},
          serviceId: _serviceType);
    } else {
      _iosInstance?.startAdvertising();
    }
    return true;
  }

  Future<void> stopAdvertising() async {
    if (Platform.isAndroid) {
      _androidInstance?.stopAdvertising();
    } else {
      _iosInstance?.stopAdvertising();
    }
  }

  Future<bool> startDiscovery(
      {required OnEndpointFound onEndpointFound,
      required OnEndpointLost onEndpointLost}) async {
    if (Platform.isAndroid) {
      _androidInstance?.startDiscovery(
          _nickName, android_nearby.Strategy.P2P_CLUSTER,
          onEndpointFound: (endpointId, endpointName, serviceId) {
            onEndpointFound(Endpoint(
              endpointId: endpointId,
              endpointName: endpointName,
            ));
          },
          onEndpointLost: (id) => onEndpointLost(id ?? ""),
          serviceId: _serviceType);
    } else {
      _iosInstance?.startDiscovery();
      _onEndpointFound = onEndpointFound;
      _onEndpointLost = onEndpointLost;
    }
    return true;
  }

  Future<void> stopDiscovery() async {
    if (Platform.isAndroid) {
      _androidInstance?.stopDiscovery();
    } else {
      _iosInstance?.stopDiscovery();
    }
  }

  void dispose() {
    stopDiscovery();
    stopAdvertising();
  }
}
