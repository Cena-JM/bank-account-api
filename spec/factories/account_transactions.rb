# frozen_string_literal: true

FactoryBot.define do
  factory :account_transaction do
    bank_account
    amount { '23.30' }
    transaction_type { 'deposit' }
  end
end
