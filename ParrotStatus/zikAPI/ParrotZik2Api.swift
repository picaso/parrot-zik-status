import IOBluetooth

class ParrotZik2Api {
    private let get = ParrotRequestProtocols.getRequest
    private let set = ParrotRequestProtocols.setRequest
    typealias Request = [UInt8]

    private var _rfCommChannel: IOBluetoothRFCOMMChannel?

    var rfcommChannel: IOBluetoothRFCOMMChannel {
        get { return _rfCommChannel! }
        set { _rfCommChannel = newValue }
    }

    init() {}

    func getAsyncNoiseCancellationStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseCancellationStatus))
    }

    func toggleAsyncNoiseCancellation(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetNoiseCancellationStatus, args: arg))
    }

    func getAsyncNoiseControlStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseControltatus))
    }

    func getAsyncEqualizerStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.EqualizerStatus))
    }

    func toggleAsyncEqualizerStatus(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetEqualizerStatus, args: arg))
    }

    func getAsyncApplicationVersion() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.ApplicationVersion))
    }

    func getAsyncBatteryInfo() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.BatteryInfo))
    }

    func getAsyncFriendlyName() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.FriendlyName))
    }

    func sendRequest(request: String) -> Bool {
        return sendRequest(get(request))
    }

    func initializeDevice(rfCommChannel: IOBluetoothRFCOMMChannel) -> Bool {
        self._rfCommChannel = rfCommChannel
        return sendRequest(createInitMessage())
    }

    private func sendRequest(request: Request) -> Bool {
        let status = _rfCommChannel?
            .writeAsync(
                UnsafeMutablePointer(request),
                length: UInt16(request.count),
                refcon: nil
        )
        return status == kIOReturnSuccess
    }

    private func createInitMessage() -> Request {
        let message = [UInt8(0), UInt8(3), UInt8(0)]
        return message
    }

}
