require 'rails_helper'

describe "Items API:" do
  describe "Record Endpoints" do
    before :each do
      Faker::UniqueGenerator.clear
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @item1 = create(:item, merchant: @merchant1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @item2 = create(:item, merchant: @merchant2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @item3 = create(:item, merchant: @merchant1)
      @item4 = create(:item, merchant: @merchant2)
    end

    it "sends a list of items" do
      get "/api/v1/items"

      item = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(item.count).to eq(4)
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
        get "/api/v1/items/find?unit_price=#{@item1.unit_price}"

        item = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(item["attributes"]["unit_price"]).to eq(@item1.unit_price)
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
        get "/api/v1/items/find_all?unit_price=#{@item1.unit_price}"

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
        expect(items.count).to eq(2)
        expect(items.class).to eq(Array)
      end

      it "can find items by its updated_at" do
        get "/api/v1/items/find_all?updated_at=#{@item1.updated_at}"

        items = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(items.count).to eq(2)
        expect(items.class).to eq(Array)
      end
    end
  end

  # Relationship Endpoints

  # Business Intelligent Endpoints
end
