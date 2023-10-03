import 'package:json_annotation/json_annotation.dart';

part "defs.g.dart";

typedef OnEndpointFound = void Function(Endpoint endpoint);
typedef OnEndpointLost = void Function(String endpointId);

class Endpoint {
  final String endpointId;
  final String endpointName;

  Endpoint({required this.endpointId, required this.endpointName});
}

@JsonSerializable()
class NearbyClientIdentifier {
  final String nickName;
  final String id;

  NearbyClientIdentifier({required this.nickName, required this.id});

  factory NearbyClientIdentifier.fromJson(Map<String, dynamic> json) =>
      _$NearbyClientIdentifierFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NearbyClientIdentifierToJson(this);

  @override
  String toString() => toJson().toString();
}
