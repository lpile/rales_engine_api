require 'rails_helper'

describe "Invoices API:" do
  describe "Record Endpoints" do
    before :each do
      Faker::UniqueGenerator.clear
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    end

    it "sends a list of invoices" do
      get "/api/v1/invoices"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice.count).to eq(2)
    end

    it "can get one invoice by its id" do
      get "/api/v1/invoices/#{@invoice1.id}"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice["id"].to_i).to eq(@invoice1.id)
    end

    describe "Invoices Single Finders" do
      it "can find invoice by its id" do
        get "/api/v1/invoices/find?id=#{@invoice1.id}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["id"].to_i).to eq(@invoice1.id)
      end

      it "can find invoice by its customer_id" do
        get "/api/v1/invoices/find?customer_id=#{@invoice1.customer_id}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
      end

      it "can find invoice by its merchant_id" do
        get "/api/v1/invoices/find?merchant_id=#{@invoice1.merchant_id}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["merchant_id"]).to eq(@invoice1.merchant_id)
      end

      it "can find invoice by its status" do
        get "/api/v1/invoices/find?status=#{@invoice1.status}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["status"]).to eq(@invoice1.status)
      end

      it "can find invoice by its created_at" do
        get "/api/v1/invoices/find?#{@invoice1.created_at}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
      end

      it "can find invoice by its updated_at" do
        get "/api/v1/invoices/find?updated_at=#{@invoice1.updated_at}"

        invoice = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
      end
    end

    describe "Customers Multi-Finders" do
      it "can find invoices by its id" do
        get "/api/v1/invoices/find_all?id=#{@invoice1.id}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(1)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its customer_id" do
        get "/api/v1/invoices/find_all?customer_id=#{@invoice1.customer_id}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(1)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its merchant_id" do
        get "/api/v1/invoices/find_all?merchant_id=#{@invoice1.merchant_id}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(1)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its status" do
        get "/api/v1/invoices/find_all?status=#{@invoice1.status}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(2)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its created_at" do
        get "/api/v1/invoices/find_all?created_at#{@invoice1.created_at}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(2)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its updated_at" do
        get "/api/v1/invoices/find_all?updated_at=#{@invoice1.updated_at}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(2)
        expect(invoices.class).to eq(Array)
      end
    end
  end

  # Relationship Endpoints

  # Business Intelligent Endpoints
end
