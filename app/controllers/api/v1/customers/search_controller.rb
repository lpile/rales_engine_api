class Api::V1::Customers::SearchController < ApplicationController
  # find_all
  def index
    render json: CustomerSerializer.new(Customer.find_all_by(query_params))
  end

  # find
  def show
    render json: CustomerSerializer.new(Customer.find_by(query_params))
  end

  private

  def query_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
