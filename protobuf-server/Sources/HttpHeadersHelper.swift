/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation
import Kitura

enum AcceptHeader {
    case json
    case protobuf
    
    var contentType: String {
        switch self {
        case .json:
            return "application/json"
        case .protobuf:
            return "application/octet-stream"
        }
    }
}

final class HttpHeadersHelper {
    func acceptHeader(headers: Headers) -> AcceptHeader {
        let accept = headers["Accept"] ?? "application/json"
        switch accept {
        case "application/json":
            return .json
        case "application/octet-stream", "application/x-protobuf", "application/x-google-protobuf":
            return .protobuf
        default:
            return .json
        }
    }
}
