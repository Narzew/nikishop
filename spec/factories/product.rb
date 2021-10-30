# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { rand(1..40) }
    category { association(:category) }
  end
end
