require 'rails_helper'

describe "Customers API:" do
  describe "Record Endpoints" do
    before :each do
      Faker::UniqueGenerator.clear
      @customer1 = create(:customer, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
      @customer2 = create(:customer, created_at: "2012-03-27T14:54:05.000Z", updated_at: "2012-03-27T14:54:05.000Z")
    end

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
    end
  end

  # Relationship Endpoints

  # Business Intelligent Endpoints
end
