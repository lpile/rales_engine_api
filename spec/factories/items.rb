FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { rand(100..100000) }
    merchant
  end
end
