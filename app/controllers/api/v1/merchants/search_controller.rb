class Api::V1::Merchants::SearchController < ApplicationController
  # find_all
  def index
    render json: MerchantSerializer.new(Merchant.find_all_by(query_params))
  end
  
  # find
  def show
    render json: MerchantSerializer.new(Merchant.find_by(query_params))
  end

  private

  def query_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
