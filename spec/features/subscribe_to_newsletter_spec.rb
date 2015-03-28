require 'rails_helper'

feature "Subscribe to newsletter", :type => :feature do

  context "in browser with native date input support" do

    scenario "subscribes confirmed user to newsletter" do

      visit_new_subscription

      # Enter your email, subscription start date, then submit the form
      fill_in "Email", with: "buddy@example.tld"
      fill_in "Start date", with: "01/01/2015"
      click_button "Subscribe"

      # be_pending_subscription_page is a custom matcher (see spec/matchers)
      expect(page).to be_pending_subscription_page

      expect do
        # Use email_spec helpers to:
        # 1. Open the correct email, then
        # 2. Visit the confirm link in that email
        open_email "buddy@example.tld", with_subject: "Please confirm"
        visit_in_email "Confirm your subscription"

        expect(page).to be_confirm_subscription_page(Subscription.last).with_subscription_starting_on("January 1st, 2015")
      end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)
    end

  end

  xcontext "in browser without native date input support" do
    
    scenario "subscribes confirmed user to newsletter" do

      visit_new_subscription

      fill_in "Email", with: "buddy@example.tld"
      fill_in "Start date", with: "01/01/2015"
      click_button "Subscribe"

      expect(page).to be_pending_subscription_page

      expect do
        open_email "buddy@example.tld", with_subject: "Please confirm"
        visit_in_email "Confirm your subscription"
        expect(page).to be_confirm_subscription_page(Subscription.last).with_subscription_starting_on("January 1st, 2015")
      end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)
    end

  end

  private

  def visit_new_subscription
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

    today = Time.zone.today.strftime("%Y-%m-%d") # Formats like: 2015-03-22
    expect(page).to have_field "Start date", with: today
  end

end
