require 'rails_helper'

describe "Transactions API:" do
  before :each do
    Faker::UniqueGenerator.clear

    @customer1 = create(:customer, first_name: "Customer", last_name: "1")
    @customer2 = create(:customer, first_name: "Customer", last_name: "2")

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

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1)
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1)
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2)
    @invoice5 = create(:invoice, merchant: @merchant4, customer: @customer2)

    @transaction1 = create(:transaction, invoice: @invoice1, result: "success", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @transaction2 = create(:transaction, invoice: @invoice2, result: "success", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
    @transaction4 = create(:transaction, invoice: @invoice4, result: "success", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
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
    it "sends a list of transactions" do
      get "/api/v1/transactions"

      transaction = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transaction.count).to eq(4)
    end

    it "can get one transaction by its id" do
      get "/api/v1/transactions/#{@transaction1.id}"

      transaction = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transaction["id"].to_i).to eq(@transaction1.id)
    end

    describe "Transactions Single Finders" do
      it "can find transaction by its id" do
        get "/api/v1/transactions/find?id=#{@transaction1.id}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["id"].to_i).to eq(@transaction1.id)
      end

      it "can find transaction by its invoice_id" do
        get "/api/v1/transactions/find?invoice_id=#{@transaction1.invoice_id}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
      end

      it "can find transaction by its credit_card_number" do
        get "/api/v1/transactions/find?credit_card_number=#{@transaction1.credit_card_number}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
      end

      it "can find transaction by its result" do
        get "/api/v1/transactions/find?result=#{@transaction1.result}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["result"]).to eq(@transaction1.result)
      end

      it "can find transaction by its created_at" do
        get "/api/v1/transactions/find?#{@transaction1.created_at}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["id"]).to eq(@transaction1.id)
      end

      it "can find transaction by its updated_at" do
        get "/api/v1/transactions/find?updated_at=#{@transaction1.updated_at}"

        transaction = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transaction["attributes"]["id"]).to eq(@transaction1.id)
      end
    end

    describe "Customers Multi-Finders" do
      it "can find transactions by its id" do
        get "/api/v1/transactions/find_all?id=#{@transaction1.id}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(1)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its invoice_id" do
        get "/api/v1/transactions/find_all?invoice_id=#{@transaction1.invoice_id}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(1)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its credit_card_number" do
        get "/api/v1/transactions/find_all?credit_card_number=#{@transaction1.credit_card_number}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(1)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its result" do
        get "/api/v1/transactions/find_all?result=#{@transaction1.result}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(4)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its created_at" do
        get "/api/v1/transactions/find_all?created_at=#{@transaction1.created_at}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(3)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its updated_at" do
        get "/api/v1/transactions/find_all?updated_at=#{@transaction1.updated_at}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(3)
        expect(transactions.class).to eq(Array)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns the associated invoice" do
      get "/api/v1/transactions/#{@transaction1.id}/invoice"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice["id"].to_i).to eq(@invoice1.id)
      expect(invoice["type"]).to eq("invoice")
    end
  end

  # Business Intelligent Endpoints
end
