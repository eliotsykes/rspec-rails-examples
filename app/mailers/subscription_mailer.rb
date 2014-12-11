class SubscriptionMailer < ApplicationMailer

  def self.send_confirmation_request!(subscription)
    confirmation_request(subscription).deliver_now!
  end

  def confirmation_request(subscription)
    @subscription = subscription
    mail to: subscription.email, subject: "Please confirm"
  end
end
