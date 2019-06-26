class Api::V1::Merchants::MostItemsController < ApplicationController
  # most_item
  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_items(params["quantity"]))
  end
end
