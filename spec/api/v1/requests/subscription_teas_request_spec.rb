require 'rails_helper'

RSpec.describe 'SubscriptionTea Requests' do
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
      
    end
  end
end