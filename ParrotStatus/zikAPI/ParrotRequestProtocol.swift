typealias ZikRequest = [UInt8]

class ParrotRequestProtocols {

    private static func createRequestHeader(request: String) -> ZikRequest {
        var header = [UInt8(0)]
        header.append(UInt8(request.characters.count) + 3)
        header.append(UInt8(0x80))
        return header
    }

    private static func generateRequest(request: String) -> ZikRequest {
        let reqMessage = createRequestHeader(request) + request.utf8
        return reqMessage
    }

    static func getRequest(request: String) -> ZikRequest {
        return generateRequest("GET \(request)")
    }

    static func setRequest(request: String, args: Bool) -> ZikRequest {
        return generateRequest("SET \(request)?arg=\(args)")
    }

    static func setRequest(request: String, args: String) -> ZikRequest {
        return generateRequest("SET \(request)?arg=\(args)")
    }

}
