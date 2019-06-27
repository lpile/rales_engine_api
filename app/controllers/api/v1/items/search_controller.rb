class Api::V1::Items::SearchController < ApplicationController
  # find
  def show
    render json: ItemSerializer.new(Item.find_by(query_params))
  end

  # find_all
  def index
    render json: ItemSerializer.new(Item.where(query_params))
  end

  private

  def query_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
