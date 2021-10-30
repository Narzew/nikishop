FactoryBot.define do
    factory :category do
      name { Faker::Food.ethnic_category }
      seq { rand(1..100) }
    end
  end