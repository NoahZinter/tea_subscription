class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: 'Subscription not initiated'}, status: 400
    end
  end

  private

  def subscription_params
    params.permit(:price, :frequency)
  end
end