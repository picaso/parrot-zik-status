import IOBluetooth

protocol BTConnectionServiceInterface {}

class BTConnectionService: BTConnectionServiceInterface {

    fileprivate let serviceName = "Parrot RFcomm service"

    fileprivate var communcationService: BTCommunicationServiceInterface!
    let notificationCenter = NotificationCenter.default

    init(service: BTCommunicationServiceInterface) {
        self.communcationService = service
        IOBluetoothDevice
            .register(forConnectNotifications: self, selector: #selector(connected))
    }

    fileprivate dynamic func connected(_: IOBluetoothUserNotification, fromDevice: IOBluetoothDevice) {
        if let deviceService = searchForBluetoothService(fromDevice) {
            fromDevice.register(
                forDisconnectNotification: self, selector: #selector(disconnected)
            )
            assert(openConnectionChannel(with: deviceService), "Error Opening connection")
            NSLog("\(fromDevice.name) is Open")
            notificationCenter.post(name: Foundation.Notification.Name(rawValue: "connected"), object: nil)
        }
    }

    fileprivate dynamic func disconnected(_ notification: IOBluetoothUserNotification,
        fromDevice device: IOBluetoothDevice) {

        NSLog("\(device.name) is Disonnected")
        notificationCenter.post(name: Foundation.Notification.Name(rawValue: "disconnected"), object: nil)
    }

    fileprivate func searchForBluetoothService(_ fromDevice: IOBluetoothDevice)
        -> IOBluetoothSDPServiceRecord? {
        guard let services = fromDevice.services as? [IOBluetoothSDPServiceRecord] else { return nil }

        return services.filter { service in filterByServiceNameFor({ service }())}
            .first
    }

    fileprivate func filterByServiceNameFor(_ serviceRecord: IOBluetoothSDPServiceRecord?) -> Bool {
        return serviceRecord?.getServiceName() == serviceName
    }

    fileprivate func openConnectionChannel(with deviceService: IOBluetoothSDPServiceRecord) -> Bool {
        var channelId: BluetoothRFCOMMChannelID = BluetoothRFCOMMChannelID()
        if deviceService.getRFCOMMChannelID(&channelId) == kIOReturnSuccess {
            NSLog("\(deviceService.device.name) is Connected")
            var rfcommChannel: IOBluetoothRFCOMMChannel? = nil
            deviceService
                .device
                .openRFCOMMChannelSync(&rfcommChannel,
                    withChannelID: channelId, delegate: communcationService)
            return true
        }
        NSLog("Error opening connection with Headset")
        return false
    }

}
