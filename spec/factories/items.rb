FactoryBot.define do
  factory :item do
    name { Faker::Commerce.unique.product_name }
    sequence :description {|n| "Description #{n}"}
    merchant

    factory :expensive_item do
      unit_price { rand(80000..100000) }
    end

    factory :moderate_item do
      unit_price { rand(40000..60000) }
    end

    factory :cheap_item do
      unit_price { rand(10000..20000) }
    end
  end
end
