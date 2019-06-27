FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Number.unique.number(16) }
    credit_card_expiration_date { "" }
    result { "failed" }
  end
end
