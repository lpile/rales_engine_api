require 'rails_helper'

describe "Merchants API:" do
  describe "Record Endpoints" do
    before :each do
      @merchant1 = create(:merchant, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @merchant2 = create(:merchant, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    end

    it "sends a list of merchants" do
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(merchants.count).to eq(2)
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
        get "/api/v1/merchants/find_all?#{@merchant1.created_at}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(2)
        expect(merchants.class).to eq(Array)
      end

      it "can find merchant by its updated_at" do
        get "/api/v1/merchants/find_all?#{@merchant1.updated_at}"

        merchants = JSON.parse(response.body)["data"]

        expect(response).to be_successful
        expect(merchants.count).to eq(2)
        expect(merchants.class).to eq(Array)
      end
    end
  end

  # Relationship Endpoint

  # Business Endpoints
end
