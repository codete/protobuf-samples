#
#  Protobuf Sample Server
#  Copyright (c) Codete 2017
#  Licensed under the MIT license. See LICENSE file.
#

require 'csv'
require 'faker'

def random_account(id, name)
  account_name = name
  balance = 12999.56
  available_funds = 9876.12
  iban = Faker::Bank.iban
  currency = 'EUR'
  owner = Faker::Name.name
  owner_address = Faker::Address.street_address + ', ' + Faker::Address.city + ' ' + Faker::Address.zip + ', ' + Faker::Address.country
  [id, account_name, balance, available_funds, iban, currency, owner, owner_address]
end

def random_transaction(id, date_offset)
  now = Date.today
  transaction_type = rand(0..1)
  transaction_date = now - date_offset
  booking_date = Faker::Date.between(transaction_date, transaction_date + 3)
  principal_disposal = Faker::Name.name
  ordering_customer = Faker::Name.name
  beneficiary = Faker::Name.name
  beneficiary_account = Faker::Bank.iban
  details = Faker::Lorem.sentence
  amount = Faker::Commerce.price
  [id, transaction_type, transaction_date, booking_date, principal_disposal, ordering_customer, beneficiary, beneficiary_account, details, amount]
end

CSV.open('Mocks/accounts.csv', 'w', col_sep: ';') do |csv|
  csv << random_account(1, 'Main account')
  csv << random_account(2, 'Second account')
end

date_offset = 0

CSV.open('Mocks/transactions_1.csv', 'w', col_sep: ';') do |csv|
  (0..1000).each do |i|
    offset = 1000000
    csv << random_transaction(offset - i, date_offset)
    if i % 20 == 0
      date_offset += 1
    end
  end
end

date_offset = 0

CSV.open('Mocks/transactions_2.csv', 'w', col_sep: ';') do |csv|
  (0..10000).each do |i|
    offset = 2000000
    csv << random_transaction(offset - i, date_offset)
    if i % 20 == 0
      date_offset += 1
    end
  end
end
