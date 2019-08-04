# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    client
    account_number { Faker::Number.number(digits: 14).to_s }
    balance { '30.00' }
  end
end
