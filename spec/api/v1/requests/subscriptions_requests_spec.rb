require 'rails_helper'

RSpec.describe 'Subscription Requests' do
  before(:all) do
    @customer = create(:customer)
  end
  describe 'create' do
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

  describe 'index' do
    it 'returns all subscriptions for a given user' do
      @customer.subscriptions.create!(title: "#{@customer.first_name}'s weekly tea subscription", status: 0, frequency: 0, price: 2.3)
      @customer.subscriptions.create!(title: "#{@customer.first_name}'s monthly tea subscription",status: 1, frequency: 1, price: 3.4)
      @customer.subscriptions.create!(title: "#{@customer.first_name}'s bi-monthly tea subscription", status: 2, frequency: 2, price: 4.5)

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      expect(response.status).to eq 200
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).is_a? Array
      expect(subscriptions[:data].length).to eq 3
      subscriptions[:data].each do |hash|
        expect(hash).to have_key(:id)
        expect(hash[:id]).is_a? String
        expect(hash).to have_key(:type)
        expect(hash[:type]).to eq 'subscription'
        expect(hash).to have_key(:attributes)
        expect(hash[:attributes]).is_a? Hash
        expect(hash[:attributes]).to have_key(:title)
        expect(hash[:attributes][:title]).is_a? String
        expect(hash[:attributes]).to have_key(:price)
        expect(hash[:attributes][:price]).is_a? Float
        expect(hash[:attributes]).to have_key(:status)
        expect(hash[:attributes][:status]).is_a? String
        expect(hash[:attributes]).to have_key(:frequency)
        expect(hash[:attributes][:frequency]).is_a? String
      end
    end
  end
end