require 'rails_helper'

describe "Merchants API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1 = create(:customer, first_name: "Customer", last_name: "1")
    @customer2 = create(:customer, first_name: "Customer", last_name: "2")

    @merchant1 = create(:merchant, name: "Merchant 1", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @merchant2 = create(:merchant, name: "Merchant 2", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @merchant3 = create(:merchant, name: "Merchant 3")
    @merchant4 = create(:merchant, name: "Merchant 4")

    @item1 = create(:item, unit_price: 6666, merchant: @merchant1)
    @item2 = create(:item, unit_price: 1010, merchant: @merchant2)
    @item3 = create(:item, unit_price: 3452, merchant: @merchant3)
    @item4 = create(:item, unit_price: 53023, merchant: @merchant1)
    @item5 = create(:item, unit_price: 12345, merchant: @merchant3)
    @item6 = create(:item, unit_price: 3456, merchant: @merchant4)

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
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
    it "sends a list of merchants" do
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(4)
    end

    it "can get one merchant by its id" do
      get "/api/v1/merchants/#{@merchant1.id}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["id"].to_i).to eq(@merchant1.id)
    end

    describe "Merchants Single Finders" do
      it "can find merchant by its id" do
        get "/api/v1/merchants/find?id=#{@merchant1.id}"

        merchant = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchant["attributes"]["id"].to_i).to eq(@merchant1.id)
      end

      it "can find merchant by its name" do
        get "/api/v1/merchants/find?name=#{@merchant1.name}"

        merchant = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchant["attributes"]["name"]).to eq(@merchant1.name)
      end

      it "can find merchant by its created_at" do
        get "/api/v1/merchants/find?#{@merchant1.created_at}"

        merchant = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchant["attributes"]["id"]).to eq(@merchant1.id)
      end

      it "can find merchant by its updated_at" do
        get "/api/v1/merchants/find?updated_at=#{@merchant1.updated_at}"

        merchant = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchant["attributes"]["id"]).to eq(@merchant1.id)
      end
    end

    describe "Merchants Multi-Finders" do
      it "can find merchant by its id" do
        get "/api/v1/merchants/find_all?id=#{@merchant1.id}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(1)
        expect(merchants.class).to eq(Array)
      end

      it "can find merchant by its name" do
        get "/api/v1/merchants/find_all?name=#{@merchant1.name}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(1)
        expect(merchants.class).to eq(Array)
      end

      it "can find merchant by its created_at" do
        get "/api/v1/merchants/find_all?created_at=#{@merchant1.created_at}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(2)
        expect(merchants.class).to eq(Array)
      end

      it "can find merchant by its updated_at" do
        get "/api/v1/merchants/find_all?updated_at=#{@merchant1.updated_at}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(2)
        expect(merchants.class).to eq(Array)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns a collection of items associated with that merchant" do
      get "/api/v1/merchants/#{@merchant1.id}/items"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items.class).to eq(Array)
      expect(items[0]["type"]).to eq("item")
    end

    it "returns a collection of invoices associated with that merchant from their known orders" do
      get "/api/v1/merchants/#{@merchant1.id}/invoices"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items.class).to eq(Array)
      expect(items[0]["type"]).to eq("invoice")
    end
  end

  describe "Business Intelligent Endpoints" do
    it "returns the top x merchants ranked by total revenue" do
      get '/api/v1/merchants/most_revenue?quantity=2'

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0]["id"].to_i).to eq(@merchant1.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant3.id)
    end

    it "returns the top x merchants ranked by total number of items sold" do
      get '/api/v1/merchants/most_items?quantity=2'

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0]["id"].to_i).to eq(@merchant2.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant1.id)
    end

    it "returns the total revenue for date x across all merchants" do
      Item.all.map {|item| (item.unit_price / 100.0).to_s}

      get "/api/v1/merchants/revenue?date=2012-03-27"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["total_revenue"]).to eq("1285.09")
    end

    it "returns the total revenue for that merchant across successful transactions" do
      get "/api/v1/merchants/#{@merchant1.id}/revenue"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["revenue"]).to eq("1127.12")
    end

    it "returns the total revenue for that merchant for a specific invoice date x" do
      get "/api/v1/merchants/#{@merchant1.id}/revenue?date=2012-03-27"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["revenue"]).to eq("1127.12")
    end

    context 'edge cases' do
      it "failed transactions are not included in top x merchants ranked by total revenue" do
        get '/api/v1/merchants/most_revenue?quantity=4'

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(3)
      end
    end
  end
end
