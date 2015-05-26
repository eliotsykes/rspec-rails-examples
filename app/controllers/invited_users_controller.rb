class InvitedUsersController < ApplicationController
  def new
    @invite = Invite.find_by(token: params[:token])
  end

  def create
  end
end
