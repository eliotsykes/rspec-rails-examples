require 'rails_helper'

feature "Share page", type: :feature, js: true do
  
  scenario "displays 3rd party widgets" do
    visit "/share"
    expect(page).to have_title "Share Our Stuff!"
    expect(page).to have_css "h1", text: "Share Our Stuff!"

    # This is the 3rd party widget
    expect(page).to have_css "button", text: "Share this"

    # This is the 3rd party script that generated the widget
    expect(page).to have_css(
      "script.social-widget[src='https://eliotsykes.github.io/rspec-rails-examples/share.js']",
      visible: :hidden # script tags are not visible
    )

    # Only the puffing billy served script adds this message:
    expect(page).to have_content("Script served by Puffing Billy")
  end

end
