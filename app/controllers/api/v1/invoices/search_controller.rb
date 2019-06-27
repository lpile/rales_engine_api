class Api::V1::Invoices::SearchController < ApplicationController
  # find
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(query_params))
  end

  # find_all
  def index
    render json: InvoiceSerializer.new(Invoice.where(query_params))
  end

  private

  def query_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
