class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.top_items_by_revenue(input_quantity)
    joins(:invoice_items, invoices: :transactions)
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .merge(Transaction.successful)
    .group(:id)
    .order('revenue DESC')
    .limit(input_quantity)
  end

  def self.top_items_sold(input_quantity)
    joins(:invoice_items, invoices: :transactions)
    .select("items.*, SUM(invoice_items.quantity) AS items_count")
    .merge(Transaction.successful)
    .group(:id)
    .order('items_count DESC')
    .limit(input_quantity)
  end

  def best_day
    invoices
    .joins(:transactions)
    .select("invoices.created_at AS best_day, SUM(invoice_items.quantity) AS items_count")
    .merge(Transaction.successful)
    .group('best_day')
    .order('items_count DESC, best_day DESC')
    .take
  end
end
