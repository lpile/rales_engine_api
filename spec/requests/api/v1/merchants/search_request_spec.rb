require 'rails_helper'

describe "Merchants API Finders," do
  before :each do
    @merchant = create(:merchant, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    @merchant2 = create(:merchant, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
  end

  describe "find parameters by attributes" do
    it "can find merchant by its id" do
      get "/api/v1/merchants/find?id=#{@merchant.id}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["attributes"]["id"].to_i).to eq(@merchant.id)
    end

    it "can find merchant by its name" do
      get "/api/v1/merchants/find?name=#{@merchant.name}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["attributes"]["name"]).to eq(@merchant.name)
    end

    it "can find merchant by its created_at" do
      get "/api/v1/merchants/find?#{@merchant.created_at}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["attributes"]["id"]).to eq(@merchant.id)
    end

    it "can find merchant by its updated_at" do
      get "/api/v1/merchants/find?updated_at=#{@merchant.updated_at}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["attributes"]["id"]).to eq(@merchant.id)
    end
  end

  describe "find all parameters by attributes" do
    it "can find merchant by its id" do
      get "/api/v1/merchants/find_all?id=#{@merchant.id}"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(1)
      expect(merchants.class).to eq(Array)
    end

    it "can find merchant by its name" do
      get "/api/v1/merchants/find_all?name=#{@merchant.name}"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(1)
      expect(merchants.class).to eq(Array)
    end

    it "can find merchant by its created_at" do
      get "/api/v1/merchants/find_all?#{@merchant.created_at}"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants.class).to eq(Array)
    end

    it "can find merchant by its updated_at" do
      get "/api/v1/merchants/find_all?#{@merchant.updated_at}"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants.class).to eq(Array)
    end
  end
end
