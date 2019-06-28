class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  # finds invoice_item's invoice
  def show
    render json: InvoiceSerializer.new(InvoiceItem.find(params[:id]).invoice)
  end
end
