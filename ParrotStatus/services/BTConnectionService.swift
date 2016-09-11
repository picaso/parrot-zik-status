import IOBluetooth

protocol BTConnectionServiceInterface {}

class BTConnectionService: BTConnectionServiceInterface {

    private let serviceName = "Parrot RFcomm service"

    private var communcationService: BTCommunicationServiceInterface!
    let notificationCenter = NSNotificationCenter.defaultCenter()

    init(service: BTCommunicationServiceInterface) {
        self.communcationService = service
        IOBluetoothDevice
            .registerForConnectNotifications(self, selector: #selector(connected))
    }

    private dynamic func connected(_: IOBluetoothUserNotification, fromDevice: IOBluetoothDevice) {
        if let deviceService = searchForBluetoothService(fromDevice) {
            fromDevice.registerForDisconnectNotification(
                self, selector: #selector(disconnected)
            )
            assert(openConnectionChannel(with: deviceService), "Error Opening connection")
            NSLog("\(fromDevice.name) is Open")
            notificationCenter.postNotificationName("connected", object: nil)
        }
    }

    private dynamic func disconnected(notification: IOBluetoothUserNotification,
        fromDevice device: IOBluetoothDevice) {

        NSLog("\(device.name) is Disonnected")
        notificationCenter.postNotificationName("disconnected", object: nil)
    }

    private func searchForBluetoothService(fromDevice: IOBluetoothDevice)
        -> IOBluetoothSDPServiceRecord? {
        guard let services = fromDevice.services as? [IOBluetoothSDPServiceRecord] else { return nil }

        return services.filter { service in filterByServiceNameFor({ service }())}
            .first
    }

    private func filterByServiceNameFor(serviceRecord: IOBluetoothSDPServiceRecord?) -> Bool {
        return serviceRecord?.getServiceName() == serviceName
    }

    private func openConnectionChannel(with deviceService: IOBluetoothSDPServiceRecord) -> Bool {
        var channelId: BluetoothRFCOMMChannelID = BluetoothRFCOMMChannelID()
        if deviceService.getRFCOMMChannelID(&channelId) == kIOReturnSuccess {
            NSLog("\(deviceService.device.name) is Connected")
            var rfcommChannel: IOBluetoothRFCOMMChannel? = nil
            deviceService
                .device
                .openRFCOMMChannelSync(&rfcommChannel,
                    withChannelID: channelId, delegate: communcationService as? AnyObject!)
            return true
        }
        NSLog("Error opening connection with Headset")
        return false
    }

}
