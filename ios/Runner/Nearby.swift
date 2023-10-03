import NearbyConnections
import UIKit
import Flutter

class Nearby {
    let connectionManager: ConnectionManager
    let advertiser: Advertiser
    var discoverer: Discoverer? = nil

    var isDiscovering: Bool = false;
    var isAdvertising: Bool = false
    var onEndpointFound: ((String, String) -> Void)? = nil
    var onEndpointLost: ((String) -> Void)? = nil

    init(serviceId: String) {
        connectionManager = ConnectionManager(serviceID: serviceId, strategy: .cluster)
        advertiser = Advertiser(connectionManager: connectionManager)
    }

    func startAdvertising(data: String) {
        if (isAdvertising) {
            stopAdvertising()
        }

        isAdvertising = true;
        advertiser.startAdvertising(using: data.data(using: .utf8)!)
    }

    func stopAdvertising() {
        if (isAdvertising) {
            advertiser.stopAdvertising();
            isAdvertising = false;
        }
    }

    func startDiscovery(onEndpointFound: @escaping (String, String) -> Void, onEndpointLost: @escaping (String) -> Void) {
        if (isDiscovering) {
            stopDiscovery();
        }

        isDiscovering = true;
        self.onEndpointFound = onEndpointFound;
        self.onEndpointLost = onEndpointLost;

        discoverer = Discoverer(connectionManager: connectionManager)
        discoverer?.delegate = self
        discoverer?.startDiscovery();
    }

    func stopDiscovery() {
        if (isDiscovering) {
            discoverer?.stopDiscovery();
            isDiscovering = false;
        }
    }
}

extension Nearby: AdvertiserDelegate, DiscovererDelegate, ConnectionManagerDelegate {
    func connectionManager(
        _ connectionManager: ConnectionManager, didReceive verificationCode: String,
        from endpointID: EndpointID, verificationHandler: @escaping (Bool) -> Void) {
        verificationHandler(false)
      }

      func connectionManager(
        _ connectionManager: ConnectionManager, didReceive data: Data,
        withID payloadID: PayloadID, from endpointID: EndpointID) {}

      func connectionManager(
        _ connectionManager: ConnectionManager, didReceive stream: InputStream,
        withID payloadID: PayloadID, from endpointID: EndpointID,
        cancellationToken token: CancellationToken) {
      }

      func connectionManager(
        _ connectionManager: ConnectionManager,
        didStartReceivingResourceWithID payloadID: PayloadID,
        from endpointID: EndpointID, at localURL: URL,
        withName name: String, cancellationToken token: CancellationToken) {
      }

      func connectionManager(
        _ connectionManager: ConnectionManager,
        didReceiveTransferUpdate update: TransferUpdate,
        from endpointID: EndpointID, forPayload payloadID: PayloadID) {
      }

    func connectionManager(
        _ connectionManager: ConnectionManager, didChangeTo state: ConnectionState,
        for endpointID: EndpointID) {
        switch state {
        case .connecting:
          break;
        case .connected:
            break;
        case .disconnected:
            break;
        case .rejected:
            break;
        }
      }

    func advertiser(
            _ advertiser: Advertiser, didReceiveConnectionRequestFrom endpointId: EndpointID,
            with context: Data, connectionRequestHandler: @escaping (Bool) -> Void) {
        // Accept or reject any incoming connection requests. The connection will still need to
        // be verified in the connection manager delegate.
        connectionRequestHandler(false)
    }

    func discoverer(
            _ discoverer: Discoverer, didFind endpointId: EndpointID, with context: Data) {
        onEndpointFound?(endpointId, String(decoding: context, as: UTF8.self))
    }

    func discoverer(_ discoverer: Discoverer, didLose endpointId: EndpointID) {
        onEndpointLost?(endpointId)
    }
}

class NearbyApiImplementation : NearbyApi {
    var _nearby: Nearby? = nil
    var _channel: FlutterMethodChannel
    var _messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger){
        _messenger = messenger
        _channel = FlutterMethodChannel(name: "nl.dylannas.chess/nearby", binaryMessenger: messenger)
    }
    
    private func onEndpointFound(endpointId: String, data: String) {
        _channel.invokeMethod("endpointFound", arguments: endpointId + "," + data)
    }
    
    private func onEndpointLost(endpointId: String) {
        _channel.invokeMethod("endpointLost", arguments: endpointId)
    }

    func initializeNearby(serviceId: String){
        _nearby?.stopAdvertising()
        _nearby?.stopDiscovery()
        _nearby = Nearby(serviceId: serviceId)
    }
    func startAdvertising(data: String){
        _nearby?.startAdvertising(data: data)
    }
    func stopAdvertising(){
        _nearby?.stopAdvertising()
    }
    func startDiscovery(data: String){
        _nearby?.startDiscovery(onEndpointFound: onEndpointFound, onEndpointLost: onEndpointLost)
    }
    func stopDiscovery(){
        _nearby?.stopDiscovery()
    }
}
