require 'rails_helper'

describe "Invoices API:" do
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

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2)
    @invoice5 = create(:invoice, merchant: @merchant4, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")

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
    it "sends a list of invoices" do
      get "/api/v1/invoices"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice.count).to eq(5)
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
        expect(invoices.count).to eq(3)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its merchant_id" do
        get "/api/v1/invoices/find_all?merchant_id=#{@invoice1.merchant_id}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(2)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its status" do
        get "/api/v1/invoices/find_all?status=#{@invoice1.status}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(5)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its created_at" do
        get "/api/v1/invoices/find_all?created_at=#{@invoice1.created_at}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(3)
        expect(invoices.class).to eq(Array)
      end

      it "can find invoices by its updated_at" do
        get "/api/v1/invoices/find_all?updated_at=#{@invoice1.updated_at}"

        invoices = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(invoices.count).to eq(3)
        expect(invoices.class).to eq(Array)
      end
    end
  end

  describe "Relationship Endpoints" do
    it "returns the associated customer" do
      get "/api/v1/invoices/#{@invoice1.id}/customer"

      customer = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(customer["id"].to_i).to eq(@customer1.id)
      expect(customer["type"]).to eq("customer")
    end

    it "returns the associated merchant" do
      get "/api/v1/invoices/#{@invoice1.id}/merchant"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["id"].to_i).to eq(@merchant1.id)
      expect(merchant["type"]).to eq("merchant")
    end

    it "returns a collection of associated transactions" do
      get "/api/v1/invoices/#{@invoice1.id}/transactions"

      transactions = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transactions.count).to eq(1)
      expect(transactions.class).to eq(Array)
      expect(transactions[0]["type"]).to eq("transaction")
    end

    it "returns a collection of associated invoice items" do
      get "/api/v1/invoices/#{@invoice1.id}/invoice_items"

      invoice_items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.class).to eq(Array)
      expect(invoice_items[0]["type"]).to eq("invoice_item")
    end

    it "returns a collection of associated invoice items" do
      get "/api/v1/invoices/#{@invoice1.id}/invoice_items"

      invoice_items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.class).to eq(Array)
      expect(invoice_items[0]["type"]).to eq("invoice_item")
    end

    it "returns a collection of associated invoice items" do
      get "/api/v1/invoices/#{@invoice1.id}/items"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items.class).to eq(Array)
      expect(items[0]["type"]).to eq("item")
    end
  end

  # Business Intelligent Endpoints
end
