/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

enum DataLoadHelperError: Error {
    case fileNotFound
    case fileNotLoaded
}

extension DataLoadHelperError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "CSV file not found. Please make sure that CSV files are generated and placed in the correct path."
        case .fileNotLoaded:
            return "CSV file cannot be loaded. Please check the read permissions to the directory and file."
        }
    }
}

final class DataLoadHelper {
    
    private lazy var bundle: Bundle? = {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
        return Bundle(path: url.appendingPathComponent("MocksGenerator/Mocks").path)
    }()

    // MARK: Public interface

    func loadAccountList() -> AccountList {
        var accountList = AccountList()
        accountList.accounts = loadAccounts()
        return accountList
    }

    func mapAccounts(accountList: AccountList) -> [UInt64: Account] {
        var dictionary = [UInt64: Account]()
        for account in accountList.accounts {
            dictionary[account.id] = account
        }
        return dictionary
    }

    // MARK: Private
    
    private func loadStringFromFile(filename: String) throws -> String {
        guard let path = bundle?.path(forResource: filename, ofType: "csv") else {
            throw DataLoadHelperError.fileNotFound
        }
        
        do {
            return try String(contentsOfFile: path)
        } catch {
            throw DataLoadHelperError.fileNotLoaded
        }
    }
    
    private func loadAccounts() -> [Account] {
        let filename = "accounts"

        do {
            let accountRows: [String] = try loadStringFromFile(filename: filename).components(separatedBy: .newlines)
            return accountRows.flatMap { row in
                if row == "" {
                    return nil
                }
                let fields = row.components(separatedBy: ";")
                let accountId = UInt64(fields[0])!
                let transactions = loadTransactions(id: accountId)
                return Account(fields: fields, transactions: transactions)
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func loadTransactions(id: UInt64) -> [Transaction] {
        let filename = "transactions_" + String(id)

        do {
            let transactionRows: [String] = try loadStringFromFile(filename: filename).components(separatedBy: .newlines)
            return transactionRows.flatMap { row in
                if row == "" {
                    return nil
                }
                let fields = row.components(separatedBy: ";")
                return Transaction(fields: fields)
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
