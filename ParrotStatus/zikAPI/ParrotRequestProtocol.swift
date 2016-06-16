class ParrotRequestProtocols {
    private static func createReuestHeader(request: String) -> [UInt8] {
        var header = [UInt8(0)]
        header.append(UInt8(request.characters.count) + 3)
        header.append(UInt8(0x80))
        return header
    }

    private static func generateRequest(request: String) -> [UInt8] {
        let reqMessage = createReuestHeader(request) + request.utf8
        return reqMessage
    }

    static func getRequest(request: String) -> [UInt8] {
        return generateRequest("GET \(request)")
    }

    static func setRequest(request: String, args: Bool) -> [UInt8] {
        return generateRequest("SET \(request)?arg=\(args)")
    }
}
