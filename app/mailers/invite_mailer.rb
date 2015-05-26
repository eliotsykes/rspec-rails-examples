class InviteMailer < ApplicationMailer

  def invite(invite)
    @invite = invite
    mail to: invite.email, subject: "You're invited to register"
  end
  
end
