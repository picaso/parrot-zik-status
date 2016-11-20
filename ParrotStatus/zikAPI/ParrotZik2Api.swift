import IOBluetooth

class ParrotZik2Api {

    fileprivate let get = ParrotRequestProtocols.getRequest
    fileprivate let set: (String, Bool) -> ZikRequest = ParrotRequestProtocols.setRequest
    fileprivate let setString: (String, String) -> [UInt8] = ParrotRequestProtocols.setRequest

    fileprivate var apiRfCommChannel: IOBluetoothRFCOMMChannel?

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

    func toggleAsyncNoiseCancellation(_ arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetNoiseCancellationStatus, arg))
    }

    func getAsyncNoiseControlStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseControltatus))
    }

    func getAsyncEqualizerStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.EqualizerStatus))
    }

    func toggleAsyncEqualizerStatus(_ arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetEqualizerStatus, arg))
    }

    func getAsyncConcertHallStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.ConcertHallStatus))
    }

    func toggleAsyncConcerHallStatus(_ arg: Bool) -> Bool {
        return sendRequest(set(ParrotZikEndpoints.SetConcertHallStatus, arg))
    }

    func getAsyncNoiseControlLevelStatus() -> Bool {
        return sendRequest(get(ParrotZikEndpoints.NoiseControlLevelStatus))
    }

    func setAsyncNoiseControlLevelStatus(_ arg: String) -> Bool {
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

    func toggleAsyncHeadDetection(_ arg: Bool) -> Bool {
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
    func sendRequest(_ request: String) -> Bool {
        return sendRequest(get(request))
    }

    func initializeDevice(_ rfCommChannel: IOBluetoothRFCOMMChannel) -> Bool {
        self.apiRfCommChannel = rfCommChannel
        return sendRequest(createInitMessage())
    }

    fileprivate func sendRequest(_ request: ZikRequest) -> Bool {
        let status = apiRfCommChannel?
            .writeAsync(
                UnsafeMutablePointer(mutating: request),
                length: UInt16(request.count),
                refcon: nil
        )
        return status == kIOReturnSuccess
    }

    fileprivate func createInitMessage() -> ZikRequest {
        let message = [UInt8(0), UInt8(3), UInt8(0)]
        return message
    }

}
