class SubscriptionMailer < ApplicationMailer

  def confirmation_request(subscription)
    @subscription = subscription
    mail to: subscription.email, subject: "Please confirm"
  end
end
