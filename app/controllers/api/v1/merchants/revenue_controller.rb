class Api::V1::Merchants::RevenueController < ApplicationController
  # total revenue off all merchants on date
  def index
    render json: TotalRevenueSerializer.new(Merchant.total_revenue_on_date(params["date"]))
  end

  # total revenue of merchant by id
  def show
    merchant = Merchant.find(params["id"])
    render json: RevenueSerializer.new(merchant.total_revenue_on_id)
  end
end
