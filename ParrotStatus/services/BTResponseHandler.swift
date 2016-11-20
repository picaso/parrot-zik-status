import AEXML
import Darwin

protocol BTResponseHandlerInterface {
    func handle(_ document: AEXMLDocument)
}

class ZikResponseHandler: BTResponseHandlerInterface {
    typealias function = (AEXMLDocument) -> Void
    var handlers = [String: function]()

    fileprivate var deviceState: DeviceState!
    init() {}
    init(deviceState: DeviceState) {
        self.deviceState = deviceState
        handlers[ParrotZikEndpoints.ApplicationVersion] = softwareVersion
        handlers[ParrotZikEndpoints.BatteryInfo] = batteryInfo
        handlers[ParrotZikEndpoints.NoiseCancellationStatus] = noiseCancellationStatus
        handlers[ParrotZikEndpoints.FriendlyName] = friendlyName
        handlers[ParrotZikEndpoints.NoiseControltatus] = noiseControlStatus
        handlers[ParrotZikEndpoints.EqualizerStatus] = equalizerStatus
        handlers[ParrotZikEndpoints.ConcertHallStatus] = concertHallStatus
        handlers[ParrotZikEndpoints.HeadDetectionStatus] = headDetectionStatus
        handlers[ParrotZikEndpoints.FlightModeStatus] = flightModeStatus
        handlers[ParrotZikEndpoints.FlightModeEnable] = exitParrot
        handlers[ParrotZikEndpoints.NoiseControlLevelStatus] = noiseControlLevelStatus
    }

    func handle(_ document: AEXMLDocument) {
        if let handle = handlers[document.root.attributes["path"]!] {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Foundation.Notification.Name(rawValue: "refreshDataState"), object: nil)
            handle(document)
        }
    }

    fileprivate func friendlyName(_ document: AEXMLDocument) {
        deviceState.name = document.root["bluetooth"].attributes["friendlyname"]!
    }

    fileprivate func softwareVersion(_ document: AEXMLDocument) {
        deviceState.version = document.root["software"].attributes["sip6"]!
    }

    fileprivate func batteryInfo(_ document: AEXMLDocument) {
        let batteryInfo = document.root["system"]["battery"]
        deviceState.batteryLevel = batteryInfo.attributes["percent"]!
        deviceState.batteryStatus = batteryInfo.attributes["state"]!
    }

    fileprivate func noiseCancellationStatus(_ document: AEXMLDocument) {
        let noiseCancellationInfo = document
            .root["audio"]["noise_cancellation"].attributes["enabled"]!
        deviceState.noiseCancellationEnabled = NSString(string: noiseCancellationInfo).boolValue
    }

    fileprivate func noiseControlStatus(_ document: AEXMLDocument) {
        let noiseControlStatus = document
            .root["audio"]["noise_control"].attributes["enabled"]!
        deviceState.noiseControlEnabled = NSString(string: noiseControlStatus).boolValue
    }

    fileprivate func equalizerStatus(_ document: AEXMLDocument) {
        let equalizerStatus = document
            .root["audio"]["equalizer"].attributes["enabled"]!
        deviceState.equalizerEnabled = NSString(string: equalizerStatus).boolValue
    }

    fileprivate func concertHallStatus(_ document: AEXMLDocument) {
        let concertHallStatus = document
            .root["audio"]["sound_effect"].attributes["enabled"]!
        deviceState.concertHallEnabled = NSString(string: concertHallStatus).boolValue
    }

    fileprivate func headDetectionStatus(_ document: AEXMLDocument) {
        let headDetectionStatus = document
            .root["system"]["head_detection"].attributes["enabled"]!
        deviceState.headDetectionEnabled = NSString(string: headDetectionStatus).boolValue
    }

    fileprivate func noiseControlLevelStatus(_ document: AEXMLDocument) {
        let level = document
            .root["audio"]["noise_control"].attributes["value"]!
        let mode = document
            .root["audio"]["noise_control"].attributes["type"]!
        deviceState.noiseControlLevelState = NoiseControlState(level: Int(level)!, mode: mode)

    }

    fileprivate func exitParrot(_ document: AEXMLDocument) {
        exit(0)
    }

    fileprivate func flightModeStatus(_ document: AEXMLDocument) {
        let flightModeStatus = document
            .root["flight_mode"].attributes["enabled"]!
        deviceState.flightModeEnabled = NSString(string: flightModeStatus).boolValue
    }

}
