class DeviceState {

    fileprivate static let Empty = String()

    fileprivate var stateVersion: String = Empty
    fileprivate var stateBatteryLevel: String = Empty
    fileprivate var stateBatteryStatus: String = Empty
    fileprivate var stateNoiseCancellationEnabled: Bool = false
    fileprivate var stateDeviceName: String = Empty
    fileprivate var stateNoiseControlEnabled: Bool = false
    fileprivate var stateEqualizerEnabled: Bool = false
    fileprivate var stateConcertHallEnabled: Bool = false
    fileprivate var stateHeadModeDetection: Bool = false
    fileprivate var stateFlightModeEnabled: Bool = false
    fileprivate var noiseControlState: NoiseControlState = NoiseControlState.cancellingNormal


    var name: String {
        get {
            return stateDeviceName
        }
        set {
            stateDeviceName = newValue
        }
    }

    var version: String {
        get {
            return stateVersion
        }
        set {
            stateVersion = newValue
        }
    }

    var batteryLevel: String {
        get {
            return stateBatteryLevel
        }
        set {
            stateBatteryLevel = newValue
        }
    }

    var batteryStatus: String {
        get {
            return stateBatteryStatus
        }
        set {
            stateBatteryStatus = newValue
        }
    }

    var noiseCancellationEnabled: Bool {
        get {
            return stateNoiseCancellationEnabled
        }
        set {
            stateNoiseCancellationEnabled = newValue
        }
    }

    var noiseControlEnabled: Bool {
        get {
            return stateNoiseControlEnabled
        }
        set {
            stateNoiseControlEnabled = newValue
        }
    }

    var equalizerEnabled: Bool {
        get {
            return stateEqualizerEnabled
        }
        set {
            stateEqualizerEnabled = newValue
        }
    }

    var concertHallEnabled: Bool {
        get {
            return stateConcertHallEnabled
        }
        set {
            stateConcertHallEnabled = newValue
        }
    }

    var headDetectionEnabled: Bool {
        get {
            return stateHeadModeDetection
        }
        set {
            stateHeadModeDetection = newValue
        }
    }

    var flightModeEnabled: Bool {
        get {
            return stateFlightModeEnabled
        }
        set {
            stateFlightModeEnabled = newValue
        }
    }

    var noiseControlLevelState: NoiseControlState {
        get {
            return noiseControlState
        }
        set {
            noiseControlState = newValue
        }
    }
}
