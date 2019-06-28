class Api::V1::Invoices::MerchantsController < ApplicationController
  # finds invoice's merchant
  def show
    render json: MerchantSerializer.new(Invoice.find(params[:id]).merchant)
  end
end
