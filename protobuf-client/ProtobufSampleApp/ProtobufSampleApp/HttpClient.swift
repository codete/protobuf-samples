/**
 *  Protobuf Sample iOS Application
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Alamofire

fileprivate let host = "http://localhost:8080"

enum AcceptHeader {
    case json
    case protobuf

    func generate() -> [String: String] {
        switch self {
        case .json:
            return ["Accept": "application/json"]
        case .protobuf:
            return ["Accept": "application/octet-stream"]
        }
    }
}

struct DurationTimes {
    let totalDuration: TimeInterval
    let requestDuration: TimeInterval
}

final class HttpClient {
    func getAccountList(acceptHeader: AcceptHeader, completion: @escaping (Bool, AccountList?, DurationTimes?) -> Void) {
        Alamofire.request(host + "/accountList", method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: acceptHeader.generate())
            .validate()
            .responseData { response in
                guard let data = response.data else {
                    completion(false, nil, nil)
                    return
                }

                do {
                    var accountList: AccountList!
                    switch acceptHeader {
                    case .protobuf:
                        accountList = try AccountList(serializedData: data)
                    case .json:
                        accountList = try AccountList(jsonUTF8Data: data)
                    }
                    
                    let durationTimes = DurationTimes(totalDuration: response.timeline.totalDuration, requestDuration: response.timeline.requestDuration)
                    completion(true, accountList, durationTimes)
                } catch {
                    print(error)
                }
        }
    }
    
    func getTransactionList(acceptHeader: AcceptHeader, id: UInt64, completion: @escaping (Bool, [Transaction], DurationTimes?) -> Void) {
        Alamofire.request(host + "/account/" + String(id), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: acceptHeader.generate())
            .validate()
            .responseData { response in
                guard let data = response.data else {
                    completion(false, [], nil)
                    return
                }
                
                do {
                    var account: Account!
                    switch acceptHeader {
                    case .protobuf:
                        account = try Account(serializedData: data)
                    case .json:
                        account = try Account(jsonUTF8Data: data)
                    }
                    let transactionList = account.transactions
                    let durationTimes = DurationTimes(totalDuration: response.timeline.totalDuration, requestDuration: response.timeline.requestDuration)
                    completion(true, transactionList, durationTimes)
                } catch {
                    print(error)
                }
        }
    }
}
