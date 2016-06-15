import AEXML

protocol BTResponseHandlerInterface {
    func handle(document: AEXMLDocument)
}

class ZikResponseHandler: BTResponseHandlerInterface {
    typealias function = AEXMLDocument -> Void
    var handlers = [String: function]()

    private var deviceState: DeviceState!

    init(deviceState: DeviceState) {
        self.deviceState = deviceState
        handlers[ParrotZikEndpoints.ApplicationVersion] = softwareVersion
        handlers[ParrotZikEndpoints.BatteryInfo] = batteryInfo
        handlers[ParrotZikEndpoints.NoiseCancellationStatus] = noiseCancellationStatus
        handlers[ParrotZikEndpoints.FriendlyName] = friendlyName
    }

    func handle(document: AEXMLDocument) {
        if let handle = handlers[document.root.attributes["path"]!] {
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName("refreshDataState", object: nil)
            handle(document)
        }
    }

    private func friendlyName (document: AEXMLDocument) {
        deviceState.name = document.root["bluetooth"].attributes["friendlyname"]!
    }

    private func softwareVersion(document: AEXMLDocument) {
        deviceState.version = document.root["software"].attributes["sip6"]!
    }

    private func batteryInfo(document: AEXMLDocument) {
        let batteryInfo = document.root["system"]["battery"]
        deviceState.batteryLevel = batteryInfo.attributes["percent"]!
        deviceState.batteryStatus = batteryInfo.attributes["state"]!
    }

    private func noiseCancellationStatus(document: AEXMLDocument) {
        let noiseCancellationInfo = document
            .root["audio"]["noise_cancellation"].attributes["enabled"]!
        deviceState.noiseCancellationEnabled = NSString(string: noiseCancellationInfo).boolValue
    }
}
