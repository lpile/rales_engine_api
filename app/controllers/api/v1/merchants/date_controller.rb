class Api::V1::Merchants::DateController < ApplicationController
  # total revenue on date
  def show
    render json: MerchantSerializer.new(Merchant.total_revenue_on_date(params["date"]))
  end
end
