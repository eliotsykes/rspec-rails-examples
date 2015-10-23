class AccessToken < ActiveRecord::Base
  include HardenedToken
  hardened_token

  belongs_to :user

end
