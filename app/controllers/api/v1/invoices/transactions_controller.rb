class Api::V1::Invoices::TransactionsController < ApplicationController
  # show all invoice's transactions
  def index
    render json: TransactionSerializer.new(Invoice.find(params[:id]).transactions)
  end
end
