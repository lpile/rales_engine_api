require 'rails_helper'

describe "InvoiceItems API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = create(:item, unit_price: 6666, merchant: @merchant1)
    @item2 = create(:item, unit_price: 1010, merchant: @merchant2)
    @item3 = create(:item, unit_price: 3452, merchant: @merchant3)
    @item4 = create(:item, unit_price: 53023, merchant: @merchant1)
    @item5 = create(:item, unit_price: 12345, merchant: @merchant3)
    @item6 = create(:item, unit_price: 3456, merchant: @merchant4)

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1)
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2)
    @invoice5 = create(:invoice, merchant: @merchant4, customer: @customer2)

    @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
    @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
    @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
    @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
    @transaction5 = create(:transaction, invoice: @invoice5)

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice_item2 = create(:invoice_item, item: @item4, invoice: @invoice1, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 7, unit_price: @item2.unit_price, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice_item4 = create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice3, quantity: 1, unit_price: @item5.unit_price, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice_item6 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item6, invoice: @invoice5, quantity: 1, unit_price: @item6.unit_price)
  end

  describe "Record Endpoints" do
    it "sends a list of invoice_items" do
      get "/api/v1/invoice_items"

      invoice_item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice_item.count).to eq(7)
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

      it "can find item by its unit_price" do
        expected = (@item1.unit_price / 100.0).to_s

        get "/api/v1/items/find?unit_price=#{expected}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["unit_price"]).to eq(expected)
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
        expect(invoice_items.count).to eq(2)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its quantity" do
        get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item1.quantity}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(6)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find items by its unit_price" do
        expected = (@item1.unit_price / 100.0).to_s

        get "/api/v1/items/find_all?unit_price=#{expected}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(1)
        expect(items.class).to eq(Array)
      end

      it "can find invoice_items by its created_at" do
        get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item1.created_at}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(3)
        expect(invoice_items.class).to eq(Array)
      end

      it "can find invoice_items by its updated_at" do
        get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_item1.updated_at}"

        invoice_items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice_items.count).to eq(3)
        expect(invoice_items.class).to eq(Array)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns the associated invoice" do
      get "/api/v1/invoice_items/#{@invoice_item1.id}/invoice"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice["id"].to_i).to eq(@invoice1.id)
      expect(invoice["type"]).to eq("invoice")
    end

    it "returns the associated item" do
      get "/api/v1/invoice_items/#{@invoice_item1.id}/item"

      item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(item["id"].to_i).to eq(@item1.id)
      expect(item["type"]).to eq("item")
    end
  end

  # Business Intelligent Endpoints
end
