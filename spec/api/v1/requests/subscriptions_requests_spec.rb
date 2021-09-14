require 'rails_helper'

RSpec.describe 'Subscription Requests' do
  describe 'create' do
    before(:all) do
      @customer = create(:customer)
      @teas = create_list(:tea, 4)
      @subscription = @customer.subscriptions.create!(price: 10.5)
      @teas.each do |tea|
        SubscriptionTea.create!(tea_id: tea.id, subscription_id: @subscription.id)
      end
    end

    it 'creates a new subscription' do
      subscription_params = {
        price: 10,
        frequency: 1,
        teas: @teas
      }
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      # expect(response.status).to eq 201

      # subscription = Subscription.last

      binding.pry
    end

    it 'returns serialized json data'

    it 'ignores extra attributes'

    it 'will not create if teas are empty'

    it 'does not create without price'

    it 'populates the title based on user name and frequency'


  end
end