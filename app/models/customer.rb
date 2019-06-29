class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  validates_presence_of :first_name, :last_name

  def favorite_merchant
    merchants
    .joins(invoices: :transactions)
    .select("merchants.*, COUNT(transactions.id) AS transactions_count")
    .merge(Transaction.successful)
    .group(:id)
    .order('transactions_count DESC')
    .first
  end
end
