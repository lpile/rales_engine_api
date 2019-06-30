require 'rails_helper'

describe "Merchants API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1, @customer2 = create_list(:customer, 2)

    @merchant1, @merchant2 = create_list(:merchant, 2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @merchant3, @merchant4 = create_list(:merchant, 2)

    @item1, @item2 = create_list(:expensive_item, 2, merchant: @merchant1)
    @item3 = create(:cheap_item , merchant: @merchant2)
    @item4, @item5, @item6 = create_list(:moderate_item , 3, merchant: @merchant3)
    @item7 = create(:moderate_item , merchant: @merchant4)

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant2, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice4 = create(:invoice, merchant: @merchant3, customer: @customer1)
    @invoice5, @invoice6 = create_list(:invoice, 2, merchant: @merchant3, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice7 = create(:invoice, merchant: @merchant4, customer: @customer1)

    @transaction1, @transaction2 = create_list(:transaction, 2, invoice: @invoice1)
    @transaction3 = create(:success_transaction, invoice: @invoice1)
    @transaction4 = create(:transaction, invoice: @invoice2)
    @transaction5 = create(:success_transaction, invoice: @invoice2)
    @transaction6 = create(:success_transaction, invoice: @invoice3)
    @transaction7 = create(:success_transaction, invoice: @invoice4)
    @transaction8 = create(:success_transaction, invoice: @invoice5)
    @transaction9, @transaction10, @transaction11 = create_list(:transaction, 3, invoice: @invoice6)
    @transaction12 = create(:success_transaction, invoice: @invoice6)
    @transaction13 = create(:transaction, invoice: @invoice7)

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
    @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice1, quantity: 1, unit_price: @item2.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item3, invoice: @invoice2, quantity: 5, unit_price: @item3.unit_price)
    @invoice_item4 = create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 2, unit_price: @item4.unit_price)
    @invoice_item6 = create(:invoice_item, item: @item5, invoice: @invoice4, quantity: 1, unit_price: @item5.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item4, invoice: @invoice5, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item8 = create(:invoice_item, item: @item6, invoice: @invoice6, quantity: 1, unit_price: @item6.unit_price)
    @invoice_item9 = create(:invoice_item, item: @item7, invoice: @invoice7, quantity: 1, unit_price: @item7.unit_price)
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

      it "can return random merchant" do
        merchants = Merchant.all.map { |merchant| merchant.id }

        get "/api/v1/merchants/random"

        merchant = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchant["type"]).to eq("merchant")
        expect(merchants).to include(merchant["id"].to_i)
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
      get "/api/v1/merchants/#{@merchant3.id}/invoices"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(3)
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
      expect(merchants[0]["id"].to_i).to eq(@merchant3.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant1.id)
    end

    it "returns the top x merchants ranked by total number of items sold" do
      get '/api/v1/merchants/most_items?quantity=2'

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0]["id"].to_i).to eq(@merchant2.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant3.id)
    end

    it "returns the total revenue for date x across all merchants" do
      total = (((@item3.unit_price + @item4.unit_price + @item6.unit_price) / 100.0).to_s)

      get "/api/v1/merchants/revenue?date=2012-03-27"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["total_revenue"]).to eq(total)
    end

    it "returns the total revenue for that merchant across successful transactions" do
      total = (((@item3.unit_price * 6) / 100.0).to_s)

      get "/api/v1/merchants/#{@merchant2.id}/revenue"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["revenue"]).to eq(total)
    end

    it "returns the total revenue for that merchant for a specific invoice date x" do
      total = ((@item3.unit_price / 100.0).to_s)

      get "/api/v1/merchants/#{@merchant2.id}/revenue?date=2012-03-27"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(revenue["attributes"]["revenue"]).to eq(total)
    end

    it "returns the customer who has conducted the most total number of successful transactions" do
      get "/api/v1/merchants/#{@merchant3.id}/favorite_customer"

      customer = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customer["type"]).to eq("customer")
      expect(customer["id"].to_i).to eq(@customer2.id)
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
