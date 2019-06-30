require 'rails_helper'

describe "Items API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = create(:item, unit_price: 6666, merchant: @merchant1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @item2 = create(:item, unit_price: 1010, merchant: @merchant2)
    @item3 = create(:item, unit_price: 3452, merchant: @merchant3, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @item4 = create(:item, unit_price: 53023, merchant: @merchant1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
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

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
    @invoice_item2 = create(:invoice_item, item: @item4, invoice: @invoice1, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 7, unit_price: @item2.unit_price)
    @invoice_item4 = create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice3, quantity: 1, unit_price: @item5.unit_price)
    @invoice_item6 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item6, invoice: @invoice5, quantity: 1, unit_price: @item6.unit_price)
  end

  describe "Record Endpoints" do
    it "sends a list of items" do
      get "/api/v1/items"

      item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(item.count).to eq(6)
    end

    it "can get one item by its id" do
      get "/api/v1/items/#{@item1.id}"

      item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(item["id"].to_i).to eq(@item1.id)
    end

    describe "Items Single Finders" do
      it "can find item by its id" do
        get "/api/v1/items/find?id=#{@item1.id}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["id"].to_i).to eq(@item1.id)
      end

      it "can find item by its name" do
        get "/api/v1/items/find?name=#{@item1.name}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["name"]).to eq(@item1.name)
      end

      it "can find item by its description" do
        get "/api/v1/items/find?description=#{@item1.description}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["description"]).to eq(@item1.description)
      end

      it "can find item by its unit_price" do
        expected = (@item1.unit_price / 100.0).to_s

        get "/api/v1/items/find?unit_price=#{expected}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["unit_price"]).to eq(expected)
      end

      it "can find item by its merchant_id" do
        get "/api/v1/items/find?merchant_id=#{@item1.merchant_id}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["merchant_id"]).to eq(@item1.merchant_id)
      end

      it "can find item by its created_at" do
        get "/api/v1/items/find?#{@item1.created_at}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["id"]).to eq(@item1.id)
      end

      it "can find item by its updated_at" do
        get "/api/v1/items/find?updated_at=#{@item1.updated_at}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["id"]).to eq(@item1.id)
      end
    end

    describe "Customers Multi-Finders" do
      it "can find items by its id" do
        get "/api/v1/items/find_all?id=#{@item1.id}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(1)
        expect(items.class).to eq(Array)
      end

      it "can find items by its name" do
        get "/api/v1/items/find_all?name=#{@item1.name}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(1)
        expect(items.class).to eq(Array)
      end

      it "can find items by its description" do
        get "/api/v1/items/find_all?description=#{@item1.description}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(1)
        expect(items.class).to eq(Array)
      end

      it "can find items by its unit_price" do
        expected = (@item1.unit_price / 100.0).to_s

        get "/api/v1/items/find_all?unit_price=#{expected}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(1)
        expect(items.class).to eq(Array)
      end

      it "can find items by its merchant_id" do
        get "/api/v1/items/find_all?merchant_id=#{@item1.merchant_id}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(2)
        expect(items.class).to eq(Array)
      end

      it "can find items by its created_at" do
        get "/api/v1/items/find_all?created_at=#{@item1.created_at}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(3)
        expect(items.class).to eq(Array)
      end

      it "can find items by its updated_at" do
        get "/api/v1/items/find_all?updated_at=#{@item1.updated_at}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(3)
        expect(items.class).to eq(Array)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns a collection of associated invoice items" do
      get "/api/v1/items/#{@item4.id}/invoice_items"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items.class).to eq(Array)
      expect(items[0]["type"]).to eq("invoice_item")
    end

    it "returns the associated merchant" do
      get "/api/v1/items/#{@item1.id}/merchant"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["id"].to_i).to eq(@merchant1.id)
      expect(merchant["type"]).to eq("merchant")
    end
  end

  describe "Business Intelligent Endpoints" do
    it "returns the top x items ranked by total revenue generated" do
      get '/api/v1/items/most_revenue?quantity=2'

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0]["id"].to_i).to eq(@item4.id)
      expect(items[1]["id"].to_i).to eq(@item5.id)
    end
  end
end
