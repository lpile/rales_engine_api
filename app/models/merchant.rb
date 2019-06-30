class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

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
    joins(invoices: [:transactions, :invoice_items])
    .select("merchants.*, SUM(invoice_items.quantity) AS items_count")
    .merge(Transaction.successful)
    .group(:id)
    .order('items_count DESC')
    .limit(input_quantity)
  end

  def self.total_revenue_on_date(input_date)
    joins(invoices: [:transactions, :invoice_items])
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .merge(Transaction.successful)
    .where("CAST(invoices.created_at AS text) LIKE ?", "%#{input_date}%")
    .take
  end

  def revenue_on_id
    invoices
    .joins(:transactions, :invoice_items)
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .merge(Transaction.successful)
    .take
  end

  def revenue_by_date(input_date)
    invoices
    .joins(:transactions, :invoice_items)
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .merge(Transaction.successful)
    .where("CAST(invoices.updated_at AS text) LIKE ?", "%#{input_date}%")
    .take
  end

  def favorite_customer
    customers
    .joins(invoices: :transactions)
    .select("customers.*, COUNT(transactions.id) AS transactions_count")
    .merge(Transaction.successful)
    .group(:id)
    .order('transactions_count DESC')
    .take
  end
end
