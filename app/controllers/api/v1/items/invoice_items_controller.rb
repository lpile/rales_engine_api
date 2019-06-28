class Api::V1::Items::InvoiceItemsController < ApplicationController
  # show all merchant's invoices
  def index
    render json: InvoiceItemSerializer.new(Item.find(params[:id]).invoice_items)
  end
end
