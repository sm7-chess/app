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
  void initializeNearby(String serviceId);
  void startAdvertising(String data);
  void stopAdvertising();
  void startDiscovery(String data);
  void stopDiscovery();
}
