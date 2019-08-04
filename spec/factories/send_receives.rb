# frozen_string_literal: true

FactoryBot.define do
  factory :send_receive do
    sender
    receiver
    amount { '13.00' }
  end
end
