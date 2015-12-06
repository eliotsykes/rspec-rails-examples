class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  ROLES = ["standard", "premium"].freeze

  validates_inclusion_of :role, in: ROLES

  has_many :access_tokens, dependent: :destroy

  def issue_access_token
    access_tokens.create!
  end
end
