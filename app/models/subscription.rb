class Subscription < ActiveRecord::Base

  validates :email, uniqueness: true, presence: true
  validates :confirmation_token, uniqueness: true, presence: true

  def self.create_and_request_confirmation!(email)
    Subscription.transaction do
      subscription = Subscription.create!(
        email: email,
        confirmation_token: generate_confirmation_token
      )
      SubscriptionMailer.send_confirmation_request!(subscription)
      subscription
    end
  end

  def self.generate_confirmation_token
    SecureRandom.hex(32)
  end

  def self.confirm!(confirmation_token)
    Subscription.find_by!(confirmation_token: confirmation_token).update!(confirmed: true)
  end

  def to_param
    confirmation_token
  end

end
