require 'rails_helper'

describe "Merchants API Finders," do
  describe "find parameters(attributes)" do
    before :each do
      @merchant = create(:merchant)
      @expected = {"data": {
                      "id": "#{@merchant.id}",
                      "type": "merchant",
                      "attributes": {
                        "name": "#{@merchant.name}"
                      }
                    }
                  }
    end

    it "can find merchant by its id" do

      get "/api/v1/merchants/find?id=#{@merchant.id}"

      expect(response).to be_successful
      expect(response.body).to eq(@expected.to_json)
    end

    it "can find merchant by its name" do

      get "/api/v1/merchants/find?name=#{@merchant.name}"

      expect(response).to be_successful
      expect(response.body).to eq(@expected.to_json)
    end

    it "can find merchant by its created_at" do

      get "/api/v1/merchants/find?created_by=#{@merchant.created_at}"

      expect(response).to be_successful
      expect(response.body).to eq(@expected.to_json)
    end

    it "can find merchant by its updated_at" do

      get "/api/v1/merchants/find?created_by=#{@merchant.updated_at}"

      expect(response).to be_successful
      expect(response.body).to eq(@expected.to_json)
    end
  end
end
