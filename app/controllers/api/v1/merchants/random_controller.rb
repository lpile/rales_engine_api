class Api::V1::Merchants::RandomController < ApplicationController
# random
  def show
    render json: MerchantSerializer.new(Merchant.random)
  end
end
