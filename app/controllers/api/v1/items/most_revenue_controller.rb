class Api::V1::Items::MostRevenueController < ApplicationController
  # most_revenue
  def index
    render json: ItemSerializer.new(Item.top_items_by_revenue(params["quantity"]))
  end
end
