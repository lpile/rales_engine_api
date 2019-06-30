class Api::V1::Items::SearchController < ApplicationController
  # find_all
  def index
    render json: ItemSerializer.new(Item.find_all_by(query_params))
  end

  # find
  def show
    render json: ItemSerializer.new(Item.find_by(query_params))
  end

  private

  def query_params
    query = params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    unless query[:unit_price].nil?
      query[:unit_price] = change_unit_price_to_integer(query[:unit_price])
    end
    query
  end

  def change_unit_price_to_integer(input_data)
    (input_data.to_f * 100).round
  end
end
