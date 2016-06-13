import IOBluetooth
import AEXML
protocol BTCommunicationServiceInterface {}

class BTCommunicationService: BTCommunicationServiceInterface, IOBluetoothRFCOMMChannelDelegate {

    private let rfcommChannel: IOBluetoothRFCOMMChannel? = nil
    private let api: ParrotZik2Api!
    private let zikResponseHandler: BTResponseHandlerInterface!

    typealias function = AEXMLDocument -> Void
    private var handlers = [String: function]()

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

            if communication(message: message) {
                let communication = extractResponsePackage(from: message)
                if let handle = handlers[communication.type] {
                    handle(communication.package!)
                }
            } else if initialization(message: message) {

                api.getAsyncApplicationVersion()
                api.getAsyncNoiseCancellationStatus()
                api.getAsyncBatteryInfo()
            }
    }

     @objc func rfcommChannelOpenComplete(rfcommChannel: IOBluetoothRFCOMMChannel!,
        status error: IOReturn) {
            NSLog("connection completed, Initializing...")
            let response = api.initializeDevice(rfcommChannel)
            assert(response, "Error Initializing bluetooth device")
            NSLog("\(rfcommChannel.getDevice().name) was successfully Initialized")
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

    private func initialization(message receivedMessage: NSData) -> Bool {
        var message = [UInt8(0), UInt8(3), UInt8(2)]
        return receivedMessage == NSData(bytes: &message, length: message.count)
    }

    private func communication(message receivedMessage: NSData) -> Bool {
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
