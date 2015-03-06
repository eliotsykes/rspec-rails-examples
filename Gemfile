source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'devise'
gem 'nokogiri'

group :development, :test do
  gem 'byebug' # Call 'byebug' in code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0' # Access IRB on error pages or by <%= console %> in views
  gem 'spring' # Spring background-runs app in dev for speed
  gem 'rspec-rails', '~> 3.1'
  
  gem 'capybara'

  # selenium-webdriver & chromedriver-helper used by
  # JavaScript-dependent feature specs (`js: true`):
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  gem 'puffing-billy'
  
  gem 'factory_girl_rails', '~> 4.5'
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

group :test do
  gem 'email_spec'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
end

