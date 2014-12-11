class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
  end

  def create
    redirect_to pending_subscriptions_path
  end

  def pending
  end
  
end
