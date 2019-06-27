FactoryBot.define do
  factory :item do
    name { Faker::Commerce.unique.product_name }
    description { Faker::ChuckNorris.unique.fact }
    unit_price { rand(100..100000) }
    merchant
  end
end
