import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon.g.dart',
  dartOptions: DartOptions(),
  swiftOut: 'ios/Runner/Pigeon.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'd2chess',
))
@HostApi()
abstract class NearbyApi {
  void initializeNearby(String serviceId, String data);
  void startAdvertising();
  void stopAdvertising();
  void startDiscovery();
  void stopDiscovery();
}
