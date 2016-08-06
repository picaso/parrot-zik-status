struct NoiseControlState {
    private static let max: Int = 2
    private static let normal: Int = 2

    private static let streetMode: String = "aoc"
    private static let cancellingMode: String = "anc"

    var level: Int = 0
    var mode: String = String()

    static func streetMax() -> NoiseControlState {
        return NoiseControlState(level: max, mode: streetMode)
    }

    static func streetNormal() -> NoiseControlState {
        return NoiseControlState(level: normal, mode: streetMode)
    }

    static func cancellingMax() -> NoiseControlState {
        return NoiseControlState(level: max, mode: cancellingMode)
    }

    static func cancellingNormal() -> NoiseControlState {
        return NoiseControlState(level: normal, mode: cancellingMode)
    }

}
