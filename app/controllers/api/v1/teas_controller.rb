class Api::V1::TeasController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    teas = tea_finder(params[:teas])
    subscription_tea_populator(params[:subscription_id], teas)
    subscription = Subscription.find(params[:subscription_id])
    subscription.update(title: "#{customer.first_name}'s #{subscription.frequency} subscription", status: 2)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  private

  def tea_finder(varieties)
    varieties.map do |variety|
      Tea.find_by(variety: variety)
    end
  end

  def subscription_tea_populator(subscription_id, tea_array)
    tea_array.map do |tea|
      SubscriptionTea.create(subscription_id: subscription_id, tea_id: tea.id)
    end
  end
end
