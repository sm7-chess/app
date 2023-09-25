//
//
// Discovery lifecycle callbacks
//
typedef OnEndpointFound = void Function(Endpoint endpoint);
typedef OnEndpointLost = void Function(String endpointId);

class Endpoint {
  final String endpointId;
  final String endpointName;

  Endpoint({required this.endpointId, required this.endpointName});
}
