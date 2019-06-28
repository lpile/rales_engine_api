class ItemSerializer
  include FastJsonapi::ObjectSerializer
  
  belongs_to :merchant
  has_many :invoice_items

  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |object|
    (object.unit_price / 100.0).to_s
  end
end
