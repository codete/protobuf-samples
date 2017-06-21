/**
 *  Protobuf Sample Server
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

extension Transaction {
    public init(fields: [String]) {
        let transactionType = fields[1] == "0" ? Transaction.TransactionType.credit : Transaction.TransactionType.debit
        self.init(id: UInt64(fields[0]), transactionType: transactionType, transactionDate: fields[2], bookingDate: fields[3], principalDisposal: fields[4], orderingCustomer: fields[5], beneficiary: fields[6], beneficiaryAccount: fields[7], details: fields[8], amount: Double(fields[9]))
    }
    
    public init(id: UInt64? = nil, transactionType: Transaction.TransactionType = Transaction.TransactionType.credit, transactionDate: String? = nil, bookingDate: String? = nil, principalDisposal: String? = nil, orderingCustomer: String? = nil, beneficiary: String? = nil, beneficiaryAccount: String? = nil, details: String? = nil, amount: Double? = nil) {
        if let v = id {
            self.id = v
        }
        
        self.transactionType = transactionType
        
        if let v = transactionDate {
            self.transactionDate = v
        }
        
        if let v = bookingDate {
            self.bookingDate = v
        }
        
        if let v = principalDisposal {
            self.principalDisposal = v
        }
        
        if let v = orderingCustomer {
            self.orderingCustomer = v
        }
        
        if let v = beneficiary {
            self.beneficiary = v
        }
        
        if let v = beneficiaryAccount {
            self.beneficiaryAccount = v
        }
        
        if let v = details {
            self.details = v
        }
        
        if let v = amount {
            self.amount = v
        }
    }
}
