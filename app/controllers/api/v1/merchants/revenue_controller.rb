class Api::V1::Merchants::RevenueController < ApplicationController
  # total revenue off all merchants on date
  def index
    render json: TotalRevenueSerializer.new(Merchant.total_revenue_on_date(params["date"]))
  end

  # total revenue of merchant by id
  def show
    merchant = Merchant.find(params["id"])
    if params["date"].nil?
      render json: RevenueSerializer.new(merchant.revenue_on_id)
    else
      render json: RevenueSerializer.new(merchant.revenue_by_date(params["date"]))
    end
  end
end
