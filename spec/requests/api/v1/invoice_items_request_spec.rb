require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of invoice_item" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.count).to eq(3)
  end

  it "can get one invoice_item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(id)
  end
end
