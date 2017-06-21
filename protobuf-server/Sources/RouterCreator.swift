/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation
import Kitura

public struct RouterCreator {
    
    static func create(accountList: AccountList, accountDictionary: [UInt64: Account], httpHeadersHelper: HttpHeadersHelper) -> Router {
        let router = Router()
        
        // Handle HTTP GET requests to /accountList
        router.get("/accountList") { request, response, next in
            let acceptHeader = httpHeadersHelper.acceptHeader(headers: request.headers)
            response.headers.append("Content-Type", value: acceptHeader.contentType)
            
            switch acceptHeader {
            case .json:
                let accountListJSON = try accountList.jsonUTF8Data()
                response.send(data: accountListJSON)
            case .protobuf:
                let data = try accountList.serializedData()
                response.send(data: data)
            }
            
            next()
        }
        
        // Handle HTTP GET requests to /account/:accountId
        router.get("/account/:accountId") { request, response, next in
            guard let accountId = UInt64(request.parameters["accountId"]!),
                let account = accountDictionary[accountId] else {
                    response.send("{\"error\" : \"Invalid id provided.\"}");
                    next()
                    return
            }
            
            let acceptHeader = httpHeadersHelper.acceptHeader(headers: request.headers)
            response.headers.append("Content-Type", value: acceptHeader.contentType)
            
            switch acceptHeader {
            case .json:
                let accountJSON = try account.jsonUTF8Data()
                response.send(data: accountJSON)
            case .protobuf:
                let data = try account.serializedData()
                response.send(data: data)
            }
            
            next()
        }

        return router
    }
}
