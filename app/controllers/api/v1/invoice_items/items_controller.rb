class Api::V1::InvoiceItems::ItemsController < ApplicationController
  # finds invoice_item's item
  def show
    render json: ItemSerializer.new(InvoiceItem.find(params[:id]).item)
  end
end
