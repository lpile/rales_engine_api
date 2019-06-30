class Api::V1::Transactions::RandomController < ApplicationController
# random
  def show
    render json: TransactionSerializer.new(Transaction.random)
  end
end
