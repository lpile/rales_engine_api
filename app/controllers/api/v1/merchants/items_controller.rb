class Api::V1::Merchants::ItemsController < ApplicationController
  # show all merchant's items
  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end
end
