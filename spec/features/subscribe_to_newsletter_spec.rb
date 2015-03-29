require 'rails_helper'

feature "Subscribe to newsletter", type: :feature do

  context "in browser with native date input", driver: driver_with(native_date_input: true) do

    scenario "subscribes confirmed user to newsletter" do

      visit_new_subscription

      submit_new_subscription_form(email: "buddy@example.tld", start_on: "01/01/2015")

      # be_pending_subscription_page is a custom matcher (see spec/matchers)
      expect(page).to be_pending_subscription_page

      expect do
        visit_emailed_confirm_subscription_link("buddy@example.tld")
        expect(page).to be_confirm_subscription_page(Subscription.last).with_subscription_starting_on("January 1st, 2015")
      end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)
    end

  end

  context "in browser without native date input", driver: driver_with(native_date_input: false)  do

    scenario "subscribes confirmed user to newsletter" do

      visit_new_subscription

      fill_in "Email", with: "buddy@example.tld"
      expect(page).not_to have_css("#subscription_start_on + .picker--opened")
      find_field("Start date").click # open the date picker
      expect(page).to have_css("#subscription_start_on + .picker--opened")
      within "#subscription_start_on + .picker" do
        find("select[title='Select a year']").select("2015")
        find("select[title='Select a month']").select("January")
        find("[aria-label='2015-01-01']", text: "1").click
      end
      expect(page).not_to have_css("#subscription_start_on + .picker--opened")
      expect(page).to have_field("subscription_start_on", with: "2015-01-01")
      click_button "Subscribe"

      expect(page).to be_pending_subscription_page

      expect do
        visit_emailed_confirm_subscription_link("buddy@example.tld")
        expect(page).to be_confirm_subscription_page(Subscription.last).with_subscription_starting_on("January 1st, 2015")
      end.to change { Subscription.where(confirmed: true).count }.from(0).to(1)

    end

  end

  private

  def submit_new_subscription_form(email:, start_on:)
    # Enter your email, subscription start date, then submit the form
    fill_in "Email", with: email
    fill_in "Start date", with: start_on
    click_button "Subscribe"
  end

  def visit_emailed_confirm_subscription_link(recipient)
    # Use email_spec helpers to:
    # 1. Open the correct email, then
    # 2. Visit the confirm link in that email
    open_email recipient, with_subject: "Please confirm"
    visit_in_email "Confirm your subscription"
  end

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
