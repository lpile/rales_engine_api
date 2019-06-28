class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  # show all invoice's invoice_items
  def index
    render json: InvoiceItemSerializer.new(Invoice.find(params[:id]).invoice_items)
  end
end
