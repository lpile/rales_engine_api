class Api::V1::Items::MerchantsController < ApplicationController
  # finds item's merchant
  def show
    render json: MerchantSerializer.new(Item.find(params[:id]).merchant)
  end
end
