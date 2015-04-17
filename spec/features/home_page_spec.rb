require 'rails_helper'

feature "Home page" do

  scenario "visit" do
    visit "/"
    expect(page).to have_title "Welcome to RSpec Rails Examples"
    expect(page).to have_css "h1", text: "Welcome"
  end

end
