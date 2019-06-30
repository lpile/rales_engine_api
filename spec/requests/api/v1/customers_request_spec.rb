require 'rails_helper'

describe "Customers API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1 = create(:customer, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @customer2 = create(:customer, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")

    @merchant1 = create(:merchant, name: "Merchant 1")
    @merchant2 = create(:merchant, name: "Merchant 2")
    @merchant3 = create(:merchant, name: "Merchant 3")
    @merchant4 = create(:merchant, name: "Merchant 4")

    @item1 = create(:item, unit_price: 6666, merchant: @merchant1)
    @item2 = create(:item, unit_price: 1010, merchant: @merchant2)
    @item3 = create(:item, unit_price: 3452, merchant: @merchant3)
    @item4 = create(:item, unit_price: 53023, merchant: @merchant1)
    @item5 = create(:item, unit_price: 12345, merchant: @merchant3)
    @item6 = create(:item, unit_price: 3456, merchant: @merchant4)

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z")
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z")
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z")
    @invoice5 = create(:invoice, merchant: @merchant4, customer: @customer2)
    @invoice6 = create(:invoice, merchant: @merchant1, customer: @customer1)

    @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
    @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
    @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
    @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
    @transaction5 = create(:transaction, invoice: @invoice5)
    @transaction6 = create(:transaction, invoice: @invoice6, result: "success")

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
    @invoice_item2 = create(:invoice_item, item: @item4, invoice: @invoice1, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 7, unit_price: @item2.unit_price)
    @invoice_item4 = create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice3, quantity: 1, unit_price: @item5.unit_price)
    @invoice_item6 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item6, invoice: @invoice5, quantity: 1, unit_price: @item6.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item4, invoice: @invoice6, quantity: 1, unit_price: @item4.unit_price)
  end

  describe "Record Endpoints" do
    it "sends a list of customers" do
      get "/api/v1/customers"

      customers = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customers.count).to eq(2)
    end

    it "can get one customer by its id" do
      get "/api/v1/customers/#{@customer1.id}"

      customer = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customer["id"].to_i).to eq(@customer1.id)
    end

    describe "Customers Single Finders" do
      it "can find customer by its id" do
        get "/api/v1/customers/find?id=#{@customer1.id}"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["attributes"]["id"].to_i).to eq(@customer1.id)
      end

      it "can find customer by its first_name" do
        get "/api/v1/customers/find?first_name=#{@customer1.first_name}"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["attributes"]["first_name"]).to eq(@customer1.first_name)
      end

      it "can find customer by its last_name" do
        get "/api/v1/customers/find?last_name=#{@customer1.last_name}"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["attributes"]["last_name"]).to eq(@customer1.last_name)
      end

      it "can find customer by its created_at" do
        get "/api/v1/customers/find?#{@customer1.created_at}"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["attributes"]["id"]).to eq(@customer1.id)
      end

      it "can find customer by its updated_at" do
        get "/api/v1/customers/find?updated_at=#{@customer1.updated_at}"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["attributes"]["id"]).to eq(@customer1.id)
      end
    end

    describe "Customers Multi-Finders" do
      it "can find customers by its id" do
        get "/api/v1/customers/find_all?id=#{@customer1.id}"

        customers = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customers.count).to eq(1)
        expect(customers.class).to eq(Array)
      end

      it "can find customers by its first_name" do
        get "/api/v1/customers/find_all?first_name=#{@customer1.first_name}"

        customers = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customers.count).to eq(1)
        expect(customers.class).to eq(Array)
      end

      it "can find customers by its last_name" do
        get "/api/v1/customers/find_all?last_name=#{@customer1.last_name}"

        customers = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customers.count).to eq(1)
        expect(customers.class).to eq(Array)
      end

      it "can find customers by its created_at" do
        get "/api/v1/customers/find_all?created_at=#{@customer1.created_at}"

        customers = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customers.count).to eq(2)
        expect(customers.class).to eq(Array)
      end

      it "can find customers by its updated_at" do
        get "/api/v1/customers/find_all?updated_at=#{@customer1.updated_at}"

        customers = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customers.count).to eq(2)
        expect(customers.class).to eq(Array)
      end

      it "can return random customer" do
        customers = Customer.all.map { |customer| customer.id }

        get "/api/v1/customers/random"

        customer = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(customer["type"]).to eq("customer")
        expect(customers).to include(customer["id"].to_i)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns a collection of associated transactions" do
      get "/api/v1/customers/#{@customer1.id}/transactions"

      customers = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customers.count).to eq(4)
      expect(customers.class).to eq(Array)
      expect(customers[0]["type"]).to eq("transaction")
    end

    it "returns a collection of associated invoices" do
      get "/api/v1/customers/#{@customer1.id}/invoices"

      customers = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customers.count).to eq(4)
      expect(customers.class).to eq(Array)
      expect(customers[0]["type"]).to eq("invoice")
    end
  end

  describe "Business Intelligent Endpoints" do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      get "/api/v1/customers/#{@customer1.id}/favorite_merchant"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["type"]).to eq("merchant")
      expect(merchant["id"].to_i).to eq(@merchant1.id)
    end
  end
end
