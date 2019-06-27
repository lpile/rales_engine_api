class Api::V1::InvoiceItems::SearchController < ApplicationController
  # find
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(query_params))
  end

  # find_all
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(query_params))
  end

  private

  def query_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end