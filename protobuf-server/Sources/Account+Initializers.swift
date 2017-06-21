/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

extension Account {
    public init(fields: [String], transactions: [Transaction]) {
        self.init(id: UInt64(fields[0]), name: fields[1], balance: Double(fields[2]), availableFunds: Double(fields[3]), iban: fields[4], currency: fields[5], owner: fields[6], ownerAddress: fields[7], transactions: transactions)
    }
    
    public init(id: UInt64? = nil, name: String? = nil, balance: Double? = nil, availableFunds: Double? = nil, iban: String? = nil, currency: String? = nil, owner: String? = nil, ownerAddress: String? = nil, transactions: [Transaction] = []) {
        if let v = id {
            self.id = v
        }
        
        if let v = name {
            self.name = v
        }
        
        if let v = balance {
            self.balance = v
        }
        
        if let v = availableFunds {
            self.availableFunds = v
        }
        
        if let v = iban {
            self.iban = v
        }
        
        if let v = currency {
            self.currency = v
        }
        
        if let v = owner {
            self.owner = v
        }
        
        if let v = ownerAddress {
            self.ownerAddress = v
        }
        
        if !transactions.isEmpty {
            self.transactions = transactions
        }
    }
}
