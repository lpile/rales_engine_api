class Api::V1::Items::MostItemsController < ApplicationController
  # most items sold
  def index
    render json: ItemSerializer.new(Item.top_items_sold(params["quantity"]))
  end
end
