import IOBluetooth

class ParrotZik2Api {

    private let get = ParrotRequestProtocols.getRequest
    private let set: (String, Bool) -> ZikRequest = ParrotRequestProtocols.setRequest
    private let setString: (String, String) -> [UInt8] = ParrotRequestProtocols.setRequest

    private var apiRfCommChannel: IOBluetoothRFCOMMChannel?

    // MARK: Properties
    var rfcommChannel: IOBluetoothRFCOMMChannel {
        get {
            return apiRfCommChannel!
        }
        set {
            apiRfCommChannel = newValue
        }
    }

    init() {}

    // MARK: Audio properties
    func getAsyncNoiseCancellationStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseCancellationStatus))
    }

    func toggleAsyncNoiseCancellation(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetNoiseCancellationStatus, arg))
    }

    func getAsyncNoiseControlStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseControltatus))
    }

    func getAsyncEqualizerStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.EqualizerStatus))
    }

    func toggleAsyncEqualizerStatus(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetEqualizerStatus, arg))
    }

    func getAsyncConcertHallStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.ConcertHallStatus))
    }

    func toggleAsyncConcerHallStatus(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetConcertHallStatus, arg))
    }

    func getAsyncNoiseControlLevelStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseControlLevelStatus))
    }

    func setAsyncNoiseControlLevelStatus(arg: String) -> Bool {
        return sendRequest(setString(ParrotZikEndpoints.SetNoiseControlLevelStatus, arg))
    }



    // MARK: Non Audo properties
    func getAsyncFlightModeStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.FlightModeStatus))
    }

    func enableAsyncFlightMode() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.FlightModeEnable))
    }

    func disableAsyncFlightMode() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.FlightModeDisable))
    }

    func getAsyncheadDetectionStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.HeadDetectionStatus))
    }

    func toggleAsyncHeadDetection(arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetHeadModeDetectionStatus, arg))
    }



    // MARK: Read Only Zik properties
    func getAsyncApplicationVersion() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.ApplicationVersion))
    }

    func getAsyncBatteryInfo() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.BatteryInfo))
    }

    func getAsyncFriendlyName() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.FriendlyName))
    }

    // MARK: Helper Functions
    func sendRequest(request: String) -> Bool {
        return sendRequest(get(request))
    }

    func initializeDevice(rfCommChannel: IOBluetoothRFCOMMChannel) -> Bool {
        self.apiRfCommChannel = rfCommChannel
        return sendRequest(createInitMessage())
    }

    private func sendRequest(request: ZikRequest) -> Bool {
        let status = apiRfCommChannel?
            .writeAsync(
                UnsafeMutablePointer(request),
                length: UInt16(request.count),
                refcon: nil
        )
        return status == kIOReturnSuccess
    }

    private func createInitMessage() -> ZikRequest {
        let message = [UInt8(0), UInt8(3), UInt8(0)]
        return message
    }

}
