class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name

  def self.top_merchants_by_revenue(input_quantity)
    joins(invoices: [:transactions, :invoice_items])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .merge(Transaction.successful)
    .group(:id)
    .order('revenue DESC')
    .limit(input_quantity)
  end

  def self.top_merchants_by_items(input_quantity)
    joins(items: :invoice_items, invoices: :transactions)
    .select("merchants.*, SUM(invoice_items.quantity) AS items_count")
    .merge(Transaction.successful)
    .group(:id)
    .order('items_count DESC')
    .limit(input_quantity)
  end
end
