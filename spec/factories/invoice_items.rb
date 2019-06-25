FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { rand(1..10) }
    unit_price { rand(100..100000) }
  end
end
