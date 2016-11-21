import IOBluetooth
import AEXML

protocol BTCommunicationServiceInterface {
    func getAsyncBatteryInfo() -> Bool
    func toggleAsyncNoiseCancellation(_ arg: Bool) -> Bool
    func toggleAsyncEqualizerStatus(_ arg: Bool) -> Bool
    func toggleAsyncConcertHall(_ arg: Bool) -> Bool
    func toggleAsyncHeadDetection(_ arg: Bool) -> Bool
    func toggleAsyncFlightMode(_ arg: Bool) -> Bool
    func setNoiseControlLevel(_ arg: NoiseControlState) -> Bool
}

class BTCommunicationService: BTCommunicationServiceInterface, IOBluetoothRFCOMMChannelDelegate {
    
    fileprivate let rfcommChannel: IOBluetoothRFCOMMChannel? = nil
    fileprivate let api: ParrotZik2Api!
    fileprivate let zikResponseHandler: BTResponseHandlerInterface!
    
    typealias function = (AEXMLDocument) -> Void
    fileprivate var handlers = [String: function]()
    fileprivate var getBatteryUpdateTimer: Timer?
    
    init(api: ParrotZik2Api, zikResponseHandler: BTResponseHandlerInterface) {
        self.api = api
        self.zikResponseHandler = zikResponseHandler
        
        handlers["answer"] = answerHandler
        handlers["notify"] = notificationHandler
    }
    
    @objc func rfcommChannelData(_ rfcommChannel: IOBluetoothRFCOMMChannel!,
                                 data dataPointer: UnsafeMutableRawPointer!,
                                 length dataLength: Int) {
        let message: Data = Data(bytes: UnsafeRawPointer(dataPointer), count: dataLength)
        
        if isCommunication(message: message) {
            let communication = extractResponsePackage(from: message as NSData)
            print(communication.package!.xml)
            if let handle = handlers[communication.type] {
                handle(communication.package!)
            }
        } else if isInitialization(message: message) {
            
            let _ = api.getAsyncApplicationVersion()
            let _ = api.getAsyncNoiseCancellationStatus()
            let _ = api.getAsyncBatteryInfo()
            let _ = api.getAsyncFriendlyName()
            let _ = api.getAsyncNoiseControlStatus()
            let _ = api.getAsyncEqualizerStatus()
            let _ = api.getAsyncFlightModeStatus()
            let _ = api.disableAsyncFlightMode()
            let _ = api.getAsyncConcertHallStatus()
            let _ = api.getAsyncheadDetectionStatus()
            let _ = api.getAsyncNoiseControlLevelStatus()
        }
    }
    
    @objc func rfcommChannelOpenComplete(_ rfcommChannel: IOBluetoothRFCOMMChannel!,
                                         status error: IOReturn) {
        NSLog("connection completed, Initializing...")
        let response = api.initializeDevice(rfcommChannel)
        assert(response, "Error Initializing bluetooth device")
        getBatteryUpdateTimer = Timer
            .scheduledTimer(
                timeInterval: 180.0,
                target: self,
                selector: #selector(getAsyncBatteryInfo),
                userInfo: nil,
                repeats: true)
        NSLog("\(rfcommChannel.getDevice().name) was successfully Initialized")
    }
    
    @objc func rfcommChannelClosed(_ rfcommChannel: IOBluetoothRFCOMMChannel!) {
        getBatteryUpdateTimer = nil
    }
    
    @objc func getAsyncBatteryInfo() -> Bool {
        return api.getAsyncBatteryInfo()
    }
    
    func toggleAsyncNoiseCancellation(_ arg: Bool) -> Bool {
        return api.toggleAsyncNoiseCancellation(arg) &&
            api.getAsyncNoiseCancellationStatus() &&
            api.getAsyncNoiseControlLevelStatus()
    }
    
    func toggleAsyncEqualizerStatus(_ arg: Bool) -> Bool {
        return api.toggleAsyncEqualizerStatus(arg) &&
            api.getAsyncEqualizerStatus()
    }
    
    func toggleAsyncConcertHall(_ arg: Bool) -> Bool {
        return api.toggleAsyncConcerHallStatus(arg) &&
            api.getAsyncConcertHallStatus()
    }
    
    func toggleAsyncHeadDetection(_ arg: Bool) -> Bool {
        return api.toggleAsyncHeadDetection(arg) &&
            api.getAsyncheadDetectionStatus()
    }
    
    func setNoiseControlLevel(_ arg: NoiseControlState) -> Bool {
        return api.setAsyncNoiseControlLevelStatus(arg.urlParameter()) &&
            api.getAsyncNoiseControlLevelStatus() &&
            api.getAsyncNoiseCancellationStatus()
    }
    
    func toggleAsyncFlightMode(_ arg: Bool) -> Bool {
        print(arg)
        return arg ? api.enableAsyncFlightMode() : api.disableAsyncFlightMode()
    }
    
    
    fileprivate func extractResponsePackage(from message: NSData)
        -> (type: String, package: AEXMLDocument?) {
            if message.length > 7 {
                let range = NSRange(location: 7, length: message.length - 7)
                let xmlData = message.subdata(with: range)
                if let data = try? AEXMLDocument(xml: xmlData) {
                    return (data.root.name, data)
                }
            }
            return ("error", nil)
    }
    
    fileprivate func isInitialization(message receivedMessage: Data) -> Bool {
        let message = [UInt8(0), UInt8(3), UInt8(2)]
        return receivedMessage == Data(bytes: UnsafeRawPointer(message), count: message.count)
    }
    
    fileprivate func isCommunication(message receivedMessage: Data) -> Bool {
        var messageLen: UInt16 = 0
        (receivedMessage as NSData).getBytes(&messageLen, range: NSRange(location: 0, length: 2))
        var magic: UInt8 = 0
        (receivedMessage as NSData).getBytes(&magic, range: NSRange(location: 2, length: 1))
        return String(magic) == "128"
    }
    
    fileprivate func notificationHandler(_ package: AEXMLDocument?) {
        if package != nil {
            assert(api.sendRequest(package!.root.attributes["path"]!))
        }
    }
    
    fileprivate func answerHandler(_ package: AEXMLDocument?) {
        if package != nil {
            zikResponseHandler.handle(package!)
        }
    }
    
    
    
}
