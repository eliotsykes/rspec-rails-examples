require "rails_helper"

feature "User upgrades", js: true do

  scenario "successfully" do
    user = create(:user, role: "standard")

    with_browser_responses('stripe checkout') do
      visit new_user_session_path
      login user
      click_button "Upgrade Membership"

      Capybara.using_wait_time 5.seconds do
        within_frame 'stripe_checkout_app' do
          fill_in "Email", with: user.email
          fill_in_stripe_field "#card_number", with: "4242 4242 4242 4242"
          fill_in_stripe_field "#cc-exp", with: "12/22"
          fill_in "CVC", with: '123'
          click_button "Pay $9.99"
        end
        expect(page).to have_no_button "Upgrade Membership"
      end
    end

    expect(page).to have_content "Charged!"
    expect(page).to have_content "Thank you for upgrading your membership!"
    expect(user.reload.premium?).to eq true
  end

  xscenario "unsuccessfully"

end
