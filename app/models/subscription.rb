class Subscription < ActiveRecord::Base

  validates :email, uniqueness: true, presence: true
  validates :confirmation_token, uniqueness: true, presence: true
  validates_presence_of :start_on

  scope :confirmation_overdue, -> { where("created_at < ?", 3.days.ago).where(confirmed: false) }

  after_initialize :init_start_on

  def self.create_and_request_confirmation(params)
    transaction do
      subscription = create!(
        email: params[:email],
        start_on: params[:start_on],
        confirmation_token: generate_confirmation_token
      )
      SubscriptionMailer.send_confirmation_request!(subscription)
      subscription
    end
  end

  def self.generate_confirmation_token
    SecureRandom.hex(32)
  end

  def self.confirm(confirmation_token)
    subscription = find_by!(confirmation_token: confirmation_token)
    subscription.update!(confirmed: true)
    subscription
  end

  def to_param
    confirmation_token
  end

  private

  def init_start_on
    self.start_on = Time.zone.today if new_record? && start_on.blank?
  end

end
