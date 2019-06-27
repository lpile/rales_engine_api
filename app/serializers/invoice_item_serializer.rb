class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :item
  belongs_to :invoice
  
  attributes :id, :item_id, :invoice_id, :quantity

  attribute :unit_price do |object|
    (object.unit_price / 100.0).to_s
  end
end
