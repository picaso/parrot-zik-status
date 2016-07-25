extension String {

    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1", "enabled":
            return true
        case "False", "false", "no", "0", "disabled":
            return false
        default:
            return nil
        }
    }

}
