class DeviceState {

    private static let Empty = String()

    private var _version: String = Empty
    private var _batteryLevel: String = Empty
    private var _batteryStatus: String = Empty
    private var _noiseCancellationEnabled: Bool = false

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

}
