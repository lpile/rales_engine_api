class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  # find merchant's favorite customer
  def show
    merchant = Merchant.find(params["id"])
    render json: CustomerSerializer.new(merchant.favorite_customer)
  end
end
