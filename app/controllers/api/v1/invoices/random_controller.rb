class Api::V1::Invoices::RandomController < ApplicationController
# random
  def show
    render json: InvoiceSerializer.new(Invoice.random)
  end
end
