require 'rails_helper'

describe "InvoiceItems API:" do
  describe "Record Endpoints" do
    before :each do
      Faker::UniqueGenerator.clear
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant2)
      @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
      @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer2)
      @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
      @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    end

    it "sends a list of invoice_items" do
      get "/api/v1/invoice_items"

      invoice_item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice_item.count).to eq(2)
    end

    it "can get one invoice_item by its id" do
      get "/api/v1/invoice_items/#{@invoice_item1.id}"

      invoice_item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice_item["id"].to_i).to eq(@invoice_item1.id)
    end

    describe "InvoiceItems Single Finders" do
      it "can find invoice_item by its id" do
        get "/api/v1/invoice_items/find?id=#{@invoice_item1.id}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["id"].to_i).to eq(@invoice_item1.id)
      end

      it "can find invoice_item by its item_id" do
        get "/api/v1/invoice_items/find?item_id=#{@invoice_item1.item_id}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["item_id"]).to eq(@invoice_item1.item_id)
      end

      it "can find invoice_item by its invoice_id" do
        get "/api/v1/invoice_items/find?invoice_id=#{@invoice_item1.invoice_id}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["invoice_id"]).to eq(@invoice_item1.invoice_id)
      end

      it "can find invoice_item by its quantity" do
        get "/api/v1/invoice_items/find?quantity=#{@invoice_item1.quantity}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["quantity"]).to eq(@invoice_item1.quantity)
      end

      it "can find invoice_item by its unit_price" do
        get "/api/v1/invoice_items/find?unit_price=#{@invoice_item1.unit_price}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["unit_price"]).to eq(@invoice_item1.unit_price)
      end

      it "can find invoice_item by its created_at" do
        get "/api/v1/invoice_items/find?#{@invoice_item1.created_at}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["id"]).to eq(@invoice_item1.id)
      end

      it "can find invoice_item by its updated_at" do
        get "/api/v1/invoice_items/find?updated_at=#{@invoice_item1.updated_at}"

        invoice_item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_item["attributes"]["id"]).to eq(@invoice_item1.id)
      end
    end

    describe "Customers Multi-Finders" do
      it "can find invoice_items by its id" do
        get "/api/v1/invoice_items/find_all?id=#{@invoice_item1.id}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(1)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its item_id" do
        get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item1.item_id}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(1)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its invoice_id" do
        get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item1.invoice_id}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(1)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its quantity" do
        get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item1.quantity}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(1)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its unit_price" do
        get "/api/v1/invoice_items/find_all?unit_price=#{@invoice_item1.unit_price}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(1)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its created_at" do
        get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item1.created_at}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(2)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its updated_at" do
        get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_item1.updated_at}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(2)
        expect(invoice_items.class).to eq(Array)
      end
    end
  end

  # Relationship Endpoints

  # Business Intelligent Endpoints
end
