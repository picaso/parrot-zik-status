class DeviceState {

    private static let Empty = String()

    private var stateVersion: String = Empty
    private var stateBatteryLevel: String = Empty
    private var stateBatteryStatus: String = Empty
    private var stateNoiseCancellationEnabled: Bool = false
    private var stateDeviceName: String = Empty
    private var stateNoiseControlEnabled: Bool = false
    private var stateEqualizerEnabled: Bool = false
    private var stateConcertHallEnabled: Bool = false
    private var stateHeadModeDetection: Bool = false
    private var stateFlightModeEnabled: Bool = false
    private var noiseControlState: NoiseControlState = NoiseControlState.cancellingNormal()


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
