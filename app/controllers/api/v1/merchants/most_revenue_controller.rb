class Api::V1::Merchants::MostRevenueController < ApplicationController
  # most_revenue
  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(params["quantity"]))
  end
end
