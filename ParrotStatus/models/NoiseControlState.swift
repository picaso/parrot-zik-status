struct NoiseControlState: Equatable {
    private static let max: Int = 2
    private static let normal: Int = 1


    private static let streetMode: String = "aoc"
    private static let cancellingMode: String = "anc"
    private static let off: String = "off"

    private var readOnlylevel: Int = 0
    private var readOnlyMode: String = String()

    var level: Int {
        return readOnlylevel
    }
    var mode: String {
        return readOnlyMode
    }

    init(level: Int, mode: String) {
        self.readOnlylevel = level
        self.readOnlyMode = mode
    }

    static var streetMax: NoiseControlState {
        return NoiseControlState(level: max, mode: streetMode)
    }

    static var streetNormal: NoiseControlState {
            return NoiseControlState(level: normal, mode: streetMode)
    }

    static var cancellingMax: NoiseControlState {
        return NoiseControlState(level: max, mode: cancellingMode)
    }

    static var cancellingNormal: NoiseControlState {
        return NoiseControlState(level: normal, mode: cancellingMode)
    }

    static var cancellingOff: NoiseControlState {
        return NoiseControlState(level: normal, mode: off)
    }

    func urlParameter() -> String {
        return "\(mode)&value=\(level)"
    }

}

func == (lhs: NoiseControlState, rhs: NoiseControlState) -> Bool {
    return lhs.urlParameter() == rhs.urlParameter()
}
