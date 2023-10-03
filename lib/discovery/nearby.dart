import 'dart:developer' as developer;
import 'dart:io';

import 'package:d2chess/discovery/defs.dart';
import 'package:d2chess/pigeon.g.dart';
import 'package:flutter/services.dart';
import 'package:nearby_connections/nearby_connections.dart' as android_nearby;

class PlatformNearby {
  static PlatformNearby? _staticInstance;

  static PlatformNearby? _self;

  PlatformNearby._() {
    _staticInstance = Platform.isAndroid ? AndroidNearby() : IOSNearby();
  }

  factory PlatformNearby() {
    return _self ?? PlatformNearby._();
  }

  Future<bool> startAdvertising(NearbyClientIdentifier identifier) async {
    return await _staticInstance?.startAdvertising(identifier) ?? false;
  }

  Future<void> stopAdvertising() async {
    await _staticInstance?.stopAdvertising();
  }

  Future<bool> startDiscovery(NearbyClientIdentifier identifier,
      {required OnEndpointFound onEndpointFound,
      required OnEndpointLost onEndpointLost}) async {
    return await _staticInstance?.startDiscovery(identifier,
            onEndpointFound: onEndpointFound, onEndpointLost: onEndpointLost) ??
        false;
  }

  Future<void> stopDiscovery() async {
    await _staticInstance?.stopDiscovery();
  }

  void dispose() {
    _staticInstance?.dispose();
  }
}

class AndroidNearby implements PlatformNearby {
  android_nearby.Nearby? _instance;
  static AndroidNearby? _staticInstance;
  static const String _serviceType = "nl.dylannas.chess";

  AndroidNearby._() {
    _instance = android_nearby.Nearby();
  }

  factory AndroidNearby() {
    return _staticInstance ?? AndroidNearby._();
  }

  @override
  Future<bool> startAdvertising(NearbyClientIdentifier identifier) async {
    return await _instance?.startAdvertising(
            identifier.toString(), android_nearby.Strategy.P2P_CLUSTER,
            onConnectionInitiated: (endpointId, connectionInfo) {},
            onConnectionResult: (endpointId, status) {},
            onDisconnected: (endpointId) {},
            serviceId: _serviceType) ??
        false;
  }

  @override
  Future<void> stopAdvertising() async {
    _instance?.stopAdvertising();
  }

  @override
  Future<bool> startDiscovery(NearbyClientIdentifier identifier,
      {required OnEndpointFound onEndpointFound,
      required OnEndpointLost onEndpointLost}) async {
    _instance?.startDiscovery(
        identifier.toString(), android_nearby.Strategy.P2P_CLUSTER,
        onEndpointFound: (endpointId, endpointName, serviceId) {
          onEndpointFound(Endpoint(
            endpointId: endpointId,
            endpointName: endpointName,
          ));
        },
        onEndpointLost: (id) => onEndpointLost(id ?? ""),
        serviceId: _serviceType);

    return true;
  }

  @override
  Future<void> stopDiscovery() async {
    _instance?.stopDiscovery();
  }

  @override
  void dispose() {
    stopDiscovery();
    stopAdvertising();
  }
}

class IOSNearby implements PlatformNearby {
  static NearbyApi? _iosInstance;
  static const String _serviceType = "nl.dylannas.chess";

  static const MethodChannel _channel =
      MethodChannel("nl.dylannas.chess/nearby");

  OnEndpointFound? _onEndpointFound;
  OnEndpointLost? _onEndpointLost;

  IOSNearby() {
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
    _iosInstance?.initializeNearby(_serviceType);
  }

  @override
  void dispose() {
    stopDiscovery();
    stopAdvertising();
  }

  @override
  Future<bool> startAdvertising(NearbyClientIdentifier identifier) async {
    await _iosInstance?.startAdvertising(identifier.toString());
    return true;
  }

  @override
  Future<bool> startDiscovery(NearbyClientIdentifier identifier,
      {required OnEndpointFound onEndpointFound,
      required OnEndpointLost onEndpointLost}) async {
    await _iosInstance?.startDiscovery(identifier.toString());
    _onEndpointFound = onEndpointFound;
    _onEndpointLost = onEndpointLost;
    return true;
  }

  @override
  Future<void> stopAdvertising() async {
    await _iosInstance?.stopAdvertising();
  }

  @override
  Future<void> stopDiscovery() async {
    _iosInstance?.stopDiscovery();
  }
}
