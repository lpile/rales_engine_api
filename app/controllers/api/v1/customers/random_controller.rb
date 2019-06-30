class Api::V1::Customers::RandomController < ApplicationController
# random
  def show
    render json: CustomerSerializer.new(Customer.random)
  end
end
