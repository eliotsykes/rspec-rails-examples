class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :access_tokens, dependent: :destroy

  def self.emails_starting_with(email)
    where("email LIKE ?", "#{email}%").order(email: :asc).limit(20).pluck(:email)
  end

  def issue_access_token
    access_tokens.create!
  end
end
