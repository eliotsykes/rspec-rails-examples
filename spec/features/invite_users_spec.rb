require 'rails_helper'

RSpec.feature "Invite users", type: :feature do

  context "Invite.send_invite(email)" do

    scenario "enables invited user to register" do
      Invite.send_invite("mary@example.tld")

      open_email "mary@example.tld", with_subject: "You're invited to register"
      visit_in_email "Click here to register"

      expect(page).to have_css("h1", text: "Register")
      fill_in "Choose a password", with: "some password"
      fill_in "Re-enter your chosen password", with: "some password"
      click_button "Register"

      expect(page).to have_text(
        "A message with a confirmation link has been sent to your email address.
        Please follow the link to activate your account."
      )

      open_email "mary@example.tld", with_subject: "Confirmation instructions"
      visit_in_email "Confirm my account"

      expect(page).to have_content "Your email address has been successfully confirmed."
      expect(current_path).to eq new_user_session_path

      fill_in "Email", with: "mary@example.tld"
      fill_in "Password", with: "some password"
      click_button "Log in"

      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Hello, mary@example.tld"
      expect(current_path).to eq "/"
    end

  end

end
