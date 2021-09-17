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

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: 200
  end

  def cancel
    subscription = Subscription.find(params[:subscription_id])
    subscription.update(status: 'cancelled')
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.permit(:price, :frequency)
  end
end