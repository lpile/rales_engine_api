class Api::V1::InvoiceItems::SearchController < ApplicationController
  # find_all
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.find_all_by(query_params))
  end

  # find
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(query_params))
  end

  private

  def query_params
    query = params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
    unless query[:unit_price].nil?
      query[:unit_price] = change_unit_price_to_integer(query[:unit_price])
    end
    query
  end

  def change_unit_price_to_integer(input_data)
    (input_data.to_f * 100).round
  end
end
