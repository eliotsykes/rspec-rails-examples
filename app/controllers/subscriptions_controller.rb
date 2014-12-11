class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
  end

  def create
    email = params.require(:subscription).require(:email).to_s
    Subscription.create_and_request_confirmation! email
    redirect_to pending_subscriptions_path
  end

  def pending
  end

  def confirm
    confirmation_token = params.require(:confirmation_token).to_s
    Subscription.confirm!(confirmation_token)
  end

end
