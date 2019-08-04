# frozen_string_literal: true

FactoryBot.define do
  factory :client, aliases: %i[sender receiver] do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    middle_name { Faker::Name.name }
    address { Faker::Address.city }
    gender { Faker::Gender.binary_type }
    date_of_birth { Faker::Date.birthday(min_age: 16, max_age: 65) }
    email { Faker::Internet.email }
  end
end
