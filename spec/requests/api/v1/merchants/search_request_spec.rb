require 'rails_helper'

describe "Merchants API Finders," do
  before :each do
    @merchant = create(:merchant)
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
      get "/api/v1/merchants/find?#{@merchant.updated_at}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchant["attributes"]["id"]).to eq(@merchant.id)
    end
  end
end
