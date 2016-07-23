class DeviceState {

    private static let Empty = String()

    private var _version: String = Empty
    private var _batteryLevel: String = Empty
    private var _batteryStatus: String = Empty
    private var _noiseCancellationEnabled: Bool = false
    private var _deviceName: String = Empty
    private var _noiseControlEnabled: Bool = false
    private var _equalizerEnabled: Bool = false
    private var _concertHallEnabled: Bool = false
    private var _headModeDetection: Bool = false
    private var _flightModeEnabled: Bool = false


    var name: String {
        get { return _deviceName }
        set { _deviceName = newValue }
    }

    var version: String {
        get { return _version }
        set { _version = newValue }
    }

    var batteryLevel: String {
        get { return _batteryLevel }
        set { _batteryLevel = newValue }
    }

    var batteryStatus: String {
        get { return _batteryStatus }
        set { _batteryStatus = newValue }
    }

    var noiseCancellationEnabled: Bool {
        get { return _noiseCancellationEnabled }
        set { _noiseCancellationEnabled = newValue }
    }

    var noiseControlEnabled: Bool {
        get { return _noiseControlEnabled }
        set { _noiseControlEnabled = newValue }
    }

    var equalizerEnabled: Bool {
        get { return _equalizerEnabled }
        set { _equalizerEnabled = newValue }
    }

    var concertHallEnabled: Bool {
        get { return _concertHallEnabled }
        set { _concertHallEnabled = newValue }
    }

    var headDetectionEnabled: Bool {
        get { return _headModeDetection }
        set { _headModeDetection = newValue }
    }

    var flightModeEnabled: Bool {
        get { return _flightModeEnabled }
        set { _flightModeEnabled = newValue }
    }

}
