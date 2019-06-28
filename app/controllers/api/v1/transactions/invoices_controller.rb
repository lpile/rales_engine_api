class Api::V1::Transactions::InvoicesController < ApplicationController
  # finds transaction's invoice
  def show
    render json: InvoiceSerializer.new(Transaction.find(params[:id]).invoice)
  end
end
