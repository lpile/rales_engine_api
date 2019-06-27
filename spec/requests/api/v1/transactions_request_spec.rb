require 'rails_helper'

describe "Transactions API:" do
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
      @transaction1 = create(:transaction, invoice: @invoice1, result: "success", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success", created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice2)
    end

    it "sends a list of transactions" do
      get "/api/v1/transactions"

      transaction = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transaction.count).to eq(2)
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
        expect(transactions.count).to eq(2)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its created_at" do
        get "/api/v1/transactions/find_all?created_at=#{@transaction1.created_at}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(2)
        expect(transactions.class).to eq(Array)
      end

      it "can find transactions by its updated_at" do
        get "/api/v1/transactions/find_all?updated_at=#{@transaction1.updated_at}"

        transactions = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(transactions.count).to eq(2)
        expect(transactions.class).to eq(Array)
      end
    end
  end

  # Relationship Endpoints

  # Business Intelligent Endpoints
end
