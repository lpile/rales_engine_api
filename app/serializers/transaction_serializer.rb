class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  
  belongs_to :invoice

  attributes :id, :invoice_id, :credit_card_number, :result
end
