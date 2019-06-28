class Api::V1::Customers::InvoicesController < ApplicationController
  # show all customer's invoices
  def index
    render json: InvoiceSerializer.new(Customer.find(params[:id]).invoices)
  end
end
