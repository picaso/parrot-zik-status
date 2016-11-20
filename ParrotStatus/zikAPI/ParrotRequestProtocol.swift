typealias ZikRequest = [UInt8]

class ParrotRequestProtocols {

    fileprivate static func createRequestHeader(_ request: String) -> ZikRequest {
        var header = [UInt8(0)]
        header.append(UInt8(request.characters.count) + 3)
        header.append(UInt8(0x80))
        return header
    }

    fileprivate static func generateRequest(_ request: String) -> ZikRequest {
        let reqMessage = createRequestHeader(request) + request.utf8
        return reqMessage
    }

    static func getRequest(_ request: String) -> ZikRequest {
        return generateRequest("GET \(request)")
    }

    static func setRequest(_ request: String, args: Bool) -> ZikRequest {
        return generateRequest("SET \(request)?arg=\(args)")
    }

    static func setRequest(_ request: String, args: String) -> ZikRequest {
        return generateRequest("SET \(request)?arg=\(args)")
    }

}
