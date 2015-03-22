class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
  end

  def create
    Subscription.create_and_request_confirmation(subscription_params)
    redirect_to pending_subscriptions_path
  end

  def pending
  end

  def confirm
    confirmation_token = params.require(:confirmation_token).to_s
    @subscription = Subscription.confirm(confirmation_token)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email, :start_on)
  end

end
