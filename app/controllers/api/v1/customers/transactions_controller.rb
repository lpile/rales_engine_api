class Api::V1::Customers::TransactionsController < ApplicationController
  # show all customer's transactions
  def index
    render json: TransactionSerializer.new(Customer.find(params[:id]).transactions)
  end
end
