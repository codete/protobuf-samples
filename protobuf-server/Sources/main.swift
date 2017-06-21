/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Kitura
import HeliumLogger
import SwiftProtobuf

// Initialize HeliumLogger
HeliumLogger.use()

// Load data from CSV files
let dataLoader = DataLoadHelper()
let accountList = dataLoader.loadAccountList()
let accountDictionary = dataLoader.mapAccounts(accountList: accountList)

// Http Headers Helper to recongnize supported Accept values
let httpHeadersHelper = HttpHeadersHelper()

// Create a new router
let router = RouterCreator.create(accountList: accountList, accountDictionary: accountDictionary, httpHeadersHelper: httpHeadersHelper)

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
