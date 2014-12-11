class Subscription < ActiveRecord::Base

  def self.create_and_request_confirmation!(email)
    subscription = Subscription.create!(
      email: email,
      confirmation_token: generate_confirmation_token
    )
    SubscriptionMailer.confirmation_request(subscription).deliver_now
    subscription
  end

  def self.generate_confirmation_token
    SecureRandom.hex(32)
  end

  def self.confirm!(confirmation_token)
    Subscription.find_by(confirmation_token: confirmation_token).update!(confirmed: true)
  end

  def to_param
    confirmation_token
  end

end
