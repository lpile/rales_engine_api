class Api::V1::Transactions::SearchController < ApplicationController
  # find_all
  def index
    render json: TransactionSerializer.new(Transaction.find_all_by(query_params))
  end

  # find
  def show
    render json: TransactionSerializer.new(Transaction.find_by(query_params))
  end

  private

  def query_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
