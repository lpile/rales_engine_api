class Api::V1::Merchants::RevenueController < ApplicationController
  # total revenue on date
  def show
    render json: TotalRevenueSerializer.new(Merchant.total_revenue_on_date(params["date"]))
  end
end
