FactoryBot.define do
  factory :item do
    name { Faker::Commerce.unique.product_name }
    sequence :description {|n| "Description #{n}"}
    unit_price { rand(100..100000) }
    merchant
  end
end
