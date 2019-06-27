class Api::V1::Customers::SearchController < ApplicationController
  # find
  def show
    render json: CustomerSerializer.new(Customer.find_by(query_params))
  end

  # find_all
  def index
    render json: CustomerSerializer.new(Customer.where(query_params))
  end

  private

  def query_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
