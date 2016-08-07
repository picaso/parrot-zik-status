import IOBluetooth
import AEXML

protocol BTCommunicationServiceInterface {
    func getAsyncBatteryInfo() -> Bool
    func toggleAsyncNoiseCancellation(arg: Bool) -> Bool
    func toggleAsyncEqualizerStatus(arg: Bool) -> Bool
    func toggleAsyncConcertHall(arg: Bool) -> Bool
    func toggleAsyncHeadDetection(arg: Bool) -> Bool
    func toggleAsyncFlightMode(arg: Bool) -> Bool
    func setNoiseControlLevel(arg: NoiseControlState) -> Bool
}

class BTCommunicationService: BTCommunicationServiceInterface, IOBluetoothRFCOMMChannelDelegate {

    private let rfcommChannel: IOBluetoothRFCOMMChannel? = nil
    private let api: ParrotZik2Api!
    private let zikResponseHandler: BTResponseHandlerInterface!

    typealias function = AEXMLDocument -> Void
    private var handlers = [String: function]()
    private var getBatteryUpdateTimer: NSTimer?

    init(api: ParrotZik2Api, zikResponseHandler: BTResponseHandlerInterface) {
        self.api = api
        self.zikResponseHandler = zikResponseHandler

        handlers["answer"] = answerHandler
        handlers["notify"] = notificationHandler
    }

    @objc func rfcommChannelData(rfcommChannel: IOBluetoothRFCOMMChannel!,
        data dataPointer: UnsafeMutablePointer<Void>,
        length dataLength: Int) {
            let message: NSData = NSData(bytes: dataPointer, length: dataLength)

            if isCommunication(message: message) {
                let communication = extractResponsePackage(from: message)
                print(communication.package!.xmlString)
                if let handle = handlers[communication.type] {
                    handle(communication.package!)
                }
            } else if isInitialization(message: message) {

                api.getAsyncApplicationVersion()
                api.getAsyncNoiseCancellationStatus()
                api.getAsyncBatteryInfo()
                api.getAsyncFriendlyName()
                api.getAsyncNoiseControlStatus()
                api.getAsyncEqualizerStatus()
                api.getAsyncFlightModeStatus()
                api.disableAsyncFlightMode()
                api.getAsyncConcertHallStatus()
                api.getAsyncheadDetectionStatus()
                api.getAsyncNoiseControlLevelStatus()
            }
    }

     @objc func rfcommChannelOpenComplete(rfcommChannel: IOBluetoothRFCOMMChannel!,
        status error: IOReturn) {
            NSLog("connection completed, Initializing...")
            let response = api.initializeDevice(rfcommChannel)
            assert(response, "Error Initializing bluetooth device")
            getBatteryUpdateTimer = NSTimer
                .scheduledTimerWithTimeInterval(
                    180.0,
                    target: self,
                    selector: #selector(getAsyncBatteryInfo),
                    userInfo: nil,
                    repeats: true)
            NSLog("\(rfcommChannel.getDevice().name) was successfully Initialized")
    }

    @objc func rfcommChannelClosed(rfcommChannel: IOBluetoothRFCOMMChannel!) {
        getBatteryUpdateTimer = nil
    }

    @objc func getAsyncBatteryInfo() -> Bool {
        return api.getAsyncBatteryInfo()
    }

    func toggleAsyncNoiseCancellation(arg: Bool) -> Bool {
        return api.toggleAsyncNoiseCancellation(arg) &&
            api.getAsyncNoiseCancellationStatus() &&
            api.getAsyncNoiseControlLevelStatus()
    }

    func toggleAsyncEqualizerStatus(arg: Bool) -> Bool {
        return api.toggleAsyncEqualizerStatus(arg) &&
            api.getAsyncEqualizerStatus()
    }

    func toggleAsyncConcertHall(arg: Bool) -> Bool {
        return api.toggleAsyncConcerHallStatus(arg) &&
            api.getAsyncConcertHallStatus()
    }

    func toggleAsyncHeadDetection(arg: Bool) -> Bool {
        return api.toggleAsyncHeadDetection(arg) &&
            api.getAsyncheadDetectionStatus()
    }

    func setNoiseControlLevel(arg: NoiseControlState) -> Bool {
        return api.setAsyncNoiseControlLevelStatus(arg.urlParameter()) &&
            api.getAsyncNoiseControlLevelStatus() &&
            api.getAsyncNoiseCancellationStatus()
    }

    func toggleAsyncFlightMode(arg: Bool) -> Bool {
        print(arg)
        return arg ? api.enableAsyncFlightMode() : api.disableAsyncFlightMode()
    }


    private func extractResponsePackage(from message: NSData)
        -> (type: String, package: AEXMLDocument?) {
            if message.length > 7 {
                let range = NSRange(location: 7, length: message.length - 7)
                let xmlData = message.subdataWithRange(range)
                if let data = try? AEXMLDocument(xmlData: xmlData) {
                    return (data.root.name, data)
                }
            }
            return ("error", nil)
    }

    private func isInitialization(message receivedMessage: NSData) -> Bool {
        var message = [UInt8(0), UInt8(3), UInt8(2)]
        return receivedMessage == NSData(bytes: &message, length: message.count)
    }

    private func isCommunication(message receivedMessage: NSData) -> Bool {
        var messageLen: UInt16 = 0
        receivedMessage.getBytes(&messageLen, range: NSRange(location: 0, length: 2))
        var magic: UInt8 = 0
        receivedMessage.getBytes(&magic, range: NSRange(location: 2, length: 1))
        return String(magic) == "128"
    }

    private func notificationHandler(package: AEXMLDocument?) {
        if package != nil {
           api.sendRequest(package!.root.attributes["path"]!)
        }
    }

    private func answerHandler(package: AEXMLDocument?) {
        if package != nil {
             zikResponseHandler.handle(package!)
        }
    }



}
