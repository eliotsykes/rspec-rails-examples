class EmailsController < ApplicationController

  def index
    # Then explore how this could be cached with Rails.cache (or automatic query cache?)
    # Mention privacy concerns, would be less of a concern with public usernames
    # (like GitHub usernames are widely accepted as being public)
    email = params.fetch(:email, '')
    @emails = email.size < 2 ? [] : User.emails_starting_with(email)
  end

end
