require 'rails_helper'


feature "Subscribe to newsletter", :type => :feature do
  
  scenario "subscribes confirmed user to newsletter" do

    # Go to the subscription page
    visit new_subscription_path

    # Enter your email and submit the form
    fill_in "Email", with: "buddy@example.tld"
    click_button "Subscribe"

    # Assert you're on the subscription pending page and asked
    # to check your inbox for the confirmation email.
    expect(current_path).to eq pending_subscriptions_path
    expect(page).to have_content(
      "Please check your inbox and click the confirmation link to complete your subscription."
    )

    expect do
      # Use email_spec helpers to:
      # 1. Open the correct email, then
      # 2. Visit the confirm link in that email
      open_email "buddy@example.tld", with_subject: "Please confirm"
      visit_in_email "Confirm your subscription"

      expect(current_path).to eq confirm_subscription_path(Subscription.last)
      expect(page).to have_content "Your subscription has been confirmed, thank you!"

    end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)
  end

end
