require 'rails_helper'


feature "Subscribe to newsletter", :type => :feature do
  
  scenario "subscribes confirmed user to newsletter" do

    visit "/"

    # Test that the Subscribe to newsletter link works
    click_link "Subscribe to newsletter"
    
    # Test the page title *BEFORE* testing the path when turbolinks
    # performs the page load. 
    # 
    # Capybara's methods account that some browser operations happen
    # asynchronously. Capybara will retry most operations for a few
    # seconds before failing a test (Capybara.default_wait_time is 2
    # seconds by default). `expect ... eq ...` will not
    # retry, whereas `expect ... have_title ...` does retry. Once
    # the new title test is passed, we can be confident that the
    # browser's current path has updated to the new path.
    expect(page).to have_title "Subscribe to our newsletter"
    expect(current_path).to eq new_subscription_path

    # Enter your email and submit the form
    fill_in "Email", with: "buddy@example.tld"
    click_button "Subscribe"

    # Assert you're on the subscription pending page and asked
    # to check your inbox for the confirmation email.
    expect(current_path).to eq pending_subscriptions_path
    expect(page).to have_title "Check your inbox"
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
      expect(page).to have_title "Subscription confirmed!"
      expect(page).to have_content "Your subscription has been confirmed, thank you!"

    end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)
  end

end
