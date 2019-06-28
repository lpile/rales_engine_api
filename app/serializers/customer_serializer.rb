class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  has_many :invoices
  has_many :transactions
  
  attributes :id, :first_name, :last_name
end
