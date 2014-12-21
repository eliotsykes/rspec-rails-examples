require 'rails_helper'

feature "User registers", :type => :feature do

  scenario "with valid details" do

    visit new_user_registration_path

    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"

    expect(current_path).to eq "/"
    expect(page).to have_content(
      "A message with a confirmation link has been sent to your email address.
      Please follow the link to activate your account."
    )

    open_email "tester@example.tld", with_subject: "Confirmation instructions"
    visit_in_email "Confirm my account"

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "Your email address has been successfully confirmed."

    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    click_button "Log in"

    expect(current_path).to eq "/"
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Hello, tester@example.tld"
  end


  xscenario "with invalid details" do
    # Blank inputs
    # Locks after x failed attempts
    # Incorrect password confirmation
    # Bad email and too short password?
    # Non-confirmed user cannot sign-in (belongs in "with valid details" context)
  end

end
