class Api::V1::TeasController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find_by(variety: params[:variety])
    added_tea = SubscriptionTea.new(tea_id: tea.id, subscription_id: params[:subscription_id])
    if added_tea.save
      subscription = Subscription.find(params[:subscription_id])
      subscription.update(title: "#{customer.first_name}'s #{subscription.frequency} subscription", status: 2)
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: 'Tea not added to subscription'}, status: 400
    end
  end
end
