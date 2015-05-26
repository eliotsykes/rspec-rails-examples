class Invite < ActiveRecord::Base

  def self.send_invite(email)
    transaction do
      invite = create!(email: email, token: SecureRandom.hex)
      InviteMailer.invite(invite).deliver_now!
    end
  end

end
