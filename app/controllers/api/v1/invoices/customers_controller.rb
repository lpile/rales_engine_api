class Api::V1::Invoices::CustomersController < ApplicationController
  # finds invoice's customer
  def show
    render json: CustomerSerializer.new(Invoice.find(params[:id]).customer)
  end
end
