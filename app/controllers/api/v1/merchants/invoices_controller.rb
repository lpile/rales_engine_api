class Api::V1::Merchants::InvoicesController < ApplicationController
  # show all merchant's invoices
  def index
    render json: InvoiceSerializer.new(Merchant.find(params[:id]).invoices)
  end
end
