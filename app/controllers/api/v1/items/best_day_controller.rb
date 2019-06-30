class Api::V1::Items::BestDayController < ApplicationController
  # find item's best day based on revenue
  def show
    item = Item.find(params["id"])
    render json: BestDaySerializer.new(item.best_day)
  end
end
