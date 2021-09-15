require 'rails_helper'

RSpec.describe 'Tea Requests' do
  before(:all) do
    @customer = create(:customer)
    @subscription = @customer.subscriptions.create(price: 12.3, frequency: 1)
    @teas = create_list(:tea, 4)
    @teas = @teas.map { |tea| tea.variety }
  end

  describe 'create' do
    it 'creates join table records for a given subscription' do
      st_params = {
        teas: @teas
      }
      headers = {'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}/teas", headers: headers, params: JSON.generate(st_params)
      expect(response.status).to eq 201
      changed_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(changed_subscription).is_a? Hash
      expect(changed_subscription).to have_key(:data)
      expect(changed_subscription[:data]).is_a? Hash
      expect(changed_subscription[:data]).to have_key(:id)
      expect(changed_subscription[:data][:id]).is_a? String
      expect(changed_subscription[:data]).to have_key(:type)
      expect(changed_subscription[:data][:type]).to eq 'subscription'
      expect(changed_subscription[:data]).to have_key(:attributes)
      expect(changed_subscription[:data][:attributes]).is_a? Hash
      expect(changed_subscription[:data][:attributes]).to have_key(:title)
      expect(changed_subscription[:data][:attributes][:title]).is_a? String
      expect(changed_subscription[:data][:attributes][:title]).not_to eq 'untitled subscription'
      expect(changed_subscription[:data][:attributes]).to have_key(:price)
      expect(changed_subscription[:data][:attributes][:price]).to eq 12.3
      expect(changed_subscription[:data][:attributes]).to have_key(:status)
      expect(changed_subscription[:data][:attributes][:status]).to eq 'active'
      expect(changed_subscription[:data][:attributes]).to have_key(:frequency)
      expect(changed_subscription[:data][:attributes][:frequency]).to eq 'monthly'
    end

    it 'test/add error handling'

    it 'test nonexistent teas'
  end
end