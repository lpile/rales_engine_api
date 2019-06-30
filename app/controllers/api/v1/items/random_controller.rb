class Api::V1::Items::RandomController < ApplicationController
# random
  def show
    render json: ItemSerializer.new(Item.random)
  end
end
