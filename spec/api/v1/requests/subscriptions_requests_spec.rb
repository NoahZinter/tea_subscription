require 'rails_helper'

RSpec.describe 'Subscription Requests' do
  describe 'create' do
    before(:all) do
      @customer = create(:customer)
    end

    it 'creates a new subscription' do
      subscription_params = {
        frequency: 1,
        price: 10.5
      }
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      expect(response.status).to eq 201

      subscription = Subscription.last
      expect(subscription.status).to eq 'pending'
      expect(subscription.title).to eq 'untitled subscription'
      expect(subscription.price).to eq 10.5
      expect(subscription.frequency).to eq 'monthly'
      expect(subscription.customer_id).to eq @customer.id
    end

    it 'returns serialized json data' do
      subscription_params = {
        frequency: 1,
        price: 10.5
      }
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)
      expect(response.status).to eq 201
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription).is_a? Hash
      expect(subscription).to have_key(:data)
      expect(subscription[:data]).is_a? Hash
      expect(subscription[:data]).to have_key(:id)
      expect(subscription[:data][:id]).is_a? String
      expect(subscription[:data]).to have_key(:type)
      expect(subscription[:data][:type]).to eq 'subscription'
      expect(subscription[:data]).to have_key(:attributes)
      expect(subscription[:data][:attributes]).is_a? Hash
      expect(subscription[:data][:attributes]).to have_key(:title)
      expect(subscription[:data][:attributes][:title]).to eq 'untitled subscription'
      expect(subscription[:data][:attributes]).to have_key(:price)
      expect(subscription[:data][:attributes][:price]).to eq 10.5
      expect(subscription[:data][:attributes]).to have_key(:frequency)
      expect(subscription[:data][:attributes][:frequency]).to eq 'monthly'

    end

    it 'ignores extra attributes' do
      subscription_params = {
        frequency: 1,
        price: 10.5,
        foo: 'bar',
        baz: 'biff'
      }
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      expect(response.status).to eq 201

      subscription = Subscription.last
      expect(subscription.status).to eq 'pending'
      expect(subscription.title).to eq 'untitled subscription'
      expect(subscription.price).to eq 10.5
      expect(subscription.frequency).to eq 'monthly'
      expect(subscription.customer_id).to eq @customer.id
      expect{subscription.foo}.to raise_error(NameError)
      expect{subscription.baz}.to raise_error(NameError)
    end

    it 'does not create without price' do
      subscription_params = {
        frequency: 1,
        price: nil
      }
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      expect(response.status).to eq 400
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to eq 'Subscription not initiated'
    end
  end
end