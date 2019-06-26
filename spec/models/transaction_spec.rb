require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before :each do
    @customer1 = create(:customer, first_name: "Customer", last_name: "1")
    @customer2 = create(:customer, first_name: "Customer", last_name: "2")

    @merchant1 = create(:merchant, name: "Merchant 1")
    @merchant2 = create(:merchant, name: "Merchant 2")
    @merchant3 = create(:merchant, name: "Merchant 3")
    @merchant4 = create(:merchant, name: "Merchant 4")

    @item1 = create(:item, unit_price: 6666, merchant: @merchant1)
    @item2 = create(:item, unit_price: 10101, merchant: @merchant2)
    @item3 = create(:item, unit_price: 3452, merchant: @merchant3)
    @item4 = create(:item, unit_price: 53023, merchant: @merchant1)
    @item5 = create(:item, unit_price: 12345, merchant: @merchant3)
    @item6 = create(:item, unit_price: 3456, merchant: @merchant4)

    @invoice1 = create(:invoice, merchant: @merchant1, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z")
    @invoice2 = create(:invoice, merchant: @merchant2, customer: @customer1)
    @invoice3 = create(:invoice, merchant: @merchant3, customer: @customer1, created_at: "2012-03-27T14:54:05.000Z")
    @invoice4 = create(:invoice, merchant: @merchant1, customer: @customer2, created_at: "2012-03-27T14:54:05.000Z")
    @invoice5 = create(:invoice, merchant: @merchant4, customer: @customer2)

    @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
    @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
    @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
    @transaction4 = create(:transaction, invoice: @invoice4, result: "success")
    @transaction5 = create(:transaction, invoice: @invoice5)

    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
    @invoice_item2 = create(:invoice_item, item: @item4, invoice: @invoice1, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item3 = create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 1, unit_price: @item2.unit_price)
    @invoice_item4 = create(:invoice_item, item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price)
    @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice3, quantity: 1, unit_price: @item5.unit_price)
    @invoice_item6 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 1, unit_price: @item4.unit_price)
    @invoice_item7 = create(:invoice_item, item: @item6, invoice: @invoice5, quantity: 1, unit_price: @item6.unit_price)
  end

  describe 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'scopes' do
    it "successful" do
      successful_transactions = Transaction.successful

      expect(successful_transactions.count).to eq(4)
      expect(Transaction.all.count).to eq(5)
    end
  end
end
