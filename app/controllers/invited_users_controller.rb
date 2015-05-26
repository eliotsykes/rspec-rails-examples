class InvitedUsersController < ApplicationController
  def new
    @invite = Invite.find_by(token: params[:token])
  end

  def create
    invite = Invite.find_by(invite_params)
    user = User.new(user_params)
    user.email = invite.email
    if user.save
      flash[:notice] = "A message with a confirmation link has been sent to your
        email address. Please follow the link to activate your account."
    else
      flash[:alert] = "Sorry, there was a problem registering the invited user."
    end
    redirect_to root_path
  end

  private

  def invite_params
    params.require(:invite).permit(:token)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
