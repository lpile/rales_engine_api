class Api::V1::InvoiceItems::RandomController < ApplicationController
# random
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.random)
  end
end
